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
                                Add Group  
                                <span id="groupdelete">
                                    <%
                                        if (session.getAttribute("groupdelete") != null) {
                                            if (session.getAttribute("groupdelete").equals("ok")) {
                                    %>
                                    <span style="margin-left: 20%; color: green">Successfully Deleted !</span>
                                    <%
                                    } else if (session.getAttribute("groupdelete").equals("no")) {
                                    %>
                                    <span style="margin-left: 20%; color: red">Delete Failed !!</span>
                                    <%
                                            }
                                        }
                                        if (session.getAttribute("groupdelete") != null) {
                                            session.removeAttribute("groupdelete");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered">
                                    <thead>
                                        <th>SL</th>
                                        <th>Group Name</th>
                                        <th>Registration Date</th>
                                        <th>Control</th>
                                    </thead>
                                    <tbody>
                                        <%
                                            int sl = 1;
                                            try {
                                                String sql_group = "select * from inv_product_group where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' order by prg_name asc";
                                                PreparedStatement pst_group = DbConnection.getConn(sql_group);
                                                ResultSet rs_group = pst_group.executeQuery();
                                                while (rs_group.next()) {
                                                    String group_name = rs_group.getString("prg_name");
                                                    String group_id = rs_group.getString("prg_slid");
                                                    String group_reg_date = rs_group.getString("prg_regdate");
                                        %>
                                        <tr>
                                            <td><%=sl++%></td>
                                            <td><%=group_name%></td>
                                            <td><%=group_reg_date%></td>
                                            <td>
                                                <a href="add_group.jsp?status=edit&group=<%=group_id%>&group_name=<%=group_name%>"><button class="btn btn-success">Edit</button></a>
                                                <a href="delete_group.jsp?gid=<%=group_id%>&status=group" onclick="return confirm('Do you want delete?')"><button class="btn btn-danger">Delete</button></a>

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
            $("#groupdelete").fadeIn(4000).delay(3000).fadeOut("slow");
        </script>
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
