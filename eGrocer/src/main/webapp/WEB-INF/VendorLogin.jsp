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
    <style><%@include file="/WEB-INF/CSS/style.css"%></style>
</head>
<body>

<div class="content">
    <form method = "post" action = "vendorLogin" class="loginCard" >

        <label>
            Vendor Name:
            <input type="text" name="vName" required>
        </label>
        <label>
            Email:
            <input type="email" name="vEmail" required>
        </label>
        <label>
            Password:
            <input type="password" name="vPassword" required>
        </label>
        <input type="submit" value="Log in">

        <div>Don't have an account? Sign up <a href="vendorRegistration">here</a></div>
    </form>
</div>

</body>
</html>
