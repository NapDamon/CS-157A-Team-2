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

<html>
<head>
    <title>Receipt</title>
    <style><%@include file="/WEB-INF/CSS/style.css"%></style>
</head>
<body>
<div align="center">
    <h1>Thank you!</h1>
    <h3>Order Details</h3>
    <p><b>Order Date: 1/1/2018</b></p>
</div>
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
    int customer_id;
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

      out.println("<div align=\"center\"><p><b>Total: " + total + "</b></p></div>");
    }
%>

    <form action="customerHome">
        <div align="center"><input type="submit" value="Return to Home Page" class="formBtn2"></div>
    </form>

</body>
</html>
