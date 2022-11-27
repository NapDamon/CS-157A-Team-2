package com.example.egrocer;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

//@WebServlet(name = "orderSummary", value = "/orderSummary")
//public class OrderSummary extends HttpServlet{
//
//    private String message;
//
//    public void init() {
//        message = "Order Summary";
//    }
//
//    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//
//        request.getRequestDispatcher("/WEB-INF/OrderSummary.jsp").forward(request,response);
//
//    }
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String item = request.getParameter("item");
//        String subtotal = request.getParameter("subtotal");
//        String shipping = request.getParameter("shipping");
//        String tax = request.getParameter("tax");
//        String total = request.getParameter("total");
//
//        OrderDetail orderDetail = new OrderDetail(item, subtotal, shipping, tax, total);
//
//        try {
//            PaymentServices paymentServices = new PaymentServices();
//            String approvalLink = paymentServices.authorizePayment(orderDetail);
//
//            response.sendRedirect(approvalLink);
//
//        } catch (PayPalRESTException ex) {
//            ex.printStackTrace();
//            request.getRequestDispatcher("/WEB-INF/OrderSummary.jsp").forward(request,response);
//        }
//
//    }
//}
