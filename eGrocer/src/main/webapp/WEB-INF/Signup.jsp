<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.PrintWriter" %><%--
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
<form>
    <tr>
        <td>First Name</td>
        <td><input type="text" name="first_name" /></td>
    </tr>
    <tr>
        <td>Last Name</td>
        <td><input type="text" name="last_name" /></td>
    </tr>
    <tr>
        <td>UserName</td>
        <td><input type="text" name="username" /></td>
    </tr>
    <tr>
        <td>Password</td>
        <td><input type="password" name="password" /></td>
    </tr>
    <input type="submit" value="Submit" />
</form>
</body>
</html>
