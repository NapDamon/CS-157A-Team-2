
<%@ page import="java.sql.*" %>
<%@ page import="com.example.egrocer.ProductsDao" %><%--
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

    out.println("<div><h3>Welcome, "+ vendor +"!</h3>");
%>
<form action="vendorOrders">
  <input type="submit" value="View Orders">
</form>
    <form action="vendorLogin">
    <input type="submit" value="Log out" name="logout">
    </form></div>

    <form action="vendorHome" method="post">
      <label>
        Product Name:
        <input type="text" name="pname" required>
      </label>
      <label>
        Price:
        <input type="text" name="price" required>
      </label>
      <label>
        Quantity:
        <input type="text" name="quantity" required>
      </label>
      <%
        out.println("<input type=\"hidden\" name=\"vendor\" value=\"" + vendor +"\">");
      %>

      <input type="submit" value="Add">
    </form>

      <h4>Current products: </h4>
      <%

        String db = "egrocer";
        String user = "root";
        ResultSet rs = null;
        Statement stmt = null;
        Connection con = null;
        int i =1;
        String product_id;
        try {
          Class.forName("com.mysql.jdbc.Driver");
          con = DriverManager.getConnection("jdbc:mysql://localhost/" + db, user, "root");
          stmt = con.createStatement();
          rs = stmt.executeQuery("SELECT * FROM products");
          while(rs.next()){
            if(vendor_id == rs.getInt("vendor_id")){
              out.println("<form action=\"vendorHome\"> Product: "+rs.getString("product_name")+ " <input type=\"submit\" value=\"Edit\" name=\"editName"+ i+ "\">"
              + "  Price: " +rs.getFloat("price")+ " <input type=\"submit\" value=\"Edit\" name=\"editPrice" +i +"\">"
              +"  Quantity: "+ rs.getInt("quantity") + " <input type=\"submit\" value=\"Edit\" name=\"editQuantity"+ i+"\">");
              out.println("<input type=\"submit\" value=\"Remove Product\" name=\"delete" +i +"\"></form>");

              if("Remove Product".equals(request.getParameter("delete"+i))){
                product_id = String.valueOf(rs.getInt("product_id"));
                out.println("<form method=\"post\" action=\"deleteProduct\">\n" +
                        " <input type=\"hidden\" name=\"product_id\" value=\"" + product_id + "\">\n" +
                        " <label>\n" +
                        " Are you sure you want to proceed?\n" +
                        " <input type=\"submit\" name=\"yes\" value=\"Yes\">\n" +
                        " <input type=\"submit\" name=\"no\" value=\"Cancel\">\n" +
                        " </label>\n" +
                        " </form>");

              }

              if("Edit".equals(request.getParameter("editPrice"+i))){
                product_id = String.valueOf(rs.getInt("product_id"));
                out.println("<form method=\"post\" action=\"editProduct\">\n" +
                        " <input type=\"hidden\" name=\"product_id\" value=\"" + product_id + "\">\n" +
                        " <label>\n" +
                        " New Product Price:\n" +
                        " <input type=\"text\" name=\"newPrice\">\n" +
                        " </label>\n" +
                        " <input type=\"submit\" value=\"Update\">\n" +
                        " </form>");
              }
              if("Edit".equals(request.getParameter("editName"+i))){
                product_id = String.valueOf(rs.getInt("product_id"));
                out.println("<form method=\"post\" action=\"editProduct\">\n" +
                        " <input type=\"hidden\" name=\"product_id\" value=\"" + product_id + "\">\n" +
                        " <label>\n" +
                        " New Product Name:\n" +
                        " <input type=\"text\" name=\"newPname\">\n" +
                        " </label>\n" +
                        " <input type=\"submit\" value=\"Update\">\n" +
                        " </form>");
              }
              if("Edit".equals(request.getParameter("editQuantity"+i))){
                product_id = String.valueOf(rs.getInt("product_id"));
                out.println("<form method=\"post\" action=\"editProduct\">\n" +
                        " <input type=\"hidden\" name=\"product_id\" value=\"" + product_id + "\">\n" +
                        " <label>\n" +
                        " New Product Quantity:\n" +
                        " <input type=\"text\" name=\"newQuantity\">\n" +
                        " </label>\n" +
                        " <input type=\"submit\" value=\"Update\">\n" +
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

       // if("Edit".equals(request.getParameter("editName"))){

        %>








<%
  }else{
    out.println("<a href=\"vendorLogin\">Log in</a>");
  }

%>

</body>
</html>
