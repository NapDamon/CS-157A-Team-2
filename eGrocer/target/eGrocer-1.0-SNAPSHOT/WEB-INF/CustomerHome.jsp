<%--
  Created by IntelliJ IDEA.
  User: Emant
  Date: 10/25/2022
  Time: 9:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.example.egrocer.ProductsDao" %>
<html>
<head>
    <title>eGrocer</title>
    <style><%@include file="/WEB-INF/CSS/style.css"%></style>

</head>
<body>

<ul>
    <li><a class="active" href="customerHome">Home</a></li>
    <li><a href="customerOrders">Orders</a></li>
    <li><a href="customerAccount">Account</a></li>
    <li style="float:right"><a href="logout">Log Out</a>
    </li>
</ul>

<%
    String name, password, email, phone, address;
    int cart_id, customer_id;
if(session.getAttribute("customer")!= null){
    name = session.getAttribute("customer").toString();
    password = session.getAttribute("password").toString();
    customer_id = (int) session.getAttribute("customer_id");
    email = session.getAttribute("email").toString();
    phone = session.getAttribute("phone").toString();
    address = session.getAttribute("address").toString();
    cart_id = (int) session.getAttribute("cart_id");

    out.println("<h3><label>Welcome " + session.getAttribute("customer") + "</label></h3>");

%>



<form  action="customerHome">
    <br /><br />

    <label for="vendor">Select Vendor</label>
    <select id="vendor" name="vendor">
        <%
            response.setContentType("text/html");
            PrintWriter output = response.getWriter();
            String db = "egrocer";
            int update, vendor_id = 0;
            String user;
            user = "root";
            ResultSet rs = null;
            int i =0;
            Statement stmt = null;
            Connection con = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost/" + db, user, "root");
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT * FROM egrocer.vendors");
                while (rs.next()) {
                    out.println("<option value=\"" + rs.getString("vendor_name") + "\">" + rs.getString("vendor_name") + "</option><br/><br/>");
                }

                rs.close();
                stmt.close();

            } catch (SQLException e) {
                output.println("SQLException caught: " + e.getMessage());
            }
        %>
    </select>
    <input type="submit" value="Go!" class="formBtn2">
</form>




    <%
        String selectedVendor =  request.getParameter("vendor");
        if (selectedVendor != null){
            out.println("<h3><label> Currently Viewing: "+selectedVendor+"</label></h3>");
            ProductsDao pdao = new ProductsDao();
            vendor_id = pdao.getVendorID(selectedVendor);
        }

        stmt = con.createStatement();

        rs = stmt.executeQuery("SELECT * FROM products WHERE vendor_id =" + vendor_id);
        while (rs.next()){
            out.print(
                    "<form>"
                            + "<label>" + rs.getString("product_name") + "</label>" +
                            "<label>$" + rs.getFloat("price") + "</label>"
                            + "<label>Available: " + rs.getInt("quantity") + "</label> "
                            + "<input type=\"number\" name=\"amount\" style=\"width: 60px\" value=\"1\">" + "  "
                            + "<input type=\"submit\" class=\"formBtn2\" name = \"cart\" value=\"Add to cart\" >"
                            + "</form>");
        }

        rs.close();
        stmt.close();
        con.close();



    %>

<%
    }else{
        out.println("<a href=\"customerLogin\">Log in</a>");
    }
%>




</body>
</html>