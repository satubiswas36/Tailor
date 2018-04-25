<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String logger = (String) session.getAttribute("logger");
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
<%
    int pageNo = 1;
    String spageNo = request.getParameter("page");
    if (spageNo != null) {
        pageNo = Integer.parseInt(spageNo);
    }
    int start = 0;
    int perpage = 20;
    int currentPage = 1;
    double total_row_table = 0;
    double total_page = 0;
    int totalpage = 0;

    try {
        // total row to table 
        String sql_total_row_table = "select COUNT(*) from customer where cus_bran_id = '" + session.getAttribute("bran_id_b_details") + "' ";
        PreparedStatement pst_total_row = DbConnection.getConn(sql_total_row_table);
        ResultSet rs_total_row = pst_total_row.executeQuery();
        while (rs_total_row.next()) {
            total_row_table = Integer.parseInt(rs_total_row.getString(1));
        }
    } catch (Exception e) {
        out.println(e.toString());
    }
    total_page = total_row_table / perpage;
    totalpage = (int) Math.ceil(total_page);

    if (pageNo == 1) {
        start = 0;
    } else {
        start = perpage * (pageNo - 1);
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

            <%                String bran_name = null;
                try {
                    String sql_bran_name = "select * from user_branch where bran_id = '" + session.getAttribute("bran_id_b_details") + "' ";
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
                                Branch Name :<b> <%= session.getAttribute("bran_name").toString().toUpperCase() %></b>
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
                            int id = 1;
                            id = ((pageNo * perpage) - perpage);
                        %>
                        <%
                            double total_balance = 0;
                            try {
                                String sql_has_customer = "select * from customer where cus_bran_id = '" + session.getAttribute("bran_id_b_details") + "' ";
                                PreparedStatement pst_has_customer = DbConnection.getConn(sql_has_customer);
                                ResultSet rs_has_customer = pst_has_customer.executeQuery();
                                if (rs_has_customer.next()) {
                                    String cus_details = "select * from customer where cus_bran_id = '" + session.getAttribute("bran_id_b_details") + "'  order by cus_name limit " + start + "," + perpage;
                                    PreparedStatement pst_details = DbConnection.getConn(cus_details);
                                    ResultSet rs_details = pst_details.executeQuery();
                        %>
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <h2>Customer Details::</h2>
                                </tr>
                                <tr>
                                    <th style="text-align: center">SL</th>
                                    <th style="text-align: center">Name</th>
                                    <th style="text-align: center">Mobile</th>
                                    <th style="text-align: center">Reference</th>
                                    <th style="text-align: center">Balance</th>                                    
                                    <th style="text-align: center">View</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    while (rs_details.next()) {
                                        id++;
                                        String sl = rs_details.getString(1);
                                        String customer_id = rs_details.getString("cus_customer_id");
                                        String customer_references = rs_details.getString("cus_reference");
                                        if (customer_references == "" || customer_references == null) {
                                            customer_references = "nobody";
                                        }
                                %>
                                <tr>
                                    <td style="text-align: center; width: 5%;"><%= id%></td>
                                    <td style="text-align: center"><%= rs_details.getString("cus_name")%></td>
                                    <td style="text-align: center"><%= rs_details.getString("cus_mobile")%></td>
                                    <td style="text-align: center"><%= customer_references%></td>
                                    <!--------------------------------------------------------------------- check balance------------------------->
                                    <%
                                        double balance = 0;
                                        try {
                                            String sql_payment_statement = "select * from account where acc_customer_id = " + customer_id;
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
                                    <!---------------------------------------------------------------------// check balance------------------------->
                                    <td style="text-align: center"><%= balance%></td>                                    
                                    <td></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td style="text-align: center"><b>Total Amount</b></td>
                                    <!--                                            total balance from account order by branch----------------------------------------------------------->
                                    <%
                                        double total_debit = 0;
                                        double total_credit = 0;
                                        try {
                                            String sql_total_balance = "select * from account where acc_bran_id = '" + session.getAttribute("bran_id_b_details") + "' ";
                                            PreparedStatement pst_total_balance = DbConnection.getConn(sql_total_balance);
                                            ResultSet rs_total_balance = pst_total_balance.executeQuery();
                                            while (rs_total_balance.next()) {
                                                String debit = rs_total_balance.getString("acc_debit");
                                                double d_debit = Double.parseDouble(debit);
                                                total_debit += d_debit;
                                                String credit = rs_total_balance.getString("acc_credit");
                                                double d_credit = Double.parseDouble(credit);
                                                total_credit += d_credit;
                                            }
                                            total_balance = total_credit - total_debit;
                                        } catch (Exception e) {
                                            out.println(e.toString());
                                        }
                                    %>
                                    <!--  --------------------------------------------------//    total balance from account order by branch----------------------------------------------------------->
                                    <td style="text-align: center"><%= total_balance%></td>
                                    <td></td>

                                </tr>
                                <%
                                } else {
                                %>
                                <center> <span style="color: red; font-size: 18px;">Nothing founds</span></center>
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
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
