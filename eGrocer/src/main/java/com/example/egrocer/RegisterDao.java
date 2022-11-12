package com.example.egrocer;


import java.sql.*;

public class RegisterDao {

    public void loadDriver(String dbDriver)
    {
        try {
            Class.forName(dbDriver);
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    public Connection getConnection() {
        Connection con = null;
        try {
            String dburl = "jdbc:mysql://localhost:3306/egrocer";
            String dbuname = "root";
            String dbpassword = "root";
            con = DriverManager.getConnection(dburl, dbuname, dbpassword);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return con;
    }

    public String insertUser(User user) {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "insert into user(password, address, phone, email) values(?,?,?,?)";
        String result="Data Entered Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getPassword());
            ps.setString(2, user.getAddress());
            ps.setNString(3, user.getPhone());
            ps.setString(4, user.getEmail());
            ps.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            result="Data Not Entered Successfully";
            e.printStackTrace();
        }
        return result;

    }
    public String insertVendor(User user) {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "insert into vendors(vendor_name) values(?)";
        String result="Data Entered Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getUname());
            ps.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            result="Data Not Entered Successfully";
            e.printStackTrace();
        }
        return result;

    }
    public String verifyUser(String email, String password) {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "select * from user";
        String result="Bad Credentials";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            while(rs.next()){
                if(rs.getString("email") != null){
                    if(rs.getString("email").equals(email) && rs.getString("password").equals(password)){
                        return "User Validated Successfully";
                    }
                }

            }


        } catch (SQLException e) {

            result="User Not Validated Successfully";
            e.printStackTrace();
        }
        return result;

    }
}
