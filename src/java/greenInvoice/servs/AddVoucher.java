/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.servs;

import greenInvoice.control.Controller;
import greenInvoice.maps.Chemicals;
import greenInvoice.maps.Glassware;
import greenInvoice.maps.Instruments;
import greenInvoice.maps.InvRep;
import greenInvoice.maps.Invoice;
import greenInvoice.maps.InvoiceId;
import greenInvoice.maps.Partymaster;
import greenInvoice.maps.Voucher;
import greenInvoice.maps.VoucherId;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 *
 * @author Vivek
 */
public class AddVoucher extends HttpServlet {

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
            String email = request.getParameter("email");
            int productid = Integer.parseInt(request.getParameter("productid"));
            Date doi = new Date(request.getParameter("doi"));
            String particulars = request.getParameter("partyno");
            String vchno = c.lastVoucherNo();
            String producttp = request.getParameter("producttp");
            double dramt = 0;
            Float gst = Float.parseFloat(request.getParameter("gst")); //changed from Double to float 15-Apr-19
            double price = Double.parseDouble(request.getParameter("prc"));
            int qty = Integer.parseInt(request.getParameter("qty"));
            double cramt = (price * qty)  + (price * qty * gst);
            int invno = Integer.parseInt(request.getParameter("invno"));
            double paid = 0;
            Invoice invoice = new Invoice();
            invoice.setCramt(cramt);
            invoice.setDoi(doi);
            invoice.setDramt(dramt);
            InvoiceId invoiceId = new InvoiceId();
            invoiceId.setInvNo(invno);
            invoiceId.setVchno(vchno);
            invoice.setId(invoiceId);
            invoice.setPaid(paid);
            invoice.setParticulars(particulars);
            
            VoucherId voucherId = new VoucherId();
            Voucher voucher = new Voucher();
            voucherId.setDos(doi);
            voucherId.setPartyno(particulars);
            voucherId.setProductid(productid);
            voucherId.setVoucherno(vchno);
            voucher.setId(voucherId);
            voucher.setPrice(price);
            voucher.setProducttp(producttp);
            voucher.setQty(qty);
            int resp = c.addVoucher(invoice, voucher);
            
            // Getting all required details for Report
            InvRep ir = new InvRep();
            Partymaster pm = c.getParty(particulars);
            ir.setAddress1(pm.getAddress1());
            ir.setAmount(cramt);
            ir.setAmountRecd(paid);
            ir.setEmail(pm.getEmail());
            ir.setGst(gst);
            ir.setInvno(invno);
            ir.setPartyName(pm.getPartyname());
            ir.setPhone(pm.getPhone());
            ir.setPrice(price);
            ir.setUnits(qty);
            ir.setVoucherno(vchno);
            ir.setDoi(doi);
            switch (producttp) {
                case "chemicals":
                    Chemicals chem = c.getChemical(productid);
                    ir.setProductDesc(chem.getProductdesc());
                    ir.setSpecs(chem.getSpecification());
                    break;
                case "glassware":
                    Glassware glass = c.getGlass(productid);
                    ir.setProductDesc(glass.getDescGoods());
                    ir.setSpecs(glass.getMake());
                    break;
                default:
                    Instruments inst = c.getInst(productid);
                    ir.setProductDesc(inst.getDescGoods());
                    ir.setSpecs(inst.getWorkingSize());
                    break;
            }
            //ir.setDoi(doi);
            //ir.setVoucherno(vchno);
            c.addInvRep(ir);
            
            if (resp == 1)
            {
                System.out.println("Successfully added");
            }
            //request.getRequestDispatcher("/WEB-INF/sellChem.jsp?email=" + email).forward(request, response);
            request.getRequestDispatcher(request.getParameter("pg")).forward(request, response);
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
