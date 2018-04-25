<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String logger = (String) session.getAttribute("logger");

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
                                Product Type
                                <span id="product_type_delete_msg" style="font-size: 18px">
                                    <%
                                        if (session.getAttribute("product_type_delete_msg") != null) {
                                            if (session.getAttribute("product_type_delete_msg").equals("deleted")) {
                                    %>
                                    <span style="margin-left: 20%; color: green">Successfully Deleted !!</span>
                                    <%
                                    } else if (session.getAttribute("product_type_delete_msg").equals("notdeleted")) {
                                    %>
                                    <span style="margin-left: 20%; color: red">Delete Failed !!</span>
                                    <%
                                            }
                                        }
                                        if (session.getAttribute("product_type_delete_msg") != null) {
                                            session.removeAttribute("product_type_delete_msg");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <th>SL</th>
                                        <th>Name</th>
                                        <th>Reg Date</th>
                                        <th>Control</th>
                                    </thead>
                                    <tbody>
                                        <%
                                            int sl = 1;
                                            try {
                                                String sql_product_type = "select * from inv_product_type where pro_type_bran_id = '" + session.getAttribute("user_bran_id") + "' order by pro_type_name asc";
                                                PreparedStatement pst_product_type = DbConnection.getConn(sql_product_type);
                                                ResultSet rs_product_type = pst_product_type.executeQuery();
                                                while (rs_product_type.next()) {
                                                    String product_type_id = rs_product_type.getString("pro_typ_slno");
                                                    String product_type = rs_product_type.getString("pro_type_name");
                                                    String product_type_reg_date = rs_product_type.getString("pro_type_date");
                                        %>
                                        <tr>
                                            <td><%=sl++%></td>
                                            <td><%=product_type%></td>
                                            <td><%=product_type_reg_date%></td>
                                            <td>
                                                <a href="add_product_type.jsp?status=edit&product_type_id=<%=product_type_id%>&product_type_name=<%=product_type%>"><button class="btn btn-success">Edit</button></a>
                                                <a class="btn btn-danger" href="delete_group.jsp?status=product_type&product_type_id=<%=product_type_id%>" onclick="return confirm('Do you want delete?')">Delete</a>
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
            $("#product_type_delete_msg").fadeIn(4000).delay(3000).fadeOut("slow");
        </script>
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
