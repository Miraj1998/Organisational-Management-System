

<%@page import="greenInvoice.data.Test"%>
<%@page import="net.sf.jasperreports.engine.export.JRXlsExporter"%>
<%@page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="net.sf.jasperreports.engine.export.JRHtmlExporter"%>
<%@page import="net.sf.jasperreports.engine.export.JRPdfExporter"%>
<%@page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.SQLException"%>
<%@page import="net.sf.jasperreports.engine.JRException"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!--%@page contentType="text/html" pageEncoding="UTF-8"%-->

<!DOCTYPE html>
<!-- viewReport.jsp page to render PDF -->
<%@ page contentType = "application/pdf" %>

<%@ page trimDirectiveWhitespaces = "true" %>

<%@ page import = "net.sf.jasperreports.engine.*" %>

<%@ page import = "java.io.File" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "java.io.FileNotFoundException" %>
<%@ page import = "java.io.InputStream" %>

<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.SQLException" %>


<%

    Map<String, Object> param = new HashMap<>();
    param.put("InvoiceNo", 1);
    try {
        /*String url = "jdbc:mysql://localhost/invinv";
        String userName = "root";
        String password = "root";

// Connecting to the Oracle database
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, userName, password);

// Loading the Jasper Report file from local file system\
        String jrxmlFile = "E:/Telegram/Invoice.jrxml";
        InputStream input = new FileInputStream(new File(jrxmlFile));

// Generate the report
        //JasperDesign jasperDesign = JRXmlLoader.load(jrxmlFile);
        //JasperReport jasperReport = JasperCompileManager.compileReport(input);
        //JasperReport jasperReport = JasperCompileManager.compileReport(input);
        JasperReport jasperReport = (JasperReport) JRLoader.loadObject(new File(jrxmlFile));
        //JasperReport jasperReport = JasperCompileManager.compileReport(input);
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, param, conn);
// Export the report as a PDF
        JasperExportManager.exportReportToPdfFile(jasperPrint,
                "E:/demo.pdf");
        response.setContentType("application/pdf");
//for creating report in excel format
        ServletOutputStream servletOutputStream = response.getOutputStream();
        //JRXlsExporter exporterXls = new JRXlsExporter();
        //exporterXls.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        //exporterXls.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,
        //        "E:/jasperReports/demo.xls");
        //exporterXls.exportReport();
        JasperExportManager.exportReportToPdfStream(jasperPrint, servletOutputStream);

        servletOutputStream.flush();
        servletOutputStream.close();
        //JasperExportManager.exportReportToHtmlFile(jasperPrint, "D:/Report.html");
        //response.sendRedirect("D:/Report.html");*/
        String path = getServletContext().getRealPath("/");
        ServletOutputStream servletOutputStream = response.getOutputStream();
        //System.out.println(path);
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/invinv","root","root");
        InputStream in = new FileInputStream("Invoice.jrxml");
        JasperReport jasperReport =  (JasperReport) JRLoader.loadObject(in);//(JasperReport) JRLoader.loadObject(new File(path + "/Invoice.jrxml"));
        //JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, param, con);
        JasperExportManager.exportReportToXmlStream(in, servletOutputStream);
        servletOutputStream.flush();
        servletOutputStream.close();
        //System.out.println("Path : " + path);
    } catch (Exception ex) {
        System.out.println(ex.getMessage());

    } 

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       
        <h1>Hello World!</h1>
    </body>
</html>
