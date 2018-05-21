<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.util.Util" %><%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 21.2.2018
  Time: 02:29
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
<%
    UserDao userDao = new UserDaoImpl();
    String id = request.getParameter("id");
    String hash = request.getParameter("hash");
    boolean password_changed = false;

    if ((id == null || id == "") || (hash == null || hash == "")) {                  // Link is correct?
        out.println("HATA");
        response.sendRedirect("errorpage.jsp");
    } else {

        if (userDao.checkIdAndPasswordSalt(Integer.parseInt(id), hash) == 0) {      // id and hash are correct?
            response.sendRedirect("errorpage.jsp");
        } else if (userDao.checkIdAndPasswordSalt(Integer.parseInt(id), hash) == 1) {
            if (request.getParameter("change_password") != null) {                  // İf Was clicked "chamgepassword"?
                String new_password = (String) request.getParameter("passwordConfirm");
                userDao.changePassword(Integer.parseInt(id), Util.hashMD5(new_password).toString());
                password_changed = true;
            }

        }
    }
%>
<div class="container">

    <div class="row">
        <!-- LEFT PART -->
        <div class="col-sm-4">
        </div>
        <!-- CONTENT PART-->
        <div class="col-sm-4">
            <!-- PANEL BEGINNIG -->
            <br><br>
            <div class="panel panel-default" style="height:80%">
                <div class="panel-body">
                    <div class="text-center text-muted">
                        <h2>AppChallenger</h2>
                        <br>
                        <br>
                    </div>
                    <!-- FORM BEGINNIG-->
                    <form id="confirmform" method="POST" data-toggle="validator" role="form">

                        <div class="form-group">
                            <input type="password" id="txt-password" maxlength="12"  minlength="8"  class="form-control" required
                                   style="background-color:#fafafa" placeholder="Enter password" name="password">
                        </div>
                        <div class="form-group">
                            <input type="password" id="txt-passwordConfirm" maxlength="12"  minlength="8"  class="form-control" required
                                   style="background-color:#fafafa" placeholder="Cpnfirm password"
                                   name="passwordConfirm">
                        </div>
                        <br>
                        <button type="submit" style="background-color: #fd5739;color:white" id="changePassword" name="change_password"
                                class="btn btn-block" disabled="true" style="background-color: #fd5739;color: white">Şİfreyi Değiş
                        </button>
                    </form>
                    <!-- FORM BEGINNIG-->
                    <br>
                    <%if (password_changed) {%>
                    <div class="text-center text-success">Parolanız Güncellendi! Lütfen <a href="Login.jsp">Giriş
                        Yapınız...</a></div>
                    <%}%>
                </div>
                <!-- PANEL ENDING -->
            </div>
            <!--PANEL FOOTER -->

        </div>

        <!--RIGHT PART OF COLOUM -->
        <div class="col-sm-4"></div>
    </div>
</div>
</div>
<!--FOOTER-->
<hr>
<div class="container">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
        <ul class="list-inline">
            <li><a href="footerinfo.jsp"><strong style="color: #fd5739;">HAKIMIZDA</strong></a></li>
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

<script type="text/javascript">
    $('#txt-passwordConfirm').keyup(function () {
        var ps = $('#txt-password').val();
        var pscf = $('#txt-passwordConfirm').val();
        if (ps == pscf && (pscf != "" && pscf != null)) {
            $('#txt-password').attr("readonly", true);
            $('#txt-passwordConfirm').attr("readonly", true);
            $('#changePassword').removeAttr("disabled");
        }
    });



</script>

</body>
</html>
