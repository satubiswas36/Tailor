<%
    String logger = (String) session.getAttribute("logger");

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
            <jsp:include page="../menu/menu.jsp?page_name=supplier_information"/>
            <div id="page-wrapper">
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="font-size: 25px">
                                Add Supplier
                                <span id="supplier_msg">
                                    <%
                                        if (session.getAttribute("add_supplier_msg") != null) {
                                            if (session.getAttribute("add_supplier_msg").equals("inserted")) {
                                    %>
                                    <span style="color: green; margin-left: 20%;">Successfully Inserted !!!!</span>
                                    <%
                                    } else if (session.getAttribute("add_supplier_msg").equals("noinserted")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Registration Failed !!</span>
                                    <%
                                    } else if (session.getAttribute("add_supplier_msg").equals("exit")) {
                                    %>
                                    <span style="color: green; margin-left: 20%;">Already Exit !!!!</span>
                                    <%
                                            }
                                        }
                                        if (session.getAttribute("add_supplier_msg") != null) {
                                            session.removeAttribute("add_supplier_msg");
                                        }
                                    %>
                                </span>                               
                            </div>
                            <div class="panel-body">
                                <form action="../AddSupplier" method="post" onsubmit="return formvalidation()">
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Name<span style="color: red">*</span></label>  
                                            <input type="text" class="form-control" name="sup_name" id="sup_name" placeholder="Enter Supplier Name" required="" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Address<span style="color: red">*</span></label>  
                                            <input type="text" class="form-control" name="sup_address" id="sup_address" placeholder="Enter Supplier Address" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Person<span style="color: red">*</span></label>  
                                            <input type="text" class="form-control" name="sup_person" id="sup_person" placeholder="Enter Supplier Person" required="true"/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Mobile<span style="color: red">*</span></label>  
                                            <input type="text" class="form-control" name="sup_mobile" id="sup_mobile" placeholder="Enter Supplier Mobile" onkeyup="checkMobile()" required=""/>
                                            <span id="exitsupmobile" style="color: red"></span>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Phone</label>  
                                            <input type="text" class="form-control" name="sup_phone" id="sup_phone" placeholder="Enter Supplier Phone" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Email</label>  
                                            <input type="email" class="form-control" name="sup_email" id="sup_email" placeholder="Enter Supplier Email" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Web Site</label>  
                                            <input type="url" class="form-control" name="sup_website" id="sup_website" placeholder="Enter Supplier WebSite" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Complain  Number</label>  
                                            <input type="text" class="form-control" name="sup_com_num" id="sup_com_num" placeholder="Enter Complain  Number" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Open Due Balance</label>  
                                            <input type="text" class="form-control" name="open_du_balance" id="open_du_balance" placeholder="Supplier Open Due Balance" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Supplier Status<span style="color: red">*</span></label>  
                                            <select class="form-control" name="supplier_status" required="">
                                                <option value="">---Select---</option>
                                                <option value="1">Local</option>
                                                <option value="2">Global</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <input type="submit" class="btn btn-primary" value="Add"  style="width: 100%"/>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>                                              
                </div>
            </div>
        </div>
        <script>
            var mobile_error;
            function checkMobile() {
                var supmobile = $("#sup_mobile").val();
                var supname = $("#sup_name").val();
                var pattern = /^01[56789]\d{8}$/;
                if (pattern.test(supmobile)) {
                    mobile_error = false;
                    $.ajax({
                        type: 'POST',
                        url: "checkExitSupplier.jsp",
                        data: {
                            "mobile": supmobile,
                            "name": supname
                        },
                        success: function (data, textStatus, jqXHR) {
                            var findata = data.trim();
                            if (findata == "exit") {
                                $("#exitsupmobile").text("Exit this account. Try another").css("color", "red");
                                mobile_error = true;
                            } else {
                                $("#exitsupmobile").text("");
                                mobile_error = false;
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {

                        }
                    });
                } else {
                    $("#exitsupmobile").text("Invalid mobile");
                    mobile_error = true;
                }
            }

            function formvalidation() {
                if(mobile_error){
                    $("#exitsupmobile").text("Something error !!")
                    return false;                    
                }
            }

            $(function () {
                $("#supplier_msg").fadeIn(500).delay(3000).fadeOut("slow");
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
