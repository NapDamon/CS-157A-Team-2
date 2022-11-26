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
<%@ page import="java.lang.*" %>
<html>
<head>
    <title>eGrocer</title>
    <style><%@include file="/WEB-INF/CSS/style.css"%></style>

</head>
<body>


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

   

%>

<ul>
    <li><a class="active" href="customerHome">Home</a></li>
    <li><a href="customerOrders">Orders</a></li>
    <li><a href="account">Account</a></li>
    <li><a href="customerCart">Cart</a></li>
    <li style="float:right"><a href="logout">Log Out</a>
    </li>
</ul>

<%
    out.println("<div><h3>Welcome, "+ name +"!</h3></div>");
%>

<form  action="customerHome">
    <br /><br />

    <label for="vendor">Select Vendor</label>
    <select id="vendor" name="vendor">
        <%
            response.setContentType("text/html");
            PrintWriter output = response.getWriter();
            String db = "egrocer";
            int update, vendor_id = 0,product_id = 0, amount = 0;
            float price = 0;
            String user, productName = null;
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
            ProductsDao pdao = new ProductsDao();
            vendor_id = pdao.getVendorID(selectedVendor);
            session.setAttribute("selectedVendor",vendor_id);
            //String sql = "SELECT COUNT(customer_id) AS count FROM egrocer.favorite WHERE customer_id = " + customer_id + " AND vendor_id = " + vendor_id;
            int count = 0;
            try{
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT COUNT(customer_id) AS count FROM egrocer.favorite WHERE customer_id = "
                        + customer_id + " AND vendor_id = " + vendor_id);
                while(rs.next())
                    count = rs.getInt("count");
            }catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            out.println("<h3><label> Currently Viewing: "+selectedVendor+"</label></h3>");
            if(count != 1)
                out.println("<form><input type=\"submit\" class=\"formBtn4\" name=\"fav\" value=\"Make Favorite!\"></form>");
        }
        try{
            stmt = con.createStatement();

            rs = stmt.executeQuery("SELECT * FROM products WHERE vendor_id =" + vendor_id);
            while (rs.next()){
                out.print(
                        "<form>"
                                + "<label>" + rs.getString("product_name") + "</label>" +
                                "<input type=\"text\" style=\"display:none;\" name=\"product_name\" value=\"" + rs.getString("product_name") + "\">" +
                                "<label>$" + rs.getFloat("price") + "</label>" +
                                "<input type=\"text\" style=\"display:none;\" name=\"product_price\" value=\"" + rs.getFloat("price") + "\">" +
                                "<label>Available: " + rs.getInt("quantity") + "</label> "
                                + "<input type=\"number\" name=\"amount\" style=\"width: 60px\" value=\"1\">" + "  "
                                + "<input type=\"submit\" class=\"formBtn2\" name = \"cart\" value=\"Add to cart\" >"
                                + "</form>");
            }
        }catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        String fav = request.getParameter("fav");
        if(fav != null)
        {
            int count = 0;
            try{
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT COUNT(customer_id) AS count FROM egrocer.favorite WHERE customer_id = "
                        + customer_id);
                while(rs.next())
                    count = rs.getInt("count");
            }catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            if(count == 0)
            {
                //ProductsDao pdao = new ProductsDao();
                vendor_id = (int) session.getAttribute("selectedVendor");
                String sql = "INSERT INTO favorite(customer_id,vendor_id) values(?,?)";
                try{
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setInt(1,customer_id);
                    ps.setInt(2,vendor_id);
                    ps.executeUpdate();
                }catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            else if(count == 1)
            {
                vendor_id = (int) session.getAttribute("selectedVendor");
                String sql = "UPDATE favorite SET customer_id = ?, vendor_id = ? WHERE customer_id = " + customer_id;
                try{
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setInt(1,customer_id);
                    ps.setInt(2,vendor_id);
                    ps.executeUpdate();
                }catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }

        String selectedProduct = request.getParameter("cart");
        if(selectedProduct != null)
        {
            ProductsDao pdao = new ProductsDao();
            productName = request.getParameter("product_name");
            cart_id = (int) session.getAttribute("cart_id");
            vendor_id = (int) session.getAttribute("selectedVendor");
            product_id = pdao.getProductID(vendor_id,productName);
            amount = Integer.parseInt(request.getParameter("amount"));
            price = Float.parseFloat(request.getParameter("product_price"));
            String sql = "INSERT INTO contains(cart_id,product_id,vendor_id,quantity,price) values(?,?,?,?,?)";
            try{
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, cart_id);
                ps.setInt(2, product_id);
                ps.setInt(3, vendor_id);
                ps.setInt(4, amount);
                ps.setFloat(5, price);
                ps.executeUpdate();
            }
            catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
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