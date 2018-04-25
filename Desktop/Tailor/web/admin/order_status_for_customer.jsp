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
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=customer"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <%
                                    String customer_id = request.getParameter("customerid");
                                    String customer_name = null;
                                %>                                
                                <h4>Customer id : <%= customer_id%></h4>
                            </div>
                            <%
                                // select customer name from customer 
                                try {
                                    String sql_customer_name = "select * from customer where cus_customer_id = '" + customer_id + "' ";
                                    PreparedStatement pst_cust_name = DbConnection.getConn(sql_customer_name);
                                    ResultSet rs_cust_name = pst_cust_name.executeQuery();
                                    if (rs_cust_name.next()) {
                                        customer_name = rs_cust_name.getString("cus_name");
                                    }
                                } catch (Exception e) {
                                    out.println(e.toString());
                                }
                            %>
                            <div class="panel-body">
                                <div class="box-body table-responsive">
                                    <%
                                        try {
                                            String sql_all_order_of_customer = "select * from ad_order where ord_cutomer_id = '" + customer_id + "'  and ord_bran_id = '" + branch_id + "'  ";

                                            PreparedStatement pst_all_order_of_customer = DbConnection.getConn(sql_all_order_of_customer);
                                            ResultSet rs_all_order_of_customer
                                                    = pst_all_order_of_customer.executeQuery();
                                            if (rs_all_order_of_customer.next()) {
                                    %>
                                    <table id="DataTable" class="table table-bordered table-hover" style="width: 61%">
                                        <thead>
                                            <h4 style="color: black">Customer Name :: <%= customer_name%></h4>
                                            <tr>
                                                <th style="text-align: center">Sl</th>
                                                <th style="text-align: center">Order ID</th>
                                                <th style="text-align: center">Status</th>                                      

                                                <th style="text-align: center">Price</th>
                                                <th style="text-align: center">View</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <%
                                                int sl = 1;
                                                try {
                                                    String sql_all_order_of_customers = "select * from ad_order where ord_cutomer_id = '" + customer_id + "'  and ord_bran_id = '" + branch_id + "'  ";

                                                    PreparedStatement pst_all_order_of_customers = DbConnection.getConn(sql_all_order_of_customers);
                                                    ResultSet rs_all_order_of_customers = pst_all_order_of_customer.executeQuery();
                                                    while (rs_all_order_of_customers.next()) {
                                                        String ord_id = rs_all_order_of_customers.getString("ord_order_id");
                                                        String ord_status = rs_all_order_of_customers.getString("ord_status");
                                                        String ord_total_price = rs_all_order_of_customers.getString("ord_total_price");
                                                        if (ord_status.equals("1")) {
                                                            ord_status = "pending....";
                                                        } else if (ord_status.equals("2")) {
                                                            ord_status = "Receive";
                                                        } else if (ord_status.equals("3")) {
                                                            ord_status = "Processing...";
                                                        } else if (ord_status.equals("4")) {
                                                            ord_status = "Complete";
                                                        } else if (ord_status.equals("5")) {
                                                            ord_status = "Delivered.";
                                                        }else if(ord_status.equals("0")){
                                                            ord_status = "Processing..";
                                                        }
                                            %>
                                            <tr>
                                                <td style="text-align: center; width: 6%;"><%= sl++%></td>
                                                <td style="text-align: center; width: 10%;"><%=  ord_id%></td>
                                                <td style="text-align: center; width: 20%;"><%=  ord_status%></td>
                                                <td style="text-align: right; width: 15%;"><%=  ord_total_price + "0"%></td>
                                                <td style="text-align: center; width: 10%;"><a href="customer_order_details.jsp?takeorderid=<%=ord_id%>" style="text-decoration: none"><button class="btn btn-primary"><span class="glyphicon glyphicon-eye-open"></span></button></a></td>
                                            </tr>
                                            <%
                                                    }
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                    <%
                                    } else {
                                    %>
                                    <center> <span class="" style="color: red; font-size: 20px">No Result found</span></center>
                                        <%
                                                }
                                            } catch (Exception e) {
                                            }
                                        %>
                                </div>          
                            </div>                            
                        </div>                                                    <!-- /. PAGE INNER  -->
                    </div>                                                    <!-- /. PAGE WRAPPER  -->
                </div>
            </div>
        </div>
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
