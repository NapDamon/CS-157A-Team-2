package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "vendorHome", value = "/vendorHome")
public class VendorHome extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pname=request.getParameter("pname");
        float price= Float.parseFloat((request.getParameter("price")));
        int quantity= Integer.parseInt(request.getParameter("quantity"));
        String vendor=request.getParameter("vendor");


        ProductsDao pdao=new ProductsDao();
        int vendor_id = pdao.getVendorID(vendor);
        String result = pdao.addProducts(vendor_id, pname,price,quantity);
        request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);
        response.getWriter().println(result);





    }

}