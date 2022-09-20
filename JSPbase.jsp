<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Homework 1</title>
    </head>
  <body>
    <h1>Homework 1</h1>
    
    <table border="1">
      <tr>
        <td>ID</td>
        <td>Name</td>
        <td>Age</td>
   </tr>
    <% 
     String db = "Projectdb";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "root";
        try {
            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Projectdb",user, password);
            //out.println(db + " database successfully opened.<br/><br/>");
            out.println("This page will be updated as the project is worked on")
            
            //out.println("Initial entries in table \"Projectdb\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Projectdb");
            while (rs.next()) {
                out.println("<tr><td>"+ rs.getInt(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td></tr>");
            }
            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
