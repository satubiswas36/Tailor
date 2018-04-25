<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String logger = (String) session.getAttribute("logger");
    String balance_status = request.getParameter("balance_status");
%>

<%
    try {

        if (logger != null) {
            if (logger.equals("user")) {
                String ss_id = (String) session.getAttribute("user_user_id");
                if (ss_id == null) {
                    response.sendRedirect("../index.jsp");
                }
            } else if (logger.equals("root")) {
                String user_root = (String) session.getAttribute("user_root");
                if (user_root == null) {
                    response.sendRedirect("../index.jsp");
                }
            } else if (logger.equals("company")) {
                String user_com_id = (String) session.getAttribute("user_com_id");
                if (user_com_id == null) {
                    response.sendRedirect("../index.jsp");
                }
            } else if (logger.equals("branch")) {
                String user_bran_id = (String) session.getAttribute("user_bran_id");
                if (user_bran_id == null) {
                    response.sendRedirect("../index.jsp");
                }
            }
        } else {
            response.sendRedirect("../index.jsp");
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
            <jsp:include page="../menu/menu.jsp"/>
            <!-- /. NAV SIDE  -->
            <%
                String branch_id = request.getParameter("b_id");
                if (session != null) {
                    if (branch_id != null) {
                        session.setAttribute("bran_id_b_details", branch_id);
                    }
                }
                String bran_name = null;
                double total_debit = 0;
                double total_credit = 0;
                double total_balance = 0;
                double debit = 0;
                double credit = 0;
                double balance = 0;
                // for per branch 
                double per_debit = 0;
                double per_credit = 0;
                double total_per_debit = 0;
                double total_per_credit = 0;
                double total_per_balance = 0;
                double per_balance = 0;
            %>
            <%
                try {
                    String sql_bran_name = "select * from user_branch where bran_id = '" + branch_id + "' ";
                    PreparedStatement pst_bran_name = DbConnection.getConn(sql_bran_name);
                    ResultSet rs_bran_name = pst_bran_name.executeQuery();
                    while (rs_bran_name.next()) {
                        bran_name = rs_bran_name.getString("bran_name");
                        if (bran_name != null) {
                            session.setAttribute("bran_name", bran_name);
                        }
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                Branch Name : <b><%if(session != null){%><%= session.getAttribute("bran_name")%><%} %></b>
                            </div>
                            <div class="panel-body">
                                <div class="" style="background: blueviolet">
                                    <center><ul class="nav navbar-nav">                                           
                                            <li><a href="com_order_view_bran.jsp">order view</a></li>
                                            <li><a href="com_all_customer_view.jsp">All Customer</a></li>
                                            <li><a href="com_payment_status.jsp">payment status</a></li>
                                            <li><a href="com_all_user_view.jsp">view all user</a></li>
                                            <li><a href="com_balance_bran.jsp?balance_status=per_branch">balance</a></li>
                                        </ul></center>
                                </div>
                            </div>
                        </div>                        
                    </div>
                    <div class="">

                        <%
                            if (balance_status.equals("all_branch")) {
                        %>
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th style="text-align: center">SL</th>
                                    <th style="text-align: center">Branch Name</th>
                                    <th style="text-align: center">Total Debit</th>
                                    <th style="text-align: center">Total Credit</th>
                                    <th style="text-align: center">Balance</th>
                                </tr>
                            </thead>
                            <%
                                int id = 1;
                                try {
                                    String sql_bran_listby_com = "select * from user_branch where bran_com_id = '"
                                            + session.getAttribute("user_com_id") + "' ";
                                    PreparedStatement pst_bran_listby_com = DbConnection.getConn(sql_bran_listby_com);
                                    ResultSet rs_bran_listby_com = pst_bran_listby_com.executeQuery();
                                    while (rs_bran_listby_com.next()) {
                                        String bracn_id = rs_bran_listby_com.getString("bran_id");
                                        String branch_name = rs_bran_listby_com.getString("bran_name");
                            %>
                            <tr>
                                <td style="text-align: center; width: 5%;"><%= id++ %></td>
                                <td style="text-align: center"><%= branch_name%></td>
                                <%
                                    try {
                                        String sql_acc = "select * from account where acc_bran_id = '" + bracn_id + "'";
                                        PreparedStatement pst_acc = DbConnection.getConn(sql_acc);
                                        ResultSet rs_acc = pst_acc.executeQuery();
                                        while (rs_acc.next()) {
                                            debit = Double.parseDouble(rs_acc.getString("acc_debit"));
                                            total_debit += debit;
                                            credit = Double.parseDouble(rs_acc.getString("acc_credit"));
                                            total_credit += credit;
                                            total_balance = total_balance + (credit - debit);
                                        }
                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                %>
                                <td style="text-align: center"><%= total_debit%></td>
                                <td style="text-align: center"><%= total_credit%></td>
                                <td style="text-align: center"><%= total_balance%></td>
                                <%
                                            total_balance = 0;
                                            total_credit = 0;
                                            total_debit = 0;
                                        }

                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                %>
                            </tr>
                        </table>
                        <%
                            }
                            if (balance_status.equals("per_branch")) {
                        %>
                        <table class="table table-striped table-bordered" style="width: 50%;">
                            <thead>
                                <tr>
                                    <th style="text-align: center; width: 5%;">SL</th>
                                    <th style="text-align: center">Date</th>
                                    <th style="text-align: center">Debit</th>
                                    <th style="text-align: center">Credit</th>
                                    <th style="text-align: center">Balance</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int sl = 0;
                                    try {
                                        String sql_balance_per_branch = "select * from account where acc_bran_id = '"
                                                + session.getAttribute("bran_id_b_details") + "' ";
                                        PreparedStatement pst_balance_per_branch = DbConnection.getConn(sql_balance_per_branch);
                                        ResultSet rs_balance = pst_balance_per_branch.executeQuery();
                                        while (rs_balance.next()) {
                                            sl++;
                                            per_debit = Double.parseDouble(rs_balance.getString("acc_debit"));
                                            total_per_debit += per_debit;
                                            per_credit = Double.parseDouble(rs_balance.getString("acc_credit"));
                                            total_per_credit += per_credit;
                                            total_per_balance = total_per_balance + (per_credit - per_debit);

                                %>
                                <tr>
                                    <td style="text-align: center; width: 6%;"><%= sl%></td>
                                    <td style="text-align: center"><%= rs_balance.getString("acc_pay_date")%></td>
                                    <td style="text-align: center"><%= per_debit%></td>
                                    <td style="text-align: center"><%= per_credit%></td>
                                    <td style="text-align: center"><%= total_per_balance%></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr>
                                    <td style="text-align: center"><b></b></td>
                                    <td style="text-align: center; width: 12%;"><b>Total</b></td>
                                    <td style="text-align: center; width: 10%;"><b><%= total_per_debit%></b></td>
                                    <td style="text-align: center; width: 10%;"><b><%= total_per_credit%></b></td>
                                    <td style="text-align: center; width: 10%;"><b><%= total_per_balance%></b></td>
                                </tr>
                                <%
                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                %>
                            </tbody>
                        </table>
                        <%
                            }
                        %>
                    </div>
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
