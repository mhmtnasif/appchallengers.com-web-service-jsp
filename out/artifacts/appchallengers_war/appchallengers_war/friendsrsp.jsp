<%@ page import="com.appchallengers.appchallengers.dao.dao.RelationshipDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.RelationshipDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 15.4.2018
  Time: 18:42
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
<body>

<%!
   int userid;
    Users users;
    List<UsersBaseDataResponseModel> usersBaseDataResponseModelList;
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
    UserDao userDao= new UserDaoImpl();
     users=userDao.findByEmail(userName);
   userid=Integer.parseInt(request.getParameter("userid"));
    RelationshipDao relationshipDao= new RelationshipDaoImpl();
    usersBaseDataResponseModelList =relationshipDao.getFriends(userid);
%>
<%for(UsersBaseDataResponseModel feed: usersBaseDataResponseModelList){%>
<ul class="list-inline">
    <li>

        <%if(feed.getId()==users.getId()){%>
        <%System.out.println(feed.getId()+"<<------>>>"+userid);%>
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
        <%}else {%>

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
    <div class="profil-image" >
        <div  class="fullname text-info">
            <a href="http://localhost:8080/myprofile.jsp">
                <strong><%=feed.getFullName()%></strong>
            </a>
        </div>
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
