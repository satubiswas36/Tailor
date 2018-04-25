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
                if(session != null){
                    if(branch_id != null){
                        session.setAttribute("bran_id_b_details", branch_id);
                    }
                }
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
                                Branch Name :<b> <%= session.getAttribute("bran_name") %></b>
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
