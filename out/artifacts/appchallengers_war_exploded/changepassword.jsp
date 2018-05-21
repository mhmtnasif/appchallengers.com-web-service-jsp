<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.web.bussiness.BusinessMainpage" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.appchallengers.appchallengers.util.Util" %><%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 16.4.2018
  Time: 00:30
  To change this template use File | Settings | File Templates.
--%>

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
    <link rel="icon" href="images/ic_logo.png"/>
    <style>

        .daireselprofil{
            width: 70px;
            height: 70px;
            border-radius: 150px;
            -webkit-border-radius: 150px;
            -moz-border-radius: 150px;
            background: url(http://resim-dosyasinin.adresi/resim.jpg) no-repeat;
            margin-right: 10px;
            margin-bottom: 20px;
        }

        .vertical-center {
            min-height: 100%;  /* Fallback for browsers do NOT support vh unit */
            min-height: 100vh; /* These two lines are counted as one :-)       */

            display: flex;
            align-items: center;
        }
        .mycontent-left {
            border-right: 1px solid #a6a6a6;
        }

    </style>

    <title>AppChallengers</title>
</head>
<body>

<%!
  Users users;
    BusinessMainpage bsm;
    int check=-1;
    int check2=-1;
    String lastpassword;
    String mdpassword;
    String mdnewpassword;
    String errormessage="";
    String infomesage="";
    int checkupdateinfo=-1;

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
    }else{

        UserDao userDao= new UserDaoImpl();
        users= userDao.findByEmail(userName);
        if(request.getParameter("changepassword")!=null){
            lastpassword=(String)request.getParameter("expassword");
            mdpassword= Util.hashMD5(lastpassword);
            if(users.getPasswordHash().equals(mdpassword)){
                mdnewpassword=Util.hashMD5((String)request.getParameter("password"));
                userDao.changePassword(users.getId(),mdnewpassword);
                check=1;
            }else {
                check=0;
                errormessage="Eski Şifreniz Hatalı !";
            }
        }
        if(request.getParameter("changemail")!=null){
            request.setCharacterEncoding("utf-8");
            if(users.getEmail().equals(request.getParameter("username"))){
                check=1;
                userDao.updateEmail(users.getId(),String.valueOf(request.getParameter("newusername")));
                response.sendRedirect("LogoutServlet");
            }else {
                check=0;
                errormessage="Eski mail adresiniz Hatalı !";
            }
        }

        if(request.getParameter("save-info")!=null){
            request.setCharacterEncoding("utf-8");
            String name=request.getParameter("fullname");
            String country=request.getParameter("country");
            byte[] bytes = new byte[name.length()];
            for (int i = 0; i < name.length(); i++) bytes[i] = (byte) name.charAt(i);
            String outputname = new String(bytes, "UTF-8");
            if(name!=null && name!="" && country!=null && country!=""){
                userDao.updateProfileWithoutPhoto(users.getId(),outputname,country);
                infomesage="Bilgileriniz Güncellendi !";
                checkupdateinfo=1;
            }
        }
        if(request.getParameter("remove-profile")!=null){
            userDao.deleteProfilePhoto(users.getId());
        }
    }

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
                        <li><a href="#"><!-- Give Link!--><i class="glyphicon glyphicon-fire"></i></a></li>
                        <li class="active"><a href="#"><!-- Give Lİnk!--><i class="glyphicon glyphicon-user"></i></a></li>
                        <li data-toggle="modal" data-target="#mynotification"><a href="javascript:notification();"><!-- Give L�nk!--><i class="glyphicon glyphicon-star"></i></a></li>
                    </ul>
                    <form class="navbar-form navbar-right" action="searching.jsp">
                        <button type="submit" class="btn btn-default input-sm" >
                            <span class="glyphicon glyphicon-search"></span>   Search
                        </button>
                    </form>
                </div>
            </div>
            <div class="col-sm-2"></div>
        </div>
    </div>
</nav>

<br><br><br><br><br>

 <div class="container">
     <div class="row">
         <div class="col-sm-2"></div>
         <div class="col-sm-8">
             <%if(check==0){%>
             <div class="alert alert-danger alert-dismissible">
                 <div class="text-center">
                 <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                 <strong>UYARI !</strong>  <%=errormessage%>
                 </div>
             </div>
             <%}%>
             <%if(checkupdateinfo==1){%>
             <div class="alert alert-success alert-dismissible">
                 <div class="text-center">
                     <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                     <strong>UYARI !</strong>  Bilgileriniz Güncellendi !
                 </div>
             </div>
             <%}%>
             <div class="panel panel-default">
                 <div class="panel-header">
                     <div class="text-center">
                         <ul class="list-inline" style="margin-top: 30px">

                             <li>
                                 <%if(users.getProfilePicture()==null || users.getProfilePicture()=="" ){%>
                                 <img src="/images/defaultprofil.png"  class="daireselprofil">
                                 <%}else{%>
                                 <img src="<%=users.getProfilePicture()%>" alt="profil.jpg" class="daireselprofil">
                                 <%}%>
                                 </li>
                             <li><h4><%=users.getFullName()%></h4></li>
                         </ul>
                     </div>
                 </div>
                 <ul class="nav nav-tabs nav-justified">
                     <li id="sifredegistir" class="active"><a href="javascript:sifreDegistir();"><strong style="color: #fd5739;">Şifre Değiştir</strong></a></li>
                     <li id="profilpic"><a href="javascript:changepic();"><strong style="color: #fd5739;">Bilgileri Güncelle</strong> </a></li>
                     <li id="profilduzenle"><a href="javascript:profiliDüzenle();"><strong style="color: #fd5739;">Profil Resmini Değiş</strong> </a></li>
                     <li id="izinler"><a href="javascript:izinler();"><strong style="color: #fd5739;">Email Değiş</strong> </a></li>

                 </ul>

                  <div class="panel-body">

                         </div>
                     </div>
                 </div>
             </div>
         </div>
         <div class="col-sm-2"></div>
     </div>
 </div>

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

<!--FOOTER-->
<hr>
<div class="container" style="margin-top: 500px">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
        <ul class="list-inline">
            <li><a href="footerinfo.jsp"><strong  style="color: #fd5739;">HAKIMIZDA</strong></a></li>
            <li><a href="footerinfo.jsp"><strong style="color: #fd5739;">DESTEK</strong></a></li>
            <li><a href="footerinfo.jsp"><strong style="color: #fd5739;">GİZLİLİK</strong></a></li>
            <li><a href="footerinfo.jsp"><strong style="color: #fd5739;">KOŞULLAR</strong></a></li>
            <ul class="list-inline pull-right">
                <li><div> <div class="text-muted"><span class="glyphicon glyphicon-copyright-mark"></span>2018 AppChallengers</div></div></li>
            </ul>
        </ul>
    </div>
    <div class="col-sm-2"></div>
</div>
<!--FOOTER-->

<script  type="text/javascript">

    var status=-1;
    function sifreDegistir() {
        status=0;
        $('#sifredegistir').addClass("active");
        $('#profilduzenle').removeClass("active");
        $('#izinler').removeClass("active");
        $('#profilpic').removeClass("active");
        $.ajax({
            url:"./changepasswordrsp.jsp",
            success:function (response) {
                $(".panel-body").html(response);
            }
        });

    }
    function profiliDüzenle() {
        status=1;
        $('#sifredegistir').removeClass("active");
        $('#profilduzenle').removeClass("active");
        $('#izinler').removeClass("active");
        $('#profilpic').addClass("active");

        $('.alert').hide();
        $.ajax({
            url:"./editprofile.jsp",
            success:function (response) {
                $(".panel-body").html(response);
            }
        });
    }
    function izinler() {
        status=2;
        $('#sifredegistir').removeClass("active");
        $('#profilduzenle').removeClass("active");
        $('#profilpic').removeClass("active");
        $('#izinler').addClass("active");
        $('.alert').hide();
        $.ajax({
            url:"./permissions.jsp",
            success:function (response) {
                $(".panel-body").html(response);
            }
        });
    }

    function changepic() {
        status=2;
        $('#sifredegistir').removeClass("active");
        $('#profilduzenle').removeClass("active");
        $('#izinler').removeClass("active");
        $('#profilpic').addClass("active");
        $('.alert').hide();
        $.ajax({
            url:"./infoupdatersp.jsp",
            success:function (response) {
                $(".panel-body").html(response);
            }
        });
    }

    $(document).ready(function () {
        $.ajax({
            url:"./changepasswordrsp.jsp",
            success:function (response) {
                $(".panel-body").html(response);
            }
        });
    });
    $('.menu-item').click(function() {
        $('.in').collapse('hide');
    });

    function toggle() {
        $('.collapse').toggle();
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
