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
     *
     * @return user id. Returns 0 if invalid credentials
     */
    public int getUserID(String email, String phone ,String pw){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM user WHERE email = ? OR phone = ? AND password = ?"  ;
        int result=0;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, phone);
            ps.setString(3, pw);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            if (rs.next()){
                result = rs.getInt("user_id");
            }


        } catch (SQLException e) {
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
    public String insertCustomer(String customer_name, int user_id) {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "insert into customers(customer_id, customer_name) values(?,?) ";
        String result="Data Entered Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.setString(2, customer_name);
            ps.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            result="Data Not Entered Successfully";
            e.printStackTrace();
        }
        return result;

    }
    public String createCart(int customer_id){
        int cartNum = 0;
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "insert into own(customer_id) values(?) ";
        String result="Cart Successfully Created";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, customer_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            result = "Cart Not Successfully Created";
            e.printStackTrace();
        }
        sql = "SELECT cart_id FROM own ORDER BY cart_id DESC LIMIT 1 ";
        try{
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            while(rs.next())
                cartNum = rs.getInt("cart_id");
        } catch (SQLException e) {
            result="Cart Not Successfully Created";
            e.printStackTrace();
        }
        sql = "insert into carts(carts_id) values(?) ";
        if(cartNum != 0)
        {
            try {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, cartNum);
                ps.executeUpdate();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                result = "Cart Not Successfully Created";
                e.printStackTrace();
            }
        }
        return result;
    }
    public String verifyUser(String email, String phone,String password) {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM user WHERE email = ? OR phone = ? AND password = ?";
        String result="Bad Credentials";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, phone);
            ps.setString(3, password);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
           if(rs.next()){
                return "User Validated Successfully";

            }


        } catch (SQLException e) {

            result="User Not Validated Successfully";
            e.printStackTrace();
        }
        return result;

    }

    public String getVendorName(int vendor_id){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM vendors WHERE vendor_id = ?" ;
        String result="";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, vendor_id);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            while (rs.next()){
                result = rs.getString("vendor_name");

            }


        } catch (SQLException e) {
            result = "Failed to retrieve vendor name";
            e.printStackTrace();
        }
        return result;
    }
    public String getCustomerName(int customer_id){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM customers WHERE customer_id = ?" ;
        String result="";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, customer_id);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            if (rs.next()){
                result = rs.getString("customer_name");
            }


        } catch (SQLException e) {

            result = "Failed to retrieve customer name";
            e.printStackTrace();
        }
        return result;
    }
    public String getPhone(int user_id){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM user WHERE user_id = ?" ;
        String result="";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            if (rs.next()){
                result = rs.getString("phone");
            }


        } catch (SQLException e) {
            result = "Failed to retrieve phone number";
            e.printStackTrace();
        }
        return result;
    }
    public String getAddress(int user_id){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM user WHERE user_id = ?" ;
        String result="";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            if (rs.next()){
                result = rs.getString("address");

            }

        } catch (SQLException e) {
            result = "Failed to retrieve address";
            e.printStackTrace();
        }
        return result;
    }
    public String getEmail(int user_id){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM user WHERE user_id = ?" ;
        String result="";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            if (rs.next()){
                result = rs.getString("email");

            }

        } catch (SQLException e) {
            result = "Failed to retrieve email";
            e.printStackTrace();
        }
        return result;
    }
    public int getCartID(int customer_id){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM own WHERE customer_id = ?" ;
        int result=0;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, customer_id);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            if (rs.next()){
                result = rs.getInt("cart_id");
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    public String getPassword(int user_id){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM user WHERE user_id=?" ;
        String result= "";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,user_id);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();

            while(rs.next()){
                result = rs.getString("password");
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    boolean hasFavorite(int customer_id)
    {
        int count = 0;
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        Statement stmt;
        ResultSet rs = null;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT COUNT(customer_id) AS count FROM egrocer.favorite WHERE customer_id = "
                    + customer_id);
            while(rs.next())
                count = rs.getInt("count");
        }catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return count == 1;
    }

    public int getFavorite(int customer_id)
    {
        int vendor_id = -1;
        if(hasFavorite(customer_id))
        {
            String dbdriver = "com.mysql.jdbc.Driver";
            loadDriver(dbdriver);
            Connection con = getConnection();
            Statement stmt;
            ResultSet rs = null;
            try{
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT vendor_id FROM egrocer.favorite WHERE customer_id = "
                        + customer_id);
                while(rs.next())
                    vendor_id = rs.getInt("vendor_id");
            }catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return vendor_id;
    }

    public String changePassword(String newPW, int user_id) throws SQLException {
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        con.setAutoCommit(false);
        String sql = "UPDATE user SET password = ? WHERE user_id=?";

        String result="Data Updated Successfully";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newPW);
            ps.setInt(2, user_id);
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
            result = 0;
            e.printStackTrace();
        }
        return result;
    }
    public int getCustomerID(String customer){
        String dbdriver = "com.mysql.jdbc.Driver";
        loadDriver(dbdriver);
        Connection con = getConnection();
        String sql = "SELECT * FROM customers WHERE customer_name = ?" ;
        int result=0;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, customer);
            ps.executeQuery();
            ResultSet rs = ps.getResultSet();
            while (rs.next()){
                if(customer.equals(rs.getString("customer_name"))){
                    result = rs.getInt("customer_id");
                }
            }

        } catch (SQLException e) {
            result = 0;
            e.printStackTrace();
        }
        return result;
    }
}
