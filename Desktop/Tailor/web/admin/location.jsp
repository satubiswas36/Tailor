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
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp" flush="true"/>
    <body>
        <div id="wrapper">            
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=product_information" flush="true"/>
            <!-- /. NAV SIDE  -->
            <%String status = request.getParameter("status");%>
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Add Product  Location
                                <span id="productlocationmsg">
                                    <%
                                        if (session.getAttribute("productlocationmsg") != null) {
                                            if (session.getAttribute("productlocationmsg").equals("inserted")) {
                                    %>
                                    <span style="color: green; margin-left: 20%;">Successfully Inserted !!</span>
                                    <%
                                    } else if (session.getAttribute("productlocationmsg").equals("notinserted")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Not Inserted !! try again</span>
                                    <%
                                    } else if (session.getAttribute("productlocationmsg").equals("updated")) {
                                    %>
                                    <span style="color: green; margin-left: 20%;">Successfully Updated !!</span>
                                    <%
                                    } else if (session.getAttribute("productlocationmsg").equals("notupdated")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Not Updated !! try again</span>
                                    <%
                                    } else if (session.getAttribute("productlocationmsg").equals("exit")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Already Exit !!</span>
                                    <%
                                            }
                                        }
                                        if (session.getAttribute("productlocationmsg") != null) {
                                            session.removeAttribute("productlocationmsg");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="panel-body">
                                <%
                                    if (status == null) {
                                %>
                                <form action="../ProductLocation" method="post" >
                                    <div class="row  form-group ab">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Group Name</label>  
                                            <select name="group_id" id="group_id" style="width: 100%; height: 32px" required="">
                                                <option value="">--Select--</option>
                                                <%
                                                    try {
                                                        String sql_group_name = "select * from inv_product_group where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' order by prg_name asc ";
                                                        PreparedStatement pst_group_name = DbConnection.getConn(sql_group_name);
                                                        ResultSet rs_group_name = pst_group_name.executeQuery();
                                                        while (rs_group_name.next()) {
                                                            String group_name = rs_group_name.getString("prg_name");
                                                            String group_id = rs_group_name.getString("prg_slid");
                                                %>
                                                <option value="<%=group_id%>"><%=group_name%></option>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Name</label>  
                                            <select name="product_id" id="product_id" style="width: 100%; height: 32px" required="">

                                            </select>
                                        </div>
                                    </div>                                   

                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Block</label>  
                                            <input type="text" class="form-control" name="product_block" id="group_name" placeholder="Enter Product Block" required="" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Self</label>  
                                            <input type="text" class="form-control" name="product_self" id="group_name" placeholder="Enter Product Self" required="" />
                                        </div>
                                    </div>                                           
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <input type="submit" class="btn btn-primary" value="Add"/>
                                            <input type="text" name="status" value="add" style="display: none"/>
                                        </div>                                    
                                    </div>
                                </form>
                                <%
                                    }
                                %>
                                <%
                                    if (status != null) {
                                        String product_group_id = request.getParameter("group_id");
                                        String product_id = request.getParameter("product_id");
                                        String product_name = request.getParameter("product_name");
                                        String block = request.getParameter("block");
                                        String self = request.getParameter("self");
                                %>
                                <form action="../ProductLocation" method="post" >
                                    <div class="row  form-group ab">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Group Name</label>  
                                            <select name="group_id" id="group_id" style="width: 100%; height: 32px">
                                                <%
                                                    try {
                                                        String sql_group = "select * from inv_product_group where prg_slid = '" + product_group_id + "' ";
                                                        PreparedStatement pst_group = DbConnection.getConn(sql_group);
                                                        ResultSet rs_group = pst_group.executeQuery();
                                                        if (rs_group.next()) {
                                                            String gp_name = rs_group.getString("prg_name");
                                                %>
                                                <option value="<%=product_group_id%>"><%=gp_name%></option>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                                <%
                                                    try {
                                                        String sql_group_name = "select * from inv_product_group where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_group_name = DbConnection.getConn(sql_group_name);
                                                        ResultSet rs_group_name = pst_group_name.executeQuery();
                                                        while (rs_group_name.next()) {
                                                            String group_name = rs_group_name.getString("prg_name");
                                                            String group_id = rs_group_name.getString("prg_slid");
                                                %>
                                                <option value="<%=group_id%>"><%=group_name%></option>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Name</label>  
                                            <select name="product_id" id="product_id" style="width: 100%; height: 32px">
                                                <option value="<%=product_id%>"><%=product_name%></option>
                                            </select>
                                        </div>
                                    </div>                                   

                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Block</label>  
                                            <input type="text" class="form-control" name="product_block" value="<%=block%>" id="group_name" placeholder="Enter Product Block" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Self</label>  
                                            <input type="text" class="form-control" name="product_self" value="<%=self%>" id="group_name" placeholder="Enter Product Self" />
                                        </div>
                                    </div>                                           
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <input type="submit" class="btn btn-primary" value="Edit"/>
                                            <input type="text" name="status" value="edit" style="display: none"/>
                                        </div>                                    
                                    </div>
                                </form>
                                <%
                                    }
                                %>
                            </div>                           
                        </div>                                                    <!-- /. PAGE INNER  -->
                    </div>                                                    <!-- /. PAGE WRAPPER  -->
                </div>
            </div>
        </div>
        <script>
            $("#group_id").change(function () {
                var group_id = $("#group_id").val();

                $.ajax({
                    type: 'POST',
                    url: "/Tailor/aaaa", // group_id ta aaaa servlet e jacce sakhan thaka session set kortaca tarpor product_name_by_group page load kortaca
                    data: {
                        "group_id": group_id,
                        "status": "location"
                    },
                    success: function (data) {
                        $("#product_id").load("product_name_by_group.jsp");
                        // alert("Deleted");
                    }
                });
            });
        
            $(function () {
                $("#productlocationmsg").fadeIn("slow").delay(3000).fadeOut("slow");
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
