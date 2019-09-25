

<%@page import="greenInvoice.maps.Usermaster"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="greenInvoice.maps.Chemicals"%>
<%@page import="greenInvoice.control.Controller"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Controller dm = new Controller();
    ArrayList<Chemicals> products = dm.getChems();
    Iterator i = products.iterator();
    String yrCnt[][] = dm.getMakeGlass(); //dm.getYrCnt();
    String email = request.getParameter("email").toString();
    System.out.println("Email From Index : " + email);
    Usermaster um = dm.getName(email);
%>
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
    </head>
    <body class="easyui-layout" style="font-family: Calibri;">
        <div data-options="region: 'center', border: false" style="padding: 10px;background: linear-gradient(white,lightgrey);overflow: hidden">
            <div style="width: 100%; height: 8%;overflow: hidden;" class="easyui-panel" >
                <table width="100%" cellpadding="5" cellspacing="5" border="0" style="background-repeat: no-repeat; background-image: url('images/buy.png');background-size: 5%; background-position: 0% 50%;">
                    <tr align="center">
                        <td><a href="GetPage?flNm=purChem.jsp&email=<%=email%>" target="frmMain" class="easyui-linkbutton" style="width: 200px;">Chemicals</a></td>
                        <td><a href="GetPage?flNm=purGlass.jsp&email=<%=email%>" target="frmMain" class="easyui-linkbutton" style="width: 200px;">Glassware</a></td>
                        <td><a href="GetPage?flNm=purInst.jsp&email=<%=email%>" target="frmMain" class="easyui-linkbutton" style="width: 200px;">Instruments</a></td>
                    </tr>
                </table>
            </div>
            <div style="width: 100%; height: 92%">
                <iframe id="frmMain" name="frmMain" style="width: 100%; height: 100%; border: 0pt; overflow: hidden;" src="GetPage?flNm=purChem.jsp&email=<%=email%>"></iframe> 
            </div>
       
        </div>
    </body>
</html>
