
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="greenInvoice.maps.Usermaster"%>
<%@page import="greenInvoice.control.Controller"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="greenInvoice.maps.Chemicals"%>
<%@page import="greenInvoice.data.DataMan"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Controller dm = new Controller();
    ArrayList<Chemicals> products = dm.getChems();
    Iterator i = products.iterator();
    String yrCnt[][] = dm.getMakeGlass(); //dm.getYrCnt();
    String email = request.getParameter("email").toString();
    System.out.println("Email From dashboard : " + email);
    Usermaster um = dm.getName(email);
    
    DecimalFormat formatter = new DecimalFormat("##,##,###");
    
    double units[] = dm.getDashData();
    
%>

<html> 
    <head>
        <meta charset="utf-8"/>
        <title>Green Invoice: Dashboard</title>
        <link type="text/css" rel="stylesheet" href="easyui/themes/black/easyui.css"/>
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
            function loadChart(d)
            {
                Highcharts.theme = {
                    colors: ['#2b908f', '#90ee7e', '#f45b5b', '#7798BF', '#aaeeee', '#ff0066',
                        '#eeaaee', '#55BF3B', '#DF5353', '#7798BF', '#aaeeee'],
                    chart: {
                        backgroundColor: {
                            linearGradient: {x1: 0, y1: 0, x2: 1, y2: 1},
                            stops: [
                                [0, '#2a2a2b'],
                                [1, '#3e3e40']
                            ]
                        },
                        style: {
                            fontFamily: '\'Unica One\', sans-serif'
                        },
                        plotBorderColor: '#606063'
                    },
                    title: {
                        style: {
                            color: '#E0E0E3',
                            textTransform: 'uppercase',
                            fontSize: '20px'
                        }
                    },
                    subtitle: {
                        style: {
                            color: '#E0E0E3',
                            textTransform: 'uppercase'
                        }
                    },
                    xAxis: {
                        gridLineColor: '#707073',
                        labels: {
                            style: {
                                color: '#E0E0E3'
                            }
                        },
                        lineColor: '#707073',
                        minorGridLineColor: '#505053',
                        tickColor: '#707073',
                        title: {
                            style: {
                                color: '#A0A0A3'

                            }
                        }
                    },
                    yAxis: {
                        gridLineColor: '#707073',
                        labels: {
                            style: {
                                color: '#E0E0E3'
                            }
                        },
                        lineColor: '#707073',
                        minorGridLineColor: '#505053',
                        tickColor: '#707073',
                        tickWidth: 1,
                        title: {
                            style: {
                                color: '#A0A0A3'
                            }
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.85)',
                        style: {
                            color: '#F0F0F0'
                        }
                    },
                    plotOptions: {
                        series: {
                            dataLabels: {
                                color: '#B0B0B3'
                            },
                            marker: {
                                lineColor: '#333'
                            }
                        },
                        boxplot: {
                            fillColor: '#505053'
                        },
                        candlestick: {
                            lineColor: 'white'
                        },
                        errorbar: {
                            color: 'white'
                        }
                    },
                    legend: {
                        itemStyle: {
                            color: '#E0E0E3'
                        },
                        itemHoverStyle: {
                            color: '#FFF'
                        },
                        itemHiddenStyle: {
                            color: '#606063'
                        }
                    },
                    credits: {
                        style: {
                            color: '#666'
                        }
                    },
                    labels: {
                        style: {
                            color: '#707073'
                        }
                    },
                    drilldown: {
                        activeAxisLabelStyle: {
                            color: '#F0F0F3'
                        },
                        activeDataLabelStyle: {
                            color: '#F0F0F3'
                        }
                    },
                    navigation: {
                        buttonOptions: {
                            symbolStroke: '#DDDDDD',
                            theme: {
                                fill: '#505053'
                            }
                        }
                    },
                    // scroll charts
                    rangeSelector: {
                        buttonTheme: {
                            fill: '#505053',
                            stroke: '#000000',
                            style: {
                                color: '#CCC'
                            },
                            states: {
                                hover: {
                                    fill: '#707073',
                                    stroke: '#000000',
                                    style: {
                                        color: 'white'
                                    }
                                },
                                select: {
                                    fill: '#000003',
                                    stroke: '#000000',
                                    style: {
                                        color: 'white'
                                    }
                                }
                            }
                        },
                        inputBoxBorderColor: '#505053',
                        inputStyle: {
                            backgroundColor: '#333',
                            color: 'silver'
                        },
                        labelStyle: {
                            color: 'silver'
                        }
                    },
                    navigator: {
                        handles: {
                            backgroundColor: '#666',
                            borderColor: '#AAA'
                        },
                        outlineColor: '#CCC',
                        maskFill: 'rgba(255,255,255,0.1)',
                        series: {
                            color: '#7798BF',
                            lineColor: '#A6C7ED'
                        },
                        xAxis: {
                            gridLineColor: '#505053'
                        }
                    },
                    scrollbar: {
                        barBackgroundColor: '#808083',
                        barBorderColor: '#808083',
                        buttonArrowColor: '#CCC',
                        buttonBackgroundColor: '#606063',
                        buttonBorderColor: '#606063',
                        rifleColor: '#FFF',
                        trackBackgroundColor: '#404043',
                        trackBorderColor: '#404043'
                    },
                    // special colors for some of the
                    legendBackgroundColor: 'rgba(0, 0, 0, 0.5)',
                    background2: '#505053',
                    dataLabelsColor: '#B0B0B3',
                    textColor: '#C0C0C0',
                    contrastTextColor: '#F0F0F3',
                    maskColor: 'rgba(255,255,255,0.3)'
                };
            Highcharts.setOptions(Highcharts.theme);
            Highcharts.chart('aoDt', {
                data: {
                    table: 'dtAo',
                    sliced: true
                },
                chart: {
                    type: 'pie'
                    /*backgroundColor: '#FFFFFF',
                    style: {
                        color: '#999'
                    }*/
                },
                legend: {
                    enabled: false
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: true
                        },
                        enableMouseTracking: true,
                        showInLegend: true
                    }
                
                },
                credits: {
                    enabled: false
                },
                title: {
                    text: 'Types of Glassware'
                },
                yAxis: {
                    title: {
                        text: 'Count'
                    }
                }
            });
            Highcharts.setOptions(Highcharts.theme);
            Highcharts.chart('container', {
                data: {
                    table: 'dt'
                },
                legend: {
                    enabled: false
                },
                chart: {
                    type: 'column'
                    /*backgroundColor: '#FFFFFF',
                    style: {
                        color: '#999'
                    }*/
                },
                plotOptions: {
                    column: {
                        dataLabels: {
                            enabled: false
                        },
                        enableMouseTracking: true
                    }
                },
                credits:
                        {
                            enabled: false
                        },
                title: {
                    text: 'Prices of Chemicals'
                },
                yAxis: {
                    allowDecimals: true,
                    title: {
                        text: 'Units'
                    }
                }
            });
            Highcharts.chart('pieChart', {
                data: {
                    table: 'dt'
                },
                credits: {
                    enabled: false
                },
                chart: {
                    type: 'pie'
                    /*backgroundColor: '#FFFFFF',
                    style: {
                        color: '#AAAAAA'
                    }*/
                },
                title: {
                    text: 'Items in Inventory'
                }
            });
            }
            $(function () {
                $("#prt").portal({
                    border: false,
                    width: '100%',
                    height: '50%'
                });
                $("#prt1").portal({
                    border: false,
                    width: '100%',
                    height: '50%'
                });

                $("#invTab").datagrid({
                    url: 'GetDashChart',
                    title: 'Chemicals Inventory',
                    pagination: true,
                    pageSize: 10,
                    pageList: [1, 2, 3, 4, 5, 10, 15, 20]
                });
                /*$('#invTab').pagination({
                 pageList: [5, 10, 20, 50]
                 });*/
                loadChart('test');
            });
        </script>
    </head>
    <body class="easyui-layout">
        
        <div data-options="region: 'center', border: false" style="padding: 0px;background: linear-gradient(white,lightgrey);overflow: hidden;">
            <div id="prt" style="height: 5%;">
                <div style="width: 25%;">
                    <div style="height:90px; overflow: hidden; border: 0pt; background: linear-gradient(#16A086,#118E74);text-align: center;vertical-align: text-bottom;" data-options="shadow: true">
                        <table width="100%" border="0" cellpadding="5">
                            <tr>
                                <td rowspan="1" width="50%"><img src="images/chemicals.png" style="-webkit-filter: drop-shadow(5px 5px 5px #222); filter: drop-shadow(5px 5px 5px #222);width:50%;"/></td>
                                <td align="left"><h1 style="font-family: Calibri; color: white;margin-top: 0px;text-shadow: 2px 2px 5px black;"><%= formatter.format(units[0]) %></h1><br/>
                                    <h4  style="font-family: Calibri; color: white; margin-top: -20px;text-shadow: 2px 2px 5px black;">Chemicals stock</h4>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div style="width: 25%;">
                    <div style="height: 90px;overflow: hidden;border: 0pt;background: linear-gradient(#297FB8, #256D9C);border: 0pt; text-align: center; border-radius: 2pt;">
                        <table width="100%" border="0" cellpadding="5">
                            <tr>
                                <td width="50%"><img src="images/glass.png" style="-webkit-filter: drop-shadow(5px 5px 5px #222); filter: drop-shadow(5px 5px 5px #222);width: 50%;opacity: 1;"/></td>
                                <td align="left"><h1 style="font-family: Calibri; color: white;margin-top: 0px;text-shadow: 2px 2px 5px black;"><!--i class="fa fa-rupee-sign fa-inverse"></i--> <%= formatter.format(units[1])%></h1>
                                    <h4  style="font-family: Calibri; color: white; margin-top: -10px;text-shadow: 2px 2px 5px black;">Glassware stock</h4>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div style="width: 25%;">
                    <div  style="height: 90px;overflow: hidden;border: 0pt; text-align: center;background: linear-gradient(#C1392B, #972D20)">
                        <table width="100%" border="0" cellpadding="5">
                            <tr>
                                <td width="50%"><img src="images/oven.png" style="-webkit-filter: drop-shadow(5px 5px 5px #222); filter: drop-shadow(5px 5px 5px #222);width: 50%;opacity: 1;"/></td>
                                <td align="left"><h1 style="font-family: Calibri; color: white;margin-top: 0px;text-shadow: 2px 2px 5px black;"><%= formatter.format(units[2])%></h1>
                                    <h4  style="font-family: Calibri; color: white; margin-top: -10px;text-shadow: 2px 2px 5px black;">Instrument stock</h4>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div style="width: 25%;">
                    <div  style="height: 90px;overflow: hidden;border: 0pt;background: linear-gradient(#27AE61,#17974D); text-align: center;">
                        <table width="100%" border="0" cellpadding="5">
                            <tr>
                                <td width="50%"><img src="images/receivable.png" style="-webkit-filter: drop-shadow(5px 5px 5px #222); filter: drop-shadow(5px 5px 5px #222);width: 50%;opacity: 1;margin-top: -10px;"/></td>
                                <td align="left"><h1 style="font-family: Calibri; color: white;margin-top: 0px;text-shadow: 2px 2px 5px black;"><i class="fa fa-rupee-sign fa-inverse" style="-webkit-filter: drop-shadow(5px 5px 5px #222); filter: drop-shadow(5px 5px 5px #222);"></i>&nbsp;<%= formatter.format(units[3])%></h1>
                                    <h4  style="font-family: Calibri; color: white; margin-top: -10px;text-shadow: 2px 2px 5px black;">Total Receivables</h4>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div id="prt1" style="height: 100%;">
                <div class="easyui-window" data-options="closed: true">
                    <table id="dt">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Prices</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                while (i.hasNext()) {
                                    Chemicals product = (Chemicals) i.next();
                            %>
                            <tr>
                                <th><%= product.getProductcode()%></th>
                                <td><%= product.getPrice()%></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                    <table id="dtAo" style="height: 270px;">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Count</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int k = 0; k < yrCnt.length; k++) {
                            %>
                            <tr>
                                <th><%= yrCnt[k][0].toUpperCase() %></th>
                                <td><%= yrCnt[k][1] %></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <div style="width: 50%">
                    <div id="container"  style="padding: 5px;box-shadow: 10px 10px 10px; height: 190px;background-color: #FEFEFE;">
                    </div>
                    <!--div id="InventoryList" style="height: 200px;font-family: Calibri;">
                        <table id="invTab" style="width: 100%; height: 100%;" class="easyui-datagrid">
                            <thead>
                                <tr>
                                    <th data-options="field:'productcode'">Product ID</th>
                                    <th data-options="field:'productdesc'" style="width: 70%;">Description</th>
                                    <th data-options="field:'specification'" style="width: 10%;">HSN Code</th>
                                    <th data-options="field:'packsize'">Pack</th>
                                    <th data-options="field:'price'" style="width: 05%;">Price (INR)</th>
                                    <th data-options="field:'gst'" style="width: 05%;">GST</th>
                                </tr>
                            </thead>
                        </table>
                    </div-->
                    <div id="aoDt" style="padding: 5px;box-shadow: 10px 10px 10px;height: 255px;font-family: Calibri;">
                    </div>
                </div>
                <div style="width: 50%">
                    <div id="InventoryList" style="height: 455px;font-family: Calibri;">
                        <table id="invTab" style="width: 100%; height: 100%;" class="easyui-datagrid">
                            <thead>
                                <tr>
                                    <th data-options="field:'productcode'">Product ID</th>
                                    <th data-options="field:'productdesc'" style="width: 60%;">Description</th>
                                    <th data-options="field:'specification'" style="width: 10%;">HSN Code</th>
                                    <th data-options="field:'packsize'">Pack</th>
                                    <th data-options="field:'price'" style="width: 05%;">Price (INR)</th>
                                    <th data-options="field:'gst'" style="width: 05%;">GST</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <!--div  id="pieChart" style="height: 250px;font-family: Calibri;" data-options="shadow: true">
                    </div>
                    <div id="aoDt" style="height: 200px;font-family: Calibri;">
                    </div-->
                </div>
            </div>
        </div>
    </body>
</html>
