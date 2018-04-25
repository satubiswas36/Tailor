<%
    String logger = (String) session.getAttribute("logger");
    String branch_id = (String) session.getAttribute("user_bran_id");

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
    <style>
        .pagination>li>a, .pagination>li>span { border-radius: 50% !important;margin: 0 5px;}
    </style>
    <body>
        <!--   delete all data from temporary-->
        <div id="wrapper">           
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=order" />
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <aside class="right-side">
                        <section class="content">
                            <div class="row">
                                <div class="col-xs-10">
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title">Processing Orders</h3>
                                        </div>        
                                        <div class="box-body table-responsive">                                            
                                            <table id="mydata" class="table table-bordered table-hover" style="width: 100%">
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center; width: 1%;">Sl</th>
                                                        <th style="text-align: left">Order Receiver</th>
                                                        <th style="text-align: center; width: 13%">Order ID</th>
                                                        <th style="text-align: center; width: 18% ;">Status</th>                                                                                                  
                                                        <th style="text-align: right; width: 14%">Price</th>
                                                        <th style="text-align: center; width: 5%;">View</th>

                                                    </tr>
                                                </thead>
                                                <%                                                    String maker_name = request.getParameter("mk_name");
                                                    String maker_oder_id = request.getParameter("ord_id");
                                                %>
                                                <tbody>
                                                    <%                                                        int sl = 1;
                                                        
                                                        try {
                                                            String status_stay = null;
                                                            String sql_show = "select * from ad_order where ord_bran_id = '" + branch_id + "' and ord_status = 0 order by ord_snlo desc";
                                                            PreparedStatement pst_order_show = DbConnection.getConn(sql_show);
                                                            ResultSet rs_order_show = pst_order_show.executeQuery();

                                                            while (rs_order_show.next()) {
                                                                String order_id = rs_order_show.getString("ord_bran_order");
                                                                String order_receive_by = rs_order_show.getString("ord_user_id");
                                                                String status = rs_order_show.getString("ord_status");
                                                                if (status.equals("1")) {
                                                                    status_stay = "Pending....";
                                                                } else if (status.equals("2")) {
                                                                    status_stay = "Receive";
                                                                } else if (status.equals("3")) {
                                                                    status_stay = "Under processing...";
                                                                } else if (status.equals("4")) {
                                                                    status_stay = "complete";
                                                                } else if (status.equals("5")) {
                                                                    status_stay = "Delivered";
                                                                } else if (status.equals("0")) {
                                                                    status_stay = "Processing..";
                                                                }
                                                                String price = rs_order_show.getString("ord_total_price");
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= sl++%></td>
                                                        <td style="text-align: left">
                                                            <%
                                                                try {
                                                                    String sql_user_name = "select * from user_user where user_id = '" + order_receive_by + "' ";
                                                                    PreparedStatement pst_user_name = DbConnection.getConn(sql_user_name);
                                                                    ResultSet rs_user_name = pst_user_name.executeQuery();
                                                                    if (rs_user_name.next()) {
                                                                        String user_name = rs_user_name.getString("user_name");
                                                            %>
                                                            <%= user_name%>
                                                            <%
                                                            } else {
                                                            %>
                                                            <%="Branch"%>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>
                                                        </td>
                                                        <td style="text-align: center"><%= order_id%></td>
                                                        <td style="text-align: center"><%= status_stay%></td>
                                                        <td style="text-align: right"><%= price + "0"%></td>
                                                        <td style="text-align: center"><a href="order_details.jsp?ord_id=<%= order_id%>&customer_id=<%= rs_order_show.getString("ord_cutomer_id")%>" style="text-decoration: none"><button class="btn btn-primary"><span class="glyphicon glyphicon-eye-open"></span></button></a></td>
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
                                    </div>
                                </div>
                            </div>
                        </section>
                    </aside>                                         
                </div>
            </div>
        </div>         
        <!--        <script src="assets/js/jquery.js" type="text/javascript"></script>-->
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
