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

  <form method = "post" action = "vendorRegistration" class="Card">
    <label>
      Vendor Name:
      <input type="text" name="vName" required class="textfield1">
    </label>
    <label>
      Email:
      <input type="email" name="vEmail" required class="textfield1">
    </label>
    <label>
      Phone:
      <input type="text" name="vPhone" required class="textfield1">
    </label>
    <label>
      Address:
      <input type="text" name="vAddress" required class="textfield1">
    </label>
    <label>
      Password:
      <input type="password" name="vPassword" required class="textfield1">
    </label>
    <input type="submit" value="Register" class="formBtn">
  </form>
</div>


</body>
</html>
