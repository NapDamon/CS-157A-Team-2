package com.example.egrocer;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "checkoutPage", value = "/checkoutPage")
public class CheckOut extends HttpServlet{

    private String message;

    public void init() {
        message = "Check Out Page";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
        request.getRequestDispatcher("/WEB-INF/CheckoutPage.jsp").forward(request,response);

    }
   
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/CheckoutPage.jsp").forward(request,response);
    }
}
