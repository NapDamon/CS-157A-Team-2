package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

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
        String vendor=request.getParameter("vName");


        RegisterDao rdao=new RegisterDao();
        String result=rdao.verifyUser(email, password);
        response.getWriter().println(result);

        if(!result.contains("Not") ){
            HttpSession session = request.getSession();
            session.setAttribute("vendor", vendor);
            session.setAttribute("password", password);
            session.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);

            if("Log out".equals(request.getParameter("logout"))){
                session.setAttribute("vendor", null);
                session.setAttribute("email", null);
                session.setAttribute("password", null);
                session.invalidate();
                out.println("<a href=\"vendorLogin\">Log in</a>");
            }

        }


    }
}
