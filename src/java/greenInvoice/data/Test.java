/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.data;

import java.text.DecimalFormat;

/**
 *
 * @author Vivek
 */
public class Test {
    public void getReport(int invNo)
    {
        try {
            /*Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/invinv","root","root");
            InputStream in = new FileInputStream("E:/Telegram/Invoice.jasper");
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(in);
            //jasperReport.setProperty("InvoiceNo", "1");
            Map<String, Object> param = new HashMap<>();
            param.put("InvoiceNo", invNo);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, param, con);
            //JasperExportManager.exportReportToPdfFile(jasperPrint, "E:/Telegram/sample.pdf");
            JasperViewer viewer = new JasperViewer(jasperPrint);
            viewer.setExtendedState(JasperViewer.MAXIMIZED_BOTH);
            viewer.setVisible(true);*/
            System.out.println("Hello");
        } catch (Exception e) {
            System.out.print("Exceptiion" + e);
        }
    }
    public static void main(String[] args) {
        // System.out.println("Usage: ReportGenerator ....");

        try {
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/invinv","root","root");
//            InputStream in = new FileInputStream("E:/Telegram/Invoice.jasper");
//            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(in);
//            //jasperReport.setProperty("InvoiceNo", "1");
//            Map<String, Object> param = new HashMap<>();
//            param.put("InvoiceNo", 2);
//            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, param, con);
//            //JasperExportManager.exportReportToPdfFile(jasperPrint, "E:/Telegram/sample.pdf");
//            JasperViewer viewer = new JasperViewer(jasperPrint);
//            viewer.setExtendedState(JasperViewer.MAXIMIZED_BOTH);
//            viewer.setVisible(true);
            double d = 12.432342345;
            d = Math.round(d * 100.0) /100.0;
            System.out.println(d);
        } catch (Exception e) {
            System.out.print("Exceptiion" + e);
        }
    }
}
