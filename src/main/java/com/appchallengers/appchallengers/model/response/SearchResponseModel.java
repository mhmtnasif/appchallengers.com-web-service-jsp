package com.appchallengers.appchallengers.model.response;

import java.util.List;

public class SearchResponseModel {

    private List<UsersBaseDataResponseModel> userList;
    private List<SearchChallengesResponseModel> challengesList;


    public SearchResponseModel(List<UsersBaseDataResponseModel> userList, List<SearchChallengesResponseModel> challengesList) {
        this.userList = userList;
        this.challengesList = challengesList;
    }

    public SearchResponseModel() {
    }

    public List<UsersBaseDataResponseModel> getUserList() {
        return userList;
    }

    public void setUserList(List<UsersBaseDataResponseModel> userList) {
        this.userList = userList;
    }

    public List<SearchChallengesResponseModel> getChallengesList() {
        return challengesList;
    }

    public void setChallengesList(List<SearchChallengesResponseModel> challengesList) {
        this.challengesList = challengesList;
    }
}
