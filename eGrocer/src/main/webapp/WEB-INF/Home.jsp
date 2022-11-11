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
<html>
<head>
    <title>eGrocer</title>
    <link href="<c:url value='/style.css'/>" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
</head>
<body>

<%--placeholder menu--%>
<div align="center" class="topnav">
    <input type="text" placeholder="Search..">
    <%
        String username = "", password="";
        int userID = 0;
        if(session.getAttribute("name")!= null){
            out.println("Welcome " + session.getAttribute("name"));
            if("logout".equals(request.getParameter("logout"))){
                session.setAttribute("name", null);
                session.setAttribute("password", null);
                session.setAttribute("email", null);
                session.setAttribute("address", null);
                session.setAttribute("password", null);
                session.invalidate();

            }
            else{
                out.println("<form action=\"login-page\">");
                out.println("<input type=\"submit\" value=\"Log out\" name=\"logout\"></form>");
            }
        }
    %>

</div>

<form  align="center" action="home">
    <br /><br />
    <label for="vendor">Select Vendor</label>
    <select id="vendor" name="vendor" class="selectVendor">
        <%
            response.setContentType("text/html");
            PrintWriter output = response.getWriter();
            String db = "egrocer";
            int vendorID = 0;
            int cartID = 0;
            String user;
            user = "root";
            ResultSet rs = null;
            int update;
            ResultSet rs2 = null;
            Statement stmt = null;
            Connection con = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost/" + db, user, "root");
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT * FROM egrocer.vendors");
                while (rs.next()) {
                    vendorID = rs.getInt("vendor_id");
                    out.println("<option value=\"" + rs.getString("vendor_name") + "\">" + rs.getString("vendor_name") + "</option><br/><br/>");
                }
                rs.close();

                rs = stmt.executeQuery("SELECT * FROM own");
                while(rs.next()){
                    if(rs.getInt("customer_id") == userID){
                        cartID = rs.getInt("cart_id");
                    }
                }
                rs.close();
                stmt.close();

                // con.close();
            } catch (SQLException e) {
                output.println("SQLException caught: " + e.getMessage());
            }
        %>
    </select>
    <input type="submit" value="Go!">


    <%
        String selectedVendor =  request.getParameter("vendor");
        if (selectedVendor != null){
            out.println("<h3>"+selectedVendor+" Shop"+"</h3>");
        }

        stmt = con.createStatement();

        rs = stmt.executeQuery("SELECT * FROM products WHERE vendor_id IN (SELECT vendor_id FROM vendors WHERE vendor_name =" +selectedVendor + ")");
        while (rs.next()){
                out.println( rs.getString("product_name") +rs.getFloat("price") +" " +"<input type=\"submit\" name = \"cart\" value=\"Add to cart\">" + "<br/><br/>");
                if(request.getParameter("cart") != null){
                    update = stmt.executeUpdate("INSERT INTO cart (cart_id, product_id)VALUES(" + cartID + "," + rs.getString("product_id") + ")");
                }
        }

        rs.close();
        stmt.close();
        con.close();



    %>

    <%--        <div class="row">--%>
    <%--            <div class = "column">--%>
    <%--&lt;%&ndash;                <img src="<c:url value='/images/banana.jpg'/>" height="300" width="300" alt="Not available"/>&ndash;%&gt;--%>
    <%--            </div>--%>
    <%--            <div class = "column">--%>
    <%--&lt;%&ndash;                <img src="<c:url value='/images/apple.jpg'/>" height ="300" width="300" alt="Not available"/>&ndash;%&gt;--%>
    <%--            </div>--%>
    <%--        </div>--%>

</form>

</body>
</html>