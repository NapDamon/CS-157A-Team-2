package com.example.egrocer;
import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "signupServlet", value = "/signup-page")
public class SignupServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Signup Page";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        /*
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if(first_name.isEmpty() || last_name.isEmpty() || username.isEmpty() ||
                password.isEmpty())
        {
            RequestDispatcher req = request.getRequestDispatcher("Signup.jsp");
            req.include(request, response);
        }
        else
        {
            RequestDispatcher req = request.getRequestDispatcher("register_2.jsp");
            req.forward(request, response);
        }*/

        request.getRequestDispatcher("/WEB-INF/Signup.jsp").forward(request,response);
    }

    public void destroy() {
    }
}
