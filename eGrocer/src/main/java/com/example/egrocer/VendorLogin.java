package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import static java.lang.System.out;

@WebServlet(name = "vendorLogin", value = "/vendorLogin")
public class VendorLogin extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/VendorLogin.jsp").forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String password=request.getParameter("vPassword");
        String email=request.getParameter("vEmail");
        String phone = request.getParameter("vPhone");
        String result="";

        RegisterDao rdao=new RegisterDao();

        result=rdao.verifyUser(email, phone, password);
        //response.getWriter().println(result);


        if(result.contains("User Validated Successfully") ){

            int vendor_id = rdao.getUserID(email, phone,password);
            String vendor = rdao.getVendorName(vendor_id);
            if (vendor.equals("")) {
                response.setContentType("text/html");

                // Hello
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("<h3>" + "You are not a vendor. Please log in <a href=\"customerLogin\">here</a>" + "</h3>");
                out.println("</body></html>");


            }else{
                HttpSession session = request.getSession();

                session.setAttribute("vendor", vendor);
                session.setAttribute("vendor_id", vendor_id);
                session.setAttribute("password", password);

                email = rdao.getEmail(vendor_id);
                session.setAttribute("email", email);


                phone = rdao.getPhone(vendor_id);
                session.setAttribute("phone", phone);

                String address = rdao.getAddress(vendor_id);
                session.setAttribute("address", address);


                request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);
            }


        }









    }
}
