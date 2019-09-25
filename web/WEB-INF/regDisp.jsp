

<%@page import="greenInvoice.data.LinearRegression"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/invinv", "root", "root");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("Select * from amonia");
    rs.last();
    double prices[] = new double[rs.getRow()];
    double sales[] = new double[rs.getRow()];
    rs.beforeFirst();
    int i = 0;
    while (rs.next()) {
        prices[i] = rs.getDouble(2);
        sales[i] = rs.getDouble(3);
        i++;
    }
    LinearRegression lr = new LinearRegression(prices, sales);
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
        <script>
            function GetVal()
            {
                var z = document.getElementById("prc").value;
                //alert("Price : " + z);
                var intercept = document.getElementById("intercept").innerHTML;
                //alert("Intercept : " + intercept);
                var slope = document.getElementById("slope").innerHTML;
                //alert("Slope : " + slope);
                var ic = parseFloat(intercept);
                var sl = parseFloat(slope);
                var res = ic + (sl * z);
                //alert("Result : " + res);
                document.getElementById("sls").value = res;
            }
            $(function () {
                Highcharts.chart('container', {
                    chart: {
                        type: 'scatter',
                        zoomType: 'xy'
                    },
                    title: {
                        text: 'Price versus Sales of Ammonia'
                    },
                    xAxis: {
                        title: {
                            enabled: true,
                            text: 'Price (INR)'
                        },
                        startOnTick: true,
                        endOnTick: true,
                        showLastLabel: true
                    },
                    yAxis: {
                        title: {
                            text: 'Sales (Units)'
                        }
                    },
                    /*legend: {
                        layout: 'vertical',
                        align: 'left',
                        verticalAlign: 'top',
                        x: 100,
                        y: 70,
                        floating: true,
                        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
                        borderWidth: 1
                    },*/
                    plotOptions: {
                        scatter: {
                            marker: {
                                radius: 5,
                                states: {
                                    hover: {
                                        enabled: true,
                                        lineColor: 'rgb(100,100,100)'
                                    }
                                }
                            },
                            states: {
                                hover: {
                                    marker: {
                                        enabled: false
                                    }
                                }
                            },
                            tooltip: {
                                headerFormat: '<b>{series.name}</b><br>',
                                pointFormat: '{point.x} INR, {point.y} Units'
                            }
                        }
                    },
                    
                    data:{
                        table: 'dt'
                    }
                });
            })
        </script>
    </head>
    <body class="easyui-layout" style="font-family: Calibri;">
        <div data-options="region: 'center', border: false" style="padding: 10px;overflow: hidden">
            <div class="easyui-panel" title="Scatter Plot" style="height: 70%; width: 100%; padding: 10px;">
                <div id="container" class="easyui-panel" fit="true">
                    
                </div>
                <div class="easyui-window" data-options="closed: true">
                    <table id="dt">
                        <thead>
                            <tr>
                                <th>Prices</th>
                                <th>Sales</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                rs.beforeFirst();
                                while (rs.next())
                                {
                                    %>
                                    <tr>
                                        <td><%=rs.getDouble(2)%></td>
                                        <td><%=rs.getDouble(3)%></td>
                                    </tr>
                                    <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div><br/>
            <div class="easyui-panel" title="Regression Coefficients" style="height: auto; width: 100%; padding: 10px;">
                <table width="100%" cellpadding="5" cellspacing="5" border="1" style="border-collapse: collapse">
                    <tr>
                        <th align="center" width="33%" style="background-color: black; color: white">Intercept</td>
                        <th align="center" width="33%" style="background-color: black; color: white">Slope</td>
                        <th align="center" style="background-color: black; color: white">Correlation Coefficient</td>
                    </tr>
                    <tr>
                        <td align="center" id="intercept"><%= Math.round(lr.intercept()*100.0)/100.0%></td>
                        <td align="center" id="slope"><%= Math.round(lr.slope()*100.0)/100.0%></td>
                        <td align="center"><%= Math.round(lr.R2()*100.0)/100.0%></td>
                    </tr>
                </table><br/><br/>
                <table width="100%" cellpadding="5" cellspacing="5" border="1" style="border-collapse: collapse">
                    <tr>
                        <td align="center" width="25%">Enter Price to predict sales:</td>
                        <td align="center" width="25%"><input type="text" id="prc" value="0"/></td>
                        <td align="center" width="25%"><input type="button" value="Predict" onclick="GetVal();"/></td>
                        <td align="center"><input type="text" id="sls" readonly="readonly"/></td>
                    </tr> 
                </table>
            </div>
        </div>

    </body>
</html>
