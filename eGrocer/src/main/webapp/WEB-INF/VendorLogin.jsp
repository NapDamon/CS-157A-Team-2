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
<header class="logo"><h1>eGrocer</h1></header>
<div class="content">

    <form method = "post" action = "vendorLogin" class="Card" >

        <label>
            Phone Number:
            <input type="text" name="vnumber" class="textfield1">
        </label>
        <label>OR</label>
        <label>
            Email:
            <input type="email" name="vEmail"  class="textfield1">
        </label>
        <label>
            Password:
            <input type="password" name="vPassword" required class="textfield1">
        </label>
        <input type="submit" value="Log in" class="formBtn">

        <div>Don't have an account? Sign up <a href="vendorRegistration">here</a></div>
    </form>
</div>

</body>
</html>
