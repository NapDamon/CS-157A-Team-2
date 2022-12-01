<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.egrocer.ProductsDao" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.egrocer.OrderDao" %>
<%@ page import="com.example.egrocer.RegisterDao" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: neenee
  Date: 11/30/22
  Time: 2:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment Page</title>
    <style><%@include file="/WEB-INF/CSS/style.css"%></style>
</head>
<body>
<%
    OrderDao oDao = new OrderDao();
    int cart_id = (int) session.getAttribute("cart_id");
    int numInCart = oDao.numOfProdInCart(cart_id);
    out.print("<li><a class=\"active\" href=\"customerCart\">Cart (" + numInCart + ")</a></li>");
%>
<header class="logo"><h1>Check Out</h1></header>
<div class="content">

    <form method = "post" action = "Receipt" class="Card">
        <label>
            Name on Card:
            <input type="text" name="cname" required class="textfield1">
        </label>
        <label>
            Card Number:
            <input type="text" name="cnum" required class="textfield1">
        </label>
        <label>
            Expiration Date:
            <input type="text" placeholder="MM / YY"  name="exp" required class="textfield1">
        </label>
        <label>
            Security Code (CVV):
            <input type="text" name="cvv" required class="textfield1">
        </label>
        <label>
            Zip Code:
            <input type="text" name="zipcode" required class="textfield1">
        </label>
            <input type="submit" value="Submit Payment" class="formBtn">
    </form>
</div>

</>
</html>
