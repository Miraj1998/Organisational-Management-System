/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.servs;

import greenInvoice.control.Controller;
import greenInvoice.maps.Glasswares;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Vivek
 */
public class EditGlass extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    /*
    | ProductID | int(11)      | NO   | PRI | NULL    |       |
    | CatNo     | int(11)      | NO   | MUL | NULL    |       |
    | SubCat    | varchar(255) | YES  |     | NULL    |       |
    | DescGoods | varchar(500) | YES  |     | NULL    |       |
    | Make      | varchar(50)  | YES  |     | NULL    |       |
    | Price     | double       | YES  |     | NULL    |       |
    | gst       | float        | YES  |     | NULL    |       |
    */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Controller c = new Controller();
            int productid = Integer.parseInt(request.getParameter("productId"));
            int catno = Integer.parseInt(request.getParameter("catNo"));
            String subcat = request.getParameter("subCat");
            String descgoods = request.getParameter("descGoods");
            String make = request.getParameter("make");
            double price = Double.parseDouble(request.getParameter("price"));
            float gst = Float.parseFloat(request.getParameter("gst"));
            
            Glasswares gls = new Glasswares();
            gls.setCatNo(catno);
            gls.setDescGoods(descgoods);
            gls.setGst(gst);
            gls.setMake(make);
            gls.setPrice(price);
            gls.setSubCat(subcat);
            gls.setProductId(productid);
            
            c.editGlass(gls);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
