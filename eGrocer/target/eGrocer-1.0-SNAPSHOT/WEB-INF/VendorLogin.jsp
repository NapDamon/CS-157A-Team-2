<%--
  Created by IntelliJ IDEA.
  User: Emant
  Date: 11/11/2022
  Time: 10:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>eGrocer</title>
</head>
<body>
<form method = "post" action = "vendorLogin">

    <label>
        Vendor Name:
        <input type="text" name="vName" >
    </label>
    <label>
        Email:
        <input type="email" name="vEmail" >
    </label>
    <label>
        Password:
        <input type="password" name="vPassword">
    </label>
    <input type="submit" value="Log in">
</form>
</body>
</html>
