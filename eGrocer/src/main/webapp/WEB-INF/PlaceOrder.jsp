<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.lang.*" %>
<html>
<head>
  <title>eGrocer</title>

</head>
<body>
    <div align="center">
        <h1>Review Your Order</h1>
        <form action="execute_payment" method="post">
            <table>
                <tr>
                    <td colspan="2"><b>Order Details:</b></td>
                    <td>
                        <input type="hidden" name="paymentId" value="${param.paymentId}" />
                        <input type="hidden" name="PayerID" value="${param.PayerID}" />
                    </td>
                </tr>
                <tr>
                    <td>Items:</td>
                    <td>${order.items}</td>
                </tr>
                <tr>
                    <td>Subtotal:</td>
                    <td>${order.amount.details.subtotal} USD</td>
                </tr>
                <tr>
                    <td>Shipping:</td>
                    <td>${order.amount.details.shipping} USD</td>
                </tr>
                <tr>
                    <td>Tax:</td>
                    <td>${order.amount.details.tax} USD</td>
                </tr>
                <tr>
                    <td>Total:</td>
                    <td>${order.amount.total} USD</td>
                </tr>
                <tr>
                    <td><br /></td>
                </tr>
                <tr>
                    <td colspan="2"><b>Payment Information:</b></td>
                </tr>
                <tr>
                    <td>Full Name:</td>
                    <td>${payment.fullName}</td>
                </tr>
                <tr>
                    <td>Card Number:</td>
                    <td>${payment.cardNumber}</td>
                </tr>
                <tr>
                    <td>Expiration date:</td>
                    <td>${payment.expDate}</td>
                </tr>
                <tr>
                    <td>CVV:</td>
                    <td>${payment.cvv}</td>
                </tr>
                <tr>
                    <td><br /></td>
                </tr>
                <tr>
                    <td colspan="2"><b>Shipping Address:</b></td>
                </tr>
                <tr>
                    <td>Recipient Name:</td>
                    <td>${shippingAddress.recipientName}</td>
                </tr>
                <tr>
                    <td>Address:</td>
                    <td>${shippingAddress.line1}</td>
                </tr>
                <tr>
                    <td>City:</td>
                    <td>${shippingAddress.city}</td>
                </tr>
                <tr>
                    <td>State:</td>
                    <td>${shippingAddress.state}</td>
                </tr>
                <tr>
                    <td>Country:</td>
                    <td>${shippingAddress.country}</td>
                </tr>
                <tr>
                    <td>Zip Code:</td>
                    <td>${shippingAddress.zipCode}</td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="Place Order" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>

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
  int cart_id, customer_id, payment_id;

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
    payment_id = (int) session.getAttribute("payment_id");

    try{
      stmt = con.createStatement();
      
       while(rs.next()){
                out.println(
                    "<form>"
                    + "<label>Items             : " + rs.getString("item") + "</label>"
                    + "<label>Sub Total         : " + rs.getInt("subTotal") + "</label>"
                    + "<label>Shipping          : " + rs.getInt("shipping") + "</label>"
                    + "<label>Tax               : " + rs.getInt("tax") + "</label>"
                    + "<label>Total             : " + rs.getInt("total") + "</label>"
                    + "<label>Full Name         : " + rs.getString("name") + "</label>"
                    + "<label>Email             : " + rs.getString("email") + "</label>"
                    + "<label>Address           : " + rs.getString("address") + "</label>"
                    + "<label>City              : " + rs.getString("city") + "</label>"
                    + "<label>State             : " + rs.getString("state") + "</label>"
                    + "<label>Zip Code          : " + rs.getInt("zip_code") + "</label>"
                    + "<label>Name on Card      : " + rs.getString("name_card") + "</label>"
                    + "<label>Card Number       : " + rs.getString("card_num") + "</label>"
                    + "<label>Exp Date          : " + rs.getInt("exp_date") + "</label>"
                    + "<label>CVV               : " + rs.getInt("cvv") + "</label>"
                    + "<input type=\"submit\" name = \"placeOrder\" value=\"Place Order\" >"
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
