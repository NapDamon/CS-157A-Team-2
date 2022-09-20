<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>3-Tier Base</title>
    </head>
  <body>
    <h1>3-Tier Base</h1>
    
    <table border="1">
      <tr>
        <td>ID</td>
        <td>Name</td>
        <td>Age</td>
   </tr>
    <% 
     String db = "Project";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "root";
        try {
            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project",user, password);
            //out.println(db + " database successfully opened.<br/><br/>");
            out.println("This page will be updated as the project is worked on.")
            
            //out.println("Initial entries in table \"emp\": <br/>");
            Statement stmt = con.createStatement();
            //ResultSet rs = stmt.executeQuery("SELECT * FROM ");
            //while (rs.next()) {
            //    out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getInt(3) + "<br/><br/>");
            //}
            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
