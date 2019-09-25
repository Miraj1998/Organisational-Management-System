

<%@page import="java.util.Iterator"%>

<%@page import="java.util.ArrayList"%>
<%@page import="greenInvoice.maps.Login"%>
<%@page import="greenInvoice.control.Controller"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Controller c = new Controller();
    ArrayList<Login> logins = c.getCreds();
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="utf-8">
  <title></title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
</head>
<body style="background-color:#1f2c35">
  <div class="container">
    <h1 align='center' style="color:white">Welcome to <a style="color:greenyellow;border-bottom:4px solid green">GreenInvoice</a></h1><br><br><br>
    <div class="row">
      <div class="col-7">
        <h3 class="ml-5" style="color:white">About this System:</h3>
        <ul style="color:white;font-size:17px" align='justify'>
          <p><i class="far fa-arrow-alt-circle-right mr-2"></i>It is an online portal no need to worry about safety of data.</p><br>
          <p><i class="far fa-arrow-alt-circle-right mr-2"></i>Since it is online it gives <b><i>On The Go</i></b> advantage, Your invoice system is accessible from
            anywhere in the world.</p><br>
            <p><i class="far fa-arrow-alt-circle-right mr-2"></i>It demands absolutely zero-maintenance cost. Continuous upgrade and security boost is our responsibility.</p><br>
            <p><i class="far fa-arrow-alt-circle-right mr-2"></i>No fixed investment, is another advantage. You do not pay huge amount and buy it, you pay subscription, on annual
              basis and enjoy the freedom to switch every year.However we trust the system and you would not.</p><br>
            </ul>
          </div>
          <div class="col-5" style="color:white">
            <div class="card" style="background-color:inherit;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 2.9), 0 6px 20px 0 rgba(0, 0, 0, 1.19)">
              <div class="m-3">
                <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                  
                </ul>
                <div class="tab-content" id="pills-tabContent">
                  <div class="tab-pane fade show active" id="pills-login" role="tabpanel" aria-labelledby="pills-login-tab">
                    <p style="font-size:32px">Log In :</p>
                    <hr style="background-color:black">
                    <form class="form-group" action="LoginCheck" method="post">
                      <label for="email" style="font-size:19px">Email:</label>
                      <input type="email" name="email" id="email" style="background-color:inherit;color:white" class="form-control" placeholder="Enter email...">
                      <br>
                      <label for="password" style="font-size:19px">Password:</label>
                      <input type="password" name="pwd" style="background-color:inherit;color:white" id="password" class="form-control" placeholder="Enter password...">
                      <br>
                      <input type="submit" value="Login" style="width:25%" class="btn btn-outline-success">
                      </form>
                  </div>

                  
                </div>
              </div>
            </div>

          </div>

        </div>

      </div>
    
        
</body>
    </html>
