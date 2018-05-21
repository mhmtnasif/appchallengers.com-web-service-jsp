package com.appchallengers.appchallengers.mongodb.websocket;

import com.appchallengers.appchallengers.mongodb.dao.ChallengedDao;
import com.appchallengers.appchallengers.mongodb.daoimpl.ChallengedDaoImpl;
import com.appchallengers.appchallengers.mongodb.model.ChallengedModel;
import com.google.gson.Gson;
import com.mongodb.*;

import javax.websocket.*;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@ServerEndpoint("/websocketserver")
public class WebSocketServer {

    private Session session;


    @OnOpen
    public void connect(Session session) throws InterruptedException {
        this.session = session;
    }

    @OnClose
    public void close() {
        this.session = null;
    }

    @OnMessage
    public void message(String userid) throws InterruptedException {
        ChallengedDao challengedDao = new ChallengedDaoImpl();
        long user_id = Long.parseLong(userid);
        String sonuc;
       while (true) {
            if (challengedDao.hasNotification(user_id)) {
                this.session.getAsyncRemote().sendText("1");
            }
            Thread.sleep(300000);
        }
    }}
