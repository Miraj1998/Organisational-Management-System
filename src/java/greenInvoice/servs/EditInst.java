/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.servs;

import greenInvoice.control.Controller;
import greenInvoice.maps.Instrument;
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
public class EditInst extends HttpServlet {

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
            Controller c = new Controller();
            //int productid = Integer.parseInt(request.getParameter("productid"));
            int instrumentsid = Integer.parseInt(request.getParameter("instrumentsId"));
            String catno = request.getParameter("catNo");
            String workingsize = request.getParameter("workingSize");
            String descgoods = request.getParameter("descGoods");
            String moc = request.getParameter("moc");
            String tempcontroller = request.getParameter("tempController");
            double rate = Double.parseDouble(request.getParameter("rate"));
            float gst = Float.parseFloat(request.getParameter("gst"));
            
            Instrument gls = new Instrument();
            gls.setInstrumentsId(instrumentsid);
            gls.setCatNo(catno);
            gls.setDescGoods(descgoods);
            gls.setGst(gst);
            gls.setMoc(moc);
            gls.setRate(rate);
            gls.setTempController(tempcontroller);
            gls.setWorkingSize(workingsize);
            
            c.editInst(gls);
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
