package com.example.egrocer;

import java.sql.*;

public class ProductsDao {
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
    public String getVendorProducts(String vendor){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM products WHERE vendor_id IN (SELECT vendor_id FROM vendors WHERE vendor_name =" +vendor +" )";
        String result="Data Entered Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()){

            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            result="Data Not Entered Successfully";
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

    public String addProducts(int vendor_id, String pname, float price, int quantity){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "insert into products(product_name, quantity, price, vendor_id) VALUES (?,?,?,?)";
        String result="Data Entered Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, pname);
            ps.setInt(2, quantity);
            ps.setFloat(3, price);
            ps.setInt(4, vendor_id);
            ps.executeUpdate();

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            result="Data Not Entered Successfully";
            e.printStackTrace();
        }
        return result;
    }

    public String getProductName(int product_id)
    {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT product_name FROM egrocer.products WHERE product_id = " + product_id;
        String result = "";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            while (rs.next())
                result = rs.getString("product_name");
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            result = "No product name found";
            e.printStackTrace();
        }
        return result;
    }

    public int getProductID(int vendor_id, String pname){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM products" ;
        int result=0;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            while (rs.next()){
                if(pname.equals(rs.getString("product_name"))
                        && vendor_id == rs.getInt("vendor_id")){
                    result = rs.getInt("product_id");
                }
            }


        } catch (SQLException e) {
            // TODO Auto-generated catch block
            result = 0;
            e.printStackTrace();
        }
        return result;
    }
    public String editProducts(int product_id, String pname, float price, int quantity){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "update products set product_name = " + pname + ", price = " + price + ", quantity = " + quantity
                + " where product_id = " + product_id;
        String result="Data Entered Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeUpdate();

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            result="Data Not Entered Successfully";
            e.printStackTrace();
        }
        return result;
    }
    public String editProductName(int product_id, int vendor_id, String pname) throws SQLException {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        con.setAutoCommit(false);
        String sql = "UPDATE products SET product_name = ? WHERE vendor_id= ? AND products.product_id= ?";

        String result="Data Updated Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, pname);
            ps.setInt(2, vendor_id);
            ps.setInt(3,product_id);
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
    public String editProductPrice(int product_id, int vendor_id, float price) throws SQLException {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        con.setAutoCommit(false);
        String sql = "UPDATE products SET price = ? WHERE vendor_id= ? AND product_id =?";

        String result="Data Updated Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setFloat(1, price);
            ps.setInt(2, vendor_id);
            ps.setInt(3, product_id);
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
    public String editProductQuantity(int product_id, int vendor_id, int quantity) throws SQLException {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        con.setAutoCommit(false);
        String sql = "UPDATE products SET quantity = ? WHERE vendor_id= ? AND products.product_id=?";

        String result="Data Updated Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, vendor_id);
            ps.setInt(3, product_id);
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

    public String deleteProduct(int product_id, int vendor_id) throws SQLException {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();

        String sql = "DELETE FROM products WHERE product_id = ? AND vendor_id = ?";

        String result="";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, product_id);
            ps.setInt(2, vendor_id);

            int i = ps.executeUpdate();
            if(i!=0)
            {
                result = "Deleting rows";
            }
            if(i==0){
                ps.close();
                con.close();
                result = "Data Deleted Successfully";
            }



        } catch (SQLException e) {


            result="Data Not Deleted Successfully";
            e.printStackTrace();
        }
        return result;
    }
}
