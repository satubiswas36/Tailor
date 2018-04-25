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
                    response.sendRedirect("../index.jsp");
                }
            }
        } else {
            response.sendRedirect("../index.jsp");
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
            <jsp:include page="../menu/menu.jsp?page_name=maker"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                <span style="font-size: 18px">Worker Registration</span>
                                <%
                                    String set_color = null;
                                    if (session.getAttribute("maker_reg_msg") != null) {
                                        if (session.getAttribute("maker_reg_msg").equals("has")) {
                                            set_color = "red";
                                        }
                                        if (session.getAttribute("maker_reg_msg").equals("ok")) {
                                            set_color = "green";
                                        }
                                        if (session.getAttribute("maker_reg_msg").equals("isavailable")) {
                                            set_color = "red";
                                        }
                                    }
                                %>
                                <center>
                                    <span class="maker_reg_succ" style="color: <%= set_color%>; font-size: 20px;">
                                        <%
                                            if (session.getAttribute("maker_reg_msg") != null) {
                                                if (session.getAttribute("maker_reg_msg").equals("has")) {
                                        %>
                                        <%= "Already exit"%>
                                        <%
                                            }
                                            if (session.getAttribute("maker_reg_msg").equals("ok")) {
                                        %>
                                        <%="Registration successful"%>
                                        <%
                                                }
                                                if (session.getAttribute("maker_reg_msg").equals("isavailable")) {
                                                    %>
                                                    <%= "Duplicate Name is not allow. Please try another" %>
                                                    <%
                                                }
                                            }
                                            session.removeAttribute("maker_reg_msg");
                                        %>
                                    </span>
                                </center>
                            </div>
                            <div class="panel-body">
                                <form action="../Makder_registration" method="post" enctype="multipart/form-data">
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="mk_name" style="margin-bottom:  0px">Name <span style="color: red">*</span> </label>  
                                            <input type="text" class="form-control" name="mk_name" pattern="[A-Za-z ]+"  id="mk_name" placeholder="maker name" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="mk_mobile" style="margin-bottom:  0px">Mobile<span style="color: red">*</span> </label>  
                                            <input type="text" class="form-control" name="mk_mobile"  pattern="01[56789]\d{8}" id="mk_mobile" placeholder="maker name" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="mk_email" style="margin-bottom:  0px">Email</label>  
                                            <input type="email" class="form-control" name="mk_email" id="mk_email" placeholder="maker email" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="mk_password" style="margin-bottom:  0px">Password</label>  
                                            <input type="password" class="form-control" name="mk_password" id="mk_password" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="mk_birthdate" style="margin-bottom:  0px">Birth-Date<span style="color: red">*</span> </label>  
                                            <input type="text" class="form-control" name="mk_birthdate" id="mk_birthdate" placeholder="maker birtdate" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="mk_address" style="margin-bottom:  0px">Address<span style="color: red">*</span></label>  
                                            <input type="text" class="form-control" name="mk_address" id="mk_address" placeholder="maker address" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="mk_nid" style="margin-bottom:  0px">NID</label>  
                                            <input type="text" class="form-control" name="mk_nid" id="mk_address" placeholder="maker nid" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="mk_nid" style="margin-bottom:  0px">Ref. Name</label>  
                                            <input type="text" class="form-control" name="mk_ref_name" id="mk_address" placeholder="Ref. Name" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="mk_nid" style="margin-bottom:  0px">Ref. Mobile</label>  
                                            <input type="text" class="form-control" name="mk_ref_mobile" id="mk_address" placeholder="Ref. Mobile" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="mk_nid" style="margin-bottom:  0px">Image<span style="color: red">*</span></label>  
                                            <input type="file" class="form-control" name="mk_image" id="mk_image" required=""/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <input type="submit" class="btn btn-primary" value="Submit">
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
        <script>
            $(".maker_reg_succ").fadeIn().delay(3000).fadeOut();
            $(function () {
                $("#mk_birthdate").datepicker({
                    dateFormat: "dd-mm-yy",
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1950:'+(new Date).getFullYear()
                });
            });
        </script>
        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
