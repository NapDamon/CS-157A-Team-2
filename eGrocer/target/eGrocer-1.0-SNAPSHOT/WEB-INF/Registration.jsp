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
<header class="logo1"><h1>eGrocer</h1></header>
<div class="content">

  <form method = "post" action = "Registration" class="Card">
    <label>
      Name:
      <input type="text" name="Name" required class="textfield1">
    </label>
    <label>
      Email:
      <input type="email" name="Email" required class="textfield1">
    </label>
    <label>
      Phone:
      <input type="text" name="Phone" required class="textfield1">
    </label>
    <label>
      Address:
      <input type="text" name="Address" required class="textfield1">
    </label>
    <label>
      Password:
      <input type="password" name="Password" required class="textfield1">
    </label>
    <label>Are you a vendor?
      <input type="checkbox" name="isVendor" value="true">
    </label>
    <input type="submit" value="REGISTER" class="formBtn">
  </form>
</div>


</body>
</html>
