

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
                    url: 'GetGlass',
                    saveUrl: 'SaveGlass',
                    updateUrl: 'EditGlass',
                    
                    toolbar: '#toolbar',
                    idField: "productId",
                    striped: true,
                    fit: true,
                    title: 'Glassware Master Register',
                    pagination: true,
                    pageSize: 15,
                    pageList: [1, 2, 3, 4, 5, 10, 15, 20],
                    remoteSort: false,
                    fitColumns: true
                });

            });
            function deleterow(target) {
                $.messager.confirm('Confirm', 'Are you sure you want to delete this record?', function (r) {
                    
                    if (r) {
                        var row = $('#invTab').edatagrid('getSelected');
                        
                        //$.messager.show(row);
                        $.post('DelGlass', row, function (response) {
                            if (response === 'success')
                                $('#invTab').edatagrid('deleteRow', getRowIndex(target));
                                $("#invTab").edatagrid('reload');
                        });
                    }
                });
            }
        </script>
    </head>
    <body class="easyui-layout" style="font-family: Calibri;">

        <div data-options="region: 'center', border: false" style="padding: 10px;background: linear-gradient(white,lightgrey);">

            <!--div class="easyui-panel" title="Records" style="width: 100%; height: 100%;padding: 10px;"-->
            <table id="invTab" style="width: 100%; height: 100%;" class="easyui-datagrid">
                <thead>
                    <tr>
                        <!--
                        private int productId;
                        private int catNo;
                        private String subCat;
                        private String descGoods;
                        private String make;
                        private Double price;
                        -->
                        <th data-options="field:'productId', auto: true" width="100" sortable="true">Product ID</th>
                        <th data-options="field:'catNo', auto: true"  editor="{type:'validatebox',options:{required:true}}" sortable="true">Category No.</th>
                        <th data-options="field:'subCat', auto: true"  editor="{type:'validatebox',options:{required:true}}"  sortable="true">Sub category</th>
                        <th data-options="field:'descGoods', auto: true" editor="{type:'validatebox',options:{required:true}}" sortable="true">Description</th>
                        <th data-options="field:'price', auto: true"  editor="{type:'validatebox',options:{required:true}}" align="right" sortable="true">Price (INR)</th>
                        <th data-options="field:'make', auto: true"  editor="{type:'validatebox',options:{required:true}}" align="right" sortable="true">Make</th>
                        <th data-options="field:'gst', auto: true" editor="{type:'validatebox',options:{required:true}}" align="right" sortable="true">GST (in Decimal)</th>
                    </tr>
                </thead>
            </table>
            <div id="toolbar" style="padding: 3px;">
                <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:$('#invTab').edatagrid('addRow')">New</a>
                <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleterow(this);">Delete</a>
                <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#invTab').edatagrid('saveRow')">Save</a>
                <a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#invTab').edatagrid('cancelRow')">Cancel</a>
            </div>
            <div id="ft" style="padding: 3px;">
                <span>Product ID:</span>
                <input id="productid" class="easyui-textbox" style="line-height:10px;border:1px solid #ccc">
                <span>Description:</span>
                <input id="descr" class="easyui-textbox" style="line-height:10px;border:1px solid #ccc">
                <span>Make:</span>
                <input id="make" class="easyui-textbox" style="line-height:10px;border:1px solid #ccc">
                <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-search" ></a>
            </div>
            <!--/div-->
        </div>
    </body>
</html>
