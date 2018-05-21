<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%@ page import="com.appchallengers.appchallengers.util.EmailUtil" %><%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 22.2.2018
  Time: 14:51
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
    UserDao userDao= new UserDaoImpl();
    String mail_sonuc="";
  if(request.getParameter("sendPasswordLink")!=null){               // Was clicked send me password link ?
      String email=(String)request.getParameter("sendPasswordLink");

      if(userDao.checkEmail(email)==1){                              // Mail is correct? İs there a mail in database?
          String subject="Confirm Email";
          Users user= userDao.findByEmail(email);
          String mail="Bir mail Doğrulama isteğinde yada şifre değiştirme isteğinde " +
                  "bulunduysan aşağıdaki linki tarayıcıya yapıştır ve bilgilerini gir.Böyle bir istekte bulunmadıysan," +
                  "bu epostayı yoksayabilirsin";
          String body="http://appchallengers.com/creatingnewpassword.jsp?id="+user.getId()+"&hash="+user.getPasswordSalt();
          String sonmail=mail+" "+body;
          if(EmailUtil.sendEmail(user.getEmail(),subject,sonmail)){     // Mail is send?
              mail_sonuc="Mailinize doğrulama postası gönderildi!<br>Lünfen kontrol ediniz...";
          }else{
              mail_sonuc="Beklenmedik bir hata oluştu! Lütfen daha sonra tekrar deneyiniz!";
          }
      }else{                                                        // İf There is no account of this eposta
          mail_sonuc="Bu eposta adresine ait hesap bulunamadı! ";
      }


  }
%>

<div class="container">

    <div class="row">
        <!-- LEFT PART -->
        <div class="col-sm-4"></div>
        <!-- CONTENT PART-->
        <div class="col-sm-4">
            <!-- PANEL BEGINNIG -->
            <br><br>
            <div class="panel panel-default" style="height:80%">
                <div class="panel-body">
                    <div class="text-center text-muted">
                        <h2>AppChallenger</h2>
                    </div>
                    <br>
                    <!-- FORM BEGINNIG-->
                    <form  method="POST" data-toggle="validator" role="form">

                        <div class="form-group">
                            <div class="text-center text-mute">Lütfen şifrenizi yenilemek için mail adresinizi giriniz...</div>
                        </div>

                        <div class="form-group">
                            <input type="email" id="txt-sendPasswordLink" class="form-control" required
                                   style="background-color:#fafafa" placeholder="Enter email" name="sendPasswordLink">
                        </div>

                        <br>
                        <button type="submit" id="btn_sendlink" class="btn  btn-block" style="background-color: #fd5739;color: white">
                            Gönder
                        </button>
                        <br>
                        <div class="text-center text-success"><%=mail_sonuc%></div>
                    </form>
                    <!-- FORM BEGINNIG-->
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
<!--FOOTER-->

</body>
</html>
