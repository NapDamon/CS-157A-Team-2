package com.example.egrocer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "deleteProduct", value = "/deleteProduct")
public class DeleteProduct extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String delete =request.getParameter("yes");

        int product_id = Integer.parseInt(request.getParameter("product_id"));
        String vendor;
        HttpSession session = request.getSession();
        vendor = (String) session.getAttribute("vendor");

        ProductsDao pdao=new ProductsDao();
        int vendor_id = pdao.getVendorID(vendor);
        String result = null;

        if("Yes".equals(delete)){
            try {
                result = pdao.deleteProduct(product_id, vendor_id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);
            response.getWriter().println(result);
        }else{
            request.getRequestDispatcher("/WEB-INF/VendorHome.jsp").forward(request,response);
            response.getWriter().println(result);
        }






    }
}
