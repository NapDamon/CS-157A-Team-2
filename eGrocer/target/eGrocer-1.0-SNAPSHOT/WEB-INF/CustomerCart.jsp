<%--
  Created by IntelliJ IDEA.
  User: napda
  Date: 11/17/2022
  Time: 1:17 PM
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
  <li><a href="customerOrders">Orders</a></li>
  <li><a href="account">Account</a></li>
  <li><a class="active" href="customerCart">Cart</a></li>
  <li style="float:right"><a href="logout">Log Out</a>
  </li>

</ul>

<%
  response.setContentType("text/html");
  PrintWriter output = response.getWriter();
  String db = "egrocer";
  int update, vendor_id = 0,product_id = 0, amount = 0;
  String user, productName = null;
  user = "root";
  ResultSet rs = null;
  int i =0;
  Statement stmt = null;
  Connection con = null;
  String name, password, email, phone, address;
  int cart_id, customer_id;
  ProductsDao pDao = new ProductsDao();

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
    cart_id = (int) session.getAttribute("cart_id");

    out.println("<h3><label>Cart for " + name + "</label></h3>");
    try{
      stmt = con.createStatement();

      rs = stmt.executeQuery("SELECT * FROM contains WHERE cart_id = " + cart_id);
      while (rs.next()){
        productName = pDao.getProductName(rs.getInt("product_id"));
        out.print(
                "<form>"
                        + "<label>" + productName + "</label>" +
                        "<input type=\"text\" style=\"display:none;\" name=\"product_id\" value=\"" + rs.getInt("product_id") + "\">" +
                        "<label>$" + rs.getFloat("price")*rs.getInt("quantity") + "</label>" +
                        "<input type=\"text\" style=\"display:none;\" name=\"product_price\" value=\"" + rs.getFloat("price")*rs.getInt("quantity") + "\">" +
                        "<label>Amount in cart: " + rs.getInt("quantity") + "</label> "
                        + "<input type=\"submit\" class=\"formBtn2\" name = \"remove\" value=\"Remove from cart\" >"
                        + "</form>");
        }
      } catch (SQLException e) {
        output.println("SQLException caught: " + e.getMessage());
      }

    String selectedProduct = request.getParameter("remove");
    if(selectedProduct != null)
    {
      ProductsDao pdao = new ProductsDao();
      product_id =Integer.parseInt(request.getParameter("product_id"));
      cart_id = (int) session.getAttribute("cart_id");
      String sql = "DELETE FROM contains WHERE product_id = " + product_id + " AND cart_id = " +cart_id;
      try{
        PreparedStatement ps = con.prepareStatement(sql);
        ps.executeUpdate();
      }
      catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }
    }

  }

%>



</body>
</html>
