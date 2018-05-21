<%@ page import="com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.VotesDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %><%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 16.3.2018
  Time: 03:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .daireselimage{
            width: 40px;
            height: 40px;
            border-radius: 150px;
            -webkit-border-radius: 150px;
            -moz-border-radius: 150px;
            background: url(http://resim-dosyasinin.adresi/resim.jpg) no-repeat;
        }
    </style>
</head>
<body>

<%!
  Users users;
%>
<%
    int postid=Integer.parseInt(request.getParameter("postid"));
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
    UserDao userDao= new UserDaoImpl();
    users=userDao.findByEmail(userName);

    //kimlerin begendiği alınacak ve asağıda templet dinamik doldurulacak
    // begenenlerin id si ve  ismi alınacacak
    VotesDaoImpl votesDao=new VotesDaoImpl();
    List<UsersBaseDataResponseModel> usersBaseDatumResponseModels =votesDao.getVotes(postid);
%>
<%for(UsersBaseDataResponseModel feed: usersBaseDatumResponseModels){%>
<ul class="list-inline">
    <li>

        <%if(feed.getId()==users.getId()){%>
            <div class="profil-image" >
                <a href="http://localhost:8080/myprofile.jsp">

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
                <a href="http://localhost:8080/profile.jsp?ref=<%=feed.getId()%>">

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
        <a href="http://localhost:8080/myprofile.jsp">
            <strong><%=feed.getFullName()%></strong>
        </a>
    </div>
    <%}else{%>
    <div  class="fullname text-info">
        <a href="http://localhost:8080/profile.jsp?ref=<%=feed.getId()%>">
            <strong><%=feed.getFullName()%></strong>
        </a>
    </div>
    <%}%>

    </li>
</ul>
<hr>
<%}%>
</body>
</html>
