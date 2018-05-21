<%@ page import="com.appchallengers.appchallengers.dao.dao.UserNotifications" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserNotificationsImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appchallengers.appchallengers.mongodb.model.ChallengedModel" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.mongodb.dao.ChallengedDao" %>
<%@ page import="com.appchallengers.appchallengers.mongodb.daoimpl.ChallengedDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: MHMTNASIF
  Date: 19.04.2018
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootsrapt lins -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="Scripts/jquerylib.js" type="text/javascript"></script>
    <style>
        .dairesel{
            width: 50px;
            height: 50px;
            border-radius: 150px;
            -webkit-border-radius: 150px;
            -moz-border-radius: 150px;
            background: url(http://resim-dosyasinin.adresi/resim.jpg) no-repeat;
        }
    </style>
    <title>Title</title>
</head>
<body>
<%!
    UserNotifications userNatifications;
    List<ChallengedModel> notificationlist;
    int userid;
    String natification_content = "";
%>
<%
    ChallengedDao challengedDao= new ChallengedDaoImpl();
    userid=Integer.parseInt(request.getParameter("userid"));
    userNatifications=new UserNotificationsImpl();
    notificationlist=userNatifications.getUserNotifications(userid);
    challengedDao.setFlag(userid);
    String image=null;
%>

<%for(ChallengedModel feed:  notificationlist){%>
  <%    int  type=feed.getType();
    if (type== 0) {
        natification_content = " " + "sana " + feed.getChallengeHeadLine()+" için meydan okudu";
    } else if (type == 1) {
        natification_content = " " + "sana arkadaş isteği gönderdi";
    } else if (type == 2) {
        natification_content = " " + "senin arkadaş isteğini kabul etti";
    } else if (type== 3) {
        natification_content = " " + "senin " + feed.getChallengeHeadLine() + " için meydan okumanı beğendi";
    }

%>

<ul class="list-inline" >
    <li><a href="profile.jsp?ref=<%=feed.getFromId()%>"><img src="<%=feed.getFromUserProfilePicture()%>"  class="dairesel"></a></li>
    <li><%=feed.getFromUserFullName()%><%=natification_content%></li>
</ul>
     <hr>
    <%}%>


</body>
</html>
