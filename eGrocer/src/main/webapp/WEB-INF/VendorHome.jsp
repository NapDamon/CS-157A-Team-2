
<%@ page import="java.sql.*" %>
<%@ page import="com.example.egrocer.ProductsDao" %>
<%@ page import="com.example.egrocer.RegisterDao" %><%--
  Created by IntelliJ IDEA.
  User: Emant
  Date: 11/11/2022
  Time: 1:34 PM
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

  String vendor, email, password;
  if(session.getAttribute("vendor") != null){
    vendor = session.getAttribute("vendor").toString();
    email = session.getAttribute("email").toString();
    password = session.getAttribute("password").toString();

    ProductsDao pdao = new ProductsDao();

    int vendor_id = pdao.getVendorID(vendor);
%>

<ul>
  <li><a class="active" href="vendorHome">Home</a></li>
  <li><a href="vendorOrders">Orders</a></li>
  <li><a href="account">Account</a></li>
  <li style="float:right"><a href="logout">Log Out</a>
  </li>
</ul>
<div >

<%
    out.println("<div><h3>Welcome, "+ vendor +"!</h3></div>");
%>





    <form action="vendorHome" method="post" class="addCard">
      <label>
        Product Name:
        <input type="text" name="pname" required class="textfield2">
      </label>
      <label>
        Price:
        <input type="text" name="price" required class="textfield2">
      </label>
      <label>
        Quantity:
        <input type="text" name="quantity" required class="textfield2">
      </label>
      <%
        out.println("<input type=\"hidden\" name=\"vendor\" value=\"" + vendor +"\">");
      %>

      <input type="submit" value="Add" class="formBtn2">
    </form>

      <h4>Your Inventory: </h4>

      <%
        String dburl = "jdbc:mysql://localhost:3306/egrocer";
        String dbuname = "root";
        String dbpassword = "root";
        ResultSet rs = null;
        Statement stmt = null;
        Connection con = null;
        int i =1;
        String product_id;
        try {
          Class.forName("com.mysql.jdbc.Driver");
          con = DriverManager.getConnection(dburl, dbuname, dbpassword);
         // con = DriverManager.getConnection("jdbc:mysql://localhost/" + db, user, "root");
          stmt = con.createStatement();
          rs = stmt.executeQuery("SELECT * FROM products");

          while(rs.next()){
            if(vendor_id == rs.getInt("vendor_id")){
              out.println("<form class=\"addCard\" action=\"vendorHome\">"
              + "<label> Product: "+rs.getString("product_name")+ "</label>"
              + "<label>  Price: " +rs.getFloat("price")+ "</label>"
              +"<label>  Quantity: "+ rs.getInt("quantity") + "</label>");
              out.println("<input class=\"formBtn2\" type=\"submit\" value=\"Edit Product\" name=\"edit" +i +"\">");
              out.println("<input class=\"formBtn2\" type=\"submit\" value=\"Remove Product\" name=\"delete" +i +"\">");
              out.println("</form>");

              if("Edit Product".equals(request.getParameter("edit"+i))){
                product_id = String.valueOf(rs.getInt("product_id"));
                out.println("<form class=\"addCard\" method=\"post\" action=\"editProduct\">\n" +
                        " <input type=\"hidden\" name=\"product_id\" value=\"" + product_id + "\">\n" +
                        " <label>\n"+
                        " New Product Name:\n" +
                        " <input type=\"text\" name=\"newPname\" class=\"textfield2\">\n" +
                        " </label>\n" +
                        " <label>\n" +
                        " New Product Price: \n" +
                        " <input type=\"text\" name=\"newPrice\" class=\"textfield2\">\n" +
                        " </label>\n" +
                        " <label>\n" +
                        " New Product Quantity:\n" +
                        " <input type=\"text\" name=\"newQuantity\" class=\"textfield2\">\n" +
                        " </label>\n" +
                        " <input type=\"submit\" name=\"update\" value=\"Update\" class=\"formBtn2\">\n" +
                        "<input type=\"submit\" name=\"cancel\" value=\"Cancel\" class=\"formBtn2\">\n" +
                        " </form>");
              }
              if("Remove Product".equals(request.getParameter("delete"+i))){
                product_id = String.valueOf(rs.getInt("product_id"));
                out.println("<form  class=\"addCard\" method=\"post\" action=\"deleteProduct\">\n" +
                        " <input type=\"hidden\" name=\"product_id\" value=\"" + product_id + "\">\n" +
                        " <label>\n" +
                        " Are you sure you want to proceed?\n" +
                        " <input type=\"submit\" name=\"yes\" value=\"Yes\" class=\"formBtn2\">\n" +
                        " <input type=\"submit\" name=\"no\" value=\"Cancel\" class=\"formBtn2\">\n" +
                        " </label>\n" +
                        " </form>");
              }

              i++;
            }
          }

          rs.close();
          stmt.close();

           con.close();
        } catch (SQLException e) {
          out.println("SQLException caught: " + e.getMessage());
        }


        %>








<%
  }else{
    out.println("<a href=\"vendorLogin\">Log in</a>");
  }

%>

</div>
</body>
</html>
