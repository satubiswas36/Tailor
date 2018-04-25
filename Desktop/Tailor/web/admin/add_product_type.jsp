<%
    String logger = (String) session.getAttribute("logger");
%>

<%
    try {

        if (logger != null) {
            if (logger.equals("user")) {
                String ss_id = (String) session.getAttribute("user_user_id");
                if (ss_id == null) {
                    response.sendRedirect("/Tailor/user/index.jsp");
                }
            } else if (logger.equals("root")) {
                String user_root = (String) session.getAttribute("user_root");
                if (user_root == null) {
                    response.sendRedirect("../index.jsp");
                }
            } else if (logger.equals("company")) {
                String user_com_id = (String) session.getAttribute("user_com_id");
                if (user_com_id == null) {
                    response.sendRedirect("/Tailor/company/index.jsp");
                }
            } else if (logger.equals("branch")) {
                String user_bran_id = (String) session.getAttribute("user_bran_id");
                if (user_bran_id == null) {
                    response.sendRedirect("/Tailor/Branch/index.jsp");
                }
            }
        } else {
            response.sendRedirect("/Tailor/user/index.jsp");
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
            <%
                String status = request.getParameter("status");

            %>
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Add Type Name
                                <span id="product_type_msg">
                                    <%                                        if (session.getAttribute("product_type_msg") != null) {
                                            if (session.getAttribute("product_type_msg").equals("inserted")) {
                                    %>
                                    <span style="color: green; margin-left: 20%;">Successfully Inserted !!</span>
                                    <%
                                    } else if (session.getAttribute("product_type_msg").equals("notinserted")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Not Inserted !! try again</span>
                                    <%
                                    } else if (session.getAttribute("product_type_msg").equals("updated")) {
                                    %>
                                    <span style="color: green; margin-left: 20%;">Successfully Updated !!</span>
                                    <%
                                    } else if (session.getAttribute("product_type_msg").equals("notupdated")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Not Updated !! try again</span>
                                    <%
                                    } else if (session.getAttribute("product_type_msg").equals("exit")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Already Exit!! try again</span>
                                    <%
                                            }
                                        }
                                        if (session.getAttribute("product_type_msg") != null) {
                                            session.removeAttribute("product_type_msg");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="panel-body">
                                <%
                                    if (status == null || status == "") {
                                %>
                                <form action="../AddProductType" method="post" >
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Type Name</label>  
                                            <input type="text" class="form-control" name="product_type_name" id="product_type_name" placeholder="name" required=""/>
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
                                        String product_type_id = request.getParameter("product_type_id");
                                        String product_type_name = request.getParameter("product_type_name");
                                %>
                                <form action="../AddProductType" method="post" >
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Type Name</label>  
                                            <input type="text" class="form-control" name="product_type_name" value="<%=product_type_name%>" id="product_type_name" placeholder="name" required=""/>
                                            <input type="text" name="product_type_id" value="<%=product_type_id%>" style="display: none"/>
                                            <input type="text" name="product_type_name" value="<%=product_type_name%>" style="display: none"/>
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
                        </div>
                    </div>
                </div>
            </div>
            <script>
                $(function () {
                    $("#product_type_msg").fadeIn("slow").delay(3000).fadeOut("slow");
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
