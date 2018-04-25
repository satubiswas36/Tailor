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
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp"/>
            <!-- /. NAV SIDE  -->
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
                int id = 1;

                try {
                    // total row to table 
                    String sql_total_row_table = "select COUNT(*) from ad_order where ord_bran_id = '" + session.getAttribute("bran_id_b_details") + "' ";
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

            <%                String bran_name = null;
                try {
                    String sql_bran_name = "select * from user_branch where bran_id = '" + session.getAttribute("bran_id_b_details") + "' ";
                    PreparedStatement pst_bran_name = DbConnection.getConn(sql_bran_name);
                    ResultSet rs_bran_name = pst_bran_name.executeQuery();
                    while (rs_bran_name.next()) {
                        bran_name = rs_bran_name.getString("bran_name");
                        if (bran_name != null) {
                            session.setAttribute("bran_name_d_details", bran_name);
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
                                Branch Name :<b> <%= session.getAttribute("bran_name_d_details")%></b>
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
                    <%
                        try {
                            String sql_order_view = "select * from ad_order where ord_bran_id = '" + session.getAttribute("bran_id_b_details") + "' ";
                            PreparedStatement pst_order_view = DbConnection.getConn(sql_order_view);
                            ResultSet rs_order_view = pst_order_view.executeQuery();
                            if (rs_order_view.next()) {
                    %>
                    <table id="DataTable" class="table table-bordered table-hover" style="width: 100%">
                        <thead>
                            <tr>
                                <th style="text-align: center">Sl</th>
                                <th style="text-align: center; width: 20%;">Date</th>
                                <th style="text-align: center">Order Receive By</th>
                                <th style="text-align: center">Order ID</th>
                                <th style="text-align: center">Status</th>  
                                <th style="text-align: center">Price</th>                                
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                id = ((pageNo * perpage) - perpage);
                                try {
                                    String status_stay = null;
                                    String sql_show = "select * from ad_order where ord_bran_id = '" + session.getAttribute("bran_id_b_details") + "' ";
                                    PreparedStatement pst_order_show = DbConnection.getConn(sql_show);
                                    ResultSet rs_order_show = pst_order_show.executeQuery();
                                    while (rs_order_show.next()) {
                                        id++;
                                        String sl = rs_order_show.getString(1);
                                        String order_id = rs_order_show.getString("ord_order_id");
                                        String order_receive_by = rs_order_show.getString("ord_user_id");
                                        String status = rs_order_show.getString("ord_status");
                                        if (status.equals("1")) {
                                            status_stay = "Pending....";
                                        } else if (status.equals("2")) {
                                            status_stay = "Receive";
                                        }
                                        String price = rs_order_show.getString("ord_total_price");
                            %>
                            <tr>
                                <td style="text-align: center; width: 6%"><%= id%></td>
                                <td style="text-align: center; width: 20%;"><%= rs_order_show.getString("ord_receive_date")%></td>
                                <td style="text-align: center">
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
                                            }
                                        } catch (Exception e) {
                                            out.println(e.toString());
                                        }
                                    %>
                                </td>
                                <td style="text-align: center; width: 8%;"><%= order_id%></td>
                                <td style="text-align: center"><%= status_stay%></td>
                                <td style="text-align: center"><%= price%></td>                                   
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
                    <center><span style="color: red; font-size: 18px;">Nothing Found !! </span></center>
                        <%
                                }
                            } catch (Exception e) {
                                out.println(e.toString());
                            }
                        %>
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
