<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
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
<!doctype html>
<html lang="en">
    <head>
        <title>Tailor</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta charset="utf-8" />
        <meta contenteditable="utf8_general_ci" />
        <!--        <meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" type="image/x-icon" href="../admin/assets/img/t_mechin.jpg"/>
        <link href="/Tailor/admin/assets/css/bootstrap.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/css/font-awesome.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />       
        <link href="/Tailor/admin/assets/css/custom.css" rel="stylesheet" />      
        <link href="/Tailor/admin/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />        
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script src="http://mymaplist.com/js/vendor/TweenLite.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
        <link rel="stylesheet" href="/resources/demos/style.css" />
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <!--      for time picker-->
        <link href="../admin/assets/css/timedropper.css" rel="stylesheet" type="text/css" />
        <script src="../admin/assets/js/timedropper.js" type="text/javascript"></script>
        <!--    <script src="../admin/assets/js/jquery.js" type="text/javascript"></script>-->

        <!------------------- select2-------------------------------->
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2-bootstrap.min.css" />
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.css" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.js"></script>
        <!------------------- select2----------end---------------------->
    </head>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=customer"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="successfullMessage" title="This is title" style="display: none">
                        <h2>Successfully Update</h2>
                    </div>
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                    <%
                                        String mobile_status = null;
                                        if (session.getAttribute("mobile_success") != null) {
                                            mobile_status = "green";
                                        } else {
                                            mobile_status = "red";
                                        }
                                    %>
                                    <span class="check_mobile" style="color: <%= mobile_status%>; margin-left: 34%; display: none"><%if (session.getAttribute("check_mobile") != null) {%><%= session.getAttribute("check_mobile")%><% } else if (session.getAttribute("mobile_success") != null) {%><%= session.getAttribute("mobile_success")%><%} %><%session.removeAttribute("check_mobile");
                                    session.removeAttribute("mobile_success"); %></span>
                            </div>
                            <div class="panel-body">
                                <form action="../Customer_Registration" id="select2Form" method="post" enctype="multipart/form-data" onsubmit="return form_validation()">
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px"> গ্রাহকের নাম<span class="" style="color: red">*</span> </label>  
                                            <input type="text" class="form-control" name="cus_name" id="cus_name" onclick="checkcc()" pattern="[A-Za-z ]+" placeholder="গ্রাহকের নাম" style="height: 40px"  required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="email" style="margin-bottom:  0px">গ্রাহকের ইমেইল<span class="" style="color: red">*</span></label>  
                                            <input type="text" class="form-control" name="cus_email" id="cus_email" placeholder="গ্রাহকের ইমেইল"  style="height: 40px" onkeyup="check_mail()"/>
                                            <span id="cus_email_error" style="color: red"></span>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="cus_phone"> গ্রাহকের মোবাইল <span style="color: red">*</span> </label>  
                                            <input type="text" class="form-control" name="cus_phone" id="cus_phone" placeholder="গ্রাহকের মোবাইল" style="height: 40px;" onkeyup="check_mobile()"/>
                                            <span id="cus_mobile_error" style="color: red"></span>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="phone" style="margin-bottom:  0px"> গ্রাহকের জাতীয় পরিচয় পত্র   নং</label>  
                                            <input type="text" class="form-control" name="cus_nid_card" id="cus_ndcard" pattern="[0-9]{17}" placeholder=" গ্রাহকের জাতীয় পরিচয় পত্র    "  style="height: 40px"/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="phone" style="margin-bottom:  0px"> গ্রাহকের রক্তের গ্রুপ  <span style="color: red">*</span></label>  
                                            <select name="cus_blood" style="width: 100%; height: 40px;" required="">
                                                <option value="">Select One</option>
                                                <option>A+</option>
                                                <option>B+</option>
                                                <option>AB+</option>
                                                <option>O+</option>
                                                <option>A-</option>
                                                <option>B-</option>
                                                <option>AB-</option>
                                                <option>O-</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="phone" style="margin-bottom:  0px"> গ্রাহকের জন্ম দিন<span class="" style="color: red">*</span>  </label>  
                                            <input type="text" class="form-control" name="cus_birthdate" id="cus_birthdate" placeholder="dd-mm-yyyy"   style="height: 40px" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="address" style="margin-bottom:  0px"> গ্রাহকের ঠিকানা<span class="" style="color: red">*</span> </label>  
                                            <input type="text" class="form-control" name="cus_address" id="cus_address" placeholder="গ্রাহকের ঠিকানা" style="height: 50px" required="" />

                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="reference" style="margin-bottom:  0px"> গ্রাহকের রেফারেন্স</label>                                              
                                            <select name="cus_reference" class="form-control">
                                                <option value="">Select One</option>
                                                <%
                                                    try {
                                                        String sql_cus = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_cus = DbConnection.getConn(sql_cus);
                                                        ResultSet rs_cus = pst_cus.executeQuery();
                                                        while (rs_cus.next()) {
                                                            String cu_name = rs_cus.getString("cus_name");
                                                %>
                                                <option value="<%= cu_name%>"><%=  cu_name%></option>
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
                                            <label for="image" style="margin-bottom:  0px"> গ্রাহকের ছবি</label>  
                                            <input type="file"  name="cus_image" id="cus_image" style="width: 100%" style="height: 40px"/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2"></div>
                                        <div class="col-sm-2">
                                            <input type="submit" class="btn btn-primary" value="Submit" style="width: 80%; font-size: 15px;"/>
                                        </div>
                                        <div class="col-sm-2">
                                            <input type="reset" class="btn btn-danger" style="width: 80%; font-size: 15px;"/>
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
            var mail_pattern = true;
            var mail_exit = true;
            var mail_empty = true;
            var mobile_pattern = true;
            var mobile_exit = true;
            var mobile_empty = true;

            $(function () {
                $("#cus_birthdate").datepicker({
                    dateFormat: "dd-mm-yy",
//                    maxDate: 0,
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1980:' + (new Date()).getFullYear()
                });
            });
            $(function () {
                $('#select2Form')
                        .find('[name="cus_reference"]')
                        .select2();
            });

            function check_mail() {
                var mail = $("#cus_email").val();
                var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

                if (mail === "") {
                    $("#cus_email_error").text("Mail is required !!");
                    mail_empty = false;
                    return false;
                } else {
                    $("#cus_email_error").text("");
                    mail_empty = true;
                }
                if (re.test(mail)) {
                    $.ajax({
                        type: 'POST',
                        url: "check_mail_exit.jsp",
                        data: {
                            "mail": mail,
                            "status": "user"
                        },
                        success: function (data, textStatus, jqXHR) {
                            var fin_data = data.trim();
                            if (fin_data === "exit") {
                                $("#cus_email_error").text("Mail is Exit. Try Another");
                                mail_exit = false;
                                return false;
                            }else {
                                mail_exit = true;
                            }
                        }
                    });
                    mail_pattern = true;
                } else {
                    $("#cus_email_error").text("Invalid Email !!");
                    mail_pattern = false;
                    return false;
                }
            }

            function check_mobile() {
                var mobile = $("#cus_phone").val();
                var tst_mobile = /^01[56789]\d{8}$/;
                if (mobile === "") {
                    $("#cus_mobile_error").text("Mobile required");
                    mobile_empty = false;
                    return false;
                } else {
                    $("#cus_mobile_error").text("");
                    mobile_empty = true;
                }
                if (tst_mobile.test(mobile)) {
                    $.ajax({
                        type: 'POST',
                        url: "check_mobile_exit.jsp",
                        data: {
                            "mobile": mobile,
                            "status": "user"
                        },
                        success: function (data, textStatus, jqXHR) {
                            var fin_data = data.trim();
                            if (fin_data === "exit") {
                                $("#cus_mobile_error").text("Mobile Exit");
                                mobile_exit = false;
                                return false;
                            }else {
                                mobile_exit = true;
                            }
                        }
                    });
                    $("#cus_mobile_error").text("");
                    mobile_pattern = true;
                } else {
                    $("#cus_mobile_error").text("Invalid Mobile !!");
                    mobile_pattern = false;
                    return false;
                }
            }

            function form_validation() {
                if (!mail_pattern) {
                    $("#cus_email_error").text("You must enter valid email !!");
                    $("#cus_email").focus();
                    return false;
                }
                if (!mail_empty) {
                    $("#cus_email_error").text("You must enter email !!");
                    $("#cus_email").focus();
                    return false;
                }
                if (!mail_exit) {
                    $("#cus_email_error").text("Please Try Another Mail !!");
                    $("#cus_email").focus();
                    return false;
                }
                if (!mobile_empty) {
                    $("#cus_mobile_error").text("You must enter mobile");
                    $("#cus_phone").focus();
                    return false;
                }
                if (!mobile_pattern) {
                    $("#cus_mobile_error").text("You must enter valid mobile");
                    $("#cus_phone").focus();
                    return false;
                }
                if(!mobile_exit){
                    $("#cus_mobile_error").text("Please try another !!");
                    $("#cus_phone").focus();
                    return false;
                }
            }

            $(function () {
                $(".check_mobile").fadeIn(500).delay(3000).fadeOut("slow");
            });
        </script>
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script> 
        <script src="/Tailor/admin/assets/js/custom.js"></script>    
    </body>
</html>
