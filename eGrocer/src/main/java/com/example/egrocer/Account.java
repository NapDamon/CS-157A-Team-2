package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "account", value = "/account")
public class Account extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        request.getRequestDispatcher("/WEB-INF/Account.jsp").forward(request,response);

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String currentPW = request.getParameter("currentPW");
        String newPW = request.getParameter("newPW");
        RegisterDao rdao = new RegisterDao();


        HttpSession session = request.getSession();
        Object vendor_id =  session.getAttribute("vendor_id");
        Object customer_id = session.getAttribute("customer_id");
        int user_id=0;

        if(vendor_id == null){
            user_id = (int) customer_id;

        } else {
            user_id = (int) vendor_id;
        }

        String correctPW = rdao.getPassword(user_id);

        if(!correctPW.equals(currentPW)){
            request.setAttribute("correctPW", "false");

            request.getRequestDispatcher("/WEB-INF/Account.jsp").forward(request,response);
        }else{
            try {
                rdao.changePassword(newPW, user_id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("changed", "true");

            request.getRequestDispatcher("/WEB-INF/Account.jsp").forward(request,response);
        }


//        if(correctPW.equals("Incorrect")){
//            request.setAttribute("correctPW", "false");
//
//            request.getRequestDispatcher("/WEB-INF/Account.jsp").forward(request,response);
//        }else {
//            if(vendor_id == null){
//                user_id = (int) customer_id;
//
//            } else {
//                user_id = (int) vendor_id;
//            }
//            try {
//                rdao.changePassword(newPW, user_id);
//            } catch (SQLException e) {
//                throw new RuntimeException(e);
//            }
//            request.setAttribute("Changed", "true");
//        }
//
//
//    }
    }
}
