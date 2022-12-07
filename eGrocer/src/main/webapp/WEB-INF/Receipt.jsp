<%--
  Created by IntelliJ IDEA.
  User: neenee
  Date: 11/30/22
  Time: 7:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.egrocer.ProductsDao" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.egrocer.OrderDao" %>
<%@ page import="java.time.LocalDate" %>

<html>
<head>
    <title>Receipt</title>
    <style><%@include file="/WEB-INF/CSS/style.css"%></style>
</head>
<body>
<div class="logo">
    <h1>Thank you!</h1>
</div>

<h3 align="center">Order Details</h3>

<%
    OrderDao oDao = new OrderDao();
    int cart_id = (int) session.getAttribute("cart_id");
%>
<%
    response.setContentType("text/html");
    PrintWriter output = response.getWriter();
    String db = "egrocer";
    String user, productName = null;
    user = "root";
    ResultSet rs = null;
    int i =0;
    Statement stmt = null;
    Connection con = null;
    String name, password, email, phone, address;
    int customer_id = 0;
    ProductsDao pDao = new ProductsDao();
    float total = 0, tax = 0;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/" + db, user, "root");
    } catch (SQLException e) {
        output.println("SQLException caught: " + e.getMessage());
    }
    if(session.getAttribute("customer")!= null) {
        name = session.getAttribute("customer").toString();
        password = session.getAttribute("password").toString();
        customer_id = (int) session.getAttribute("customer_id");
        email = session.getAttribute("email").toString();
        phone = session.getAttribute("phone").toString();
        address = session.getAttribute("address").toString();
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT * FROM contains WHERE cart_id = " + cart_id);
            while (rs.next()) {
                productName = pDao.getProductName(rs.getInt("product_id"));
                total += rs.getFloat("price") * rs.getInt("quantity");
                out.print(
                        "<div align=\"center\"><form>"
                                + "<label>" + productName + "</label>"
                                + "<input type=\"text\" style=\"display:none;\" name=\"product_id\" value=\"" + rs.getInt("product_id") + "\">"
                                + "<label>Quanity: " + rs.getInt("quantity") + "</label> "
                                + "<label>$" + rs.getFloat("price") * rs.getInt("quantity") + "</label>"
                                + "<input type=\"text\" style=\"display:none;\" name=\"product_price\" value=\"" + rs.getFloat("price") * rs.getInt("quantity") + "\">"
                                + "</div></form>");
            }
        }
        catch (SQLException e) {
            output.println("SQLException caught: " + e.getMessage());
        }

    }


    int orderNum = 0;
    double amount = 0.0;
    LocalDate today = LocalDate.now();
    String method;
    method = "Debit Card";
    method = "Credit Card";

        out.println("<div align=\"center\"><p><b>Order Date: " + today + "</b></p></div>");
        out.println("<div align=\"center\"><p><b>Total: " + total + "</b></p></div>");

    try{
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT order_num FROM egrocer.orders ORDER BY order_num DESC LIMIT 1");

        while(rs.next())
            orderNum = rs.getInt("order_num");
    }catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }

    try
    {
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT SUM(price * quantity) as total  FROM contains WHERE cart_id = " + cart_id);
        while (rs.next()){
            amount = rs.getDouble("total");
        }
    }catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }

    oDao.addOrder(orderNum+1,today.toString(),customer_id,orderNum+301);
    oDao.createOrderDetails(cart_id,orderNum+1);

    oDao.addPayment(orderNum + 301, today.toString(), method, amount, customer_id);

%>

<form action="customerHome">
    <div align="center"><input type="submit" value="Return to Home Page" class="formBtn3"></div>
</form>


</body>
</html>