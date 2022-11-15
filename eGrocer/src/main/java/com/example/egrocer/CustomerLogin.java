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

@WebServlet(name = "customerLogin", value = "/customerLogin")
public class CustomerLogin extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/CustomerLogin.jsp").forward(request,response);
        
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String password=request.getParameter("cPassword");
        String email=request.getParameter("cEmail");
        String phone = request.getParameter("cPhone");
        String result="";

        RegisterDao rdao=new RegisterDao();

        result=rdao.verifyUser(email, phone, password);
        response.getWriter().println(result);


        if(result.contains("User Validated Successfully") ){

            int customer_id = rdao.getUserID(email, phone,password);
            int cart_id = rdao.getCartID(customer_id);

            HttpSession session = request.getSession();
            session.setAttribute("cart_id", cart_id);
            session.setAttribute("customer_id", customer_id);
            session.setAttribute("password", password);

            email = rdao.getEmail(customer_id);
            session.setAttribute("email", email);

            String customer = rdao.getCustomerName(customer_id);
            session.setAttribute("customer", customer);

            phone = rdao.getPhone(customer_id);
            session.setAttribute("phone", phone);

            String address = rdao.getAddress(customer_id);
            session.setAttribute("address", address);


            request.getRequestDispatcher("/WEB-INF/CustomerHome.jsp").forward(request,response);


        }









    }
}
