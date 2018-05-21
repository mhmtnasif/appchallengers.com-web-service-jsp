<%--
  Created by IntelliJ IDEA.
  User: MHMTNASIF
  Date: 25.04.2018
  Time: 23:04
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
    <title>Title</title>
</head>
<body>

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
                        <li><a href="trends.jsp"><!-- Give Link!--><i class="glyphicon glyphicon-fire"></i></a></li>
                        <li class="active"><a href="profile.jsp"><!-- Give Lİnk!--><i class="glyphicon glyphicon-user"></i></a></li>
                    </ul>
                    <form class="navbar-form navbar-center">
                        <div class="input-group">
                            <input type="text" class="form-control input-md" onkeyup="searchh()" id="myInput" placeholder="Search" name="search" >
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
                <div class="panel-body">

                </div>
            </div>
        </div>
        <div class="col-sm-2"></div>
    </div>
</div>

<script  type="text/javascript">

    function searchh() {
        $("#panel-body").html("");
        var s=$("#myInput").val();
        var uzunluk=s.length;
        if(uzunluk>=2){
            //alert("asasas");
                $.ajax({
                    url:"http://localhost:8080/searchrsp.jsp",
                    type:"POST",
                    data:{word:s},
                    success: function (cevap) {
                        // $("#"+like_idd).html(cevap);
                        $('.panel-body').html(cevap);

                    }
                });
        }
    }
</script>

</body>
</html>
