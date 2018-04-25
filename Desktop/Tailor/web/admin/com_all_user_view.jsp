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
                String branch_id = request.getParameter("b_id");
                String branch_d_status = request.getParameter("bran_d_status");
                String bran_name = null;
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
                            String user_status = null;
                            String sql_all_user = "select * from user_user where user_bran_id = '" + session.getAttribute("bran_id_b_details") + "' ";
                            PreparedStatement pst_all_user = DbConnection.getConn(sql_all_user);
                            ResultSet rs_all_user = pst_all_user.executeQuery();
                            if (rs_all_user.next()) {
                        %>
                        <table class="table table-striped table-bordered">
                            <thead>
                                <th style="text-align: center">SL</th>
                                <th style="text-align: center">User Name</th>
                                <th style="text-align: center">Email</th>
                                <th style="text-align: center">Mobile</th>
                                <th style="text-align: center">Address</th>
                                <th style="text-align: center">Status</th>

                            </thead>
                            <tbody>
                                <%
                                    try {
                                        String sql_all_users = "select * from user_user where user_bran_id = '" + session.getAttribute("bran_id_b_details") + "' ";
                                        PreparedStatement pst_all_users = DbConnection.getConn(sql_all_users);
                                        ResultSet rs_all_users = pst_all_users.executeQuery();
                                        while (rs_all_users.next()) {
                                            // check user active or not 
                                            if (rs_all_users.getString("user_status").equals("1")) {
                                                user_status = "active";
                                            } else {
                                                user_status = "inactive";
                                            }
                                %>
                                <tr>
                                    <td style="text-align: center; width: 5%;"><%= id++%></td>
                                    <td style="text-align: center"><%= rs_all_users.getString("user_name")%></td>
                                    <td style="text-align: center"><%= rs_all_users.getString("user_email")%></td>
                                    <td style="text-align: center"><%= rs_all_users.getString("user_mobile")%></td>
                                    <td style="text-align: center"><%= rs_all_users.getString("user_address")%></td>
                                    <td style="text-align: center"><%= user_status%></td>
                                </tr>
                                <%
                                        }
                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                } else {
                                %>
                                <center><span style="color: red; font-size: 21px;">No result here !!</span></center>
                                    <%
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
