<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%@ page import="com.appchallengers.appchallengers.util.EmailUtil" %><%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 18.2.2018
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootsrapt lins -->
    <link rel="icon" href="images/ic_logo.png"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="Script/jquerylib.js" type="text/javascript"></script>

    <title>AppChallengers</title>
</head>
<body style="background-color:#fdfbfb ">


<%!
    String mail_sonuc;
    String  subject;
    String body;
    String username;
    String mailson;
    String mail="Bir mail Doğrulama isteğinde yada şifre değiştirme isteğinde " +
            "bulunduysan aşağıdaki linki tarayıcıya yapıştır ve bilgilerini gir.Böyle bir istekte bulunmadıysan," +
            "bu epostayı yoksayabilirsin";

%>

<%
    HttpSession session1=request.getSession(false);
    javax.servlet.http.Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (javax.servlet.http.Cookie cookie : cookies) {
            if (cookie.getName().equals("user"))
                username = cookie.getValue();


        }
    }else{
        username=(String)session1.getAttribute("username");
    }

    subject="Confirm Email";
    UserDao userDao = new UserDaoImpl();
    Users user= userDao.findByEmail(username);
    body="http://appchallengers.com/confirm.jsp?id="+user.getId()+"&hash="+user.getPasswordSalt();
    mailson=mail+" "+body;
    try{
        if(EmailUtil.sendEmail(user.getEmail(),subject,mailson)){
            mail_sonuc="Mailinize doğrulama postası gönderildi!<br>Lütfen kontrol ediniz...";
        }else{
            mail_sonuc="Beklenmedik bir hata oluştu! Lütfen daha sonra tekrar deneyiniz..";
        }
    }catch (Exception e){
        System.out.println(e.getMessage());
    }

%>

<div class="container">

    <div class="row">
        <!-- LEFT PART -->
        <div class="col-sm-4"></div>
        <!-- CONTENT PART-->
        <div class="col-sm-4">
            <!-- PANEL BEGINNIG -->
            <br><br><br><br>
            <div class="panel panel-default">

                <div class="panel-body">

                    <div class="text-center text-muted" style="margin-top: 200px" >
                        <h2>AppChallengers</h2>
                            <br>
                    </div>
                    <!-- FORM BEGINNIG-->
                    <form action="ConfirmMailServlet" method="POST" data-toggle="validator" role="form">
                        <div class="text-success text-center"><%=mail_sonuc%></div>
                        <br>
                        <button type="submit" name="send_mail" id="btn-mailsend" class="btn btn-primary btn-block" style="background-color: #fd5739;color: white;margin-bottom: 200px">Tekrar Gönder</button>
                    </form>
                    <!-- FORM ENDİNG-->

                    <!-- PANELBODY ENDING -->
                </div>
                <!--PANEL FOOTER -->

            </div>
            <br><br><br><br>

            <!--RIGHT PART OF COLOUM -->
            <div class="col-sm-4" ></div>
        </div>
    </div>
</div>

<script src="Script/sendmail.js" type="text/javascript"></script>

</body>
</html>
