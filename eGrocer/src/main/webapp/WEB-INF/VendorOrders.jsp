<%--
  Created by IntelliJ IDEA.
  User: Emant
  Date: 11/11/2022
  Time: 7:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.egrocer.ProductsDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>eGrocer</title>
</head>
<body>

<%
    int vendor_id = (int) session.getAttribute("vendor_id");


    String db = "egrocer";
    String user = "root";
    ResultSet rs = null;
    Statement stmt = null;
    Connection con = null;
    String order_num="";
    int i = 1;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost/" + db, user, "root");
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM ships WHERE vendor_id=" + vendor_id);
        while(rs.next()){

            out.println("Order Number: "+ rs.getInt("order_num")+ ", Shipment ID: " + rs.getInt("shipment_id")
                    + ", Shipping Date: "+ rs.getString("shipping_date") + ", Status: " + rs.getString("status")
                    + " <form action=\"vendorOrders\"> "
                    + "<input type=\"submit\" value=\"Update Status\" name=\"editStatus" +i+"\"></form>");


            if("Update Status".equals(request.getParameter("editStatus"+i))){
                order_num = String.valueOf(rs.getInt("order_num"));
                out.println(" <form method=\"post\" action=\"updateStatus\">\n" +
                        " <input type=\"hidden\" name=\"order_num\" value=\"" + order_num + "\">\n" +
                        " <label>\n" +
                        " New Status:\n" +
                        " <input type=\"text\" name=\"newStatus\">\n" +
                        " </label>\n" +
                        " <input type=\"submit\" value=\"Update\">\n" +
                        " </form>");
            }
            i++;
        }
        rs.close();
        stmt.close();
        con.close();
    } catch (SQLException e) {
        out.println("SQLException caught: " + e.getMessage());
    }

//    if("Update Status".equals(request.getParameter("editStatus"))){
//        out.println(" <form method=\"post\" action=\"updateStatus\">\n" +
//                " <input type=\"hidden\" name=\"order_num\" value=\"" + order_num + "\">\n" +
//                " <label>\n" +
//                " New Status:\n" +
//                " <input type=\"text\" name=\"newStatus\">\n" +
//                " </label>\n" +
//                " <input type=\"submit\" value=\"Update\">\n" +
//                " </form>");
//
//    }
%>
</body>
</html>
