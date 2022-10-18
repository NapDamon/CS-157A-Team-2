package com.example.egrocer;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "LoginPage", value = "/login-page")
public class LoginServlet extends HttpServlet {
    private String message;

    public void init() {message = "Login Page";}

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        //displaying Login text inputs and login page header
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("<br/>");
        out.println("<form>");
        out.println("<label for=\"username\">Username:</label><br>");
        out.println("<input type=\"text\" id=\"username\" name=\"username\"><br>");
        out.println("<label for=\"password\">Password:</label><br>");
        out.println("<input type=\"text\" id=\"password\" name=\"password\"><br>");
        out.println("</body></html>");
    }
}