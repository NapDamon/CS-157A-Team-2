package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "updateOrder", value = "/updateOrder")
public class UpdateOrder extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/VendorOrders.jsp").forward(request,response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newStatus =request.getParameter("newStatus");
        String newDate =request.getParameter("newDate");
        String update = request.getParameter("update");
        int order_num = Integer.parseInt(request.getParameter("order_num"));


        HttpSession session = request.getSession();
       // String vendor = (String) session.getAttribute("vendor");
        int vendor_id = (int) session.getAttribute("vendor_id");

        OrderDao odao=new OrderDao();
       // int order_num = odao.getOrderNum(vendor_id, shipment_id);
        String result = null;
        if("Update".equals(update)){
            if(newStatus != null){
                try {
                    result = odao.updateStatus(vendor_id,order_num, newStatus);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if(newDate != null){
                try {
                    result = odao.updateOrderDate(vendor_id,order_num, newDate);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }

        }

        request.getRequestDispatcher("/WEB-INF/VendorOrders.jsp").forward(request,response);

        response.getWriter().println(result);





    }
}
