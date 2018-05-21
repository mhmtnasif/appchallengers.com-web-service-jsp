package com.appchallengers.appchallengers.model.entity;


import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;

import javax.persistence.*;

@Entity
@NamedQueries({
        @NamedQuery(name = "Relationship.checkRelationship", query = "SELECT COUNT(relationship) from Relationship relationship where relationship.firstUser.id=:firstuser and relationship.secondUser.id=:seconduser"),
        @NamedQuery(name = "Relationship.getRelationship", query = "SELECT relationship from Relationship relationship where relationship.firstUser.id=:firstuser and relationship.secondUser.id=:seconduser"),
})
@NamedNativeQuery(name = "Relationship.getRelationships", query = "SELECT" +
        " u.İD as id,u.FULLNAME AS fullname,u.PROFİLEPİCTURE as profile_picture FROM USERS  u, RELATİONSHİP  r " +
        " WHERE u.İD = CASE WHEN r.FİRSTUSER_İD = ? THEN r.SECONDUSER_İD" +
        " WHEN r.SECONDUSER_İD = ? THEN r.FİRSTUSER_İD END AND r.STATUS = 1"
        , resultSetMapping = "Relationship.UsersBaseDataResponseModel")
@SqlResultSetMapping(name = "Relationship.UsersBaseDataResponseModel",
        classes = @ConstructorResult(
                targetClass = UsersBaseDataResponseModel.class,
                columns = {
                        @ColumnResult(name = "id", type = long.class),
                        @ColumnResult(name = "fullName",type = String.class),
                        @ColumnResult(name = "profile_picture",type = String.class)
                }
        ))
public class Relationship {

    public static enum Type {SEND_REQUEST, FRIEND}

    @Id
    @SequenceGenerator(name = "LICENSE_SEQ", sequenceName = "LICENSE_SEQ", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "LICENSE_SEQ")
    private long id;
    @ManyToOne()
    private Users firstUser;
    @ManyToOne()
    private Users secondUser;
    private long userActionId;
    @Enumerated(EnumType.ORDINAL)
    private Type status;

    public Relationship() {
    }

    public Relationship(Users firstUser, Users secondUser, long userActionId, Type status) {
        this.firstUser = firstUser;
        this.secondUser = secondUser;
        this.userActionId = userActionId;
        this.status = status;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Users getFirstUser() {
        return firstUser;
    }

    public void setFirstUser(Users firstUser) {
        this.firstUser = firstUser;
    }

    public Users getSecondUser() {
        return secondUser;
    }

    public void setSecondUser(Users secondUser) {
        this.secondUser = secondUser;
    }

    public long getUserActionId() {
        return userActionId;
    }

    public void setUserActionId(long userActionId) {
        this.userActionId = userActionId;
    }

    public Type getStatus() {
        return status;
    }

    public void setStatus(Type status) {
        this.status = status;
    }

}
