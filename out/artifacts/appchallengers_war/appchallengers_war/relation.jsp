<%@ page import="com.appchallengers.appchallengers.dao.dao.RelationshipDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserNotifications" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.RelationshipDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserNotificationsImpl" %>
<%@ page import="com.appchallengers.appchallengers.mongodb.model.ChallengedModel" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %><%--
  Created by IntelliJ IDEA.
  User: MHMTNASIF
  Date: 18.04.2018
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    int status;
    int visitorid;
    int visitedid;
    RelationshipDao relationshipDao;
    String a;
    int firstuser;
    int seconduser;

%>
<%
    UserNotifications userNotifications = new UserNotificationsImpl();
    visitedid = Integer.parseInt(request.getParameter("visitedid"));  // diğer kullanıcı
    visitorid = Integer.parseInt(request.getParameter("visitorid")); //oturum sahibi
    System.out.println("oturum >>>"+visitorid);

    if(visitorid<visitedid){
        firstuser=visitorid;
        seconduser=visitedid;
    }else{
        firstuser=visitedid;
        seconduser=visitorid;
    }
    status = Integer.parseInt(request.getParameter("status"));
    UserDao userDao=new UserDaoImpl();
    Users users=userDao.findUserById(visitorid);
    System.out.println(status);
    relationshipDao = new RelationshipDaoImpl();

    if (status == 0) {
        relationshipDao.deleteRelationship(firstuser, seconduser);
        a = "1";
    } else if (status == 1) {
        relationshipDao.addRelationship(firstuser, seconduser, visitorid);
        userNotifications.insert(new ChallengedModel(users.getId(), users.getFullName(), users.getProfilePicture(), visitedid, 1, "default", users.getId(), 0));

        a = "2";
    } else if (status == 2) {
        relationshipDao.acceptRelationship(firstuser, seconduser, visitorid);
        userNotifications.insert(new ChallengedModel(users.getId(), users.getFullName(), users.getProfilePicture(), visitedid, 2, "default", users.getId(), 0));
        a = "3";
    }
%>
</body>
</html>
