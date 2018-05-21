package com.appchallengers.appchallengers.dao.dao;

import com.appchallengers.appchallengers.model.entity.Challenges;
import com.appchallengers.appchallengers.model.entity.Users;
import com.appchallengers.appchallengers.model.response.SearchChallengesResponseModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;

import java.util.Collection;
import java.util.List;

public interface ChallengesDao {

    Challenges addChallenge(Challenges challenge);
    List<SearchChallengesResponseModel> search(String param);
    Challenges getChallenge(long challengeId);
    void addChallengeNotification(Challenges challenges,Users users, List<UsersBaseDataResponseModel> usersBaseDataResponseModels);
}
