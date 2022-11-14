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
        // TODO Auto-generated method stub
        request.getRequestDispatcher("/WEB-INF/VendorLogin.jsp").forward(request,response);
        //response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String password=request.getParameter("vPassword");
        String email=request.getParameter("vEmail");



        RegisterDao rdao=new RegisterDao();
        String result=rdao.verifyUser(email, password);
        response.getWriter().println(result);

        if(result.contains("User Validated Successfully") ){

            int vendor_id = rdao.getUserID(email, password);

            HttpSession session = request.getSession();
            session.setAttribute("vendor_id", vendor_id);
            session.setAttribute("password", password);
            session.setAttribute("email", email);

            String vendor = rdao.getVendor(vendor_id);
            session.setAttribute("vendor", vendor);

            String phone = rdao.getPhone(vendor_id);
            session.setAttribute("phone", phone);

            String address = rdao.getAddress(vendor_id);
            session.setAttribute("address", address);


            request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);


        }





    }
}
