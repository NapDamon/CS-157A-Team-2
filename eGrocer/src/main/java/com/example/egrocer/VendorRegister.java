package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static java.lang.System.out;

@WebServlet(name = "vendorReg", value = "/vendorReg")
public class VendorRegister extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.getRequestDispatcher("/WEB-INF/VendorRegistration.jsp").forward(request,response);
        //response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vendor=request.getParameter("vName");
        String password=request.getParameter("vPassword");
        String email=request.getParameter("vEmail");
        String phone=request.getParameter("vPhone");
        String address=request.getParameter("vAddress");
        User user=new User(vendor, password, email, phone, address);
        RegisterDao rdao=new RegisterDao();
        String result=rdao.insertUser(user);
        response.getWriter().println(result);
        result = rdao.insertVendor(user);
        response.getWriter().println(result);

        if(!result.contains("Not") ){
            HttpSession session = request.getSession();
            session.setAttribute("vendor", vendor);
            session.setAttribute("password", password);
            session.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);


        }



    }



}
