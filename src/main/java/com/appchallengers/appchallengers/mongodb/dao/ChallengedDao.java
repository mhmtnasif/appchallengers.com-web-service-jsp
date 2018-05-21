package com.appchallengers.appchallengers.mongodb.dao;

import com.appchallengers.appchallengers.mongodb.model.ChallengedModel;

import java.util.List;


public interface ChallengedDao {

    void insert(ChallengedModel challengedModel);
    List<ChallengedModel> getUserNotification(long toId);
    boolean hasNotification(long toId);
    void setFlag(long toId);
}
