
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
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
    <label>Select Vendor</label>
    <select class="selectVendor">
        <%
            String db = "egrocer";
            String user; // assumes database name is the same as username
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
                con.close();
            } catch (SQLException e) {
                out.println("SQLException caught: " + e.getMessage());
            }
        %>
    </select>
    <h3 id="selectedVendor" ></h3>
    <script>
        $(document).ready(function() {
            $("select.selectVendor").change(function() {
                const header = document.getElementById("selectedVendor");
                header.innerHTML = $(this).children("option:selected").val() + " Shop";

            });
        });
    </script>

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