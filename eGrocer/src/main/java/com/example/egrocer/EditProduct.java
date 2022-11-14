package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "editProduct", value = "/editProduct")
public class EditProduct extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPname=request.getParameter("newPname");
        String newPrice= request.getParameter("newPrice");
        String newQuantity = request.getParameter("newQuantity");
        int product_id = Integer.parseInt(request.getParameter("product_id"));
        String vendor;
        HttpSession session = request.getSession();
        vendor = (String) session.getAttribute("vendor");

        ProductsDao pdao=new ProductsDao();
        int vendor_id = pdao.getVendorID(vendor);
        String result = null;

        if(newPname != null){
            try {
                result = pdao.editProductName(product_id, vendor_id, newPname);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if(newPrice != null){
            float price = Float.parseFloat(newPrice);
            try {
                result = pdao.editProductPrice(product_id,vendor_id, price);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if(newQuantity != null){
            int quantity = Integer.parseInt(newQuantity);
            try {
                result = pdao.editProductQuantity(product_id,vendor_id, quantity);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

         request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);
        response.getWriter().println(result);





    }
}
