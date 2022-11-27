<%--
  Created by IntelliJ IDEA.
  User: napda
  Date: 11/27/2022
  Time: 1:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.example.egrocer.ProductsDao" %>
<%@ page import="java.lang.*" %>
<html>
<head>
  <title>eGrocer</title>
  <style><%@include file="/WEB-INF/CSS/style.css"%></style>

</head>
<body>

<ul>
  <li><a href="customerHome">Home</a></li>
  <li><a class="active" href="customerOrders">Orders</a></li>
  <li><a href="account">Account</a></li>
  <li><a href="customerCart">Cart</a></li>
  <li style="float:right"><a href="logout">Log Out</a>
  </li>

</ul>



</body>
</html>
