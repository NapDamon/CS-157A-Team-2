<%--
  Created by IntelliJ IDEA.
  User: Emant
  Date: 11/11/2022
  Time: 10:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>eGrocer</title>
    <style><%@include file="/WEB-INF/CSS/style.css"%></style>
</head>
<body>
<header class="logo"><h1>eGrocer</h1></header>
<div class="content">

    <form method = "post" action = "Login" class="Card" >

        <label>
            Phone Number:
            <input type="text" name="Phone" class="textfield1">
        </label>
        <br><br><div style="text-align: center"><label >OR</label></div><br>
        <label>
            Email:
            <input type="email" name="Email"  class="textfield1">
        </label>
        <label>
            Password:
            <input type="password" name="Password" required class="textfield1">
        </label>
        <label>Are you a vendor?
        <input type="checkbox" name="isVendor" value="true">
        </label>
        <input type="submit" value="Log in" class="formBtn">

        <div>Don't have an account? Sign up <a href="Registration">here</a></div>
        <div style="padding-top: 16px; color: red">
            <%
                if(request.getAttribute("invalidCreds") != null && request.getAttribute("invalidCreds").equals("true")){
                    out.println("<label>Invalid Credentials</label>");

                }
                if(request.getAttribute("vendor") != null && request.getAttribute("vendor").equals("false")){
                    out.println("<label>You are not a vendor.</label>");

                }
                if(request.getAttribute("customer") != null && request.getAttribute("customer").equals("false")){
                    out.println("<label>You are not a customer.</label>");

                }
            %>
        </div>
    </form>

</div>

</body>
</html>
