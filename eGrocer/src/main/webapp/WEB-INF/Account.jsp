<%@ page import="com.example.egrocer.RegisterDao" %><%--
  Created by IntelliJ IDEA.
  User: Emant
  Date: 11/14/2022
  Time: 3:01 PM
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
    String name ="";
    if(session.getAttribute("vendor") != null){
        name = session.getAttribute("vendor").toString();
    }
    if(session.getAttribute("customer") != null){
        name = session.getAttribute("customer").toString();
    }
String email = session.getAttribute("email").toString();
String phone = session.getAttribute("phone").toString();
String address = session.getAttribute("address").toString();

if(session.getAttribute("vendor") != null){
    out.println(
            "<ul>\n" +
                    "  <li><a href=\"vendorHome\">Home</a></li>\n" +
                    "  <li><a href=\"vendorOrders\">Orders</a></li>\n" +
                    "  <li><a class=\"active\" href=\"account\">Account</a></li>\n" +
                    "  <li style=\"float:right\"><a href=\"logout\">Log Out</a>\n" +
                    "  </li>\n" +
                    "</ul>"
    );
}else out.println(
        "<ul>\n" +
                "    <li><a href=\"customerHome\">Home</a></li>\n" +
                "    <li><a href=\"customerOrders\">Orders</a></li>\n" +
                "    <li><a class=\"active\" href=\"account\">Account</a></li>\n" +
                "    <li><a href=\"customerCart\">Cart</a></li>\n" +
                "    <li style=\"float:right\"><a href=\"logout\">Log Out</a>\n" +
                "    </li>\n" +
                "</ul>"
);
%>



<div class="content">
 <div class="padding">
<form class="Card" style="text-align: center">

  <label>Name: <%out.println(name);%></label><br><br>
  <label>Email: <%out.println(email);%></label><br><br>
  <label>Phone: <%out.println(phone);%></label><br><br>
  <label>Address: <%out.println(address);%></label><br><br>
    <input type="submit" name="changePW" value="Change Password" class="formBtn2">
</form>
    <%

    if("Change Password".equals(request.getParameter("changePW"))){
        out.println(

                        "     <form action=\"account\" method=\"post\" class=\"Card\" style=\"text-align: center\">\n" +
                        "         <label> \n" +
                        "             Current Password: \n" +
                        "             <input type=\"password\" name=\"currentPW\"class=\"textfield1\">\n" +
                        "         </label>\n" +
                        "         <label> \n" +
                        "             New Password: \n" +
                        "             <input type=\"password\" name=\"newPW\" class=\"textfield1\">\n" +
                        "         </label>\n" +
                        "         <input type=\"submit\" name=\"updatePW\" value=\"Update\" class=\"formBtn2\">\n" +
                        "         \n" +
                        "     </form>"
        );
    }

  if(request.getAttribute("correctPW") != null && request.getAttribute("correctPW").equals("false")){
      out.println("<label>Current password is incorrect</label>");

  }
  if(request.getAttribute("changed") != null && request.getAttribute("changed").equals("true")){
      out.println("<label>Successfully changed password.</label>");

  }

    %>





 </div>
</div>

</body>
</html>
