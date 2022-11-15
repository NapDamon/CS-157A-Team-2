<%--
  Created by IntelliJ IDEA.
  User: Emant
  Date: 11/14/2022
  Time: 6:46 PM
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

  <form method = "post" action = "customerLogin" class="Card" >

    <label>
      Phone Number:
      <input type="text" name="cPhone" class="textfield1">
    </label>
    <br><br><div style="text-align: center"><label >OR</label></div><br>
    <label>
      Email:
      <input type="email" name="cEmail"  class="textfield1">
    </label>
    <label>
      Password:
      <input type="password" name="cPassword" required class="textfield1">
    </label>
    <input type="submit" value="Log in" class="formBtn">

    <div>Don't have an account? Sign up <a href="customerRegistration">here</a></div>
  </form>
</div>

</body>
</html>
