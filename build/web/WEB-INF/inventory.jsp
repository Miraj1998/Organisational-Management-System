

<%@page import="greenInvoice.maps.Partymaster"%>
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
    ArrayList<Partymaster> parties = dm.getParties();
    Iterator i = products.iterator();
    Iterator p = parties.iterator();
    //String yrCnt[][] = dm.getMakeGlass(); //dm.getYrCnt();
    String email = request.getParameter("email").toString();
    //System.out.println("Email From Index : " + email);
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
        <script>
            $(function(){
                $("#stockchem").datagrid({
                   url: 'GetTabData?tp=chem',
                   fit: true,
                   pagination: true,
                   title: 'Chemicals Inventory',
                   pageSize: 15,
                   pageList: [1, 2, 3, 4, 5, 10, 15, 20],
                   singleSelect: true,
                   remoteSort: false
                });
                $("#stockglass").datagrid({
                   url: 'GetTabData?tp=glass',
                   fit: true,
                   pagination: true,
                   title: 'Glassware Inventory',
                   pageSize: 15,
                   pageList: [1, 2, 3, 4, 5, 10, 15, 20],
                   singleSelect: true,
                   remoteSort: false
                });
                $("#stockinst").datagrid({
                   url: 'GetTabData?tp=inst',
                   fit: true,
                   pagination: true,
                   title: 'Instruments Inventory',
                   pageSize: 15,
                   pageList: [1, 2, 3, 4, 5, 10, 15, 20],
                   singleSelect: true,
                   remoteSort: false
                });
            })
        </script>
    </head>
    <body class="easyui-layout">
        <div data-options="region: 'center',border: false" style="padding:10px;">
            <div class='easyui-tabs' data-options="fit: true">
                <div title="Chemicals" style="padding:10px;">
                    <table id="stockchem">
                        <thead>
                            <tr>
                                <!--
                                | productid     | int(11)       | YES  |     | NULL    |       |
                                | units         | int(10)       | YES  |     | NULL    |       |
                                | productdesc   | varchar(300)  | YES  |     | NULL    |       |
                                | specification | varchar(1000) | YES  |     | NULL    |       |
                                -->
                                <th data-options="field:'productid',auto: true" width="100" sortable="true">Product ID</th>
                                <th data-options="field:'productdesc',auto: true" width="100" sortable="true">Description</th>
                                <th data-options="field:'specification',auto: true" width="100" sortable="true">Specifications</th>
                                <th data-options="field:'units',auto: true" width="100" sortable="true">Units</th>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div title="Glassware" style="padding:10px;">
                    <table id="stockglass">
                        <thead>
                            <tr>
                                <th data-options="field:'productid',auto: true" width="100" sortable="true">Product ID</th>
                                <th data-options="field:'descgoods',auto: true" width="100" sortable="true">Description</th>
                                <th data-options="field:'make',auto: true" width="100" sortable="true">Make</th>
                                <th data-options="field:'units',auto: true" width="100" sortable="true">Units</th>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div title="Instruments" style="padding:10px;">
                    <table id="stockinst">
                        <thead>
                            <tr>
                                <th data-options="field:'productid',auto: true" width="100" sortable="true">Product ID</th>
                                <th data-options="field:'descgoods',auto: true" width="100" sortable="true">Description</th>
                                <th data-options="field:'moc',auto: true" width="100" sortable="true">MOC</th>
                                <th data-options="field:'units',auto: true" width="100" sortable="true">Units</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
