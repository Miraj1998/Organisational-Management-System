

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
    String email = request.getAttribute("email").toString();
    request.setAttribute("email", email);
    Usermaster um = dm.getName(email);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
                    url: 'GetDashChart',
                    saveUrl: 'Chemical',
                    updateUrl: 'EditChemical',
                    destroyUrl: 'delChemical',
                    toolbar: '#toolbar',
                    idField: "productcode",
                    striped: true,
                    fit: true,
                    title: 'Chemicals Master Register',
                    pagination: true,
                    pageSize: 15,
                    pageList: [1, 2, 3, 4, 5, 10, 15, 20],
                    remoteSort: false
                });

            });
        </script>
    </head>
    <body class="easyui-layout" style="font-family: Calibri;">
        <div data-options="region: 'north', border: false" style="height: 35px; padding: 0px; overflow: hidden">
            <table width="100%" style="border-collapse: collapse; background-color: #1F2C35;" border="0" cellpadding="10">
                <tr>
                    <td style="width: 9.5%;background-color: #1F2C35;color:white;font-family: Calibri; font-size: 14pt;text-align:center;vertical-align: top;">MY INVOICE</td>
                    <!--td style="width: 1%;"><i class="fa fa-tachometer-alt fa-inverse"></i></td>
                    <td style="width: 70%;"><span style="font-family: Calibri;"> Dashboard </span></td-->
                    <td style="width: 70%;text-align: right;"><%= um.getName()%></td>
                    <td style="width: 2%;"><a class="easyui-tooltip" title="Messages" href="#"><i class="fa fa-envelope fa-inverse"></i></a></td>
                    <td style="width: 2%; text-shadow: 2px 2px;"><i class="fa fa-chart-pie fa-inverse"></i></td>
                    <td style="width: 2%;"><i class="fa fa-comments fa-inverse"></i></td>
                    <td style='width: 3%;'><i class="fa fa-user fa-inverse"></i></td>
                </tr>
            </table>
        </div>
        <div data-options="region: 'west', border: false, split: false, collapsible: true" style="border-top: 1pt solid #2B2A47; width: 150px;background-color: #1F2C35;">
            <table width="100%" border="0" cellpadding="5" cellspacing="0" style="font-family: Calibri; vertical-align: middle; font-size: 10pt;">
                <!--tr>
                    <td></td>
                </tr-->
                <tr>
                    <td colspan="2" align="center" style="background-color: black;">REPORTS</td>
                </tr>
                <tr align="left">
                    <td ><a href="index.jsp"><i class="fa fa-tachometer-alt fa-inverse"></i><span style="margin-left: 17px;">Dashboard</span></a></td>
                </tr>
                <tr align="left">
                    <td><img src="images/orders.png" style="width: 20px;vertical-align: middle;"/> <span style="margin-left: 10px;">Orders</span></td>
                </tr>
                <tr align="left">
                    <td><img src="images/inventory.png" style="width:15px; vertical-align: middle;"/> <span style="margin-left: 15px;">Inventory report</span></td>
                </tr>
                <tr align="left">
                    <td><img src="images/receipts.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Receipts</span></td>
                </tr>
                <tr align="left">
                    <td><img src="images/invoice.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Invoice</span></td>
                </tr>
                <tr>
                    <td colspan="2" align="center" style="background-color: black">MASTER RECORDS</td>
                </tr>
                <tr align="left">
                <a href=""><td style="background-color: #A1A2A3;"><img src="images/chemicals.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Chemicals</span></td></a>
                </tr>
            </table>
        </div>
        <div data-options="region: 'center', border: false" style="padding: 10px;background: linear-gradient(white,lightgrey);">
            <!--div class="easyui-panel" title="Entry" style="width: 100%;height: 30%;padding: 10px;">
                <form action="Chemical?email=<%=email%>">
                    <table width="100%" border="0" cellpadding="5" cellspacing="5">
                        <tr>
                            <td width="25%" align="right">Description: </td>
                            <td width="25%"><input type="text" class="easyui-textbox" name="desc"/></td>
                            <td width="15%" align="right">Price (INR):</td>
                            <td><input type="text" class="easyui-textbox" name="price"/></td>
                        </tr>
                        <tr>
                            <td align="right">HSN Code:</td>
                            <td><input type="text" class="easyui-textbox" name="hsn"/></td>
                            <td align="right">GST Rate:</td>
                            <td><input type="text" class="easyui-textbox" name="gst"/></td>
                        </tr>
                        <tr>
                            <td align="right">Pack Size:</td>
                            <td><input type="text" class="easyui-textbox" name="pack"/></td>
                            <td></td>
                            <td><input type="submit" class="easyui-linkbutton" style="height: 30px; width: 150px;"/></td>

                    </table>
                </form>
            </div> <br/-->
            <div class="easyui-panel" title="Records" style="width: 100%; height: 100%;padding: 10px;">
                <table id="invTab" style="width: 100%; height: 100%;" class="easyui-datagrid">
                    <thead>
                        <tr>
                            <th data-options="field:'productcode'" width="100" sortable="true">Product ID</th>
                            <th data-options="field:'productdesc'"  editor="{type:'validatebox',options:{required:true}}" width="300" sortable="true">Description</th>
                            <th data-options="field:'specification'"  editor="{type:'validatebox',options:{required:true}}" width="70" sortable="true">HSN Code</th>
                            <th data-options="field:'packsize'" editor="{type:'validatebox',options:{required:true}}" width="70" sortable="true">Pack</th>
                            <th data-options="field:'price'"  editor="{type:'validatebox',options:{required:true}}" width="300" align="right" sortable="true">Price (INR)</th>
                            <th data-options="field:'gst'"  editor="{type:'validatebox',options:{required:true}}" width="300" align="right" sortable="true">GST</th>
                        </tr>
                    </thead>
                </table>
                <div id="toolbar" style="padding: 3px;">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:$('#invTab').edatagrid('addRow')">New</a>
                    <!--a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:$('#invTab').edatagrid('destroyRow')">Delete</a-->
                    <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#invTab').edatagrid('saveRow')">Save</a>
                    <a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#invTab').edatagrid('cancelRow')">Cancel</a>

                </div>
            </div>
        </div>
    </body>
</html>
