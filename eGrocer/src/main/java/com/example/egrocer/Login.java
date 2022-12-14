package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "Login", value = "/Login")
public class Login extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Login.jsp").forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String password=request.getParameter("Password");
        String email=request.getParameter("Email");
        String phone = request.getParameter("Phone");
        String isVendor = request.getParameter("isVendor");
        String result="";
        String username= "";
        String jsp="";

        RegisterDao rdao=new RegisterDao();

        result=rdao.verifyUser(email, phone, password);
        //response.getWriter().println(result);


        if(result.contains("User Validated Successfully") ){
            HttpSession session = request.getSession();
            int user_id = rdao.getUserID(email, phone,password);
            String vendorName = rdao.getVendorName(user_id);
            String customerName = rdao.getCustomerName(user_id);
            if(email.equals("")){
                email = rdao.getEmail(user_id);
            }
            if(phone.equals("")){
                phone = rdao.getPhone(user_id);
            }

            String address = rdao.getAddress(user_id);

            if(isVendor != null && !vendorName.equals("")){
                //username = rdao.getVendorName(user_id);
                session.setAttribute("vendor", vendorName);
                session.setAttribute("vendor_id", user_id);
                session.setAttribute("password", password);
                session.setAttribute("email", email);
                session.setAttribute("phone", phone);
                session.setAttribute("address", address);
                jsp = "/WEB-INF/VendorHome.jsp";
                response.sendRedirect("vendorHome");
              //  request.getRequestDispatcher(jsp).forward(request,response);
            }else if(isVendor == null && !customerName.equals("")){

                //username = rdao.getCustomerName(user_id);
                int cart_id = rdao.getCartID(user_id);
                session.setAttribute("customer", customerName);
                session.setAttribute("customer_id", user_id);
                session.setAttribute("cart_id", cart_id);
                session.setAttribute("password", password);
                session.setAttribute("email", email);
                session.setAttribute("phone", phone);
                session.setAttribute("address", address);
                jsp = "/WEB-INF/CustomerHome.jsp";
                response.sendRedirect("customerHome");
              //  request.getRequestDispatcher(jsp).forward(request,response);
            }else if(isVendor != null){
                request.setAttribute("vendor", "false");
                request.getRequestDispatcher("/WEB-INF/Login.jsp").forward(request,response);
//                response.setContentType("text/html");
//                PrintWriter out = response.getWriter();
//                out.println("<html><body>");
//                out.println("<h3>" + "You are not a vendor." + "</h3>");
//                out.println("</body></html>");
            }else {
                request.setAttribute("customer", "false");
                request.getRequestDispatcher("/WEB-INF/Login.jsp").forward(request,response);
//                response.setContentType("text/html");
//                PrintWriter out = response.getWriter();
//                out.println("<html><body>");
//                out.println("<h3>" + "You are not a customer." + "</h3>");
//                out.println("</body></html>");

            }



        }else if(result.equals("Bad Credentials")){
            request.setAttribute("invalidCreds", "true");
            request.getRequestDispatcher("/WEB-INF/Login.jsp").forward(request,response);
        }









    }
}
