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
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Maker List
                            </div>
                            <div class="panel-body">
                                <table class="table table-striped" style="width: 30%;">
                                    <thead>
                                        <tr>
                                            Delivery Date
                                        </tr>
                                        <tr>
                                            <th style="text-align: center">Sl</th>
                                            <th style="text-align: center">Maker Name</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            String product_name = request.getParameter("product_name");
                                            String maker_order = request.getParameter("order_id");
                                            int id = 1;
                                            try {
                                                // check maker is available or not 
                                                String sql_has_maker = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                PreparedStatement pst_has_maker = DbConnection.getConn(sql_has_maker);
                                                ResultSet rs_has_maker = pst_has_maker.executeQuery();
                                                if (rs_has_maker.next()) {
                                                    String sql_maker_list = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' order by mk_name asc";
                                                    PreparedStatement pst_maker_list = DbConnection.getConn(sql_maker_list);
                                                    ResultSet rs_maker_list = pst_maker_list.executeQuery();
                                                    while (rs_maker_list.next()) {
                                                        String maker_name = rs_maker_list.getString("mk_name");
                                        %>
                                        <tr>
                                            <td style="text-align: center; width: 5%;"><%= id++%></td>
                                            <td style="text-align: center;">
                                                <a href="add_maker_order_product.jsp?mk_name=<%=maker_name%>&product_name=<%=product_name%>&maker_order=<%=maker_order%>" style="text-decoration: none"><%=maker_name%></a>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <span style="color: red;"><%="Nothing found !!"%></span>
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
