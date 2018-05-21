package com.appchallengers.appchallengers.dao.dao;

import com.appchallengers.appchallengers.model.entity.ChallengeDetail;
import com.appchallengers.appchallengers.model.entity.Challenges;
import com.appchallengers.appchallengers.model.entity.Users;
import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.GetChallengeDetailInfoModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;

import java.util.List;

public interface ChallengesDetailDao {

    GetChallengeDetailInfoModel getChallengeDetailInfo(long userId,long challengeId);
    List<ChallengeResponseModel> getChallengeDetailOrderByTime(long userId, long challengeId);
    List<ChallengeResponseModel> getChallengeDetailOrderByLikes(long userId, long challengeId);
    ChallengeDetail addChallengesDetail(ChallengeDetail challengeDetail);
    ChallengeDetail getChallengeDetail(long challenge_detail_id);
    List<ChallengeResponseModel> getUserChallengeFeedList(long userId);
    void addChallengeDetailNotification(Challenges challenges, Users users, List<UsersBaseDataResponseModel> usersBaseDataResponseModels);

}
