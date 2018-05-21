<%@ page import="com.appchallengers.appchallengers.dao.dao.ChallengesDetailDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.ChallengesDetailDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.response.GetChallengeDetailInfoModel" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%@ page import="com.appchallengers.appchallengers.model.response.ChallengeResponseModel" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 17.4.2018
  Time: 23:00
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
         .panel{
             border-top: 0px;
         }
     </style>
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
  long challengeid;
  Users users;
  long userid;
  GetChallengeDetailInfoModel  detailModel;
  List<ChallengeResponseModel> challengeResponseModelList;
%>
<%
    ChallengesDetailDao challengesDetailDao = new ChallengesDetailDaoImpl();

    UserDao userDao= new UserDaoImpl();
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
    users=userDao.findByEmail(userName);
    userid=users.getId();
    challengeid = Integer.parseInt(request.getParameter("ref"));
    challengeResponseModelList = challengesDetailDao.getChallengeDetailOrderByTime(userid,challengeid);
    System.out.println("-->>>>>>>>aaaa"+challengeid);
    detailModel= challengesDetailDao.getChallengeDetailInfo(userid,challengeid);

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
                        <li class="active"><a href="trends.jsp"><!-- Give Link!--><i class="glyphicon glyphicon-fire"></i></a></li>
                        <li ><a href="myprofile.jsp"><!-- Give Lİnk!--><i class="glyphicon glyphicon-user"></i></a></li>
                    </ul>
                    <form class="navbar-form navbar-right" >
                        <div class="input-group">
                            <input type="text" class="form-control input-sm" placeholder="Search" name="search" >
                            <div class="input-group-btn">
                                <button class="btn btn-default input-sm" type="submit">
                                    <i class="glyphicon glyphicon-search"></i>
                                </button>
                            </div>
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
        <div class="col-sm-8">
            <div class="panel panel-default">
                <div class="text-info">
                </div>
                <ul class="nav nav-tabs nav-justified">
                    <li id="enson" class="active"><a href="javascript:enson();"><strong>Enson</strong> </a></li>
                    <li id="popular" ><a href="javascript:popular();"><strong>Popüler</strong></a></li>
                </ul>
                <div class="panel-body">
                    <ul class="list-inline">
                        <li><%=detailModel.getHeadLine()%></li>
                        <li><%=detailModel.getCounter()%></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-sm-2"></div>
    </div>
</div>

 <div id="content">
     <%for(ChallengeResponseModel feed: challengeResponseModelList){%>
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
                                     <img src="<%=feed.getProfilepicture()%>" alt="profil.jpg"  class="dairesel">
                                 </a>
                             <li>
                                 <a href="profile.jsp?ref=<%=feed.getChallenge_detail_user_id()%>"><strong><%=feed.getFullname()%></strong></a> <!-- jsp?=feed.getChallenge_detail_user_id()-->
                             </li>
                             <li><strong>></strong></li>
                             <li><a href="challengedetail.jsp?ref=<%=feed.getChallenge_detail_id()%>"><%=feed.getHeadline()%></a></li>
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
             // $('#btnlike-<%=feed.getChallenge_detail_id()%>').css("background-color","yellow");
             $('#btnlike-<%=feed.getChallenge_detail_id()%>').css("background-color","yellow");
             <%}%>
         });
     </script>
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
            <div class="modal-body" id="like-modal">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div id="sonuc"></div>
<script  type="text/javascript">
    var status=-1;
    function popular() {
        status=0;
        $('#popular').addClass("active");
        $('#enson').removeClass("active");
        $.ajax({
            url:"http://localhost:8080/challengedetailresponse.jsp",
            data:{status:status,userid:<%=userid%>,challengeid:<%=challengeid%>},
            success:function (response) {
                $("#content").html(response);
            }
        });

    }
    function enson() {
        status=1;
        $('#popular').removeClass("active");
        $('#enson').addClass("active");
        $.ajax({
            url:"http://localhost:8080/challengedetailresponse.jsp",
            data:{status:status,userid:<%=userid%>,challengeid:<%=challengeid%>},
            success:function (response) {
                $("#content").html(response);
            }
        });
    }

    function toggle() {
        $('.collapse').toggle();
    }


    $('.btn').click(function () {
        var id=$(this).attr('id').toString();            // Tıklanılan butonun id sin, al

        var index= id.indexOf("-");                     // btnlike- kısmını at sadece id yi al  "clear_id"
        var id_firstpart = id.slice(0,index);           // - den öncesini al ve kontrol et like mı dislike butonumu
        var id_lenght=id_firstpart.length;              // uzunluğu 7 ise btnlike eger 10 ise btndislike butonuna basılmıs
        var clear_id = id.slice(index+1);               // Tıklanınlan postun saf id sine ulasatık buton id üzarinden
        var  vote=$('#vote-'+clear_id).html();
        if(vote==0){
            $('#vote-'+clear_id).html(1);
            $('#btnlike-'+clear_id).css("background-color","yellow");
        }else if(vote ==1){
            $('#vote-'+clear_id).html(0);
            $('#btnlike-'+clear_id).css("background-color","");
        }
        //alert(vote);
        if(id_lenght==7){                               // like butonuna basılma durumu

            var like_idd="likenumber-"+clear_id;         // begenelerin sayısısnı yazan div in id si
            var like_sayısı=$("#"+like_idd).html().trim().toString();
            var color="black";

            //alert("Like butonuna basıldı"+clear_id+like_sayısı);
            //  Buradaki ajax metodu beğenilen postun id sini ve  begennen kullanıcının id sini
            // parametre olarak gönderiyor. Eger bu kisi daha önce begenmisse begeni geri alınacak
            // ilk defa begenmisse begeni bir arttırılıp veri tabanına kaydedilecek
            $.ajax({
                url:"http://localhost:8080/likeresponse.jsp",
                data:{postid:clear_id,userid:<%=users.getId()+""%>,like:like_sayısı.toString(),status:vote},
                success: function (cevap) {
                    // $("#"+like_idd).html(cevap);
                    $("#"+like_idd).html($(cevap).filter("div").html());
                    //  color= $(cevap).filter("div").css("color").toString();

                }
            });
        }
    });

    // modal filling with ajax
    $('.modal-like').click(function () {
        alert("aaaaaaa");
        var id=$(this).attr('id').toString();
        var index= id.indexOf("-");
        var post_id = id.slice(index+1);
        $.ajax({
            url:"http://localhost:8080/likepeopleresponse.jsp",
            data:{postid:<%=challengeid%>},
            success: function (cevap) {
                // $("#"+like_idd).html(cevap);
                $('#like-modal').html(cevap);
            }
        });
    });

    $(".modal-like").hover(function () {
        $(this).css("cursor","pointer");
    },function () {
    });


    function notification() {
        alert("aa");
        $.ajax({
            url:"http://localhost:8080/notifications.jsp",
            data:{userid:<%=users.getId()%>},
            success: function (cevap) {
                $('#notification').html(cevap);
            }
        });

    }

</script>
</body>
</html>
