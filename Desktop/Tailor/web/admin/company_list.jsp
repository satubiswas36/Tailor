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
    <jsp:include page="../menu/header.jsp" flush="true"/>
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
                                All Company List  <% out.println(logger);%>
                            </div>
                            <div class="panel-body">
                                <table class="table table-striped table-responsive table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>SL</th>
                                            <th>Name</th>
                                            <th>Mobile</th>
                                            <th>Phone</th>
                                            <th>fax</th>
                                            <th>Address</th>
                                            <th>Web site</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            int id = 1;
                                            try {
                                                    String sql_company = "select * from user_company order by com_name";
                                                    PreparedStatement pst_company = DbConnection.getConn(sql_company);
                                                    ResultSet rs_company = pst_company.executeQuery();
                                                    while(rs_company.next()){
                                                        %>
                                                        <tr>
                                                            <td><%= id++ %></td>
                                                            <td><%= rs_company.getString("com_name") %></td>
                                                            <td><%= rs_company.getString("com_mobile") %></td>
                                                            <td><%= rs_company.getString("com_phone") %></td>
                                                            <td><%= rs_company.getString("com_fax_no") %></td>
                                                            <td><%= rs_company.getString("com_address") %></td>
                                                            <td><%= rs_company.getString("com_websit") %></td>
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
