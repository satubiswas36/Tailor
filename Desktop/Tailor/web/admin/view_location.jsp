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
                    response.sendRedirect("/Tailo/index.jsp");
                }
            }
        } else {
            response.sendRedirect("/Tailor/index.jsp");
        }

    } catch (Exception e) {
        out.println(e.toString());
    }
%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=product_information"/>  
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                Product Location
                                <span id="product_location_delete_msg" style="font-size: 18px">
                                    <%
                                        if (session.getAttribute("product_location_delete_msg") != null) {
                                            if (session.getAttribute("product_location_delete_msg").equals("deleted")) {
                                    %>
                                    <span style="margin-left: 20%; color: green">Successfully Deleted !!</span>
                                    <%
                                    } else if (session.getAttribute("product_location_delete_msg").equals("notdeleted")) {
                                    %>
                                    <span style="margin-left: 20%; color: red">Delete Failed !!</span>
                                    <%
                                            }
                                        }
                                        if (session.getAttribute("product_location_delete_msg") != null) {
                                            session.removeAttribute("product_location_delete_msg");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <th>SL</th>
                                        <th>Product Name</th>
                                        <th>Block</th>
                                        <th>Self</th>
                                        <th>Action</th>
                                    </thead>
                                    <tbody>
                                        <%
                                            int sl = 1;
                                            String product_name = null;
                                            String group_id = null;
                                            try {
                                                String sql_product_location = "select * from inv_product_location where pl_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                PreparedStatement pst_product_location = DbConnection.getConn(sql_product_location);
                                                ResultSet rs_product_location = pst_product_location.executeQuery();
                                                while (rs_product_location.next()) {
                                                    String product_name_id = rs_product_location.getString("pl_product_id");
                                                    String block = rs_product_location.getString("pl_block");
                                                    String self = rs_product_location.getString("pl_self");
                                                    // product id dhore product name select kora
                                                    String sql_product_name = "select * from inv_product_name where prn_slid = '"+product_name_id+"' ";
                                                    PreparedStatement pst_product_name = DbConnection.getConn(sql_product_name);
                                                    ResultSet rs_product_name = pst_product_name.executeQuery();
                                                    if(rs_product_name.next()){
                                                        product_name = rs_product_name.getString("prn_product_name");
                                                        group_id = rs_product_name.getString("prn_group_id");
                                                    }
                                                    %>
                                                    <tr>
                                                        <td><%=sl++%></td>
                                                        <td><%=product_name%></td>
                                                        <td><%=block%></td>
                                                        <td><%=self%></td>
                                                        <td>
                                                            <a href="location.jsp?status=edit&group_id=<%=group_id%>&product_id=<%=product_name_id%>&product_name=<%=product_name%>&block=<%=block%>&self=<%=self%>"><button class="btn btn-success">Edit</button></a>
                                                            <a class="btn btn-danger" href="delete_group.jsp?status=location&product_id_location=<%=product_name_id%>" onclick="return confirm('Do you want delete?')">Delete</a>
                                                        </td>
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
        <script>
            $("#product_location_delete_msg").fadeIn(4000).delay(3000).fadeOut("slow");
        </script>
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
