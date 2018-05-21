package com.appchallengers.appchallengers.dao.dao;

import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.GetUserInfoResponseModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;

import java.util.List;

public interface GetUserInfoDao {

    GetUserInfoResponseModel getUserInfo(long user_id, long info_user_id);
    List<ChallengeResponseModel>  getUserChallenges(long user_id, long info_user_id);
    List<ChallengeResponseModel>  getUserAcceptedChallenges(long user_id, long info_user_id);
    List<UsersBaseDataResponseModel>  getUserRelationships(long info_user_id);
}
