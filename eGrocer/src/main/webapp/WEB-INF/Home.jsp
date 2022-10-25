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
    <a class="active" href="#home">Home</a>
    <a href="#about">About</a>
    <a href="#contact">Contact</a>
    <input type="text" placeholder="Search..">
</div>

<form method="post" align="center">
    <br /><br />
    <label for="vendor">Select Vendor</label>
    <select id="vendor" name="vendor" class="selectVendor">
        <%
            response.setContentType("text/html");
            PrintWriter output = response.getWriter();
            String db = "egrocer";
            String user;
            user = "root";

            ResultSet rs = null;
            Statement stmt = null;
            Connection con = null;
            try {

                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost/" + db, user, "root");
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT * FROM egrocer.vendors");
                while (rs.next()) {
                    out.println("<option value=" + rs.getString(2) + ">" + rs.getString(2) + "</option><br/><br/>");

                }
                rs.close();
                stmt.close();
               // con.close();
            } catch (SQLException e) {
                output.println("SQLException caught: " + e.getMessage());
            }
        %>
    </select>
<%--    <h3 id="selectedVendor"></h3>--%>
<%--    <script>--%>
<%--        $(document).ready(function() {--%>
<%--            $("select.selectVendor").change(function() {--%>
<%--                const header = document.getElementById("selectedVendor");--%>
<%--                header.innerHTML = $(this).children("option:selected").val() + " Shop";--%>

<%--            });--%>
<%--        });--%>
<%--    </script>--%>
    <%
        String selectedVendor =  request.getParameter("vendor");
        out.println("<h3>"+selectedVendor+"</h3>");
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM stock WHERE vendor="  + "'"+selectedVendor+"'" );
        while (rs.next()) {
            out.println( rs.getString(3) + ", " + rs.getString(4) +" "+"<input type=\"submit\" value=\"Add to cart\">" + "<br/><br/>");


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
