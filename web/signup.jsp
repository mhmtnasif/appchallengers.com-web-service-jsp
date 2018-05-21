<%@ page import="com.appchallengers.appchallengers.dao.dao.ApplicationDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.ApplicationDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Country" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.AbstractList" %><%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 19.2.2018
  Time: 01:10
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
<body style="background-color:#fdfbfb ">
<%!
    String message;
    List<Country> countries;
%>
<%
    ApplicationDao applicationDao= new ApplicationDaoImpl();
    countries= applicationDao.getCountryList();
    message=(String)request.getAttribute("signup_message");
%>

<div class="container">

    <div class="row">
        <!-- LEFT PART -->
        <div class="col-sm-2"></div>
        <div class="col-sm-2"id="mobile-fisrtpart"></div>
        <div class="col-sm-4" id="carousel">

            <br><br>
            <!-- PANEL BEGINNIG -->
            <!-- PANEL BODY BEGINNING-->

            <div id="myCarousel" class="carousel slide float-sm-right" style="min-height:min-content;"  role="listbox" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner">

                    <div class="item active">
                        <img src="/images/first.jpeg" alt="Los Angeles" style="min-height:100%;">
                    </div>

                    <div class="item">
                        <img src="/images/second.jpeg" alt="Chicago" style="min-height:100%;">
                    </div>

                    <div class="item">
                        <img src="/images/third.jpeg" alt="New York" style="min-height:100%;">

                    </div>
                </div>

                <!-- Left and right controls -->
                <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <!-- PANEL ENDING -->
            <br>

        </div>
        <!-- CONTENT PART-->
        <div class="col-sm-4">
            <!-- PANEL BEGINNIG -->
            <br><br>
            <div class="panel panel-default">

                <div class="panel-body">

                    <div class="text-center text-muted" >
                        <h2>AppChallenger</h2>
                    </div>
                    <!-- FORM BEGINNIG-->
                    <form   action="SignupServlet" method="POST" data-toggle="validator" role="form">
                        <div class="form-group">
                            <input type="text" id="txt-fullname" class="form-control" required
                                   style="background-color:#fafafa" placeholder="Name and surname" maxlength="25"  name="fullname">
                        </div>

                        <div class="form-group">
                            <input type="email" id="txt-email" class="form-control" required
                                   style="background-color:#fafafa" placeholder="Enter email" name="email">
                        </div>
                        <div class="form-group">
                            <input type="password" id="txt-password" maxlength="12"  minlength="8" class="form-control" required
                                   style="background-color:#fafafa" placeholder="Enter password" name="password">

                        </div>
                        <div class="form-group">
                            <select class="form-control" id="select-country" name="country" size="0"  >
                                <%if(countries!=null && countries.size()!=0){%>
                                <%for( Country i: countries){%>
                                <option><%=i.getCountryName()%></option>
                                <%}%>
                                <%}%>
                            </select>
                        </div>
                        <br>
                        <button type="submit" id="submit-singup" class="btn  btn-block" style="background-color: #fd5739;color: white">Kaydol</button>
                        <br>
                        <%if(message!=null){%>
                        <div class="text-danger text-center">
                            <%=message%>
                        </div>
                        <%}%>
                        <div class="text-muted text-center">
                            Kayıt olarak <span data-toggle="modal" data-target="#agrement" class="modal-like text-info" id="useragrement" style="color: #fd5739">kullanıcı sözleşmesini</span> kabul etmiş oluyorsunuz!
                        </div>
                    </form>
                    <!-- FORM ENDİNG-->

                    <!-- PANEL BODY ENDING -->
                </div>
                <!--PANEL FOOTER -->
                <div class="panel-footer">
                    <div class="text-center text-muted" style="color: #fd5739">Hesabın Var mı?<a href="Login.jsp" style="color: #fd5739">Giriş Yap</a></div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="text-center"> <a href="https://play.google.com/store/apps/details?id=com.appchallengers.appchallengers">
                        <img src="/images/google-play-badge.png" alt="GooglePlay" style="width:50%">

                    </a></div>
                </div>
            </div>
            <!--RIGHT PART OF COLOUM -->

        </div>
        <div class="col-sm-2" ></div>
        <div class="col-sm-2"id="mobile-secondpart"></div>
    </div>
</div>
<!-- AGREMENT MODAL-->
<div class="modal fade" id="agrement" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" >Kullanıcı Sözleşmesi!</h4>
            </div>
            <div class="modal-body" >
                Sitemiz Beta aşamasındadır !
            </div>
            <div class="modal-footer">
                <button type="button" id="like-close" class="btn btn-default" data-dismiss="modal">Tamam</button>
            </div>
        </div>
    </div>
</div>

<hr>
<div class="container">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
        <ul class="list-inline">
            <li><a href="footerinfo.jsp"><strong style="color: #fd5739">HAKIMIZDA</strong></a></li>
            <li><a href="footerinfo.jsp"><strong style="color: #fd5739">DESTEK</strong></a></li>
            <li><a href="footerinfo.jsp"><strong style="color: #fd5739">GİZLİLİK</strong></a></li>
            <li><a href="footerinfo.jsp"><strong style="color: #fd5739">KOŞULLAR</strong></a></li>
            <ul class="list-inline pull-right">
            <li><div> <div class="text-muted"><span class="glyphicon glyphicon-copyright-mark"></span>2018 AppChallengers</div></div></li>
          </ul>
        </ul>
    </div>
    <div class="col-sm-2"></div>

</div>


<script  type="text/javascript">
    // setting the templete for mobile devices
    $(document).ready(function () {
        var width = window.innerWidth;
        var height = window.innerHeight;
        $('#mobile-fisrtpart').hide();
        $('#mobile-secondpart').hide()
        if(width<768){
            $('#carousel').hide();
            $('#mobile-fisrtpart').show();
            $('#mobile-secondpart').show()

        }

    });
    $(".modal-like").hover(function () {
        $(this).css("cursor","pointer");
    },function () {
    });

    $('#txt-fullname').bind('keyup blur',function(){
        var node = $(this);
        node.val(node.val().replace(/[^A-ZİIÖÇĞÜŞ a-zöçşğüı]/g,'') ); }
    );
</script>

</body>
</html>
