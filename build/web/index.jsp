
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
    String email = request.getAttribute("email").toString();
    System.out.println("Email From Index : " + email);
    Usermaster um = dm.getName(email);
%>

<html> 
    <head>
        <meta charset="utf-8"/>
        <link rel="icon" href="images/logo1.png">
        <link type="text/css" rel="stylesheet" href="easyui/themes/black/easyui.css"/>
        <link type="text/css" rel="stylesheet" href="css/fa-svg-with-js.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css?family=Coiny|Concert+One|Pacifico|ZCOOL+XiaoWei" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=PT+Sans:700i" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>

        <title style="background-color: #1F2C35;text-shadow: 2px 2px 2px grey;color: #171a1d;font-family: 'Concert One', cursive; font-size: 20pt;text-align:center;vertical-align: top;">Green Invoice</title>
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
                color: black /* #AACCFF;*/

            }
            #x:hover{
                background-color: grey;
                -webkit-filter: drop-shadow(5px 5px 5px #222); filter: drop-shadow(5px 5px 5px #222);
                /* color: black;*/
            }
            img:hover{
                
            }
            td:hover{
                
            }
            /*head { 
                display: block; 
            }
            title { 
                display: block; font-size: 200%; font-weight: bold; 
            }*/
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
                        table: 'dtAo'
                    },
                    chart: {
                        type: 'pie'
                                /*backgroundColor: '#FFFFFF',
                                 style: {
                                 color: '#999'
                                 }*/
                    },
                    legend: {
                        enabled: true
                    },
                    plotOptions: {
                        pie: {
                            dataLabels: {
                                enabled: false
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
                    title: 'Inventory Report',
                    pagination: true,
                    pageSize: 15,
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
        <div data-options="region: 'north', border: false" style="height: 50px; padding: 0px; overflow: hidden">
            <!--table width="100%" style="border-collapse: collapse; background-color: #1F2C35;" border="0" cellpadding="10"-->
            <table width="100%" style="border-collapse: collapse; background-color: #000;" border="0" cellpadding="10">
                <tr>
                    <td align="center" style="width: 8%"><img src="images/logo1.png" style="width: 30px;height: 30px;-webkit-filter: drop-shadow(2px 2px 2px #888); filter: drop-shadow(2px 2px 2px #888);"/></td>
                    <td style="width: 17%;background-color: #000;color: greenyellow;font-family: 'PT Sans', cursive; font-size: 20pt;text-align:center;vertical-align: top;">Green Invoice</td>
                    
                    <!--td style="width: 1%;"><i class="fa fa-tachometer-alt fa-inverse"></i></td>
                    <td style="width: 70%;"><span style="font-family: Calibri;"> Dashboard </span></td-->
                    
                    <td style="width: 69%; text-align: right; font-family: 'Coiny', cursive;"><a href="#" class="easyui-menubutton" data-options="menu:'#mm1',iconCls:'icon-edit'"><%= um.getName()%></a></td>
                    <!--td style="width: 2%;"><a class="easyui-tooltip" title="Messages" href="#"><i class="fa fa-envelope fa-inverse"></i></a></td>
                    <td style="width: 2%; text-shadow: 2px 2px;"><i class="fa fa-chart-pie fa-inverse"></i></td>
                    <td style="width: 2%;"><i class="fa fa-comments fa-inverse"></i></td-->
                    <!--td style='width: 3%;'><!--i class="fa fa-user fa-inverse"></i><img src='images/user.png' style="width: 20px;"/></td-->
                </tr>
            </table>
                   
                    <div id="mm1" style="width:150px;">
                        <div><a href="http://localhost:8084/GreenInvoice">Logout</a></div>
                        <!--div><button type="button" data-toggle="modal" data-target="#exampleModal">Change Password</button></div-->
                        <div><a href="#" data-target="#exampleModal" data-toggle="modal">Change Password</a></div>
                    </div>
                    
 
        </div>
        <div data-options="region: 'west', border: false, split: false, collapsible: true" style="border-top: 1pt solid #2B2A47; width: 150px;background-color: #1F2C35;;background-image: url(images/logo.png);background-size: 100%; background-repeat:  no-repeat; background-position-y: bottom; ">
            <table width="100%" border="0" cellpadding="5" cellspacing="0" style="font-family: Calibri; vertical-align: middle; font-size: 10pt">
                <!--tr>
                    <td></td>
                </tr-->
                <tr>
                    <td colspan="2" align="center" style="background-color: black;border-top: 1pt solid #000;border-bottom: 1pt solid #555;">REPORTS</td>
                </tr>
                <tr align="left">
                    <!--td style="background-color: #A1A2A3;"><i class="fa fa-tachometer-alt fa-inverse"></i><span style="margin-left: 17px;">Dashboard</span></td-->
                    <td id='x'><a href="GetPage?flNm=dashboard.jsp&email=<%=email%>" target="ifrm"><i class="fa fa-tachometer-alt fa-inverse"></i><span style="margin-left: 17px;">Dashboard</span></a></td>
                </tr>
                <!--tr align="left">
                    <td id='x'><img src="images/orders.png" style="width: 15px;vertical-align: middle;"/> <span style="margin-left: 15px;">Orders</span></td>
                </tr-->
                <tr align="left">
                    <td id='x'><a href="GetPage?flNm=inventory.jsp&email=<%=email%>" target="ifrm"><img src="images/inventory.png" style="width:15px; vertical-align: middle;"/> <span style="margin-left: 15px;">Inventory report</span></a></td>
                </tr>
                <tr align="left">
                    <td id='x'><a href="GetPage?flNm=receipts.jsp&email=<%=email%>" target="ifrm"><img src="images/receipts.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Receipts</span></a></td>
                </tr>
                
                <tr>
                    <td colspan="2" align="center" style="background-color: black;border-top: 1pt solid #555;border-bottom: 1pt solid #555;">TRANSACTIONS</td>
                </tr>
                <tr align="left">
                    <td id='x'><a href="GetPage?flNm=purchase.jsp&email=<%=email%>" target="ifrm"><img src="images/buy.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Purchase</span></a></td>
                </tr>
                <tr align="left">
                    <td id='x'><a href="GetPage?flNm=sales.jsp&email=<%=email%>" target="ifrm"><img src="images/sell1.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Sell</span></a></td>
                </tr>
                <tr align="left">
                    <td id='x'><a href="GetPage?flNm=regDisp.jsp&email=<%=email%>" target="ifrm"><img src="images/prediction.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Prediction</span></a></td>
                </tr>
                <!--tr align="left">
                    <td id='x'><a href="GetPage?flNm=receivePayment.jsp&email=<%=email%>" target="ifrm"><img src="images/invoice.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Receive Payment</span></a></td>
                </tr-->
                <tr>
                    <td colspan="2" align="center" style="background-color: black;border-top: 1pt solid #555;border-bottom: 1pt solid #555;">MASTER RECORDS</td>
                </tr>
                <tr align="left">
                    <td id='x'><a href="GetPage?flNm=chem.jsp&email=<%=email%>" target="ifrm"><img src="images/chemicals.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Chemicals</span></a></td>
                </tr>
                <tr align="left">
                    <td id='x'><a href="GetPage?flNm=glass.jsp&email=<%=email%>" target="ifrm"><img src="images/glass.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Glassware</span></a></td>
                </tr>
                <tr align="left">
                    <td id='x'><a href="GetPage?flNm=instrument.jsp&email=<%=email%>" target="ifrm"><img src="images/oven.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Instruments</span></a></td>
                </tr>
                <tr align="left">
                    <td id='x'><a href="GetPage?flNm=party.jsp&email=<%=email%>" target="ifrm"><img src="images/party.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Parties</span></a></td>
                </tr>
                <tr align="left">
                    <td id='x'><a href="GetPage?flNm=user.jsp&email=<%=email%>" target="ifrm"><img src="images/user.png" style="width: 20px; vertical-align: middle;"/> <span style="margin-left: 10px;">Users</span></a></td>
                </tr>
                
            </table>
        </div>
        <div data-options="region: 'center', border: false" style="border-top: 1pt solid #888;padding: 0px;background: linear-gradient(white,lightgrey);overflow: hidden;">
            <iframe name="ifrm" style="width: 100%; height: 100%; overflow: hidden; border: 0pt" src="GetPage?flNm=dashboard.jsp&email=<%=email%>"></iframe>
            
        </div>
            <!-- Modal -->
            
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document" style="color:whitesmoke">
                     <div class="modal-content" style="background-color:#1F2C35;">
                            <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Change Password</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                                    <div class="modal-body form-horizontal">
                                        <div class="container">
                                        <form method="post" action="changepwd">

                                        <input type="hidden" name="email" value="<%=email%>"/>
                                        <div class="row">
                                            <div class="col-5">
                                                <label for="current_password">Current Password</label>
                                            </div>
                                            <div class="col-7">
                                                <input style="background-color:inherit" type="password" class="form-control" name="current_password" placeholder="Current Password" required="true">
                                            </div>
                                        </div>
<!--                                      <div class="control-group form-group row">
                                          <label for="current_password" class="col-sm-2 col-form-label control-label">Current Password</label>
                                          <div class="controls col-sm-10">
                                              <input type="password" class="form-control" name="current_password">
                                          </div>
                                      </div>-->
<br>
                                       <div class="row">
                                            <div class="col-5">
                                                <label for="new_password">New Password</label>
                                            </div>
                                            <div class="col-7">
                                              <input style="background-color:inherit" type="password" class="form-control" name="new_password" id="new_password" placeholder="New Password" required="true">
                                            </div>
                                        </div>
<br>
                                       <div class="row">
                                            <div class="col-5">
                                                <label for="confirm_password">Confirm Password</label>
                                            </div>
                                            <div class="col-7">
                                              <input style="background-color:inherit" type="password" class="form-control" name="confirm_password" id="confirm_password" placeholder="Confirm Password" required="true">
                                            </div>
                                        </div>
<br>
<div align="right">
    <input type="button" value="Close" class="btn btn-outline-info" data-dismiss="modal"/>
    <input type="submit" id="submit" value="Save Password" class="btn btn-outline-success"/>
</div>
                                        
                                           </form>

                                    </div>    
                                        </div>
                                        
                                
                                         
                        
                    </div>
                </div>
            </div>
                                                         

                    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
                    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
                    <script>
                
                            $('#submit').on('click',function(){
                                if($('#new_password').val() != $('#confirm_password').val()){
                                    alert("Passwords does not match!");
                                    $('#new_password').focus()
                                    return false;
                                }else{
                                    return true;
                                }
                            });
                    </script>
    </body>
    
</html>
