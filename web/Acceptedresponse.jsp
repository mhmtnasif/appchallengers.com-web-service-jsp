<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.GetUserInfoDao" %>
<%@ page import="com.appchallengers.appchallengers.model.response.ChallengeResponseModel" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.GetUserInfoDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.response.ChallengeResponseModel" %><%--
  Created by IntelliJ IDEA.
  User: rabb�m
  Date: 15.4.2018
  Time: 13:49
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
         .dairesel{
             width: 50px;
             height: 50px;
             border-radius: 150px;
             -webkit-border-radius: 150px;
             -moz-border-radius: 150px;
             background: url(http://resim-dosyasinin.adresi/resim.jpg) no-repeat;
         }
     </style>
    <title>AppChallengers</title>
</head>
<body>

<!-- Bu sayfa kullan�c� kabul etti�i cahllenge lar� g�rmek istegi�inde ajax cevab� olarak
     d�nderilecek.-->

 <%!
     int userid;
     int visitorid;
     int status;
     List<ChallengeResponseModel> userChallengeFeedList2;
     List<ChallengeResponseModel> userChallengeFeedList;
 %>
 <%
   userid=Integer.parseInt(request.getParameter("userid"));
   status=Integer.parseInt(request.getParameter("status"));
     UserDao userDao= new UserDaoImpl();
     Users users=userDao.findUserById(userid);
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
     Users session_user= userDao.findByEmail(userName);
     visitorid=(int)session_user.getId();

     // Kabul eden ki�iler listesi olu�turulacak
     GetUserInfoDao getUserInfoDao= new GetUserInfoDaoImpl();
      userChallengeFeedList2 = getUserInfoDao.getUserAcceptedChallenges(visitorid, userid);
      userChallengeFeedList = getUserInfoDao.getUserChallenges(visitorid, userid);

 %>

  <%if(status==0){%>
   <!-- Bu kabul edilen chalenge postlar�ya doldurulacak  bura yukar�daki kanbul eden liste g�re de�itirilecek-->
<%if(userChallengeFeedList2!=null){%>
<%for(ChallengeResponseModel feed: userChallengeFeedList2){%>
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
                                <%if(feed.getProfilepicture()==null || feed.getProfilepicture()=="" ){%>
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
                            <button type="button" class="btn btn-default btn-sm" style="color:#fd5739" id="btnlike-<%=feed.getChallenge_detail_id()%>"><span id="likethumb-<%=feed.getChallenge_detail_id()%>"
                                     class="glyphicon glyphicon-thumbs-up" ></span>Like
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

 <%}%>

 <%if(status==1){%>
<!-- Bu k�s�m mychallge k�sm�n� doldurucack profilin ilk yuklendi�i duruuyla ayn� olacak-->
<%if(userChallengeFeedList!=null){%>
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

                                <%if(feed.getProfilepicture()==null || feed.getProfilepicture()=="" ){%>
                            <img src="/images/defaultprofil.png"  class="dairesel">
                                <%}else{%>
                            <img src="<%=feed.getProfilepicture()%>" alt="profil.jpg"  class="dairesel">
                                <%}%>

                        <li>
                            <div class="text-info"><strong><%=feed.getFullname()%></strong></div><!-- jsp?=feed.getChallenge_detail_user_id()-->
                        </li>
                        <li><strong>></strong></li>
                        <li><a href="challengedetail.jsp?ref=<%=feed.getChallenge_id()%>"><%=feed.getHeadline()%></a></div></li>
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
                            <button type="button" style="color:#fd5739" class="btn btn-default btn-sm" id="btnlike-<%=feed.getChallenge_detail_id()%>"><span id="likethumb-<%=feed.getChallenge_detail_id()%>"
                                    class="glyphicon glyphicon-thumbs-up" ></span>Like
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
 <%}%>



<script  type="text/javascript">

    // LİKE - DİSLİKE
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
                data:{postid:clear_id,userid:<%=visitorid%>,like:like_sayısı.toString(),status:vote},
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
    // BEGENENLER MODAL
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

    $(".modal-like").hover(function () {
        $(this).css("cursor","pointer");
    },function () {
    });


</script>

</body>
</html>
