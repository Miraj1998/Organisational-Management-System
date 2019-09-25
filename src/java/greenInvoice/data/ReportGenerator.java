/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.data;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;

/**
 *
 * @author Vivek
 */
public class ReportGenerator {

    public static void main(String[] args) {
        // System.out.println("Usage: ReportGenerator ....");

        try {
            //Digester dig = new Digester();
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/invinv","root","root");
            InputStream in = new FileInputStream("E:/Telegram/Invoice.jasper");
            //JasperReport jasperReport = JasperCompileManager.compileReport("E:/Telegram/Invoice.jrxml");
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(in);
            //JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null);
            //JasperReportsContext jsp =  
            //JasperViewer viewer = new JasperViewer(jasperReport);
            JasperPrint prnt =JasperFillManager.fillReport(in,  new HashMap<String, Object>(), 
    new JREmptyDataSource());;
        } catch (Exception e) {
            System.out.print("Exceptiion" + e);
        }
    }
}
