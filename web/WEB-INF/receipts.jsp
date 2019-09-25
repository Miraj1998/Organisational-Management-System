<%-- 
    Document   : chemicals
    Created on : 21 Oct, 2018, 12:40:35 PM
    Author     : Vivek
--%>

<%@page import="greenInvoice.maps.Usermaster"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="greenInvoice.maps.Chemicals"%>
<%@page import="greenInvoice.control.Controller"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Controller dm = new Controller();
    ArrayList<Chemicals> products = dm.getChems();
    int invnos[] = dm.getPendingInvoice();
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
                    toolbar: '#toolbar',
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

        <div data-options="region: 'center', border: false" style="padding: 10px;background: linear-gradient(white,lightgrey);">

            <table id="invTab" style="width: 100%; height: 100%;" class="easyui-datagrid">
                <thead>
                    <tr>
                        <th data-options="field:'rectno', auto: true" width="100" sortable="true">Receipt No.</th>
                        <th data-options="field:'invno', auto: true"  editor="{type:'validatebox',options:{required:true}}" sortable="true">Invoice No.</th>
                        <th data-options="field:'dor', auto: true"  editor="{type:'validatebox',options:{required:true}}"  sortable="true">Date of Receipt</th>
                        <th data-options="field:'recd', auto: true" editor="{type:'validatebox',options:{required:true}}" sortable="true">Received (INR)</th>
                        <th data-options="field:'pending', auto: true"  editor="{type:'validatebox',options:{required:true}}" align="right" sortable="true">Pending (INR)</th>
                    </tr>
                </thead>
            </table>
            <div id="toolbar" style="padding: 3px;">
                <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:$('#addRec').window('open')">New</a>
                <!--a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#invTab').edatagrid('saveRow')">Save</a>
                <a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#invTab').edatagrid('cancelRow')">Cancel</a-->
            </div>
            <div id="ft" style="padding: 3px;">
                <span>Receipt No:</span>
                <input id="rectno" class="easyui-textbox" style="line-height:10px;border:1px solid #ccc">
                <span>Invoice No:</span>
                <input id="invno" class="easyui-textbox" style="line-height:10px;border:1px solid #ccc">
                <span>Date of Receipt:</span>
                <input id="dor" class="easyui-textbox" style="line-height:10px;border:1px solid #ccc">
                <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-search" ></a>
            </div>
            <div id="addRec" class="easyui-window" data-options="closable:true, maximizable: false, modal: true, minimizable: false, resizable: false, collapsible: false, closed: true" style="padding: 10px;width: 50%;">
                <form id="addRecFrm" action="AddReceipt" method="post">
                    <input type="hidden" name="email" value="<%=email%>"/>
                    <table width="100%" border="0" cellpadding="5" cellspacing="5">
                        <tr>
                            <td align="right" width="50%">Invoice No:</td>
                            <td>
                                <select name="invno" class="easyui-combobox" data-options="editable: false">
                                    <%
                                        for (int z=0;z<invnos.length;z++)
                                        {
                                    %>
                                    <option value="<%=invnos[z]%>"><%=invnos[z]%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Date of Receipt:</td>
                            <td><input class="easyui-datebox" name="dor" style="width:60%" data-options="required:true"/></td>
                        </tr>
                        <tr>
                            <td align="right">Amount Received (INR):</td>
                            <td><input class="easyui-numberbox" name="recd" style="width:60%;" data-options="required:true"/></td>
                        </tr>
                        <tr>
                            <td align="right"><input type="reset" class="easyui-linkbutton" style="width: 50%; height: 25px;"/></td>
                            <td align="left"><input type="submit" value="Add Receipt" class="easyui-linkbutton" style="width: 50%; height: 25px;"/></td>
                        </tr>
                    </table>
                    
                </form>
            </div>
        </div>
    </body>
</html>
