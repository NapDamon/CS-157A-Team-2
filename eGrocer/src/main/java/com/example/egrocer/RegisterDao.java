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


    public String insertUser(String pw, String address, String phone, String email) {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "insert into user(password, address, phone, email) values(?,?,?,?)";
        String result="Data Entered Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, pw);
            ps.setString(2, address);
            ps.setNString(3, phone);
            ps.setString(4, email);
            ps.executeUpdate();

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            result="Data Not Entered Successfully";
            e.printStackTrace();
        }
        return result;

    }

    /**
     *
     * @param address
     * @param phone
     * @return user id. Returns 0 if insert failed
     */
    public int getUserID(String address, String phone){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM user" ;
        int result=0;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            while (rs.next()){

                if(address.equals(rs.getString("address")) && phone.equals(rs.getString("phone"))){
                    result = rs.getInt("user_id");
                }
            }


        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return result;
    }
    public String insertVendor(String vendor_name, int user_id) {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "insert into vendors(vendor_id, vendor_name) values(?,?) ";
        String result="Data Entered Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.setString(2, vendor_name);
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
        String sql = "SELECT * FROM user";
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
    public int getVendorID(String vendor){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM vendors" ;
        int result=0;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            while (rs.next()){
                if(vendor.equals(rs.getString("vendor_name"))){
                    result = rs.getInt("vendor_id");
                }
            }


        } catch (SQLException e) {
            // TODO Auto-generated catch block
            result = 0;
            e.printStackTrace();
        }
        return result;
    }
}
