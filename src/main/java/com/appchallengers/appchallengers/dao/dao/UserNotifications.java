package com.appchallengers.appchallengers.dao.dao;

import com.appchallengers.appchallengers.mongodb.model.ChallengedModel;

import java.util.List;

public interface UserNotifications {

    void insert(ChallengedModel challengedModel);
    List<ChallengedModel> getUserNotifications(long toId);
    boolean hasNotifications(long toId);
    void setFlag(long toId);
}
