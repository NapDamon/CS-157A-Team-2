<%--
  Created by IntelliJ IDEA.
  User: Emant
  Date: 11/14/2022
  Time: 3:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>eGrocer</title>
  <style><%@include file="/WEB-INF/CSS/style.css"%></style>
</head>
<body>
<%
String vendor = session.getAttribute("vendor").toString();
String email = session.getAttribute("email").toString();
String phone = session.getAttribute("phone").toString();
String address = session.getAttribute("address").toString();
%>
<ul>
<li><a href="vendorHome">Home</a></li>
<li><a href="vendorOrders">Orders</a></li>
<li><a class="active" href="vendorAccount">Account</a></li>
<li style="float:right"><a href="logout">Log Out</a>
</li>
</ul>

<div class="content">
 <div class="padding">
<form class="Card" style="text-align: center">
  <label>Vendor Name: <%out.println(vendor);%></label><br><br>
  <label>Email: <%out.println(email);%></label><br><br>
  <label>Phone: <%out.println(phone);%></label><br><br>
  <label>Address: <%out.println(address);%></label>
</form>
 </div>
</div>

</body>
</html>
