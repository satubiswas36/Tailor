<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String logger = (String) session.getAttribute("logger");
    String branch_id = null;

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
    <head>
        <title>Tailor</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta charset="utf-8"/>
        <meta contenteditable="utf8_general_ci"/>
        <!--        <meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="shortcut icon" type="image/x-icon" href="../admin/assets/img/t_mechin.jpg"/>
        <link href="/Tailor/admin/assets/css/bootstrap.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/css/font-awesome.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />       
        <link href="/Tailor/admin/assets/css/custom.css" rel="stylesheet" />      
        <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/dataTables.jqueryui.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/dataTables.uikit.min.css" rel="stylesheet" type="text/css"/>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />        
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <!--        <link href="assets/css/bootstrap.css" rel="stylesheet" type="text/css"/>
                <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>-->


        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />        
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script src="http://mymaplist.com/js/vendor/TweenLite.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
        <link rel="stylesheet" href="/resources/demos/style.css"/>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    </head>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=user" flush="true"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                All users
                                <%
                                    if (session != null) {
                                        if (session.getAttribute("user_deleted") != null) {
                                            if (session.getAttribute("user_deleted").equals("ok")) {
                                %>
                                <center><span id="user_delete" style="color: red; font-size: 18px;">User Deleted !!</span></center>
                                    <%
                                    } else {
                                    %>
                                <center><span id="user_delete" style="color: red; font-size: 18px;">Failed to delete !</span></center>
                                    <%
                                                }
                                                session.removeAttribute("user_deleted");
                                            }
                                        }
                                    %>
                                <%
                                        if (session != null) {
                                            if (session.getAttribute("user_updated") != null) {
                                                if (session.getAttribute("user_updated").equals("ok")) {
                                    %>
                                    <span id="user_delete" style="color: green">Successfully Updated !!</span>
                                    <%
                                    } else {
                                    %>
                                    <span id="user_delete" style="color: red">Failed Update !!</span>
                                    <%
                                                }
                                                session.removeAttribute("user_updated");
                                            }
                                        }
                                    %>
                            </div>
                            <div class="panel-body">
                                <%
                                    int id = 1;
                                    String user_status = null;
                                    String sql_all_user = "select * from user_user where user_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                    PreparedStatement pst_all_user = DbConnection.getConn(sql_all_user);
                                    ResultSet rs_all_user = pst_all_user.executeQuery();
                                    if (rs_all_user.next()) {
                                %>
                                <table class="table table-striped table-bordered" id="mydata">
                                    <thead>
                                        <th style="text-align: center">SL</th>
                                        <th style="text-align: center">User Name</th>
                                        <th style="text-align: center">Email</th>
                                        <th style="text-align: center">Mobile</th>
                                        <th style="text-align: center">Address</th>
                                        <th style="text-align: center">Status</th>
                                        <th style="text-align: center">Action</th>                                        
                                    </thead>
                                    <tbody>
                                        <%
                                            String userid = null;
                                            try {
                                                String sql_all_users = "select * from user_user where user_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                PreparedStatement pst_all_users = DbConnection.getConn(sql_all_users);
                                                ResultSet rs_all_users = pst_all_users.executeQuery();
                                                while (rs_all_users.next()) {
                                                    // check user active or not 
                                                    if (rs_all_users.getString("user_status").equals("1")) {
                                                        user_status = "active";
                                                    } else {
                                                        user_status = "inactive";
                                                    }
                                                    userid = rs_all_users.getString("user_id");
                                        %>
                                        <tr>
                                            <td style="text-align: center"><%= id++%></td>
                                            <td style="text-align: center"><%= rs_all_users.getString("user_name")%></td>
                                            <td style="text-align: center"><%= rs_all_users.getString("user_email")%></td>
                                            <td style="text-align: center"><%= rs_all_users.getString("user_mobile")%></td>
                                            <td style="text-align: center"><%= rs_all_users.getString("user_address")%></td>
                                            <td style="text-align: center"><%= user_status%></td>
                                            <td style="text-align: center">
                                                <form name="myform<%=id%>" action="user_reg.jsp" method="post">
                                                    <input type="text" name="userid" value="<%=userid%>" style="display: none"/>
                                                </form>                                                
                                                <a href="javascript:myform<%=id%>.submit()"><span class="glyphicon glyphicon-edit" style="color: green"></span></a>                                                
                                            </td>
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
                        </div>                                                    <!-- /. PAGE INNER  -->
                    </div>                                                    <!-- /. PAGE WRAPPER  -->
                </div>
            </div>
        </div>
        <script>
            $("#user_delete").fadeIn("slow").delay(3000).fadeOut("slow");
        </script>
        <script src="assets/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>
        <script>
            $("#mydata").dataTable({
                "pagingType": "simple_numbers",
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search..."
                }
            });
        </script>         
    </body>
</html>
