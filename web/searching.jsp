<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: MHMTNASIF
  Date: 25.04.2018
  Time: 23:04
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
    <script src="Scripts/jquerylib.js" type="text/javascript"></script>
    <title>AppChallengers</title>
</head>
<body>
<%!
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
%>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-2"></div>
            <div class="col-sm-8">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" onclick="toggle()"  data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.jsp">AppChallengers</a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li ><!-- Give Link!--><a href="index.jsp"><i class="glyphicon glyphicon-home"></i></a></li>
                        <li><a href="trends.jsp"><!-- Give Link!--><i class="glyphicon glyphicon-fire"></i></a></li>
                        <li ><a href="myprofile.jsp"><!-- Give Lİnk!--><i class="glyphicon glyphicon-user"></i></a></li>
                        <li data-toggle="modal" data-target="#mynotification"><a href="javascript:notification();"><!-- Give L�nk!--><i class="glyphicon glyphicon-star"></i></a></li>
                    </ul>
                    <form class="navbar-form">
                        <div class="input-group">
                            <input type="text" class="form-control input-md" onkeyup="searchh()" id="myInput" placeholder="Search" name="search" >
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-sm-2"></div>
        </div>
    </div>
</nav>
<br><br><br>

<div class="container">
    <div class="row">
        <div class="col-sm-2"></div>
        <div class="col-sm-8" style="margin-bottom: 600px">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div id="search-message">
                        <div class="alert alert-info alert-dismissible fade in">
                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                            <strong>Yukarıdaki arama kutucuğundan arkadaşlarınızı , kişileri ve challengeları arayabilirsiniz !</strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-2"></div>
    </div>
</div>

<!--FOOTER-->
<hr>
<div class="container">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
        <ul class="list-inline">
            <li><a href="footerinfo.jsp"><strong>HAKIMIZDA</strong></a></li>
            <li><a href="footerinfo.jsp"><strong>DESTEK</strong></a></li>
            <li><a href="footerinfo.jsp"><strong>GİZLİLİK</strong></a></li>
            <li><a href="footerinfo.jsp"><strong>KOŞULLAR</strong></a></li>
            <ul class="list-inline pull-right">
                <li><div> <div class="text-muted"><span class="glyphicon glyphicon-copyright-mark"></span>2018 AppChallengers</div></div></li>
            </ul>
        </ul>
    </div>
    <div class="col-sm-2"></div>
</div>
<!--FOOTER-->

<!-- NOTİFİCATİON MODAL-->
<div class="modal fade" id="mynotification" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Bildirimler</h4>
            </div>
            <div class="modal-body" id="notification">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- NOTİFİCATİON MODAL-->

<script  type="text/javascript">

    function searchh() {
        $("#panel-body").html("");
        var s=$("#myInput").val();
        var uzunluk=s.length;
        if(uzunluk>=2){
                $.ajax({
                    url:"./searchrsp.jsp",
                    type:"POST",
                    data:{word:s},
                    success: function (cevap) {
                        // $("#"+like_idd).html(cevap);
                        $('.panel-body').html(cevap);
                    }
                });
        }
    }

    // BİLDİRİM MODALI
    function notification() {
        sessionStorage.setItem("notifi","0");
        $(".glyphicon-star").css("color","white");
        $.ajax({
            url:"./notifications.jsp",
            data:{userid:<%=users.getId()%>},
            success: function (cevap) {
                $('#notification').html(cevap);
            }
        });

    }

    $('#myInput').click(function () {
        $('#search-message').hide();
    });

    function toggle() {
        $('.collapse').toggle();
    }





    //NOTİFİCATİON
    var connection = new WebSocket('ws://appchallengers.com:80/websocketserver');

    connection.onopen = function () {
        connection.send("<%=users.getId()%>");
    };

    // Log errors
    connection.onerror = function (error) {
        console.error('WebSocket Error ' + error);
    };

    // Log messages from the server
    connection.onmessage = function (e) {

        var sonuc=e.data.toString();
        if(sonuc=="1"){
            sessionStorage.setItem("notifi","1");
            $(".glyphicon-star").css("color","red");
        }
    };

    $(document).ready(function () {
        var notifiy=sessionStorage.getItem("notifi").toString();
        if(notifiy==1){
            $(".glyphicon-star").css("color","red")
        }
    });
</script>

</body>
</html>
