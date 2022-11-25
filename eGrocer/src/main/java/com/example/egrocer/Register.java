package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "Registration", value = "/Registration")
public class Register extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.getRequestDispatcher("/WEB-INF/Registration.jsp").forward(request,response);
        //response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username =request.getParameter("Name");
        String password =request.getParameter("Password");
        String email =request.getParameter("Email");
        String phone =request.getParameter("Phone");
        String address =request.getParameter("Address");
        String isVender = request.getParameter("isVendor");
        String result="";
        int cart_id =0;
        String jsp ="";

        RegisterDao rdao=new RegisterDao();
        result =rdao.insertUser(password,address,phone,email);
        response.getWriter().println(result);

        int user_id = rdao.getUserID(email,phone,password);

        response.getWriter().println(user_id);
        if(user_id != 0){
            if(isVender != null){
                result = rdao.insertVendor(username, user_id);
                jsp = "/WEB-INF/VendorHome.jsp";
            }else{
                result = rdao.insertCustomer(username, user_id);
                rdao.createCart(user_id);
                cart_id = rdao.getCartID(user_id);
                jsp = "/WEB-INF/CustomerHome.jsp";
            }

        }

        response.getWriter().println(result);
        HttpSession session = request.getSession();

        if(!result.contains("Not") ){

            if(cart_id != 0){
                session.setAttribute("cart_id", cart_id);
                session.setAttribute("customer", username);
                session.setAttribute("customer_id", user_id);
            }else{
                session.setAttribute("vendor", username);
                session.setAttribute("vendor_id", user_id);
            }

            session.setAttribute("password", password);
            session.setAttribute("email", email);
            session.setAttribute("address", address);
            session.setAttribute("phone", phone);
            request.getRequestDispatcher(jsp).forward(request,response);


        }



    }



}
