package com.appchallengers.appchallengers.dao.dao;


import com.appchallengers.appchallengers.model.entity.Relationship;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;

import java.util.List;

public interface RelationshipDao {

     void addRelationship(long firstUser,long secondUser,long actionId);
     boolean acceptRelationship(long firstUser, long secondUser, long actionId);
     void deleteRelationship(long firstUser,long secondUser);
     Relationship getRelationship(long firstUser, long secondUser);
     List<UsersBaseDataResponseModel> getFriends(long userId);
     Long checkRelationship(long firstUser,long secondUser);
}
