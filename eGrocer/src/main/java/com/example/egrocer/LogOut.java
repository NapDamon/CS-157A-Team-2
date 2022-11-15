package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "logout", value = "/logout")
public class LogOut extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        if(session.getAttribute("vendor") != null && !session.getAttribute("vendor").equals("")){
            session.removeAttribute("vendor");
            session.removeAttribute("password");
            session.removeAttribute("email");
            session.removeAttribute("vendor_id");
            session.removeAttribute("address");
            session.removeAttribute("phone");
            request.getRequestDispatcher("/WEB-INF/VendorLogin.jsp").forward(request,response);
        }
        if(session.getAttribute("customer") != null && !session.getAttribute("customer").equals("")){
            session.removeAttribute("vendor");
            session.removeAttribute("password");
            session.removeAttribute("email");
            request.getRequestDispatcher("/WEB-INF/Login.jsp").forward(request,response);
        }



    }


}
