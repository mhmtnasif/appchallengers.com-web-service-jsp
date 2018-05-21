package com.appchallengers.appchallengers.model.entity;

import com.appchallengers.appchallengers.model.response.GetUserInfoResponseModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

@Entity
@NamedQueries({
        @NamedQuery(name = "Users.findUserByEmail", query = "SELECT user from Users user where user.email=:email"),
        @NamedQuery(name = "Users.checkEmail", query = "SELECT COUNT(user) from Users user where user.email=:email"),
        @NamedQuery(name = "Users.checkIdAndPasswordSalt", query = "SELECT COUNT(user) from Users user where user.id=:id and user.passwordSalt=:passwordSalt"),
        @NamedQuery(name = "Users.login", query = "select count(user)from Users user where user.email=:email and user.passwordHash=:passwordHash")
})
@NamedNativeQueries({
        @NamedNativeQuery(name = "Users.getInfo", query = "SELECT" +
                "  A.İD AS id," +
                "  A.FULLNAME AS fullname, " +
                "  A.PROFİLEPİCTURE AS profilepicture," +
                "  A.COUNTRY AS country," +
                "  A.USERACTİONID AS useractionid," +
                "  A.STATUS AS status," +
                "  A.CHALLENGES AS challenges," +
                "  A.ACCEPTED_CHALLENGES AS accepted_challenges," +
                "  B.FRİENDS AS friends" +
                " FROM (SELECT" +
                "        u.İD as id," +
                "        u.FULLNAME AS fullname," +
                "        u.PROFİLEPİCTURE AS profilepicture," +
                "        u.COUNTRY AS country," +
                "        CASE WHEN r1.USERACTİONID IS NULL" +
                "          THEN -1" +
                "        ELSE r1.USERACTİONID END as useractionid," +
                "        CASE WHEN r1.STATUS IS NULL" +
                "          THEN -1" +
                "        ELSE r1.STATUS END as status," +
                "        COUNT(C2.İD)               AS challenges," +
                "        COUNT(C.İD) - COUNT(C2.İD) AS accepted_challenges" +
                "      FROM USERS u" +
                "        LEFT JOIN RELATİONSHİP r1 ON ? = r1.FİRSTUSER_İD AND r1.SECONDUSER_İD = ? " +
                "        LEFT JOIN CHALLENGEDETAİL C ON u.İD = C.CHALLENGE_DETAİL_USER_İD " +
                "        LEFT JOIN CHALLENGES C2 ON C.CHALLENGE_İD = C2.İD AND C2.CHALLENGE_USER_İD = C.CHALLENGE_DETAİL_USER_İD " +
                "      WHERE u.İD = ?" +
                "      GROUP BY u.İD, u.FULLNAME, u.PROFİLEPİCTURE," +
                "        u.COUNTRY, r1.USERACTİONID, r1.STATUS) AS A" +
                "  LEFT JOIN (" +
                "              SELECT COUNT(r.İD) AS friends" +
                "              FROM RELATİONSHİP r " +
                "              WHERE (r.SECONDUSER_İD = ? OR r.FİRSTUSER_İD = ?) AND r.STATUS=1" +
                "            ) AS B ON A.İD = ?", resultSetMapping = "Users.getUserInfo"),
        @NamedNativeQuery(name = "Users.search", query = "SELECT u.İD as id,u.FULLNAME as fullname,u.PROFİLEPİCTURE " +
                " AS profile_picture FROM users u WHERE LOWER(u.FULLNAME)  LIKE ? OR LOWER(u.EMAİL) LIKE ? ", resultSetMapping = "Users.search")
})
@SqlResultSetMappings({
        @SqlResultSetMapping(name = "Users.getUserInfo",
                classes = @ConstructorResult(
                        targetClass = GetUserInfoResponseModel.class,
                        columns = {
                                @ColumnResult(name = "id", type = long.class),
                                @ColumnResult(name = "fullname", type = String.class),
                                @ColumnResult(name = "profilepicture", type = String.class),
                                @ColumnResult(name = "country", type = String.class),
                                @ColumnResult(name = "useractionid", type = long.class),
                                @ColumnResult(name = "status", type = int.class),
                                @ColumnResult(name = "challenges", type = long.class),
                                @ColumnResult(name = "accepted_challenges", type = long.class),
                                @ColumnResult(name = "friends", type = long.class)
                        }
                )),
        @SqlResultSetMapping(name = "Users.search",
                classes = @ConstructorResult(
                        targetClass = UsersBaseDataResponseModel.class,
                        columns = {
                                @ColumnResult(name = "id", type = long.class),
                                @ColumnResult(name = "fullname", type = String.class),
                                @ColumnResult(name = "profile_picture", type = String.class)
                        }
                ))
})

public class Users {

    public static enum Active {NOT_CONFİRMED, ACTIVE, FROZEN}

    @Id
    @SequenceGenerator(name = "LICENSE_SEQ", sequenceName = "LICENSE_SEQ", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "LICENSE_SEQ")
    private long id;
    private String fullName;
    private String email;
    private String passwordHash;
    private String passwordSalt;
    private String country;
    private String profilePicture;
    @Enumerated(EnumType.ORDINAL)
    private Active active;
    private Timestamp createDate;
    private Timestamp updateDate;

    @OneToMany(orphanRemoval = true, mappedBy = "firstUser", cascade = {CascadeType.ALL})
    private List<Relationship> relationships_one = new LinkedList<Relationship>();

    @OneToMany(orphanRemoval = true, mappedBy = "secondUser", cascade = {CascadeType.ALL})
    private List<Relationship> relationships_two = new LinkedList<Relationship>();

    @OneToMany(orphanRemoval = true, mappedBy = "challenge_user", cascade = {CascadeType.ALL})
    private List<Challenges> challengesList = new LinkedList<Challenges>();

    @OneToMany(orphanRemoval = true, mappedBy = "challenge_detail_user", cascade = {CascadeType.ALL})
    private List<ChallengeDetail> challengeDetailList = new LinkedList<ChallengeDetail>();

    @OneToMany(orphanRemoval = true, mappedBy = "vote_user", cascade = {CascadeType.ALL})
    private List<Votes> votes = new LinkedList<Votes>();

    public Users() {
    }

    public Users(String fullName, String email, String passwordHash, String passwordSalt, String country, String profilePicture, Active active, Timestamp createDate, Timestamp updateDate) {
        this.fullName = fullName;
        this.email = email;
        this.passwordHash = passwordHash;
        this.passwordSalt = passwordSalt;
        this.country = country;
        this.profilePicture = profilePicture;
        this.active = active;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    public Users(String fullName, String email, String passwordHash, String passwordSalt, String country, Active active, Timestamp createDate, Timestamp updateDate) {
        this.fullName = fullName;
        this.email = email;
        this.passwordHash = passwordHash;
        this.passwordSalt = passwordSalt;
        this.country = country;
        this.active = active;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getPasswordSalt() {
        return passwordSalt;
    }

    public void setPasswordSalt(String passwordSalt) {
        this.passwordSalt = passwordSalt;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public Active getActive() {
        return active;
    }

    public void setActive(Active active) {
        this.active = active;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public Timestamp getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Timestamp updateDate) {
        this.updateDate = updateDate;
    }
}
