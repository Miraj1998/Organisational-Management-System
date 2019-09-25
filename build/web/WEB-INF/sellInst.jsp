
<%@page import="greenInvoice.maps.Instruments"%>
<%@page import="greenInvoice.maps.Stock"%>
<%@page import="greenInvoice.maps.Partymaster"%>
<%@page import="greenInvoice.maps.Usermaster"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="greenInvoice.maps.Chemicals"%>
<%@page import="greenInvoice.maps.Chemicals"%>
<%@page import="greenInvoice.control.Controller"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Controller dm = new Controller();
    ArrayList<Instruments> products = dm.getInst();
    ArrayList<Partymaster> parties = dm.getParties();
    ArrayList<Stock> stocks = dm.getStock();
    Iterator i = products.iterator();
    Iterator p = parties.iterator();
    Iterator stck = stocks.iterator();
    //String yrCnt[][] = dm.getMakeGlass(); //dm.getYrCnt();
    String email = request.getParameter("email").toString();
    //System.out.println("Email From Index : " + email);
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
                $('#invno').numberbox('textbox').bind('blur', function (e) 
                {
                    var k = $('#invno').numberbox('getValue');
                    //alert("Hello");
                    getDet(k);
                });
            });
            function getDet(a)
            {
                //alert(a);
                //$("#partyno").combobox('setValue',3);
                $.ajax({
                    type: "GET",
                    url: "GetInvDet?invno=" + a,
                    async: true,
                    success: function (data)
                    {
                        var k = data.split("|");
                        var y = k[1].split("-");
                        var dates = y[1]+"/"+y[2]+"/"+y[0];
                        var partyNo = parseInt(k[0]);
                        $("#partyno").combobox('setValue',partyNo);
                        $("#doi").datebox('setValue', dates);
                    }
                });
            }
            function doCall(a)
            {
                $.ajax({
                    type: "GET",
                    url: "GetProduct?tp=instrument&productid=" + a,
                    async: true,
                    success: function (data)
                    {
                        //alert(data);
                        var k = data.split("|");
                        //alert(k[1]);
                        $("#avqty").textbox('setValue', k[0]);
                        $("#prc").textbox('setValue', k[1]);
                        $("#gst").textbox('setValue', k[2]);
                    }
                });
            }
            
            function chkQty()
            {
                var a = document.getElementById('qty').value;
                
                var b = document.getElementById('avqty').value;
                //alert("A : " + a + ", B : " + b);
                if (a > b)
                {
                    
                    alert("Cannot oversell");
                    document.getElementById('qty').value = "0";
                    document.getElementById('qty').focus();
                }
                
            }
        </script>
    </head>
    <body class="easyui-layout" style="font-family: Calibri;">
        <div data-options="region: 'north', border: false" style="padding: 10px; height: 48%;">
            <div class="easyui-panel" style="width: 100%; height: 50px;background-repeat: no-repeat; overflow: hidden; background-image: url('images/instrument.png');background-size: 3%; background-position: 0% 50%;" >
                <h2 style="margin-left: 50px;margin-top: 10px;">Instruments</h2>
            </div><br/>
            <form action="AddVoucher?tp=instrument" method="post">
                <input type="hidden" name="email" value="<%= email%>"/>
                <input type="hidden" name="producttp" value="instrument"/>
                <input type="hidden" name="pg" value="\WEB-INF\sellInst.jsp?email=<%=email%>"/>
                <div class="easyui-panel" title="Invoice Details">
                    <table style="height: 100%;width: 100%;border: 0pt;" cellpadding="3" cellspacing="3">
                        <tr>
                            <td align="center" width="10%">Invoice No:</td>
                            <td align="center" width="10%"><input type="text" class="easyui-numberbox" id="invno" name="invno" onchange="$('#getInvNo').value = this.value;"/></td>
                            <td align="center" width="25%">Buyer:</td>
                            <td align="center" width="25%" style="border-right: 1pt solid;">
                                <select name="partyno" id="partyno" class="easyui-combobox" style="width: 200px;">
                                    <%                                while (p.hasNext()) {
                                            Partymaster pm = (Partymaster) p.next();
                                    %>
                                    <option value="<%= pm.getPartyno()%>"><%=pm.getPartyname()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                            <td align="center" width="15%">Date:</td>
                            <td align="center"><div class="easyui-datebox" id="doi" name="doi" date="<%= new java.util.Date()%>" style="width: 320px;"/></td>
                        </tr>
                        </tr>
                    </table>
                </div>
                </br>
                <div class="easyui-panel" title="Add Vouchers">

                    <table style="height: 100%;width: 100%;border: 0pt;" cellpadding="3" cellspacing="3">
                        <tr>
                            <td align="center" width="5%">Product:</td>
                            <td align="center" width="30%" style="border-right: 1pt solid;">
                                <select name="productid" style="width: 310px;" onChange="doCall(this.value);">
                                    <option value="0">Select Instrument</option>
                                    <%
                                        while (i.hasNext()) {
                                            Instruments chem = (Instruments) i.next();

                                    %>
                                    <option value="<%= chem.getInstrumentsId()%>"><%= chem.getDescGoods() + " , " + chem.getWorkingSize() + ", " + chem.getMoc() %></option>
                                    <%  }
                                    %>
                                </select>
                            </td>
                            <td  align="center">Available Qty:</td>
                            <td width="7%" align="center" style="border-right: 1pt solid;"><input class="easyui-textbox" id="avqty" name="avqty" style="width: 50px;" editable="false"/></td>
                            <td  align="center">Price (INR):</td>
                            <td width="7%" align="center" style="border-right: 1pt solid;"><input class="easyui-textbox" id="prc" name="prc" style="width: 50px;" editable="false"/></td>
                            <td align="center">GST Rate:</td>
                            <td align="center" width="7%" style="border-right: 1pt solid;"><input class="easyui-textbox" id="gst" name="gst" style="width: 50px;" editable="false"/></td>
                            <td align="center">Sell Qty:</td>
                            <td align="center" width="7%" style="border-right: 1pt solid;"><input id="qty" name="qty" style="width: 50px;" onblur="chkQty();"/></td>
                            <td align="center"><input type="submit" value="Add Voucher" class="easyui-linkbutton" onblur="chkQty();"></td>
                        </tr>
                    </table>

                </div>
            </form>
            <!--form action="GenRep" method="post">
                <input type="submit" value="Generate Report" class="easyui-linkbutton" style="width: 200px;"/>
            </form-->
            </br>
            <!--div class="easyui-panel" title = "Invoice Print"  style= "padding: 0px;">
                <form action="GenRep">
                    <table width="50%" border="0" cellspacing="3" cellpadding="3">
                        <tr>
                            <td width = "30%" align="center">Select Invoice Number:</td>
                            <td width="15%" align="center">
                                <select name="getInvNo" class="easyui-combobox" style="width: 100px;">
                                    <%
                                        int invno[] = dm.getInvoiceNo();
                                        for (int z = 0; z < invno.length; z++) {
                                    %>
                                    <option value="<%= invno[z]%>"><%= invno[z]%></option>
                                    <% }
                                    %>
                                </select>
                            </td>
                            <td align="center"><input type="submit" value="Get Report" class="easyui-linkbutton" style="width: 150px;height: 30px;"/></td>
                        </tr>
                    </table>

                    
                </form>

            </div-->
        </div>

        <div data-options="region: 'center', border: false" style="padding: 10px;" >
            <table id="tbl" class="easyui-datagrid" data-options="id: 'invno', url: 'GetInvoice', fit: true, pagination: true, remoteSort: false">
                <thead>
                    <tr>
                        <th field="invno" sortable="true">Invoice No</th>
                        <th field="doi" sortable="true">Date of Invoice</th>
                        <th field="particulars" sortable="true">Party No</th>
                        <th field="vchno" sortable="true">Voucher No</th>
                        <th field="cramt" sortable="true">Amount (INR)</th>
                        <th field="paid" sortable="true">Amount Received (INR)</th>
                    </tr>
                </thead>
            </table>
        </div>
    </body>
</html>
