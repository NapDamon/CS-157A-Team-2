<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="static java.lang.System.out" %><%--
  Created by IntelliJ IDEA.
  User: neenee
  Date: 10/25/22
  Time: 2:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
</head>
<body>
<h1>Sign Up</h1>
<form method="post" action="signup-page">
    <tr>
        <td>Name</td>
        <td><input type="text" name="name" /></td>
    </tr>
    <tr>
        <td>Phone</td>
        <td><input type="text" name="phone" /></td>
    <tr>
        <td>Email</td>
        <td><input type="text" name="email" /></td>
    </tr>
    </tr>
    <tr>
        <td>Password</td>
        <td><input type="password" name="password" /></td>
    </tr>
    <input type="submit" value="Submit" />

</form>

</body>
</html>
