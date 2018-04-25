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
            response.sendRedirect("/Tailor/user/index.jsp");
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
            <jsp:include page="../menu/menu.jsp" flush="true"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Party Registration
                            </div>
                            <div class="panel-body">
                                <form action="" method="post" enctype="multipart/form-data">

                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Party Name</label>  
                                            <input type="text" class="form-control" name="prty_name" id="prty_name" placeholder="name" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="email" style="margin-bottom:  0px">Party Email</label>  
                                            <input type="email" class="form-control" name="prty_email" id="prty_email" placeholder="email" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="phone" style="margin-bottom:  0px">Party Phone</label>  
                                            <input type="text" class="form-control" name="cus_phone" id="cus_phone" placeholder="phone" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="address" style="margin-bottom:  0px">Party Address</label>  
                                            <input type="text" class="form-control" name="prty_address" id="prty_address" placeholder="address" style="height: 50px" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="reference" style="margin-bottom:  0px">Party Reference</label>  
                                            <input type="text" class="form-control" name="prty_reference" id="prty_reference" placeholder="reference" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="image" style="margin-bottom:  0px">Party Image</label>  
                                            <input type="file"  name="cus_image" id="cus_image" style="width: 100%" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <input type="reset" class="btn btn-danger btn-circle" style="width: 100%; font-size: 20px"/>
                                        </div>
                                        <div class="col-sm-3">
                                            <input type="submit" class="btn btn-primary btn-circle" style="width: 100%; font-size: 20px;"/>
                                        </div>                                    
                                    </div>
                                </form>
                            </div>
                        </div>                                                    <!-- /. PAGE INNER  -->
                    </div>                                                    <!-- /. PAGE WRAPPER  -->
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
