package com.appchallengers.appchallengers.dao.dao;

import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.GetUserInfoResponseModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;

import java.util.List;

public interface GetProfileDao {

    GetUserInfoResponseModel getProfileInfo(long user_id);

    List<ChallengeResponseModel> getProfileChallenges(long user_id);

    List<ChallengeResponseModel> getProfileAcceptedChallenges(long user_id);

    List<UsersBaseDataResponseModel> getProfileRelationships(long user_id);
}
