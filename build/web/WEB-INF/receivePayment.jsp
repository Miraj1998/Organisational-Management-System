

<%@page import="greenInvoice.maps.Usermaster"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="greenInvoice.maps.Chemicals"%>
<%@page import="greenInvoice.control.Controller"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Controller dm = new Controller();
    ArrayList<Chemicals> products = dm.getChems();
    Iterator i = products.iterator();
    String yrCnt[][] = dm.getYrCnt();
    String email = request.getParameter("email").toString();
    request.setAttribute("email", email);
    Usermaster um = dm.getName(email);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Green Invoice: Glassware Master Record</title>
        <link type="text/css" rel="stylesheet" href="easyui/themes/black/easyui.css"/>
        <link type="text/css" rel="stylesheet" href="easyui/themes/color.css"/>
        <link type="text/css" rel="stylesheet" href="easyui/themes/icon.css"/>
        <link type="text/css" rel="stylesheet" href="easyui/demo/demo.css"/>
        <link type="text/css" rel="stylesheet" href="css/fa-svg-with-js.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script type="text/javascript" src="easyui/jquery.min.js"></script>
        <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>

        <script type="text/javascript" src="easyui/jquery.portal.js"></script>
        <script type="text/javascript" src="js/fontawesome-all.js"></script>
        <script src="https://code.highcharts.com/highcharts.src.js"></script>
        <script src="https://code.highcharts.com/modules/series-label.js"></script>
        <script src="https://code.highcharts.com/modules/data.js"></script>
        <script src="https://code.highcharts.com/highcharts-more.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script type="text/javascript" src="easyui/jquery.edatagrid.js"></script>
        <title>JSP Page</title>
        <style>
            a
            {
                text-decoration: none;
                color: white
            }
            a:hover{
                color: #AACCFF;                
            }
        </style>
        <script>
            $(function () {
                $("#invTab").edatagrid({
                    url: 'GetReceipts',
                    //toolbar: '#toolbar',
                    //footer: '#ft',
                    idField: "rectno",
                    striped: true,
                    fit: true,
                    title: 'Receipts Log',
                    pagination: true,
                    pageSize: 15,
                    pageList: [1, 2, 3, 4, 5, 10, 15, 20],
                    remoteSort: false,
                    fitColumns: true
                });

            });
        </script>
    </head>
    <body class="easyui-layout" style="font-family: Calibri;">
        
        <div data-options="region: 'center', border: false" style="padding: 10px;">
            <table id="">
                
            </table>
        </div>
    </body>
</html>
