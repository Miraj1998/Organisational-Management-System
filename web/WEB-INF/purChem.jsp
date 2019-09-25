

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
            $(function () {
                $("#chmtb").datagrid({
                    fit: true,
                    url: "GetStock?tp=chemicals",
                    title: 'Chemicals Inventory',
                    pagination: true,
                    pageSize: 4,
                    pageList: [1, 2, 3, 4, 5, 10, 15, 20],
                    singleSelect: true,
                    remoteSort: false
                });
                $("#vchr").datagrid({
                   fit: true,
                   url: "GetVoucher?tp=chemicals",
                   title: 'Vouchers',
                   pagination: true,
                   pageSize: 5,
                   pageList: [1,2,3,4,5,10,15,20],
                   remoteSort: false
                });
                $("#prt").portal({
                    fit: true,
                    border: false
                });
            })
        </script>
    </head>
    <body class="easyui-layout" style="font-family: Calibri;">
        <div data-options="region: 'north',border: false" style="height: 55%; padding: 10px;background-color: #1F2C35;overflow: hidden">
            <form class="easyui-form" id="frmChem" action="PurChem">
                <input type="hidden" name="email" value="<%= email%>"/>
                <input type="hidden" name="producttp" value="chemicals"/>
                <table width="100%" border="0" cellpadding="5" cellspacing="5" style="-webkit-filter: drop-shadow(5px 5px 5px #222); filter: drop-shadow(5px 5px 5px #222);font-size: 12pt;background-image: url('images/chemicals.png'); background-size: 200px 200px;background-position: 10% 50%; background-repeat: no-repeat; background-position-y: center">
                    <tr>
                        <td align="right">Voucher No.:</td>
                        <td width="40%"><input class="easyui-textbox" name="voucherno" value="0" style="text-align: right; width: 320px;"/></td>
                    </tr>
                    <tr>
                        <td align="right">Date:</td>
                        <td><div class="easyui-datebox" name="dos" style="width: 320px;"/></td>
                    </tr>
                    <tr>
                        <td align="right">Supplier:</td>
                        <td>
                            <select name="partyno" class="easyui-combobox" style="width: 320px;">
                                <%                                while (p.hasNext()) {
                                        Partymaster pm = (Partymaster) p.next();
                                %>
                                <option value="<%= pm.getPartyno()%>"><%=pm.getPartyname()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="40%" align="right">Chemical:</td>
                        <td>
                            <select name="productid" class="easyui-combobox" style="width: 320px;">
                                <%
                                    while (i.hasNext()) {
                                        Chemicals c = (Chemicals) i.next();
                                %>
                                <option value="<%= c.getProductcode()%>"><%= c.getProductcode() + " - " + c.getProductdesc() + " - " + c.getSpecification() + " - " + c.getPrice()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Units:</td>
                        <td><input class="easyui-numberbox" name="qty" value="0" style="text-align: right; width: 320px;"/></td>
                    </tr>
                    <tr>
                        <td align="right">Price per Unit (INR):</td>
                        <td><input class="easyui-numberbox" name="price" value="0.00" style="text-align: right;width: 320px;" data-options="precision: 2"/></td>

                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Purchase" style="height: 30px; width: 100px;" class="easyui-linkbutton"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div data-options="region: 'center',border: false" style="padding: 10px;background-color: #1F2C35;">
            <div id="prt" style="overflow: hidden;">
                <div style="width: 50%;"> 
                    <div style="height: 200px;">
                        <table id="chmtb">
                            <thead>
                                <tr>
                                    <th data-options="field:'productId', auto: true" width="100" sortable="true">Product ID</th>
                                    <th data-options="field:'units', auto: true" width="100" sortable="true">Units</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
                <div style="width: 50%">
                    <div style="height: 200px;">
                        <table id="vchr">
                            <thead>
                            <tr>
                                <!--
| voucherno | partyno | dos        | productid | qty  | price | producttp |
+-----------+---------+------------+-----------+------+-------+-----------+
| 10        | 1       | 2019-02-15 |         1 |   10 |   100 | chemicals |
                                -->
                                <th data-options="field:'voucherno',auto: true" width="100" sortable="true">Voucher No</th>
                                <th data-options="field:'partyno', auto: true" width="100" sortable="true">Party No.</th>
                                <th data-options="field:'dos',auto: true" width="100" sortable="true">Date</th>
                                <th data-options="field:'productid', auto: true" width="100" sortable="true">Product ID</th>
                                <th data-options="field:'qty', auto: true" width="100" sortable="true">Quantity</th>
                                <th data-options="field:'price',auto: true" width="100" sortable="true">Price (INR)</th>   
                                <th data-options="field:'amt',auto: true" width="100" sortable="true">Amount (INR)</th>
                                <!--th data-options="field:'producttp, auto: true" width="100" sortable="true">Type</th-->    
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
               
            </div>
        </div>
    </body>
</html>
