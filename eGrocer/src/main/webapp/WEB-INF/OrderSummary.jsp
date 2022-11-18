<%--
  Created by IntelliJ IDEA.
  User: neenee
  Date: 11/17/2022
  Time: 4:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.lang.*" %>
<html>
<head>
  <title>eGrocer</title>
  <style><%@include file="/WEB-INF/CSS/style.css"%></style>

</head>
<body>

<h2>Order Summary</h2>

<div class="row">
  <div class="col-75">
    <div class="container">
        <div class="row">
          <div class="col-50">
            <h3>Billing Address</h3>
            <label for="fname"><i class="fa fa-user"></i> Full Name</label>
            <input type="text" id="fname" name="firstname" placeholder="John M. Doe">
            <label for="email"><i class="fa fa-envelope"></i> Email</label>
            <input type="text" id="email" name="email" placeholder="john@example.com">
            <label for="adr"><i class="fa fa-address-card-o"></i> Address</label>
            <input type="text" id="adr" name="address" placeholder="542 W. 15th Street">
            <label for="city"><i class="fa fa-institution"></i> City</label>
            <input type="text" id="city" name="city" placeholder="New York">

            <div class="row">
              <div class="col-50">
                <label for="state">State</label>
                <input type="text" id="state" name="state" placeholder="NY">
              </div>
              <div class="col-50">
                <label for="zip">Zip</label>
                <input type="text" id="zip" name="zip" placeholder="10001">
              </div>
            </div>
          </div>

          <div class="col-50">
            <h3>Payment</h3>
            <label for="fname">Accepted Cards</label>
            <div class="icon-container">
              <i class="fa fa-cc-visa" style="color:navy;"></i>
              <i class="fa fa-cc-amex" style="color:blue;"></i>
              <i class="fa fa-cc-mastercard" style="color:red;"></i>
              <i class="fa fa-cc-discover" style="color:orange;"></i>
            </div>
            <label for="cname">Name on Card</label>
            <input type="text" id="cname" name="cardname" placeholder="John More Doe">
            <label for="ccnum">Credit card number</label>
            <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444">
            <label for="expmonth">Exp Month</label>
            <input type="text" id="expmonth" name="expmonth" placeholder="September">
            <div class="row">
              <div class="col-50">
                <label for="expyear">Exp Year</label>
                <input type="text" id="expyear" name="expyear" placeholder="2018">
              </div>
              <div class="col-50">
                <label for="cvv">CVV</label>
                <input type="text" id="cvv" name="cvv" placeholder="352">
              </div>
            </div>
          </div>
          
        </div>
        <label>
          <input type="checkbox" checked="checked" name="sameadr"> Shipping address same as billing
        </label>
        <input type="submit" value="Continue to checkout" class="btn">
    </div>
  </div>
  <div class="col-25">
    <div class="container">
      <h4>Cart <span class="price" style="color:black"><i class="fa fa-shopping-cart"></i> <b>4</b></span></h4>
      <p><a href="#">Product 1</a> <span class="price">$15</span></p>
      <p><a href="#">Product 2</a> <span class="price">$5</span></p>
      <p><a href="#">Product 3</a> <span class="price">$8</span></p>
      <p><a href="#">Product 4</a> <span class="price">$2</span></p>
      <hr>
      <p>Total <span class="price" style="color:black"><b>$30</b></span></p>
    </div>
  </div>
</div>

<%

  response.setContentType("text/html");
  PrintWriter output = response.getWriter();
  String db = "egrocer";
  int update, vendor_id = 0, product_id = 0, amount = 0;
  String user, productName = null;
  user = "root";
  ResultSet rs = null;
  int i =0;
  Statement stmt = null;
  Connection con = null;
  String name, password, email, phone, address;
  int cart_id, customer_id;

  try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/" + db, user, "root");
  } catch (SQLException e) {
    output.println("SQLException caught: " + e.getMessage());
  }

  if(session.getAttribute("customer")!= null) {
    name = session.getAttribute("customer").toString();
    password = session.getAttribute("password").toString();
    customer_id = (int) session.getAttribute("customer_id");
    email = session.getAttribute("email").toString();
    phone = session.getAttribute("phone").toString();
    address = session.getAttribute("address").toString();
    cart_id = (int) session.getAttribute("cart_id");

    try{
      stmt = con.createStatement();

      rs = stmt.executeQuery("SELECT * FROM contains WHERE cart_id = " + cart_id);
      
       while(rs.next()){
                out.println(
                    "<form class=\"orderCard\" action=\"vendorOrders\"style=\"flex-direction: column\">"
                    + "<label>Full Name         : " + rs.getString("name") + "</label>"
                    + "<label>Email             : " + rs.getString("email") + "</label>"
                    + "<label>Address           : " + rs.getString("address") + "</label>"
                    + "<label>City              : " + rs.getString("city") + "</label>"
                    + "<label>State             : " + rs.getString("state") + "</label>"
                    + "<label>Zip Code          : " + rs.getInt("zip_code") + "</label>"
                    + "<label>Name on Card      : " + rs.getString("name_card") + "</label>"
                    + "<label>Credit Card Number: " + rs.getString("card_num") + "</label>"
                    + "<label>Exp Month         : " + rs.getInt("exp_month") + "</label>"
                    + "<label>Exp Date          : " + rs.getInt("exp_date") + "</label>"
                    + "<label>CVV               : " + rs.getInt("cvv") + "</label>"
                    + "<input type=\"submit\" class=\"formBtn2\" name = \"contCheckout\" value=\"Continue to checkout\" >"
                    + "</form>"
                );
                
        }
        
        rs.close();
        stmt.close();
        con.close();
        
      } catch (SQLException e) {
        output.println("SQLException caught: " + e.getMessage());
      }

  }

%>

</body>
</html>
