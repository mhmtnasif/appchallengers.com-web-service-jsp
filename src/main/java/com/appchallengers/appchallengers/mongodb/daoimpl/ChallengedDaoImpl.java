package com.appchallengers.appchallengers.mongodb.daoimpl;

import com.appchallengers.appchallengers.mongodb.dao.ChallengedDao;
import com.appchallengers.appchallengers.mongodb.model.ChallengedModel;
import com.google.gson.Gson;
import com.mongodb.*;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;


public class ChallengedDaoImpl implements ChallengedDao {

    public void insert(ChallengedModel challengedModel) {
        MongoClient mongoClient = new MongoClient("localhost", 27017);
        MongoDatabase db = mongoClient.getDatabase("appchallengers");
        MongoCollection collection = db.getCollection("notification");
        Document document = new Document();
        document.put("fromId", challengedModel.getFromId());
        document.put("fromUserFullName", challengedModel.getFromUserFullName());
        document.put("fromUserProfilePicture", challengedModel.getFromUserProfilePicture());
        document.put("toId", challengedModel.getToId());
        document.put("type", challengedModel.getType());
        document.put("challengeHeadLine", challengedModel.getChallengeHeadLine());
        document.put("actionId", challengedModel.getActionId());
        document.put("flag", challengedModel.getFlag());
        document.put("createDate", new Date());
        collection.insertOne(document);
        mongoClient.close();
    }

    public List<ChallengedModel> getUserNotification(long toId) {
        MongoClient mongoClient = new MongoClient("localhost", 27017);
        DB db = mongoClient.getDB("appchallengers");
        DBCollection collection = db.getCollection("notification");
        DBCursor cursor = collection.find(new BasicDBObject("toId", toId)).sort(new BasicDBObject("createDate", -1));
        List<ChallengedModel> challengedModels = new LinkedList<ChallengedModel>();
        while (cursor.hasNext()) {
            DBObject resultElement = cursor.next();
            Map resultElementmap = resultElement.toMap();
            resultElementmap.remove("_id");
            String json = new Gson().toJson(resultElementmap);
            challengedModels.add(new Gson().fromJson(json, ChallengedModel.class));
        }
        mongoClient.close();
        setFlag(toId);
        return challengedModels;
    }

    public boolean hasNotification(long toId) {
        MongoClient mongoClient = new MongoClient("localhost", 27017);
        DB db = mongoClient.getDB("appchallengers");
        DBCollection collection = db.getCollection("notification");
        List<BasicDBObject> list = new LinkedList<BasicDBObject>();
        list.add(new BasicDBObject("toId", toId));
        list.add(new BasicDBObject("flag", 0));
        DBCursor cursor = collection.find(new BasicDBObject("$and", list));
        if (cursor.hasNext()) {
            mongoClient.close();
            return true;
        } else {
            mongoClient.close();
            return false;
        }
    }

    public void setFlag(long toId) {
        MongoClient mongoClient = new MongoClient("localhost", 27017);
        DB db = mongoClient.getDB("appchallengers");
        DBCollection collection = db.getCollection("notification");
        List<BasicDBObject> list = new LinkedList<BasicDBObject>();
        list.add(new BasicDBObject("toId", toId));
        list.add(new BasicDBObject("flag", 0));
        DBObject query = new BasicDBObject("$and", list);
        DBObject update = new BasicDBObject("$set", new BasicDBObject("flag", 1));
        collection.update(query,update,false,true);
        mongoClient.close();
    }

}
