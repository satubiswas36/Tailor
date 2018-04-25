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
        }else {
            response.sendRedirect("/Tailor/index.jsp");
        }

    } catch (Exception e) {
        out.println(e.toString());
    }
%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <div id="wrapper">            
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=supplier_information"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading"style="color: #ff6666; font-size: 25px">
                                Add Supplier Bank Information
                            </div>
                            <div class="panel-body">
                                <form action="" method="post" >
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Supplier Name</label>  
                                            <select name="supplier_name" style="width: 100%; height: 32px">
                                                <option></option>
                                                <option>Supplier One</option>
                                                <option>Supplier Two</option>
                                                <option>Supplier Three</option>
                                                <option>Supplier Four</option>
                                            </select>
                                        </div>
                                    </div>                                    
                                   <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Bank Name</label>  
                                            <input type="text" class="form-control" name="b_name" id="b_name" placeholder="Enter  Bank Name" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Branch Name</label>  
                                            <input type="text" class="form-control" name="branch_name" id="branch_name" placeholder="Enter Branch Name" />
                                        </div>
                                    </div>
                                     <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Account Name</label>  
                                            <input type="text" class="form-control" name="acc_name" id="acc_name" placeholder="Enter Account Name" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Account No</label>  
                                            <input type="text" class="form-control" name="acc_no" id="acc_no" placeholder="Enter Account No" />
                                        </div>
                                    </div>
                                 <div class="row">
                                        <div class="col-sm-2">
                                            <input type="submit" class="btn btn-primary" value="Add">
                                        </div>                                    
                                    </div>
                                </form>
                            </div>
                            <p class="error"></p>
                        </div>                                                    <!-- /. PAGE INNER  -->
                    </div>                                                    <!-- /. PAGE WRAPPER  -->
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
