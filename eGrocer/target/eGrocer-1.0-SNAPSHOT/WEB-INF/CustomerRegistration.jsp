<%--
  Created by IntelliJ IDEA.
  User: Emant
  Date: 11/14/2022
  Time: 6:33 PM
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

    <form method = "post" action = "customerRegistration" class="Card">
        <label>
            Name:
            <input type="text" name="cName" required class="textfield1">
        </label>
        <label>
            Email:
            <input type="email" name="cEmail" required class="textfield1">
        </label>
        <label>
            Phone:
            <input type="text" name="cPhone" required class="textfield1">
        </label>
        <label>
            Address:
            <input type="text" name="cAddress" required class="textfield1">
        </label>
        <label>
            Password:
            <input type="password" name="cPassword" required class="textfield1">
        </label>
        <input type="submit" value="Register" class="formBtn">
    </form>
</div>
</body>
</html>
