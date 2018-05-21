package com.appchallengers.appchallengers.model.response;

public class RelationshipResponseModel {

    private Integer firstUserId;
    private Integer secondUserId;
    private long actionUserId;
    private Integer relationshipStatus;

    public RelationshipResponseModel(Integer firstUserId, Integer secondUserId, long actionUserId, Integer relationshipStatus) {
        this.firstUserId = firstUserId;
        this.secondUserId = secondUserId;
        this.actionUserId = actionUserId;
        this.relationshipStatus = relationshipStatus;
    }
}
