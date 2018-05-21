<%@ page import="com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.ChallengesDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.ChallengesDao" %>
<%@ page import="com.appchallengers.appchallengers.model.response.SearchChallengesResponseModel" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %><%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 25.4.2018
  Time: 04:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9">
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
    <title>AppChallengers</title>
</head>
<%!
 String data;
    List<UsersBaseDataResponseModel> listperson;
    List<SearchChallengesResponseModel> listheadline;
    Users users;
%>
<%
    HttpSession session1 = request.getSession(false);
    String userName = null;
    javax.servlet.http.Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (javax.servlet.http.Cookie cookie : cookies) {
            if (cookie.getName().equals("user"))
                userName = cookie.getValue();


        }
    }else{
        userName=(String)session1.getAttribute("username");
    }
    if(userName==null){
        response.sendRedirect("errorpage.jsp");
    }
    UserDao userDao= new UserDaoImpl();
    users=userDao.findByEmail(userName);
    ChallengesDao challengesDao= new ChallengesDaoImpl();
    data=request.getParameter("word");
    String word="%"+data+"%";
    listperson=userDao.search(word);
    listheadline=challengesDao.search(word);
    Thread.sleep(1000);
%>
<body>
<div class="text-muted">Kişiler</div>
<hr>
<%if(listperson!=null && listperson.size()!=0){%>
<%for(UsersBaseDataResponseModel feed: listperson){%>
<ul class="list-inline">
    <li>

        <%if(feed.getId()==users.getId()){%>
            <div class="profil-image" >
            <a href="./myprofile.jsp">
                <%if(feed.getProfile_picture()==null || feed.getProfile_picture()=="" ){%>
                <img src="/images/defaultprofil.png"  class="daireselimage">
                <%}else{%>
                <img src="<%=feed.getProfile_picture()%>" alt="profil.jpg"  class="daireselimage">
                <%}%>

                <!-- yukarıya resim dinamik gelecek-->
            </a>
            </div>
        <%}else{%>
            <div class="profil-image" >
                <a href="./profile.jsp=<%=feed.getId()%>">
                    <%if(feed.getProfile_picture()==null || feed.getProfile_picture()=="" ){%>
                    <img src="/images/defaultprofil.png"  class="daireselimage">
                    <%}else{%>
                    <img src="<%=feed.getProfile_picture()%>" alt="profil.jpg"  class="daireselimage">
                    <%}%>

                    <!-- yukarıya resim dinamik gelecek-->
                </a>
            </div>
            <%}%>

    <li>

    <%if(feed.getId()==users.getId()){%>
    <div  class="fullname text-info">
        <a href="./myprofile.jsp">
            <strong><%=feed.getFullName()%></strong>
        </a>
    </div>
    <%}else{%>

    <div  class="fullname text-info">
        <a href="./profile.jsp?ref=<%=feed.getId()%>">
            <strong><%=feed.getFullName()%></strong>
        </a>
    </div>
    <%}%>

    </li>
</ul>
<hr>
<%}%>
<%}%>
<div class="text-muted">Headlines</div>
<hr>
<%if(listheadline!=null && listheadline.size()!=0){%>
<%for(SearchChallengesResponseModel feed: listheadline){%>
<ul class="list-inline">
    <li>
        <a href="challengedetail.jsp?ref=<%=feed.getChallengeId()%>"><%=feed.getHeadLine()%></a>
    </li>
</ul>
<hr>
<%}%>
<%}%>
</body>
</html>
