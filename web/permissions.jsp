<%--
  Created by IntelliJ IDEA.
  User: rabbım
  Date: 17.4.2018
  Time: 03:35
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
 <div class="text-center text-muted" style="margin-top: 60px;margin-bottom: 60px">


     <div class="row">
         <div class="col-sm-4"></div>
         <div class="col-sm-4">
             <form id="confirmform" method="POST" data-toggle="validator" role="form">
                 <table class="table ">
                     <tr>
                         <td>
                             <label style="font-size: small;" for="txt-username">Eski mail</label>
                         </td>
                         <td>
                             <div class="form-group ">
                                 <input type="email" id="txt-username" class="form-control input-sm" required
                                        style="background-color:#fafafa" placeholder="Enter email" name="username">
                             </div>
                         </td>
                     </tr>
                     <tr >
                         <td>
                             <label style="font-size: small;" for="txt-newusername">Yeni mail</label>
                         </td>
                         <td>
                             <div class="form-group ">
                                 <input type="email" id="txt-newusername" class="form-control input-sm" required
                                        style="background-color:#fafafa" placeholder="New email" name="newusername">
                             </div>
                         </td>
                     </tr>
                     <br>
                     <tr >
                         <td>
                             <label style="font-size: small;" for="txt-confirmusername">Onayla</label>
                         </td>
                         <td>
                             <div class="form-group ">
                                 <input type="email" id="txt-confirmusername" class="form-control input-sm" required
                                        style="background-color:#fafafa" placeholder="New email" name="confirmusername">
                             </div>
                         </td>
                     </tr>
                     <br>
                     <tr>
                         <td>
                         </td>
                         <td>
                             <button type="submit"  style="background-color: #fd5739;color:white" id="changemail" name="changemail"
                                     class="btn  btn-block" disabled="true">Maili Değiş
                             </button>
                         </td>
                     </tr>
                 </table>
             </form>
         </div>
         <div class="col-sm-4"></div>

         <script  type="text/javascript">
             $('#txt-confirmusername').keyup(function () {
                 var ps = $('#txt-newusername').val();
                 var pscf = $('#txt-confirmusername').val();
                 if (ps == pscf && (pscf != "" && pscf != null)) {
                     $('#txt-newusername').attr("readonly", true);
                     $('#txt-confirmusername').attr("readonly", true);
                     $('#changemail').removeAttr("disabled");
                 }
             });

         </script>
 </div>
</body>
</html>
