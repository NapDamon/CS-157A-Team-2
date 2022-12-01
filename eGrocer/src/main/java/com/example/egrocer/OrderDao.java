package com.example.egrocer;

import java.sql.*;

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

    public void deleteOrder(int order_num,int customer_id,int cart_id)
    {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "DELETE FROM orders WHERE order_num = ? AND customer_id = ?";
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,order_num);
            ps.setInt(2,customer_id);
            ps.executeUpdate();
        }catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        sql = "DELETE FROM contents_of WHERE order_num = ? AND cart_id = ?";
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,order_num);
            ps.setInt(2,cart_id);
            ps.executeUpdate();
        }catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void addOrder(int order_num,String date,int customer_id,int payment_id)
    {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "INSERT INTO orders(order_num,order_date,customer_id,payment_id) VALUES(?,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, order_num);
            ps.setString(2, date);
            ps.setInt(3, customer_id);
            ps.setInt(4, payment_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void clearCart(int cart_id)
    {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "DELETE FROM contains WHERE cart_id = ?";
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,cart_id);
            ps.executeUpdate();
        }catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        updateCartNum(cart_id,0);
    }

    public int getCartNum(int cart_id)
    {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        Statement stmt;
        ResultSet rs = null;
        int num = -1;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT num_of_products FROM egrocer.carts WHERE carts_id = "
                    + cart_id);
            while(rs.next())
                num = rs.getInt("num_of_products");
        }catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return num;
    }

    public void updateCartNum(int cart_id,int num)
    {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "UPDATE carts SET num_of_products = ? WHERE carts_id = " + cart_id;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, num);
            ps.executeUpdate();
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    void addOrderContents(int cart_id,int order_num,int product_id,int quantity)
    {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        ProductsDao pDao = new ProductsDao();
        int vendor_id = pDao.getVendorID(product_id);
        String sql = "insert into contents_of(cart_id, order_num, product_id, vendor_id, quantity) VALUES (?,?,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, cart_id);
            ps.setInt(2, order_num);
            ps.setInt(3, product_id);
            ps.setInt(4, vendor_id);
            ps.setInt(5, quantity);
            ps.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void createOrderDetails(int cart_id,int order_num)
    {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        Statement stmt;
        ResultSet rs = null;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT product_id,quantity FROM egrocer.contains WHERE cart_id = "
                    + cart_id);
            while(rs.next())
                addOrderContents(cart_id,order_num,rs.getInt("product_id"),rs.getInt("quantity"));
        }catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        clearCart(cart_id);
    }

    public boolean checkInCart(int product_id,int cart_id)
    {
        int count = 0;
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        Statement stmt;
        ResultSet rs = null;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT COUNT(product_id) AS count FROM egrocer.contains WHERE cart_id = "
                    + cart_id + " AND product_id = "+ product_id );
            while(rs.next())
                count = rs.getInt("count");
        }catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return count == 1;
    }

    public int numOfProdInCart(int cart_id)
    {
        int sum = 0;
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        Statement stmt;
        ResultSet rs = null;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT SUM(quantity) AS sum FROM egrocer.contains WHERE cart_id = " + cart_id);
            while(rs.next())
                sum = rs.getInt("sum");
        }catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return sum;
    }
}
