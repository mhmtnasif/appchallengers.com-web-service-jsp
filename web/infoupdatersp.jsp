<%@ page import="com.appchallengers.appchallengers.dao.dao.UserDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Users" %>
<%@ page import="com.appchallengers.appchallengers.dao.dao.ApplicationDao" %>
<%@ page import="com.appchallengers.appchallengers.dao.daoimpl.ApplicationDaoImpl" %>
<%@ page import="com.appchallengers.appchallengers.model.entity.Country" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: MHMTNASIF
  Date: 24.04.2018
  Time: 03:22
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
    <title>AppChallengers</title>
</head>
<body>

<%!
    List<Country> countries;
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

    UserDao userDao= new UserDaoImpl();
    Users users= userDao.findByEmail(userName);

    ApplicationDao applicationDao= new ApplicationDaoImpl();
    countries= applicationDao.getCountryList();

%>


<div class="row">
    <div class="col-sm-4"></div>
    <div class="col-sm-4">
        <form id="confirmform"  method="POST" data-toggle="validator" role="form">
            <table class="table ">
                <tr>
                    <td>
                        <label style="font-size: small;" >İsim</label>
                    </td>
                    <td>
                        <input type="text" id="txt-fullname" value="<%=users.getFullName()%>" class="form-control input-sm" required
                               style="background-color:#fafafa;" name="fullname">
                    </td>
                </tr>
                <tr >
                    <td>
                        <label style="font-size: small;" >Ülke</label>
                    </td>
                    <td>
                        <select class="form-control" id="select-country" name="country" size="0"  >
                            <%if(countries!=null){%>
                            <%for( Country i: countries){%>
                            <option <%if(i.getCountryName().equalsIgnoreCase(users.getCountry())){%>
                                    selected<%}%>
                            ><%=i.getCountryName()%></option>
                            <%}%>
                            <%}%>
                        </select>
                    </td>
                </tr>
            </table>
            <button type="submit"  style="background-color: #fd5739;color:white" id="btn-save-info" name="save-info"
                    class="btn  btn-block" >Kaydet
            </button>
        </form>
    </div>
    <div class="col-sm-4"></div>
</div>

<script>
    $('#txt-fullname').bind('keyup blur',function(){
        var node = $(this);
        node.val(node.val().replace(/[^A-ZİIÖÇĞÜŞ a-zöçşğüı]/g,'') ); }
    );
</script>

</body>
</html>
