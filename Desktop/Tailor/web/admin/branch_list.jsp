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
                                Branch List
                                <%
                                    if (session.getAttribute("bran_list_update") != null) {
                                        if (session.getAttribute("bran_list_update").equals("ok")) {
                                %>
                                <span id="bran_list_update" style="color: green; font-size: 18px;">Successfully Updated !!</span>
                                <%
                                } else {
                                %>
                                <span id="bran_list_update" style="color: red; font-size: 18px;">Updated Failed !! Try Again Please</span>
                                <%
                                        }
                                    }
                                    if (session.getAttribute("bran_list_update") != null) {
                                        session.removeAttribute("bran_list_update");
                                    }
                                %>
                            </div>
                            <div class="panel-body">
                                <table class="table table-responsive table-bordered">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center">SL</th>
                                            <th style="text-align: center">Name</th>
                                            <th style="text-align: center">Person Name</th>
                                            <th style="text-align: center">Logo</th>
                                            <th style="text-align: center">Mobile</th>                                            
                                            <th style="text-align: center">Address</th> 
                                            <th style="text-align: center">Sender ID</th> 
                                            <th style="text-align: center">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            int id = 1;
                                            String bran_id = null;
                                            String imageName = null;
                                            String sender_id = null;
                                            String bran_person_name = null;
                                            try {
                                                String sql_company = "select * from user_branch order by bran_name";
                                                PreparedStatement pst_company = DbConnection.getConn(sql_company);
                                                ResultSet rs_company = pst_company.executeQuery();
                                                while (rs_company.next()) {
                                                    bran_id = rs_company.getString("bran_id");
                                                    imageName = rs_company.getString("bran_com_logo");
                                                    sender_id = rs_company.getString("bran_sender_id");
                                                    bran_person_name = rs_company.getString("bran_person_name");
                                        %>
                                        <tr>
                                            <td style="text-align: center"><%= id++%></td>
                                            <td style="text-align: center"><%= rs_company.getString("bran_name")%></td>
                                            <td style="text-align: center"><%if(bran_person_name != null){%><%=bran_person_name%><%}%></td>
                                            <td style="text-align: center"><img src="../images/<%=imageName%>" class="img-circle" alt="" style="width: 50" height="50"/></td>

                                            <td style="text-align: center"><%= rs_company.getString("bran_mobile")%></td>                                            
                                            <td><%= rs_company.getString("bran_address")%></td>
                                            <td><%=sender_id%></td>
                                            <td><a href="branch_regis.jsp?bran_id=<%=bran_id%>"><button class="btn btn-primary">Update</button></a></td>
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
            $("#bran_list_update").fadeIn("slow").delay(3000).fadeOut("slow");           
        </script>
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
