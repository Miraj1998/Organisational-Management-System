/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.servs;

import greenInvoice.control.Controller;
import greenInvoice.maps.Chemicals;
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
public class Chemical extends HttpServlet {

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
            //String email = request.getParameter("email");
            //request.setAttribute("email", request.getParameter("email"));
            Controller c = new Controller();
            int lst = c.getLastProdId();
            //System.out.println("Last Product Code : " + lst);
            String desc = request.getParameter("productdesc");
            double price = Double.parseDouble(request.getParameter("price"));
            float gst = Float.parseFloat(request.getParameter("gst"));
            String pack = request.getParameter("packsize");
            String hsn = request.getParameter("specification");
            Chemicals chem = new Chemicals();
            chem.setGst(gst);
            chem.setPacksize(pack);
            chem.setPrice(price);
            chem.setProductcode(lst);
            chem.setProductdesc(desc);
            chem.setSpecification(hsn);
            System.out.println("Chemicals : " + chem);
            c.addChem(chem);
            //request.getRequestDispatcher("/WEB-INF/chemicals.jsp").forward(request, response);
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
