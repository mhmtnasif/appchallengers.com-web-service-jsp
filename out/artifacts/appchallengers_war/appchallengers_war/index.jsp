<%@ page import="com.sun.org.apache.xpath.internal.SourceTree" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.endpoint.service.UserChallengeService" %>
<%@ page import="com.appchallengers.appchallengers.model.response.ChallengeResponseModel" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.ChallengesDetailDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.ChallengesDetailDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.mongodb.websocket.WebSocketServer" %>
<%@ page import="javax.websocket.Session" %><%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 13.2.2018
  Time: 19:40
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

    <title>$Title$</title>

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

</head>
<body style="background-color:#f3f3f3">


<%!

    Cookie indexCookie = null;
    int pageCheck;
    Users users;
    String deneme;
    String userfullname;

%>
<%
    HttpSession session1 = request.getSession(false);
    UserDao userDao= new UserDaoImpl();
    String userName = null;
    javax.servlet.http.Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (javax.servlet.http.Cookie cookie : cookies) {
            if (cookie.getName().equals("user"))
                userName = cookie.getValue();


        }
    }
    if (userName == null) {
        pageCheck = 0;
    } else {
        users=userDao.findByEmail(userName);
        System.out.println("----->COOKİE BOS DEĞİL" + userName);
        pageCheck = 1;
    }
    if (pageCheck == 0) {
        if (session1.getAttribute("username") == null) {
            pageCheck = 0;
            System.out.println("----->SESSİON BOS DEĞİL");
        } else {
            users=userDao.findByEmail("username");
            pageCheck = 1;
        }
    }
    if (pageCheck != 1) {
        response.sendRedirect("Login.jsp");
    }
    UserDaoImpl userDao1= new UserDaoImpl();
    Users users=userDao1.findByEmail(userName);
    ChallengesDetailDao challengesDetailDao= new ChallengesDetailDaoImpl();
    List<ChallengeResponseModel> userChallengeFeedList =challengesDetailDao.getUserChallengeFeedList(users.getId());

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
                        <li class="active"><!-- Give Link!--><a href="index.jsp"><i class="glyphicon glyphicon-home"></i></a></li>
                        <li><a href="trends.jsp"><!-- Give Link!--><i class="glyphicon glyphicon-fire"></i></a></li>
                        <li ><a href="myprofile.jsp"><!-- Give L�nk!--><i class="glyphicon glyphicon-user"></i></a></li>
                        <li data-toggle="modal" data-target="#mynotification"><a href="javascript:notification();"><!-- Give L�nk!--><i class="glyphicon glyphicon-star"></i></a></li>
                    </ul>
                    <form class="navbar-form navbar-right" action="searching.jsp">
                        <button type="submit" class="btn btn-default" >
                            <span class="glyphicon glyphicon-search"></span>   Search
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-sm-2"></div>
    </div>
</nav>
<br><br><br><br><br>

<!-- POSTLAR -->
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
                            <a href="profile.jsp?ref=<%=feed.getChallenge_detail_user_id()%>" i> <!-- jsp?=feed.getChallenge_detail_user_id()-->
                                <%if(feed.getProfilepicture()==null || feed.getProfilepicture()=="" ){%>
                                <img src="/images/defaultprofil.png"  class="dairesel">
                                <%}else{%>
                                <img src="<%=feed.getProfilepicture()%>" alt="profil.jpg"  class="dairesel">
                                <%}%>
                            </a>
                        <li>
                        <a href="profile.jsp?ref=<%=feed.getChallenge_detail_user_id()%>"><strong><%=feed.getFullname()%></strong></a> <!-- jsp?=feed.getChallenge_detail_user_id()-->
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
                            <button type="button" class="btn btn-default btn-sm" id="btnlike-<%=feed.getChallenge_detail_id()%>"><span
                                    class="glyphicon glyphicon-thumbs-up" ></span>Like
                            </button>
                        </li>
                        <li><div class="modal-like" id="likenumber-<%=feed.getChallenge_detail_id()%>" data-toggle="modal" data-target="#begenenler" ><%=feed.getLikes()%></div></li>
                    </ul>
                    <div align="right">
                        <button type="button" id="btn_like5"><span class="glyphicon glyphicon-flag"></span></button>
                    </div>
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
        // $('#btnlike-<%=feed.getChallenge_detail_id()%>').css("background-color","yellow");
        $('#btnlike-<%=feed.getChallenge_detail_id()%>').css("background-color","yellow");
        <%}%>
    });

</script>
<%}%>
<!-- POSTLAR -->



<!-- BEGENELER MODAL-->
<div class="modal fade" id="begenenler" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Begenenler</h4>
            </div>
            <div class="modal-body" >

            </div>
            <div class="modal-footer">
                <button type="button" id="like-close" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- BEGENELER MODAL-->

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
<div class="page-fooer">
</div>

<script  type="text/javascript">




    function searchh() {
        var s=$(myInput).val();
        var uzunluk=s.length;
        if(uzunluk>=2){
            //alert("asasas");
            var jQueryCalis = $.noConflict(true);
            (function($) {
                $.ajax({
                    url:"http://localhost:8080/searchrsp.jsp",
                    type:"POST",
                    data:{word:s},
                    success: function (cevap) {
                        // $("#"+like_idd).html(cevap);
                        $('.dropdown-menu').html(cevap);

                    }
                });
            })(jQueryCalis);
        }
    }


        /* $("#myInput").on("keyup", function() {
            var s=$(myInput).val();
            var uzunluk=s.length;
            if(uzunluk>=2){
                alert("asasas");
                $.ajax({
                    url:"http://localhost:8080/searchrsp.jsp",
                    data:{word:s},
                    success: function (cevap) {
                        // $("#"+like_idd).html(cevap);
                        $('.dropdown-menu').html(cevap);
                    }
                });
            }

            var value = $(this).val().toLowerCase();
            $(".dropdown-menu li").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        }); */


    // LİKE - DİSLİKE
    $('.btn').click(function () {
            var id=$(this).attr('id').toString();            // Tıklanılan butonun id sin, al
        var index= id.indexOf("-");                     // btnlike- kısmını at sadece id yi al  "clear_id"
        var id_firstpart = id.slice(0,index);           // - den öncesini al ve kontrol et like mı dislike butonumu
        var id_lenght=id_firstpart.length;              // uzunluğu 7 ise btnlike eger 10 ise btndislike butonuna basılmıs
        var clear_id = id.slice(index+1);               // Tıklanınlan postun saf id sine ulasatık buton id üzarinden
        var  vote=$('#vote-'+clear_id).html();
        /*if(vote==0){
            $('#vote-'+clear_id).html(1);
            $('#btnlike-'+clear_id).css("background-color","yellow");
        }else if(vote ==1){
            $('#vote-'+clear_id).html(0);
            $('#btnlike-'+clear_id).css("background-color","");
        }*/
        if(id_lenght==7){                               // like butonuna basılma durumu
            var like_idd="likenumber-"+clear_id;         // begenelerin sayısısnı yazan div in id si
            var like_sayısı=$("#"+like_idd).html().trim().toString();
            var color="black";
            //  Buradaki ajax metodu beğenilen postun id sini ve  begennen kullanıcının id sini
            // parametre olarak gönderiyor. Eger bu kisi daha önce begenmisse begeni geri alınacak
            // ilk defa begenmisse begeni bir arttırılıp veri tabanına kaydedilecek
            $.ajax({
               url:"http://localhost:8080/likeresponse.jsp",
                data:{postid:clear_id,userid:<%=users.getId()+""%>,like:like_sayısı.toString(),status:vote},
                success: function (cevap) {
                    $("#"+like_idd).html($(cevap).filter("div").html());
                    if(vote==0){
                        $('#vote-'+clear_id).html(1);
                        $('#btnlike-'+clear_id).css("background-color","yellow");
                    }else if(vote ==1){
                        $('#vote-'+clear_id).html(0);
                        $('#btnlike-'+clear_id).css("background-color","");
                    }
                }
            });
        }
    });

    // BEGENENLER MODALI
    $('.modal-like').click(function () {
        var id=$(this).attr('id').toString();
        var index= id.indexOf("-");
        var post_id = id.slice(index+1);
        $.ajax({
            url:"http://localhost:8080/likepeopleresponse.jsp",
            data:{postid:post_id},
            success: function (cevap) {
                // $("#"+like_idd).html(cevap);
                $('.modal-body').html(cevap);

            }
        });
    });

    // BİLDİRİM MODALI
    function notification() {
        $(".glyphicon-star").css("color","white");
        $.ajax({
            url:"http://localhost:8080/notifications.jsp",
            data:{userid:<%=users.getId()%>},
            success: function (cevap) {
                $('#notification').html(cevap);
                alert("calıstı");
            }
        });

    }

    // BEGENİ SAYISI HOVER
    $(".modal-like").hover(function () {
        $(this).css("cursor","pointer");
    },function () {
    });

    //NAVBAR COLLAPSE TOGGLE
    function toggle() {
        $('.collapse').toggle();
    }


    //NOTİFİCATİON CLİENT

    var wsUrl = "ws://localhost:8080/websocketserver";
    var webSocket;

    function init() {
        webSocket = new WebSocket(wsUrl);
        webSocket.onopen = function(evt) {
            onOpen(event)
        };
        webSocket.onclose = function(evt) {
            onClose(event)
        };
        webSocket.onmessage = function(evt) {
            onMessage(event)
        };
        webSocket.onerror = function(evt) {
            onError(event)
        };
    }

    function onOpen(event){
        Console.log("OnOpen Event");
    }

    function onClose(event) {
        Console.log("OnClose Event");
    }

    function onError(event) {
        Console.log("OnError Event");
    }

    function sendMessage() {
        webSocket.send(<%=users.getId()%>);
    }

    function onMessage(event) {
        var sonuc=event.data.toString();
         if(sonuc=="1"){
             $(".glyphicon-star").css("color","red");
         }
    }

    window.addEventListener("load", init, false);



   $(window).scroll(function () {
      sendMessage();
   });
</script>

</body>
</html>

