<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Country" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.ApplicationDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.ApplicationDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 16.4.2018
  Time: 21:04
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
        #my-file { visibility: hidden; }
    </style>
    <title>Title</title>
</head>
<body>

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
    Users users= userDao.findByEmail(userName);

    ApplicationDao applicationDao= new ApplicationDaoImpl();
    List<Country> countries= applicationDao.getCountryList();

%>


<div class="row">
    <div class="col-sm-4"></div>
    <div class="col-sm-4">
        <form id="savepicture" action="SaveProfilPic" method="POST" data-toggle="validator" role="form" enctype="multipart/form-data">
            <div class="text-center">
                <div class="profile" style="margin-top: 30px">
                    <%if(users.getProfilePicture()==null || users.getProfilePicture()=="" ){%>
                    <img id="profil-pic" src="/images/personn.jpg"  class="daireselprofil">
                    <%}else{%>
                    <img id="profil-pic" src="<%=users.getProfilePicture()%>" alt="profil.jpg" name="profilPicture" class="daireselprofil" >
                    <%}%>

                    <div class="hiddenfile">
                        <input type="button" id="my-button" value="Resim Seç">
                        <input type="file" name="my_file" id="my-file" onchange="onFileSelected(event)">
                    </div>
                </div>
            </div>
            <button type="submit" disabled="true" id="btn-save-profile" name="save-profile"
                    class="btn btn-primary btn-block" >Kaydet
            </button>
        </form>
        <form id="remove-profilpic" >
            <button type="submit"  id="btn-remove-profile" name="remove-profile"
                    class="btn btn-primary btn-block" >Prpfil Resmini Kaldır
            </button>
        </form>
    </div>
    <div class="col-sm-4"></div>
</div>




<script  type="text/javascript">

    var imgsrc;

    $('#btn-save').click(function () {
        alert($('#txt-fullname').val());
    });
    $('#my-button').click(function(){
        $('#my-file').click();
    });
    function onFileSelected(event) {
        //alert($('input[type=file]').val());
        var selectedFile = event.target.files[0];
        var reader = new FileReader();

        var imgtag = document.getElementById("profil-pic");
        imgtag.title = selectedFile.name;

        reader.onload = function(event) {
            imgtag.src = event.target.result;
            //imgsrc=event.target.result;
        };

        reader.readAsDataURL(selectedFile);
        $('#btn-save-profile').removeAttr("disabled");

    }

    $('#my-button').click(function () {
        $("#txt-hidden").html("1");
    });
</script>

</body>
</html>
