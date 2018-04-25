<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String logger = (String) session.getAttribute("logger");
    String user_id = null;
%>
<%
    // get user id from session
    if (session != null) {
        if (session.getAttribute("user_user_id") != null) {
            user_id = (String) session.getAttribute("user_user_id");
        }
    }
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
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper">
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                <%
                                    String status = null;
                                    if(session.getAttribute("user_profile_not_update") != null){
                                        status = "red";
                                    }else {
                                        status = "green";
                                    }
                                    %>
                                    <span class="user_profile_update" style="color: <%= status %>; font-size: 18px"><% if(session.getAttribute("user_profile_update") != null){%><%= session.getAttribute("user_profile_update") %> <% }else if(session.getAttribute("user_profile_not_update")!=null){%><%="Profile not updated ! try again please" %><%} %></span><% session.removeAttribute("user_profile_update"); session.removeAttribute("user_profile_not_update"); %>
                            </div>
                            <div class="panel-body">
                                <form action="user_profile_updated.jsp" method="post">
                                    <table id="" class="table table-bordered table-hover table-responsive">
                                        <%
                                            String user_name = null;
                                            String user_email = null;
                                            String user_old_password = null;
                                            String user_new_password = null;
                                            String user_mobile = null;
                                            String user_address = null;
                                            try {
                                                String sql_user_profile = "select * from user_user where user_id = '" + user_id + "' ";
                                                PreparedStatement pst_user_profile = DbConnection.getConn(sql_user_profile);
                                                ResultSet rs_user_profile = pst_user_profile.executeQuery();
                                                while (rs_user_profile.next()) {
                                                    user_name = rs_user_profile.getString("user_name");
                                                    user_email = rs_user_profile.getString("user_email");
                                                    user_old_password = rs_user_profile.getString("user_password");
                                                    user_mobile = rs_user_profile.getString("user_mobile");
                                                    user_address = rs_user_profile.getString("user_address");
                                        %>
                                        <input type="text" name="user_id" value="<%= user_id%>" style="display: none" />
                                        <tr>
                                            <td>User Name </td>
                                            <td><input type="text" class="form-control" value="<%= user_name%>" name="user_name" required=""/></td>
                                        </tr>
                                        <tr>
                                            <td>User Email</td>
                                            <td><input type="email" class="form-control" value="<%= user_email%>" name="user_email" required=""/></td>
                                        </tr>
                                        <tr>
                                            <td>User Old Password</td>
                                            <td><input type="password" class="form-control" id="user_old_pas" onblur="checkoldpass()"  name="user_old_password" required=""/></td>
                                        </tr>
                                        <tr>
                                            <td>User New Password</td>
                                            <td><input type="password" class="form-control" name="user_new_password"  required=""/> </td>
                                        </tr>
                                        <tr>
                                            <td>User Mobile</td>
                                            <td><input type="text" class="form-control" value="<%= user_mobile%>" name="user_mobile" required=""/> </td>
                                        </tr>
                                        <tr>
                                            <td>User Address</td>
                                            <td><input type="text" class="form-control" name="user_address"  value="<%= user_address %>" style="height: 50px; text-align: justify" required=""/> </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><input type="submit" value="Update Profile"/></td>
                                        </tr>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            }
                                        %>
                                    </table>
                                </form>
                            </div>                            
                        </div>                                                    <!-- /. PAGE INNER  -->
                    </div>                                                    <!-- /. PAGE WRAPPER  -->
                </div>
            </div>
        </div>
        <script>
          $(function(){
              $(".user_profile_update").show("slow").delay(4000).hide(2500);
          });
        </script>
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
