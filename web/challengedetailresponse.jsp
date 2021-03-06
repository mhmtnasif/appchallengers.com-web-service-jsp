<%@ page import="com.appchallengers.appchallengers.dao.dao.ChallengesDetailDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.ChallengesDetailDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.response.ChallengeResponseModel" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: MHMTNASIF
  Date: 19.04.2018
  Time: 18:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>AppChallengers</title>
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
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9">
</head>
<body>

<%!
    String dene;
    int status=-1;
    List<ChallengeResponseModel> challengeResponseModelList;
    int userid;
    List<ChallengeResponseModel> popularlist;
%>

<%
    ChallengesDetailDao challengesDetailDao = new ChallengesDetailDaoImpl();
    int challengeid=Integer.parseInt(request.getParameter("challengeid"));
     userid=Integer.parseInt(request.getParameter("userid"));
    status=Integer.parseInt(request.getParameter("status"));
   if(status==0){
       dene="populer";
       popularlist= challengesDetailDao.getChallengeDetailOrderByLikes(userid,challengeid);
   }else if(status==1){
       dene="enson";
      challengeResponseModelList = challengesDetailDao.getChallengeDetailOrderByTime(userid,challengeid);

   }
%>
<%if(status==0){%>
<%if(popularlist!=null){%>
<%for(ChallengeResponseModel feed: popularlist){%>
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
                        <li><div class="text-center"><%=feed.getHeadline()%></div></li>
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
<%}%>
<%if(status==1){%>
<%if(challengeResponseModelList!=null){%>
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
                        <li><div class="text-center"><%=feed.getHeadline()%></div></li>
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
                data:{postid:clear_id,userid:<%=userid%>,like:like_sayısı.toString(),status:vote},
                success: function (cevap) {
                    $("#"+like_idd).html($(cevap).filter("div").html());
                    if(vote==0){
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

    // BEGENİ SAYISI HOVER
    $(".modal-like").hover(function () {
        $(this).css("cursor","pointer");
    },function () {
    });

    $('.modal-like').click(function () {
        var id=$(this).attr('id').toString();
        var index= id.indexOf("-");
        var post_id = id.slice(index+1);
        $.ajax({
            url:"./likepeopleresponse.jsp",
            data:{postid:post_id},
            success: function (cevap) {
                $('#like-modal').html(cevap);
            }
        });
    });
</script>

</body>
</html>
