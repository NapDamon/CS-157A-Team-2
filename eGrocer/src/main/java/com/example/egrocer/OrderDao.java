package com.example.egrocer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OrderDao {
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
    public String updateStatus(int vendor_id, int order_num, String status) throws SQLException {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        con.setAutoCommit(false);
        String sql = "UPDATE ships SET status = ? WHERE order_num= ? AND vendor_id =?";

        String result="Data Updated Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, order_num);
            ps.setInt(3, vendor_id);

            ps.executeUpdate();
            con.commit();
            ps.close();
            con.close();

        } catch (SQLException e) {


            result="Data Not Updated Successfully";
            e.printStackTrace();
        }
        return result;
    }
    public String updateOrderDate(int vendor_id, int order_num, String status) throws SQLException {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        con.setAutoCommit(false);
        String sql = "UPDATE ships SET shipping_date = ? WHERE order_num= ? AND vendor_id = ?";

        String result="Data Updated Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, order_num);
            ps.setInt(3, vendor_id);
            ps.executeUpdate();
            con.commit();
            ps.close();
            con.close();

        } catch (SQLException e) {


            result="Data Not Updated Successfully";
            e.printStackTrace();
        }
        return result;
    }
}
