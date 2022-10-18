<%--
  Created by IntelliJ IDEA.
  User: napda
  Date: 10/18/2022
  Time: 2:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h1>Login</h1>
<br/>
<form>
  <label for=\"username\">Username:</label><br>
  <input type="text" id=\"username\" name=\"username\"><br>
  <label for=\"password\">Password:</label><br>
  <input type="text" id=\"password\" name=\"password\"><br><br>
  <input type="submit" value="Login"><br>
</form>
<%
  response.setContentType("text/html");
  PrintWriter output = response.getWriter();
  String db = "eGrocer";
  String user; // assumes database name is the same as username
  user = "root";
  String password = "root";
  String usernameInput = request.getParameter("username");
  String passwordInput = request.getParameter("password");
  try {

    java.sql.Connection con;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eGrocer",user, password);

    //out.println("Initial entries in table \"Projectdb\": <br/>");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT Username FROM eGrocer WHERE" + usernameInput + " = Username AND " +  passwordInput + " = Password");
    if(rs.next())
      output.println("Logged in as " + usernameInput);
    rs.close();
    stmt.close();
    con.close();
  } catch(SQLException e) {
    output.println("SQLException caught: " + e.getMessage());
  }
%>

</body>
</html>
