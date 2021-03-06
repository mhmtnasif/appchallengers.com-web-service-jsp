<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.RelationshipDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.RelationshipDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.response.ChallengeResponseModel" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.GetUserInfoDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.GetUserInfoDao" %>
<%@ page import="com.appchallengers.appchallengers.model.response.GetUserInfoResponseModel" %>
<%@ page import="com.appchallengers.appchallengers.mongodb.model.ChallengedModel" %>
<%@ page import="com.google.gson.Gson" %>
<%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 15.4.2018
  Time: 22:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootsrapt lins -->
    <link rel="icon" href="images/ic_logo.png"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="Scripts/jquerylib.js" type="text/javascript"></script>

    <style>
        .daireselprofil{
            width: 150px;
            height: 150px;
            border-radius: 150px;
            -webkit-border-radius: 150px;
            -moz-border-radius: 150px;
            background: url(http://resim-dosyasinin.adresi/resim.jpg) no-repeat;
            margin-right: 10px;
            margin-bottom: 20px;
        }
        .dairesel{
            width: 50px;
            height: 50px;
            border-radius: 150px;
            -webkit-border-radius: 150px;
            -moz-border-radius: 150px;
            background: url(http://resim-dosyasinin.adresi/resim.jpg) no-repeat;
        }

        .nav-tabs > li, .nav-pills > li {
            float:none;
            display:inline-block;
            *display:inline; /* ie7 fix */
            zoom:1; /* hasLayout ie7 trigger */
        }

    </style>

    <title>AppChallengers</title>
</head>
<body>

<%!
  RelationshipDao relationshipDao;
    Users users;
    List<ChallengeResponseModel> userChallengeFeedList;
    GetUserInfoResponseModel getUserInfoResponseModel;

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
        relationshipDao=new RelationshipDaoImpl();
        GetUserInfoDao getUserInfoDao= new GetUserInfoDaoImpl();
        userChallengeFeedList = getUserInfoDao.getUserChallenges(users.getId(), users.getId());
        getUserInfoResponseModel=getUserInfoDao.getUserInfo(users.getId(),users.getId());
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
                        <li ><!-- Give Link!--><a href="index.jsp?not"><i class="glyphicon glyphicon-home"></i></a></li>
                        <li><a href="trends.jsp"><!-- Give Link!--><i class="glyphicon glyphicon-fire"></i></a></li>
                        <li class="active"><a href="myprofile.jsp"><!-- Give Lİnk!--><i class="glyphicon glyphicon-user"></i></a></li>
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

</div>
<%if(users!=null && getUserInfoResponseModel!=null){%>
<div class="container" >
    <div class="row">
        <div class="col-sm-2">
        </div>
        <div class="col-sm-8" >
            <div class="text-center">
                <ul class="list-inline">
                    <li>
                        <%if(users.getProfilePicture()==null || users.getProfilePicture()=="" ){%>
                        <p><img src="/images/defaultprofil.png"  class="daireselprofil"></p>
                        <%}else{%>
                        <p><img src="<%=users.getProfilePicture()%>" alt="profij.jpg" class="daireselprofil"></p>
                        <%}%>
                    </li>
                    <li>
                        <ul  style="list-style-type:none" >
                            <li>
                                <ul class="list-inline">
                                    <li><h3><%=users.getFullName()%></h3></li>
                                    <li id="setting" > <div class="dropdown">
                                        <button class="btn btn-default dropdown-toggle input-sm" type="button" data-toggle="dropdown">
                                            <span class="glyphicon glyphicon-cog"></span>
                                            <span class="caret"></span></button>
                                        <ul class="dropdown-menu">
                                            <li><a href="changepassword.jsp">Genel Ayarlar</a></li>
                                            <li><a href="LogoutServlet">Çıkış Yap</a></li>
                                            <li><a href="#">İptal</a></li>
                                        </ul>
                                    </div></li>
                                </ul>
                            </li>
                            <li  style="margin-top:8px">
                                <ul class="list-inline">
                                    <li class="info"><strong><%=getUserInfoResponseModel.getChallenges() %></strong> Meydan Okuduklarım</li>
                                    <li class="info modal-like"  id="friends" data-toggle="modal" data-target="#arkadaslar" ><strong><%=getUserInfoResponseModel.getFriends() %></strong> Arkadaşlar</li>
                                    <li class="info"><strong><%=getUserInfoResponseModel.getAccepted_challenges()%></strong> Kabul Edilen Meydan Okumalar</li>

                                </ul>
                            </li>
                        </ul>

                    </li>
                </ul>
            </div>
            <hr>
            <ul class="nav nav-tabs nav-justified">
                <li id="mychallenge" class="active"><a href="javascript:myChallenge();"><strong>Meydan Okuduklarım</strong></a></li>
                <li id="acceptedchallenge"><a href="javascript:acceptedChallenge();"><strong>Kabul Edilen Meydan Okumalar</strong> </a></li>
            </ul>
        </div>
        <div class="col-sm-2">
        </div>
    </div>
</div>
<%}%>
<!--NO CONTENT -->
<%if(userChallengeFeedList!=null){%>
<%if(userChallengeFeedList.size()==0){%>
<br><br><br><br><br><br><br><br>
<div class="container">
    <div class="row">
        <div class="col-sm-2" style="margin-bottom: 400px"></div>
        <div class="col-sm-8">
            <div class="alert alert-success alert-dismissible">
                <div class="text-center">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>HOŞGELDİNİZ!</strong> Sayfa Akışınızda herhangi bir paylaşımınız veya arkadaşınız olmadığından içerik bulunmamaktadır.!
                </div>
            </div>
        </div>
        <div class="col-sm-2"></div>
    </div>
</div>
<%}%>
<div class="content">
    <%for(ChallengeResponseModel feed: userChallengeFeedList){%>
    <div class="container">
        <div class="row">
            <!-- LEFT PART -->
            <div class="col-sm-2"></div>
            <!-- CONTENT PART-->
            <div class="col-sm-8">
                <!-- PANEL BEGINNIG -->
                <div class="vote" id="vote-<%=feed.getChallenge_detail_id()%>"><%=feed.getVote()%></div>
                <div class="panel panel-default" id="p<%=feed.getChallenge_detail_id()%>">
                    <div class="panel-heading " style="background-color: #fefefe">
                        <ul class="list-inline">
                            <li>

                                    <%if(users.getProfilePicture()==null || users.getProfilePicture()=="" ){%>
                                <img src="/images/defaultprofil.png"  class="dairesel">
                                    <%}else{%>
                                        <img src="<%=feed.getProfilepicture()%>" alt="profil.jpg"  class="dairesel">
                                    <%}%>
                            <li>
                                <div class="text-info"><strong><%=feed.getFullname()%></strong></div><!-- jsp?=feed.getChallenge_detail_user_id()-->
                            </li>
                            <li><strong>></strong></li>
                            <li><a href="challengedetail.jsp?ref=<%=feed.getChallenge_id()%>"><%=feed.getHeadline()%></a></li>
                        </ul></div>
                    <div class="panel-body">
                        <div align="center"  class="embed-responsive embed-responsive-4by3">
                            <video id="video-<%=feed.getChallenge_detail_id()%>" controls muted autoplay loop class="embed-responsive-item" onclick="this.paused ? this.play() : this.pause();">
                                <source src="<%=feed.getChallenge_url()%>" type="video/mp4">
                                <track src="<%=feed.getChallenge_url()%>" label="English subtitles"
                                       kind="subtitles" srclang="en" default></track>
                            </video>
                        </div>
                    </div>
                    <div class="panel-footer" style="background-color: #fefefe">

                        <ul class="list-inline">
                            <li>
                                <button type="button" style="color:#fd5739" class="btn btn-default btn-sm" id="btnlike-<%=feed.getChallenge_detail_id()%>"><span
                                        id="likethumb-<%=feed.getChallenge_detail_id()%>"  class="glyphicon glyphicon-thumbs-up" ></span>Like
                                </button>
                            </li>
                            <li><div class="modal-like" id="likenumber-<%=feed.getChallenge_detail_id()%>" data-toggle="modal" data-target="#begenenler" ><%=feed.getLikes()%></div></li>

                        </ul>

                        <!--  <span class="pull-right"><i class="glyphicon glyphicon-search"></i></span> -->
                    </div>
                    <!-- PANEL ENDING -->
                </div>
            </div>
            <!--RIGHT PART -->
            <div class="col-sm-2"></div>
        </div>
    </div>

    <script  type="text/javascript">
        $(document).ready(function () {
            $('.vote').hide();
            <% if(feed.getVote()==1){ %>
            $('#btnlike-<%=feed.getChallenge_detail_id()%>').css("background-color","#fd5739");
            $('#btnlike-<%=feed.getChallenge_detail_id()%>').css("color","white");
            $("#likethumb-<%=feed.getChallenge_detail_id()%>").css("color","white");
            <%}%>
        });

    </script>
    <%}%>
    <%}%>

</div>
<div class="modal fade" id="begenenler" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Begenenler</h4>
            </div>
            <div class="modal-body" id="modal-content">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="arkadaslar" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Akadaşlar</h4>
            </div>
            <div class="modal-body" id="modal-arkadaslar">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
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
<hr>
<div class="container" style="margin-top: 500px">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
        <ul class="list-inline">
            <li><a href="footerinfo.jsp"><strong style="color:#fd5739;">HAKIMIZDA</strong></a></li>
            <li><a href="footerinfo.jsp"><strong style="color:#fd5739;">DESTEK</strong></a></li>
            <li><a href="footerinfo.jsp"><strong style="color:#fd5739;">GİZLİLİK</strong></a></li>
            <li><a href="footerinfo.jsp"><strong style="color:#fd5739;">KOŞULLAR</strong></a></li>
            <ul class="list-inline pull-right">
                <li><div> <div class="text-muted"><span class="glyphicon glyphicon-copyright-mark"></span>2018 AppChallengers</div></div></li>
            </ul>
        </ul>
    </div>
    <div class="col-sm-2"></div>

</div>

<script  type="text/javascript">
    var status=-1;
    function acceptedChallenge() {
        status=0;
        $('#acceptedchallenge').addClass("active");
        $('#mychallenge').removeClass("active");
        $.ajax({
            url:"./Acceptedresponse.jsp",
            data:{userid:<%=users.getId()%>,status:status},
            success:function (response) {
                $(".content").html(response);
            }
        });

    }
    function myChallenge() {
        status=1;
        $('#acceptedchallenge').removeClass("active");
        $('#mychallenge').addClass("active");
        $.ajax({
            url:"./Acceptedresponse.jsp",
            data:{userid:<%=users.getId()%>,status:status},
            success:function (response) {
                $(".content").html(response);
            }
        });
    }
    $(".info").hover(function () {
        $(this).css("cursor","pointer");
    },function () {
    });
    $(".glyphicon").hover(function () {
        $(this).css("cursor","pointer");
    },function () {
    });
    // Arkadaşlar modalını doldurur
    $('#friends').click(function () {
        $.ajax({
            url:"./friendsrsp.jsp",
            data:{userid:<%=users.getId()%>},
            success: function (cevap) {
                $('#modal-arkadaslar').html(cevap);
            }
        });
    });

    $('.modal-like').click(function () {
        var id=$(this).attr('id').toString();
        var index= id.indexOf("-");
        var post_id = id.slice(index+1);
        $.ajax({
            url:"./likepeopleresponse.jsp",
            data:{postid:post_id},
            success: function (cevap) {
                // $("#"+like_idd).html(cevap);
                $('#modal-content').html(cevap);
            }
        });
    });

  function toggle() {
      $('.collapse').toggle();
  }

    $(".modal-like").hover(function () {
        $(this).css("cursor","pointer");
    },function () {
    });


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

    $('.btn').click(function () {
        var id=$(this).attr('id').toString();            // Tıklanılan butonun id sin, al
        var index= id.indexOf("-");                     // btnlike- kısmını at sadece id yi al  "clear_id"
        var id_firstpart = id.slice(0,index);           // - den öncesini al ve kontrol et like mı dislike butonumu
        var id_lenght=id_firstpart.length;              // uzunluğu 7 ise btnlike eger 10 ise btndislike butonuna basılmıs
        var clear_id = id.slice(index+1);               // Tıklanınlan postun saf id sine ulasatık buton id üzarinden
        var  vote=$('#vote-'+clear_id).html();
        if(id_lenght==7){                               // like butonuna basılma durumu
            var like_idd="likenumber-"+clear_id;         // begenelerin sayısısnı yazan div in id si
            var like_sayısı=$("#"+like_idd).html().trim().toString();
            var color="black";
            $.ajax({
                url:"./likeresponse.jsp",
                data:{postid:clear_id,userid:<%=users.getId()%>,like:like_sayısı.toString(),status:vote},
                success: function (cevap) {
                    $("#"+like_idd).html($(cevap).filter("div").html());
                    if(vote==0){
                        $('#vote-'+clear_id).html(1);
                        $('#btnlike-'+clear_id).css("background-color","#fd5739");
                        $('#btnlike-'+clear_id).css("color","white");
                        $("#likethumb-"+clear_id).css("color","white");
                    }else if(vote ==1){
                        $('#vote-'+clear_id).html(0);
                        $('#btnlike-'+clear_id).css("background-color","white");
                        $('#btnlike-'+clear_id).css("color","#fd5739");
                        $("#likethumb-"+clear_id).css("color","#fd5739");
                    }
                }
            });
        }
    });


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
