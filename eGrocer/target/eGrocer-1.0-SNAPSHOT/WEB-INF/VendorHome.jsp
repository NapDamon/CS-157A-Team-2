<%--
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
    out.println("<div><h3>Welcome "+ vendor +"</h3>");
    out.println("<form action=\"vendorLogin\">");
    out.println("<input type=\"submit\" value=\"Log out\" name=\"logout\"></form></div>");

  }else{
    out.println("<a href=\"vendorLogin\">Log in</a>");
  }

%>

</body>
</html>
