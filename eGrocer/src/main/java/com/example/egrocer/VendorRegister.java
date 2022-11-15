package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static java.lang.System.out;

@WebServlet(name = "vendorRegistration", value = "/vendorRegistration")
public class VendorRegister extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.getRequestDispatcher("/WEB-INF/VendorRegistration.jsp").forward(request,response);
        //response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vendor =request.getParameter("vName");
        String password =request.getParameter("vPassword");
        String email =request.getParameter("vEmail");
        String phone =request.getParameter("vPhone");
        String address =request.getParameter("vAddress");
        String result="";

        RegisterDao rdao=new RegisterDao();
        result =rdao.insertUser(password,address,phone,email);
        response.getWriter().println(result);

        int vendor_id = rdao.getUserID(email,phone,password);
        response.getWriter().println(vendor_id);
        if(vendor_id != 0){
            result = rdao.insertVendor(vendor, vendor_id);
        }

        response.getWriter().println(result);

        if(!result.contains("Not") ){
//            int vendor_id = rdao.getVendorID(vendor);
            HttpSession session = request.getSession();
            session.setAttribute("vendor_id", vendor_id);
            session.setAttribute("vendor", vendor);
            session.setAttribute("password", password);
            session.setAttribute("email", email);
            session.setAttribute("address", address);
            session.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);


        }



    }



}
