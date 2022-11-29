<%--
  Created by IntelliJ IDEA.
  User: Emant
  Date: 11/11/2022
  Time: 7:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.egrocer.ProductsDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>eGrocer</title>
    <style><%@include file="/WEB-INF/CSS/style.css"%></style>
</head>
<body>

<ul>
    <li><a href="vendorHome">Home</a></li>
    <li><a class="active" href="vendorOrders">Orders</a></li>
    <li><a href="account">Account</a></li>
    <li style="float:right"><a href="logout">Log Out</a>
    </li>
</ul>

<%--<div class="orderContent">--%>
<%--<div class="padding">--%>

<h4>Your Orders: </h4>
<%
    int vendor_id = (int) session.getAttribute("vendor_id");


    String dburl = "jdbc:mysql://localhost:3306/egrocer";
    String dbuname = "root";
    String dbpassword = "root";
    ResultSet rs = null;
    Statement stmt = null;
    Connection con = null;
    String order_num="";
    int i = 1;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(dburl, dbuname, dbpassword);
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT A.*, address FROM " +
                "(SELECT * FROM orders NATURAL JOIN ships " +
                " NATURAL JOIN customers NATURAL JOIN payments) A," +
                "user " +
                "WHERE user.user_id = A.customer_id AND A.vendor_id =" + vendor_id);


        while(rs.next()){

                out.println(
                    "<form class=\"addCard\" action=\"vendorOrders\">"
                    + "<label>Order Number: "+ rs.getInt("order_num") + "</label>"
                    + "<label>Order Date: "+ rs.getString("order_date") + "</label>"
                    + "<label>Total Cost: $"+ rs.getString("amount") + "</label>"
                    + "<label> Shipment ID: " + rs.getInt("shipment_id") + "</label>"
                    + "<label>Shipping Address: "+ rs.getString("address") + "</label>"
                    + "<label> Shipping Date: "+ rs.getString("shipping_date") + "</label>"
                    + "<label> Status: " + rs.getString("status") + "</label>"
                    + "<input type=\"submit\" value=\"Update Status\" name=\"editStatus" +i+"\"class=\"formBtn3\">"
                    + "<input type=\"submit\" value=\"Update Shipping Date\" name=\"editDate" +i+"\"class=\"formBtn3\">"
                    + "</form>"
                );


                if("Update Shipping Date".equals(request.getParameter("editDate"+i))){
                    order_num = String.valueOf(rs.getInt("order_num"));
                    out.println("<form class=\"addCard\" method=\"post\" action=\"updateOrder\" >\n" +
                            " <input type=\"hidden\" name=\"order_num\" value=\"" + order_num + "\">\n" +
                            " <label>\n" +
                            " New Shipping Date:\n" +
                            " <input type=\"text\" name=\"newDate\"class=\"textfield2\">\n" +
                            " </label>\n" +
                            " <input type=\"submit\" name=\"update\" value=\"Update\"class=\"formBtn2\">\n" +
                            "<input type=\"submit\" name=\"cancel\" value=\"Cancel\" class=\"formBtn2\">\n" +
                            " </form>");
                }

                if("Update Status".equals(request.getParameter("editStatus"+i))){
                    order_num = String.valueOf(rs.getInt("order_num"));
                    out.println(" <form class=\"addCard\" method=\"post\" action=\"updateOrder\">\n" +
                            " <input type=\"hidden\" name=\"order_num\" value=\"" + order_num + "\">\n" +
                            " <label>\n" +
                            " New Status:\n" +
                            " <input type=\"text\" name=\"newStatus\" class=\"textfield2\">\n" +
                            " </label>\n" +
                            " <input type=\"submit\" name=\"update\" value=\"Update\" class=\"formBtn2\">\n" +
                            "<input type=\"submit\" name=\"cancel\" value=\"Cancel\" class=\"formBtn2\">\n" +
                            " </form>");
                }
                i++;

        }


        rs.close();
        stmt.close();
        con.close();
    } catch (SQLException e) {
        out.println("SQLException caught: " + e.getMessage());
    }


%>
<%--</div>--%>
<%--</div>--%>
</body>
</html>
