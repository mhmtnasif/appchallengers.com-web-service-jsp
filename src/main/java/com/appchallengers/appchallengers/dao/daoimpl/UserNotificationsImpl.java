package com.appchallengers.appchallengers.dao.daoimpl;

import com.appchallengers.appchallengers.dao.dao.UserNotifications;
import com.appchallengers.appchallengers.mongodb.dao.ChallengedDao;
import com.appchallengers.appchallengers.mongodb.daoimpl.ChallengedDaoImpl;
import com.appchallengers.appchallengers.mongodb.model.ChallengedModel;

import java.util.List;

public class UserNotificationsImpl implements UserNotifications {

    private ChallengedDao challengedDao = new ChallengedDaoImpl();

    public void insert(ChallengedModel challengedModel) {
        challengedDao.insert(challengedModel);
    }

    public List<ChallengedModel> getUserNotifications(long toId) {
        return challengedDao.getUserNotification(toId);
    }

    public boolean hasNotifications(long toId) {
        return challengedDao.hasNotification(toId);
    }

    public void setFlag(long toId) {
        challengedDao.setFlag(toId);
    }
}
