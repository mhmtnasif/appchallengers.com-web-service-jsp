<%@ page import="com.appchallengers.appchallengers.dao.dao.ChallengesDetailDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.VotesDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.ChallengesDetailDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.VotesDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.ChallengeDetail" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Votes" %>
<%@ page import="com.appchallengers.appchallengers.web.bussiness.BusinessMainpage" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%@ page import="com.appchallengers.appchallengers.mongodb.dao.ChallengedDao" %>
<%@ page import="com.appchallengers.appchallengers.mongodb.daoimpl.ChallengedDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserNotifications" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserNotificationsImpl" %>
<%@ page import="com.appchallengers.appchallengers.mongodb.model.ChallengedModel" %>
<%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 5.3.2018
  Time: 00:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9">
</head>
<body>

<%!
    long like_status;
    String likeColor;
    String like_size;
%>
<%!

    VotesDao votesDao = new VotesDaoImpl();
    ChallengesDetailDao challengesDetailDao = new ChallengesDetailDaoImpl();
    UserDaoImpl userDao = new UserDaoImpl();

    public void votes(long postid ,long userid) {
        Users users=userDao.findUserById(userid);
        UserNotifications userNotifications =new UserNotificationsImpl();
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance(Locale.US).getTime().getTime());
        Votes votes = votesDao.getVote(postid, userid);
        ChallengeDetail challengeDetail = challengesDetailDao.getChallengeDetail(postid);
        if (votes.getCreate_date() == null) {
            votesDao.addVote(new Votes(
                    challengeDetail, userDao.findUserById(userid), currentTimestamp
            ));
            userNotifications.insert(new ChallengedModel(users.getId(), users.getFullName(),users.getProfilePicture(), challengeDetail.getChallenge_detail_user().getId(), 3, challengeDetail.getChallenge().getHeadLine(), users.getId(),0));


        } else {
            votesDao.deleteVote(votes);
        }
    }
%>
<%
    VotesDao votesDao = new VotesDaoImpl();
    ChallengesDetailDao challengesDetailDao = new ChallengesDetailDaoImpl();
    UserDaoImpl userDao = new UserDaoImpl();
    int postid = Integer.parseInt(request.getParameter("postid"));
    int userid = Integer.parseInt(request.getParameter("userid"));
    int like_number = Integer.parseInt(request.getParameter("like"));
    int votee = Integer.parseInt(request.getParameter("status"));
    BusinessMainpage businessMainpage = new BusinessMainpage();


    if (votee == 1 && like_number >= 0) {
        like_number = like_number - 1;
        like_size = String.valueOf(like_number);
        votes(postid,userid);

    } else if (votee == 0) {
        like_number = like_number + 1;
        like_size = String.valueOf(like_number);
        votes(postid,userid);

    }

%>

<div id="response" style="color:<%=likeColor%>;"><%=like_size%>
</div>
<%
    votee = -1;
    like_number = -1;
    likeColor = null;
    like_size = null;
%>

</body>
</html>
