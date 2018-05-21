package com.appchallengers.appchallengers.model.entity;

import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.GetChallengeDetailInfoModel;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

@Entity
@NamedNativeQueries({
        @NamedNativeQuery(name = "ChallengeDetail.getUserChallengeDetail", query = "SELECT" +
                " CHALLENGE_DETAİL_USER_İD as challenge_detail_user_id,FULLNAME as fullname," +
                " PROFİLEPİCTURE as profilepicture,CHALLENGEDETAİL.CHALLENGE_İD AS challenge_id," +
                " CHALLENGEDETAİL.İD as challenge_detail_id,CHALLENGE_URL as challenge_url," +
                " HEADLİNE as headline,CASE WHEN V.VOTE_USER_İD = ? THEN 1 ELSE 0 END AS vote," +
                " COUNT(V2.İD) AS likes FROM CHALLENGEDETAİL" +
                " LEFT JOIN USERS ON CHALLENGEDETAİL.CHALLENGE_DETAİL_USER_İD = USERS.İD" +
                " LEFT JOIN CHALLENGES ON CHALLENGEDETAİL.CHALLENGE_İD = CHALLENGES.İD" +
                " LEFT JOIN VOTES AS V ON CHALLENGEDETAİL.İD = V.CHALLENGE_DETAİL_İD AND V.VOTE_USER_İD = ?" +
                " LEFT JOIN VOTES AS V2 ON CHALLENGEDETAİL.İD = V2.CHALLENGE_DETAİL_İD" +
                " WHERE CHALLENGE_DETAİL_USER_İD IN (SELECT USERS.İD FROM USERS, RELATİONSHİP" +
                " WHERE USERS.İD = CASE WHEN FİRSTUSER_İD = ? THEN SECONDUSER_İD WHEN SECONDUSER_İD = ?" +
                " THEN FİRSTUSER_İD ELSE -1 END AND STATUS = ?)" +
                " GROUP BY CHALLENGE_DETAİL_USER_İD, FULLNAME, PROFİLEPİCTURE, CHALLENGEDETAİL.CHALLENGE_İD,CHALLENGEDETAİL.İD, " +
                " CHALLENGE_URL, HEADLİNE,V.VOTE_USER_İD,APPCHALLENGERS.CHALLENGEDETAİL.CREATE_DATE" +
                " ORDER BY APPCHALLENGERS.CHALLENGEDETAİL.CREATE_DATE DESC",
                resultSetMapping = "userChallengeFeedList"),
        @NamedNativeQuery(name = "ChallengeDetail.getChallengeDetailInfo", query = "SELECT" +
                "  t1.HEADLİNE AS headline,t1.COUNTER AS counter,t2.STATUS AS status," +
                " t1.CHALLENGE_İD AS challenge_id FROM (SELECT B.CHALLENGE_İD as challenge_id," +
                " C.HEADLİNE as headline," +
                "         count(CHALLENGE_İD) AS counter FROM CHALLENGEDETAİL  B" +
                "         JOIN CHALLENGES C ON B.CHALLENGE_İD = C.İD" +
                "       WHERE B.CHALLENGE_İD = ?" +
                "       GROUP BY CHALLENGE_İD, C.HEADLİNE" +
                "     ) AS t1," +
                "  (SELECT count(CHALLENGE_DETAİL_USER_İD) AS status" +
                "   FROM CHALLENGEDETAİL" +
                "   WHERE CHALLENGEDETAİL.CHALLENGE_İD = ? AND CHALLENGE_DETAİL_USER_İD = ?  " +
                "  ) AS t2", resultSetMapping = "getChallengeDetailInfo"),
        @NamedNativeQuery(name = "ChallengeDetail.getChallengeDetailOrderByTime", query = "SELECT" +
                " CHALLENGE_DETAİL_USER_İD as challenge_detail_user_id,FULLNAME as fullname," +
                " PROFİLEPİCTURE as profilepicture,CHALLENGEDETAİL.CHALLENGE_İD AS challenge_id," +
                " CHALLENGEDETAİL.İD as challenge_detail_id,CHALLENGE_URL as challenge_url," +
                " HEADLİNE headline,CASE WHEN V.VOTE_USER_İD = ? THEN 1 ELSE 0 END AS vote," +
                " COUNT(V2.İD) AS likes" +
                " FROM CHALLENGES" +
                "  JOIN CHALLENGEDETAİL ON CHALLENGES.İD = CHALLENGEDETAİL.CHALLENGE_İD" +
                "  LEFT JOIN USERS ON CHALLENGEDETAİL.CHALLENGE_DETAİL_USER_İD = USERS.İD" +
                "  LEFT JOIN VOTES AS V ON CHALLENGEDETAİL.İD = V.CHALLENGE_DETAİL_İD AND V.VOTE_USER_İD = ?" +
                "  LEFT JOIN VOTES AS V2 ON CHALLENGEDETAİL.İD = V2.CHALLENGE_DETAİL_İD" +
                " WHERE CHALLENGE_İD =?" +
                " GROUP BY CHALLENGE_DETAİL_USER_İD, FULLNAME, PROFİLEPİCTURE, CHALLENGEDETAİL.CHALLENGE_İD,CHALLENGEDETAİL.İD," +
                "  CHALLENGE_URL, HEADLİNE, V.VOTE_USER_İD, APPCHALLENGERS.CHALLENGEDETAİL.CREATE_DATE" +
                " ORDER BY APPCHALLENGERS.CHALLENGEDETAİL.CREATE_DATE DESC", resultSetMapping = "userChallengeFeedList"),
        @NamedNativeQuery(name = "ChallengeDetail.getChallengeDetailOrderByLikes", query = "SELECT" +
                " CHALLENGE_DETAİL_USER_İD as challenge_detail_user_id,FULLNAME as fullname," +
                " PROFİLEPİCTURE as profilepicture,CHALLENGEDETAİL.CHALLENGE_İD AS challenge_id," +
                " CHALLENGEDETAİL.İD as challenge_detail_id,CHALLENGE_URL as challenge_url," +
                " HEADLİNE as headline,CASE WHEN V.VOTE_USER_İD = ? THEN 1 ELSE 0 END AS vote," +
                " COUNT(V2.İD) AS likes" +
                " FROM CHALLENGES" +
                "  JOIN CHALLENGEDETAİL ON CHALLENGES.İD = CHALLENGEDETAİL.CHALLENGE_İD" +
                "  LEFT JOIN USERS ON CHALLENGEDETAİL.CHALLENGE_DETAİL_USER_İD = USERS.İD" +
                "  LEFT JOIN VOTES AS V ON CHALLENGEDETAİL.İD = V.CHALLENGE_DETAİL_İD AND V.VOTE_USER_İD = ?" +
                "  LEFT JOIN VOTES AS V2 ON CHALLENGEDETAİL.İD = V2.CHALLENGE_DETAİL_İD" +
                " WHERE CHALLENGE_İD =?" +
                " GROUP BY CHALLENGE_DETAİL_USER_İD, FULLNAME, PROFİLEPİCTURE, CHALLENGEDETAİL.CHALLENGE_İD,CHALLENGEDETAİL.İD," +
                "  CHALLENGE_URL, HEADLİNE, V.VOTE_USER_İD, APPCHALLENGERS.CHALLENGEDETAİL.CREATE_DATE" +
                " ORDER BY LİKES DESC", resultSetMapping = "userChallengeFeedList")})

@SqlResultSetMappings({
        @SqlResultSetMapping(name = "userChallengeFeedList",
                classes = @ConstructorResult(
                        targetClass = ChallengeResponseModel.class,
                        columns = {
                                @ColumnResult(name = "challenge_detail_user_id", type = long.class),
                                @ColumnResult(name = "fullname",type = String.class),
                                @ColumnResult(name = "profilepicture",type=String.class),
                                @ColumnResult(name = "challenge_id", type = long.class),
                                @ColumnResult(name = "challenge_detail_id", type = long.class),
                                @ColumnResult(name = "challenge_url",type = String.class),
                                @ColumnResult(name = "headline",type = String.class),
                                @ColumnResult(name = "vote", type = long.class),
                                @ColumnResult(name = "likes", type = long.class)
                        }
                )),
        @SqlResultSetMapping(name = "getChallengeDetailInfo",
                classes = @ConstructorResult(
                        targetClass = GetChallengeDetailInfoModel.class,
                        columns = {
                                @ColumnResult(name = "headline",type = String.class),
                                @ColumnResult(name = "counter", type = long.class),
                                @ColumnResult(name = "status",type = int.class),
                                @ColumnResult(name = "challenge_id",type = long.class),
                        }
                ))
})
public class ChallengeDetail {

    @Id
    @SequenceGenerator(name = "LICENSE_SEQ", sequenceName = "LICENSE_SEQ", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "LICENSE_SEQ")
    private long id;
    @ManyToOne
    private Challenges challenge;
    @ManyToOne
    private Users challenge_detail_user;
    private String challenge_url;
    private Timestamp create_date;

    @OneToMany(orphanRemoval = true, mappedBy = "challenge_detail", cascade = {CascadeType.ALL})
    List<Votes> votes = new LinkedList<Votes>();

    public ChallengeDetail(Challenges challenge, Users challenge_detail_user, String challenge_url, Timestamp create_date) {
        this.challenge = challenge;
        this.challenge_detail_user = challenge_detail_user;
        this.challenge_url = challenge_url;
        this.create_date = create_date;
    }

    public ChallengeDetail() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }


    public Users getChallenge_detail_user() {
        return challenge_detail_user;
    }

    public void setChallenge_detail_user(Users challenge_detail_user) {
        this.challenge_detail_user = challenge_detail_user;
    }

    public String getChallenge_url() {
        return challenge_url;
    }

    public void setChallenge_url(String challenge_url) {
        this.challenge_url = challenge_url;
    }

    public Timestamp getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Timestamp create_date) {
        this.create_date = create_date;
    }

    public Challenges getChallenge() {
        return challenge;
    }

    public void setChallenge(Challenges challenge) {
        this.challenge = challenge;
    }
}
