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
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.egrocer.RegisterDao" %>
<%@ page import="com.example.egrocer.OrderDao" %>
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
    <%
        OrderDao oDao = new OrderDao();
        int cart_id = (int) session.getAttribute("cart_id");
        int numInCart = oDao.numOfProdInCart(cart_id);
        out.print("<li><a href=\"customerCart\">Cart (" + numInCart + ")</a></li>");
    %>
  <li style="float:right"><a href="logout">Log Out</a>
  </li>

</ul>

<%
    response.setContentType("text/html");
    PrintWriter output = response.getWriter();
    String db = "egrocer";
    int update, vendor_id = 0,product_id = 0, amount = 0;
    String user, productName = null, vendorName = null;
    user = "root";
    ResultSet rs = null;
    int i =0;
    Statement stmt = null;
    Connection con = null;
    String name, password, email, phone, address;
    int customer_id;
    ProductsDao pDao = new ProductsDao();
    RegisterDao rDao = new RegisterDao();
    float total = 0;
    ArrayList<Integer> orderNums = new ArrayList<>();

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

    out.println("<div><h3>" + name + "'s Orders</h3></div><br>");

    try{
      stmt = con.createStatement();

      rs = stmt.executeQuery("SELECT order_num FROM egrocer.orders WHERE customer_id = " + customer_id);
      while (rs.next())
        orderNums.add(rs.getInt("order_num"));
    } catch (SQLException e) {
      output.println("SQLException caught: " + e.getMessage());
    }

    try{
      for(int j = 0;j<orderNums.size();j++)
      {
        out.print("<form><div><h3><label>Order Number: " + orderNums.get(j) + "</label></h3></div>");
        out.print("<input type=\"text\" style=\"display:none;\" name=\"orderNum\" value=\"" + orderNums.get(j) + "\">");
        out.print("<input type=\"submit\" class=\"formBtn4\" name=\"removeOrderDetail\" value=\"Remove this order details\"></form>");
        rs = stmt.executeQuery("SELECT * FROM contents_of WHERE order_num = " + orderNums.get(j));
        while (rs.next()){
          productName = pDao.getProductName(rs.getInt("product_id"));
          vendorName = rDao.getVendorName(pDao.getVendorID(rs.getInt("product_id")));
          out.print("<label>" + productName + "</label>" +
                          "<input type=\"text\" style=\"display:none;\" name=\"product_id\" value=\"" + rs.getInt("product_id") + "\">" +
                          "<label>Amount ordered: " + rs.getInt("quantity") + "</label>" +
                            "<label> Ordered from: " + vendorName + "</label><br>");
        }
      }
    } catch (SQLException e) {
      output.println("SQLException caught: " + e.getMessage());
    }

    String removeOrder = request.getParameter("removeOrderDetail");
    if(removeOrder != null)
    {
        int orderToRemove = Integer.parseInt(request.getParameter("orderNum"));
        oDao.deleteOrder(orderToRemove,customer_id,cart_id);
    }

  }

%>
</body>
</html>
