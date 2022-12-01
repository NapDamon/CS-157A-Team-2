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
<%@ page import="com.example.egrocer.RegisterDao" %>
<%@ page import="com.example.egrocer.OrderDao" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Or" %>
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
    OrderDao oDao = new OrderDao();
    int numInCart = oDao.numOfProdInCart(cart_id);
   

%>

<ul>
    <li><a class="active" href="customerHome">Home</a></li>
    <li><a href="customerOrders">Orders</a></li>
    <li><a href="account">Account</a></li>
        <%
            out.print("<li><a href=\"customerCart\">Cart (" + numInCart + ")</a></li>");
        %>

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
            int update, vendor_id = 0,product_id = 0, amount = 0,searchVendor_id = 0;
            float price = 0;
            String user, productName = null,searchResult = "";
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
<form>
    <div><label>- Or -</label></div>
    <br>
    <label for="search">Search for product by name:</label>
    <input type="text" id="search" name="search">
    <input type="submit" value="Go!" class="formBtn2">
</form>




    <%
        String selectedVendor =  request.getParameter("vendor");
        RegisterDao rDao = new RegisterDao();
        if (selectedVendor != null || rDao.getFavorite(customer_id) != -1){
            ProductsDao pdao = new ProductsDao();
            if(selectedVendor != null)
            {
                vendor_id = pdao.getVendorID(selectedVendor);
                session.setAttribute("selectedVendor",vendor_id);
                out.println("<h3><label> Currently Viewing: "+selectedVendor+"</label></h3>");
            }
            else if(rDao.getFavorite(customer_id) != -1)
            {
                vendor_id = rDao.getFavorite(customer_id);
                out.println("<h3><label> Currently Viewing Your Favorite: "+rDao.getVendorName(vendor_id)+"</label></h3>");
            }

            if(rDao.getFavorite(customer_id) != vendor_id)
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
                                + "<input type=\"submit\" id=\"cart\" class=\"formBtn2\" name = \"cart\" value=\"Add to cart\" >"
                                + "</form>");
            }
        }catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        searchResult = request.getParameter("search");
        if(searchResult != null)
        {
            try{
                productName = searchResult;
                stmt = con.createStatement();

                rs = stmt.executeQuery("SELECT * FROM products WHERE product_name = \"" + productName + "\"");
                out.print("<h3><label>Search Results for: " + productName + "</label></h3>");
                if(!rs.isBeforeFirst())
                    out.print("<div><label>No Products were found</label></div>");
                while (rs.next()){
                    searchVendor_id = rs.getInt("vendor_id");
                    out.print(
                            "<form>"
                                    + "<label>" + rs.getString("product_name") + "</label>" +
                                    "<input type=\"text\" style=\"display:none;\" name=\"product_name\" value=\"" + rs.getString("product_name") + "\">" +
                                    "<label>$" + rs.getFloat("price") + "</label>" +
                                    "<input type=\"text\" style=\"display:none;\" name=\"product_price\" value=\"" + rs.getFloat("price") + "\">" +
                                    "<label>Available: " + rs.getInt("quantity") + "</label> "
                                    + "<label>Vendor: " + rDao.getVendorName(searchVendor_id) + "</label>"
                                    + "<input type=\"text\" style=\"display:none;\" name=\"vendor_id\" value=\"" + searchVendor_id + "\">" +
                                    "<input type=\"number\" name=\"amount\" style=\"width: 60px\" value=\"1\">" + " "
                                    + "<input type=\"submit\" class=\"formBtn2\" name = \"searchCart\" value=\"Add to cart\" >"
                                    + "</form>");
                }
            }catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }

        String fav = request.getParameter("fav");
        if(fav != null)
        {
            vendor_id = (int) session.getAttribute("selectedVendor");
            if(rDao.getFavorite(customer_id) == -1)
            {
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
            else if(rDao.getFavorite(customer_id) != vendor_id)
            {
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
        String searchedProduct = request.getParameter("searchCart");
        if(selectedProduct != null || searchedProduct != null)
        {
            ProductsDao pdao = new ProductsDao();
            productName = request.getParameter("product_name");
            cart_id = (int) session.getAttribute("cart_id");
            if(session.getAttribute("selectedVendor") != null)
                vendor_id = (int) session.getAttribute("selectedVendor");
            else if(searchedProduct != null)
                vendor_id = Integer.parseInt(request.getParameter("vendor_id"));
            product_id = pdao.getProductID(vendor_id,productName);
            amount = Integer.parseInt(request.getParameter("amount"));
            price = Float.parseFloat(request.getParameter("product_price"));
            if(!oDao.checkInCart(product_id,cart_id))
            {
                String sql = "INSERT INTO contains(cart_id,product_id,vendor_id,quantity,price) values(?,?,?,?,?)";
                try{
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setInt(1, cart_id);
                    ps.setInt(2, product_id);
                    ps.setInt(3, vendor_id);
                    ps.setInt(4, amount);
                    ps.setFloat(5, price);
                    ps.executeUpdate();
                    oDao.updateCartNum(cart_id,amount + oDao.getCartNum(cart_id));
                }
                catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            else{
                String sql = "UPDATE contains SET quantity = ?,price = ? WHERE cart_id = " + cart_id + " AND " +
                        "product_id = " + product_id + " AND " + " vendor_id = " + vendor_id;
                try{
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setInt(1, amount);
                    ps.setFloat(2, price);
                    ps.executeUpdate();
                    oDao.updateCartNum(cart_id,amount + oDao.getCartNum(cart_id));
                }
                catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
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