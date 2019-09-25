/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.servs;

import greenInvoice.control.Controller;
import greenInvoice.maps.Voucher;
import greenInvoice.maps.VoucherId;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Vivek
 */
public class PurGlass extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           Voucher v = new Voucher();
           String email = request.getParameter("email");
           System.out.println("DOS : " + request.getParameter("dos"));
           VoucherId vid = new VoucherId();
           vid.setDos(new Date(request.getParameter("dos")));
           vid.setPartyno(request.getParameter("partyno"));
           vid.setProductid(Integer.parseInt(request.getParameter("productid")));
           vid.setVoucherno(request.getParameter("voucherno"));
           v.setQty(Integer.parseInt(request.getParameter("qty")));
           v.setPrice(Double.parseDouble(request.getParameter("price")));
           v.setProducttp(request.getParameter("producttp"));
           v.setId(vid);
           Controller c = new Controller();
           c.purChem(v);
           response.sendRedirect("/WEB-INF/purGlass?email=" + email);
           //request.getRequestDispatcher("/WEB-INF/purGlass?email=" + email).forward(request, response);
        
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
