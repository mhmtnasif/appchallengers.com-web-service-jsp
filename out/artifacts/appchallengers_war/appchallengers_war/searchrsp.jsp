<%@ page import="com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.ChallengesDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.ChallengesDao" %>
<%@ page import="com.appchallengers.appchallengers.model.response.SearchChallengesResponseModel" %><%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 25.4.2018
  Time: 04:00
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

        .daireselimage{
            width: 30px;
            height: 30px;
            border-radius: 150px;
            -webkit-border-radius: 150px;
            -moz-border-radius: 150px;
            background: url(http://resim-dosyasinin.adresi/resim.jpg) no-repeat;
        }

    </style>
    <title>Title</title>
</head>
<%!
 String data;
    List<UsersBaseDataResponseModel> listperson;
    List<SearchChallengesResponseModel> listheadline;
%>
<%
    ChallengesDao challengesDao= new ChallengesDaoImpl();
    UserDao userDao= new UserDaoImpl();
    data=request.getParameter("word");
    System.out.println("Çalıştıııtıııııııııııı"+"------>>"+data);
    String word="%"+data+"%";
    listperson=userDao.search(word);
    listheadline=challengesDao.search(word);
    Thread.sleep(1000);
%>
<body>
<div class="text-muted">Kişiler</div>
<%for(UsersBaseDataResponseModel feed: listperson){%>
<ul class="list-inline">
    <li>
        <div class="profil-image" >
            <a href="http://localhost:8080/profile.jsp?ref=1">
                <%if(feed.getProfile_picture()==null || feed.getProfile_picture()=="" ){%>
                <img src="/images/defaultprofil.png"  class="daireselimage">
                <%}else{%>
                <img src="<%=feed.getProfile_picture()%>" alt="profil.jpg"  class="daireselimage">
                <%}%>

                <!-- yukarıya resim dinamik gelecek-->
            </a>
        </div>
    <li>
        <div  class="fullname text-info">
            <a href="http://localhost:8080/profile.jsp?ref=1">
                <strong><%=feed.getFullName()%></strong>
            </a>
        </div>
    </li>
</ul>
<hr>
<%}%>
<div class="text-muted">Headlines</div>
<%for(SearchChallengesResponseModel feed: listheadline){%>
<ul class="list-inline">
    <li>
        <a href="challengedetail.jsp?ref=<%=feed.getChallengeId()%>"><%=feed.getHeadLine()%></a>
    </li>
</ul>
<hr>
<%}%>
</body>
</html>
