package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "editProduct", value = "/editProduct")
public class EditProduct extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPname=request.getParameter("newPname");
        String newPrice= request.getParameter("newPrice");
        String newQuantity = request.getParameter("newQuantity");
        String update = request.getParameter("update");
        int product_id = Integer.parseInt(request.getParameter("product_id"));

        HttpSession session = request.getSession();
        int vendor_id = (int) session.getAttribute("vendor_id");


        ProductsDao pdao=new ProductsDao();

        String result = null;
        if("Update".equals(update)){

            if(!Objects.equals(newPname, "")){
                try {
                    result = pdao.editProductName(product_id, vendor_id, newPname);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }

            if(!Objects.equals(newPrice, "")){
                float price = Float.parseFloat(newPrice);
                try {
                    result = pdao.editProductPrice(product_id,vendor_id, price);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }

            if(!Objects.equals(newQuantity, "")){
                int quantity = Integer.parseInt(newQuantity);
                try {
                    result = pdao.editProductQuantity(product_id,vendor_id, quantity);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }

            response.getWriter().println(result);
        }
        request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);




    }
}
