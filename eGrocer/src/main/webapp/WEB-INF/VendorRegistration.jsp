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

  <form method = "post" action = "vendorRegistration" class="signupCard">
    <label>
      Vendor Name:
      <input type="text" name="vName" required>
    </label>
    <label>
      Email:
      <input type="email" name="vEmail" required>
    </label>
    <label>
      Phone:
      <input type="text" name="vPhone" required>
    </label>
    <label>
      Address:
      <input type="text" name="vAddress" required>
    </label>
    <label>
      Password:
      <input type="password" name="vPassword" required>
    </label>
    <input type="submit" value="Register">
  </form>
</div>


</body>
</html>
