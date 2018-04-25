
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%
    String logger = (String) session.getAttribute("logger");
    String branch_id = (String) session.getAttribute("user_bran_id");
    String last_status = null;
    String sl_no = null;
%>

<%
    try {

        if (logger != null) {
            if (logger.equals("user")) {
                String ss_id = (String) session.getAttribute("user_user_id");
                if (ss_id == null) {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            } else if (logger.equals("root")) {
                String user_root = (String) session.getAttribute("user_root");
                if (user_root == null) {
                    response.sendRedirect("../index.jsp");
                }
            } else if (logger.equals("company")) {
                String user_com_id = (String) session.getAttribute("user_com_id");
                if (user_com_id == null) {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            } else if (logger.equals("branch")) {
                String user_bran_id = (String) session.getAttribute("user_bran_id");
                if (user_bran_id == null) {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            }
        } else {
            response.sendRedirect("/Tailor/index.jsp");
        }

    } catch (Exception e) {
        out.println(e.toString());
    }
%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Calendar"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Tailor</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta charset="utf-8" />
        <meta contenteditable="utf8_general_ci" />
        <!--        <meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" type="image/x-icon" href="../admin/assets/img/t_mechin.jpg"/>
        <link href="/Tailor/admin/assets/css/bootstrap.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/css/font-awesome.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />       
        <link href="/Tailor/admin/assets/css/custom.css" rel="stylesheet" />      
        <link href="/Tailor/admin/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />        
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script src="http://mymaplist.com/js/vendor/TweenLite.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
        <link rel="stylesheet" href="/resources/demos/style.css" />
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <!--      for time picker-->
        <link href="../admin/assets/css/timedropper.css" rel="stylesheet" type="text/css" />
        <script src="../admin/assets/js/timedropper.js" type="text/javascript"></script>
        <!--    <script src="../admin/assets/js/jquery.js" type="text/javascript"></script>-->
        
        <!------------------- select2-------------------------------->
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2-bootstrap.min.css" />
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.css" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.js"></script>
        <!------------------- select2----------end---------------------->

    </head>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=cost" flush="true"/> 
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 45px">
                                Expend :<span class="payment_status" style="color: green; font-size: 18px; margin-left: 10%"><% if (session.getAttribute("expend_status") != null) {%><%="Successfully added!!"%><%} %></span><%session.removeAttribute("expend_status"); %>
                            </div>
                            <div class="panel-body">
                                <form action="" id="select2Form" class="form-horizontal" method="post">                                    
                                            <div class="form-group">
                                                <label class="col-md-4 control-label" for="expend_description">Description</label>
                                                <div class="col-md-4">
                                                    <input type="text" name="description" id="description" class="form-control" maxlength="40" required=""/>
                                                </div>
                                            </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="payment">Payment</label>
                                        <div class="col-md-4">
                                            <input type="text" name="amount" id="amount" pattern="^[1-9][0-9]*$" class="form-control" maxlength="8"  placeholder="amount" required=""/>
                                        </div>                                        
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="expend_date">Payment Date</label>
                                        <div class="col-md-4">
                                            <%
                                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                Date date = new Date();
                                                String date_f = dateFormat.format(date);
                                            %>
                                            <input type="text" class="form-control" value="<%= date_f%>" name="date" id="date" placeholder="dd-mm-yyyy"   style="height: 40px" required=""/>
                                        </div>
                                        <input type="text" name="page_status" value="expend" id="page_status" style="display: none" />
                                    </div>
                                        <center> <input type="button" class="btn btn-success" id="btnsubmit" value="Submit" /></center>
                                </form>
                            </div>  
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
           
           $("#btnsubmit").click(function(){
               $("#btnsubmit").attr("disabled","disabled");
               var description = $("#description").val();
               var amount = $("#amount").val();
               var date = $("#date").val();
               var page_status = $("#page_status").val();
               
               if(description == ""){
                   alert("Please enter description");
                   $("#btnsubmit").removeAttr("disabled");
                   return false;
               }
               if(amount == ""){
                   alert("Please enter amount");
                  $("#btnsubmit").removeAttr("disabled");
                   return false;
               }
               if(isNaN(amount)){
                   alert("Amount must be number");
                   $("#btnsubmit").removeAttr("disabled");
                   return false;
               }
               
               $.ajax({
                   type: 'POST',
                   url: "/Tailor/Expend",
                   data: {
                       "description":description,
                       "amount":amount,
                       "date":date,
                       "page_status":page_status
                   },
                   success: function (data, textStatus, jqXHR) {
                        $("#description").val("");
                        $("#amount").val("");
                        $("#date").val("");
                        $("#btnsubmit").removeAttr("disabled");
                        alert("Successfully Inserted");
                    }
               });
           });

            $(function () {
                $("#date").datepicker({
                    dateFormat: "yy-mm-dd",
                    maxDate: 0
                });
            });

            $(function () {
                $(".payment_status").fadeIn("slow").delay(3000).fadeOut("slow");
            });

        </script>
        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <script src="assets/js/bootstrap.min.js"></script>   
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
