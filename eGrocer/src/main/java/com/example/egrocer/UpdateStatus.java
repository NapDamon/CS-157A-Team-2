package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import static java.lang.System.out;

@WebServlet(name = "updateStatus", value = "/updateStatus")
public class UpdateStatus extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/VendorOrders.jsp").forward(request,response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newStatus =request.getParameter("newStatus");
        int order_num = Integer.parseInt(request.getParameter("order_num"));


        HttpSession session = request.getSession();
       // String vendor = (String) session.getAttribute("vendor");
        int vendor_id = (int) session.getAttribute("vendor_id");

        OrderDao odao=new OrderDao();
       // int order_num = odao.getOrderNum(vendor_id, shipment_id);
        String result = null;
        try {
            result = odao.updateStatus(order_num, newStatus);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("/WEB-INF/VendorOrders.jsp").forward(request,response);
        response.getWriter().println(result);





    }
}
