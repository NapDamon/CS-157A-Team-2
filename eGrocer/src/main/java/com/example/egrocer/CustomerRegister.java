package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static java.lang.System.out;

@WebServlet(name = "customerRegistration", value = "/customerRegistration")
public class CustomerRegister extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.getRequestDispatcher("/WEB-INF/CustomerRegistration.jsp").forward(request,response);
        //response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customer =request.getParameter("cName");
        String password =request.getParameter("cPassword");
        String email =request.getParameter("cEmail");
        String phone =request.getParameter("cPhone");
        String address =request.getParameter("cAddress");
        String result="";

        RegisterDao rdao=new RegisterDao();
        result =rdao.insertUser(password,address,phone,email);
        response.getWriter().println(result);

        int customer_id = rdao.getUserID(email,phone,password);
        response.getWriter().println(customer_id);
        if(customer_id != 0){
            result = rdao.insertCustomer(customer, customer_id);
        }

        response.getWriter().println(result);

        if(!result.contains("Not") ){
            rdao.createCart(customer_id);
            int cart_id = rdao.getCartID(customer_id);

            HttpSession session = request.getSession();
            session.setAttribute("cart_id", cart_id);
            session.setAttribute("customer_id", customer_id);
            session.setAttribute("customer", customer);
            session.setAttribute("password", password);
            session.setAttribute("email", email);
            session.setAttribute("address", address);
            session.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/CustomerHome.jsp").forward(request,response);


        }



    }



}
