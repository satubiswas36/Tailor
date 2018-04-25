<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String logger = (String) session.getAttribute("logger");
    String branch_id = (String) session.getAttribute("user_bran_id");
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




<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Tailor</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta charset="utf-8"/>
        <meta contenteditable="utf8_general_ci"/>
        <!--        <meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="shortcut icon" type="image/x-icon" href="../admin/assets/img/t_mechin.jpg"/>
        <link href="/Tailor/admin/assets/css/bootstrap.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/css/font-awesome.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />       
        <link href="/Tailor/admin/assets/css/custom.css" rel="stylesheet" />      
        <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/dataTables.jqueryui.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/dataTables.uikit.min.css" rel="stylesheet" type="text/css"/>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />        
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <!--        <link href="assets/css/bootstrap.css" rel="stylesheet" type="text/css"/>
                <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>-->


        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />        
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script src="http://mymaplist.com/js/vendor/TweenLite.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
        <link rel="stylesheet" href="/resources/demos/style.css"/>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    </head>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=customer" flush="true"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">                    
                    <div class="panel panel-default">
                        <div class="panel-heading" style="height: 50px;">
                            <h4>View All Customer</h4>
                        </div>
                        <div class="panel-body">
                            <table class="table table-striped table-bordered" style="width: 100%;" id="mydata">
                                <thead>                                    
                                    <tr>
                                        <th style="text-align: center; width: 5%">SL</th>
                                        <th style="text-align: center">Name</th>
                                        <th style="text-align: center; width: 15%;">Mobile</th>
                                        <th style="text-align: center">Reference</th>                                        
                                        <th style="text-align: center; width: 15%;">Order Status</th>                                        
                                    </tr>
                                </thead>
                                <tbody>                                    
                                    <%
                                        double total_balance = 0;
                                        int sl = 1;
                                        try {
                                            String cus_details = "select * from customer where cus_bran_id = '" + branch_id + "'  order by cus_name asc";
                                            PreparedStatement pst_details = DbConnection.getConn(cus_details);
                                            ResultSet rs_details = pst_details.executeQuery();
                                            while (rs_details.next()) {                                               
                                                
                                                String customer_id = rs_details.getString("cus_customer_id");
                                                String customer_references = rs_details.getString("cus_reference");
                                                if (customer_references == "" || customer_references == null) {
                                                    customer_references = "nobody";
                                                }
                                    %>                                   
                                    <tr>
                                        <td style="text-align: center"><%= sl++%></td>
                                        <td style="text-align: left"> <img src="../images/<%=rs_details.getString("cus_pic")%>" alt="" style="height: 50px; width: 50px;"/><%= rs_details.getString("cus_name")%></td>
                                        <td style="text-align: center"><%= rs_details.getString("cus_mobile")%></td>
                                        <td style="text-align: left"><%= customer_references%></td>
                                        <!--------------------------------------------------------------------- check balance------------------------->
                                        <%
                                            double balance = 0;
                                            try {
                                                String sql_payment_statement = "select * from account where acc_bran_id = '"+session.getAttribute("user_bran_id")+"' and acc_customer_id = " + customer_id;
                                                PreparedStatement pst_payment_statement = DbConnection.getConn(sql_payment_statement);
                                                ResultSet rs_payment_statement = pst_payment_statement.executeQuery();
                                                while (rs_payment_statement.next()) {
                                                    String Debit = rs_payment_statement.getString("acc_debit");
                                                    double acc_debit = Double.parseDouble(Debit);
                                                    String Credit = rs_payment_statement.getString("acc_credit");
                                                    double acc_credit = Double.parseDouble(Credit);
                                                    balance = balance + (acc_credit - acc_debit);
                                                }
                                                total_balance += balance;
                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            }
                                        %>                                        
                                        <td style="text-align: center"><a href="order_status_for_customer.jsp?customerid=<%= customer_id%>" style="text-decoration: none"><button class="btn btn-primary"><span class="glyphicon glyphicon-eye-open"></span></button></a></td>

                                    </tr>

                                    <%
                                            }

                                        } catch (Exception e) {
                                            out.println(e.toString());
                                        }
                                    %>
                                </tbody>
                            </table>                            
                        </div>                            
                    </div>                                                    <!-- /. PAGE INNER  -->
                </div>                                                    <!-- /. PAGE WRAPPER  -->
            </div>
        </div>
        <script src="assets/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>
        <script>
            $("#mydata").dataTable({
                "pagingType": "simple_numbers",
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search..."
                }
            });
        </script>              
    </body>
</html>
