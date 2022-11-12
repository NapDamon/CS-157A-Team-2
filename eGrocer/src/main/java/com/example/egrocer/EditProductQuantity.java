package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "editProductQuantity", value = "/editProductQuantity")
public class EditProductQuantity extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));
        String vendor;
        HttpSession session = request.getSession();
        vendor = (String) session.getAttribute("vendor");

        ProductsDao pdao=new ProductsDao();
        int vendor_id = pdao.getVendorID(vendor);
        String result = null;
        try {
            result = pdao.editProductQuantity(vendor_id, newQuantity);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);
        response.getWriter().println(result);


    }
}
