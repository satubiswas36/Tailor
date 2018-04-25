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

<!DOCTYPE html>
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
        <link href="/Tailor/admin/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
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

        <!--      for time picker-->

        <link href="../admin/assets/css/timedropper.css" rel="stylesheet" type="text/css"/>
        <script src="../admin/assets/js/timedropper.js" type="text/javascript"></script>
        <!--    <script src="../admin/assets/js/jquery.js" type="text/javascript"></script>-->   
        <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css"/>
        <style>
            .btn-bs-file{
                position:relative;
            }
            .btn-bs-file input[type="file"]{
                position: absolute;

                filter: alpha(opacity=0);
                opacity: 0;
                width:0;
                height:0;
                outline: none;
                cursor: inherit;
            }
        </style>
    </head>
    <body>
        <%
            String bran_id = request.getParameter("bran_id");
            String com_sender_id = null;
            // jodi company thaka branch create kora hoy tahole sender id ta brach sender id ta bosba. so that i find sender id from company
            try {
                String sql_com_sender_id = "select * from user_company where com_company_id = '" + session.getAttribute("user_com_id") + "' ";
                PreparedStatement pst_com_sender_id = DbConnection.getConn(sql_com_sender_id);
                ResultSet rs_com_sender_id = pst_com_sender_id.executeQuery();
                if (rs_com_sender_id.next()) {
                    com_sender_id = rs_com_sender_id.getString("com_sender_id");
                }
            } catch (Exception e) {
                out.println(e.toString());
            }

            String bran_name = null;
            String bran_email = null;
            String bran_password = null;
            String bran_mobile = null;
            String bran_phone = null;
            String bran_fax = null;
            String bran_address = null;
            String bran_city = null;
            String bran_open_time = null;
            String bran_close_time = null;
            String bran_zipcode = null;
            String bran_taxable = null;
            String bran_business_type = null;
            String bran_website = null;
            String bran_expire_date = null;
            String bran_sender_id = null;
            String bran_message_time = null;
            String bran_image_name = null;
            String bran_status = null;
            String bran_person_name = null;
            String bran_order_no = null;

            try {
                String sql_bran_details = "select * from user_branch where bran_id = '" + bran_id + "' ";
                PreparedStatement pst_bran_details = DbConnection.getConn(sql_bran_details);
                ResultSet rs_bran_details = pst_bran_details.executeQuery();
                if (rs_bran_details.next()) {
                    bran_name = rs_bran_details.getString("bran_name");
                    bran_email = rs_bran_details.getString("bran_email");
                    bran_password = rs_bran_details.getString("bran_password");
                    bran_mobile = rs_bran_details.getString("bran_mobile");
                    bran_phone = rs_bran_details.getString("bran_phone");
                    bran_fax = rs_bran_details.getString("bran_fax_no");
                    bran_address = rs_bran_details.getString("bran_address");
                    bran_city = rs_bran_details.getString("bran_city");
                    bran_zipcode = rs_bran_details.getString("bran_zipcode");
                    bran_taxable = rs_bran_details.getString("bran_is_taxable");
                    bran_business_type = rs_bran_details.getString("bran_business_type");
                    bran_website = rs_bran_details.getString("bran_website");
                    bran_expire_date = rs_bran_details.getString("bran_expire_date");
                    bran_open_time = rs_bran_details.getString("bran_open_time");
                    bran_close_time = rs_bran_details.getString("bran__close_time");
                    bran_sender_id = rs_bran_details.getString("bran_sender_id");
                    bran_message_time = rs_bran_details.getString("bran_message_time");
                    bran_image_name = rs_bran_details.getString("bran_com_logo");
                    bran_status = rs_bran_details.getString("bran_status");
                    bran_person_name = rs_bran_details.getString("bran_person_name");
                    bran_order_no = rs_bran_details.getString("bran_order_no");
                }
            } catch (Exception e) {
                out.println(e.toString());
            }
        %>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                Branch Registration
                                <%
                                    String set_color = null;
                                    if (session.getAttribute("bran_email_check_msg") != null) {
                                        if (session.getAttribute("bran_email_check_msg").equals("has")) {
                                            set_color = "red";
                                        }
                                        if (session.getAttribute("bran_email_check_msg").equals("inserted")) {
                                            set_color = "green";
                                        }
                                    }
                                    if (session.getAttribute("bran_mobile_check_msg") != null) {
                                        if (session.getAttribute("bran_mobile_check_msg").equals("has")) {
                                            set_color = "red";
                                        }
                                    }
                                %>
                                <center><span class="branch_message" style="color: <%= set_color%>; font-size: 20px">
                                        <%
                                            if (session.getAttribute("bran_email_check_msg") != null) {
                                                if (session.getAttribute("bran_email_check_msg").equals("has")) {
                                        %>
                                        <%= "Already taken this email"%>
                                        <%
                                            }
                                            if (session.getAttribute("bran_email_check_msg").equals("inserted")) {
                                        %>
                                        <%= "Registration successful"%>
                                        <%
                                                }
                                            }
                                            if (session.getAttribute("") != null) {
                                                if (session.getAttribute("bran_mobile_check_msg").equals("has")) {
                                        %>
                                        <%= "Already taken this Mobile"%>
                                        <% }
                                            }
                                            if (session.getAttribute("bran_email_check_msg") != null) {
                                                session.removeAttribute("bran_email_check_msg");
                                            }
                                            if (session.getAttribute("bran_mobile_check_msg") != null) {
                                                session.removeAttribute("bran_mobile_check_msg");
                                            }
                                        %>
                                    </span></center>
                            </div>
                            <div class="panel-body">
                                <form class="form-group" <%if (bran_id != null) {%>action="../Branch_Update"<%} else {%> action="../branch_reg"<%}%> method="post" enctype="multipart/form-data" onsubmit="return form_validation()">
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Branch Name<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="bran_name" placeholder="branch name" <%if (bran_name != null) {%>value="<%=bran_name%>"<%} %> pattern="[A-Za-z ]+" style="margin-bottom: 10px; height: 35px;" required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Email<span style="color: red;">*</span></label>
                                            <%
                                                if (bran_id == null) {
                                            %>
                                            <input type="email" class="form-control" name="bran_email" id="bran_email" <%if (bran_email != null) {%>value="<%=bran_email%>"<%}%> onkeyup="mail_check()" placeholder="email" style="height: 35px;" required=""/>
                                            <%
                                            } else {
                                            %>
                                            <input type="email" class="form-control" name="bran_email" id="bran_email" <%if (bran_email != null) {%>value="<%=bran_email%>"<%}%> onkeyup="check_mail_pattern()" placeholder="email" style="height: 35px;" required=""/>
                                            <%
                                                }
                                            %>
                                            <span id="exit_mail" style="color: red; font-style: italic"></span>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Password<span style="color: red;">*</span></label>
                                            <input type="password" class="form-control" name="bran_password" <%if (bran_password != null) {%>value="<%=bran_password%>"<%} %> placeholder="password" style="height: 35px; margin-bottom: 10px" required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Mobile<span style="color: red;">*</span></label>
                                            <%
                                                if (bran_id == null) {
                                            %>
                                            <input type="text" class="form-control" name="bran_mobile" id="bran_mobile" <%if (bran_mobile != null) {%>value="<%=bran_mobile%>"<%}%> placeholder="mobile" pattern="01[56789]\d{8}" onkeyup="mobile_check()" required=""/>
                                            <%
                                            } else {
                                            %>
                                            <input type="text" class="form-control" name="bran_mobile" id="bran_mobile" <%if (bran_mobile != null) {%>value="<%=bran_mobile%>"<%}%> placeholder="mobile" pattern="01[56789]\d{8}" required=""/>
                                            <%
                                                }
                                            %>
                                            <span id="mobile_error" style="color: red"></span>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Phone</label>
                                            <input type="text" class="form-control" name="bran_phone" <%if (bran_phone != null) {%>value="<%=bran_phone%>"<%} %> placeholder="phone" style="height: 35px; margin-bottom: 10px"/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Fax No</label>
                                            <input type="text" class="form-control" name="bran_fax" placeholder="fax no" <%if (bran_fax != null) {%>value="<%=bran_fax%>"<%}%>/>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Address<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="bran_address" placeholder="address" <%if (bran_address != null) {%>value="<%=bran_address%>"<%} %> style="height: 35px; margin-bottom: 10px" required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">City<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="bran_city" placeholder="city"  <%if (bran_city != null) {%>value="<%=bran_city%>"<%}%> pattern="[A-Za-z ]+" required=""/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Zip Code</label>
                                            <input type="text" class="form-control" name="bran_zipcode" placeholder="zip code" <%if (bran_zipcode != null) {%>value="<%=bran_zipcode%>"<%} %> />
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Business Type</label>
                                            <input type="text" class="form-control" name="bran_bus_type" placeholder="branch type" style="height: 35px; margin-bottom: 10px;" <%if (bran_business_type != null) {%>value="<%=bran_business_type%>"<%}%> />
                                        </div>
                                    </div>
                                    <div class="row">  
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Open Time</label>
                                            <input type="text" class="form-control" name="bran_open_time" id="bran_open_time"  <%if (bran_open_time != null) {%>value="<%=bran_open_time%>"<%} %>/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Close Time</label>
                                            <input type="text" class="form-control" name="bran_close_time" id="bran_close_time" style="margin-bottom: 10px;"  <%if (bran_close_time != null) {%>value="<%=bran_close_time%>"<%}%>/>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Web Site</label>
                                            <input type="url" class="form-control" name="bran_website" placeholder="web site"  <%if (bran_website != null) {%>value="<%=bran_website%>"<%} %> style="height: 35px; margin-bottom: 10px;"/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="taxable" style="margin: 0px;">Taxable</label>
                                            <select name="taxable" class="form-control">
                                                <%
                                                    String bran_taxable_status = null;
                                                    if (bran_taxable != null) {
                                                        if (bran_taxable.equals("1")) {
                                                            bran_taxable_status = "Yes";
                                                        } else if (bran_taxable.equals("0")) {
                                                            bran_taxable_status = "No";
                                                        }
                                                    }
                                                %>
                                                <%
                                                    if (bran_taxable != null) {
                                                %>
                                                <option value="<%=bran_taxable%>"><%=bran_taxable_status%></option>
                                                <%
                                                    }
                                                %>
                                                <option value="">Select One</option>
                                                <option value="1">Yes</option>
                                                <option value="0">No</option>
                                            </select>
                                        </div>                                        
                                    </div>
                                    <div class="row">            
                                        <div class="col-sm-5">
                                            <label form="bran_sender_id" style="margin: 0px;">Branch Sender ID</label>
                                            <%
                                                if (com_sender_id != null) {
                                            %>
                                            <input type="text" name="bran_sender_id" class="form-control" style=""  <%if (com_sender_id != null) {%>value="<%=com_sender_id%>"<%} %>/>
                                            <%
                                            } else {
                                            %>
                                            <input type="text" name="bran_sender_id" class="form-control" style=""  <%if (bran_sender_id != null) {%>value="<%=bran_sender_id%>"<%} %>/>
                                            <%
                                                }
                                            %>                                                
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Expire Date<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="bran_expire_date" id="bran_expiredate" style="" <%if (bran_expire_date != null) {%>value="<%=bran_expire_date%>"<%}%> required=""/>
                                        </div>  
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin-top: 8px;">Person Name<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="bran_person_name" placeholder="person name" style="height: 35px; margin-bottom: 10px;" <%if (bran_person_name != null) {%>value="<%=bran_person_name%>"<%}%> required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin-top: 8px;">Order No</label>
                                            <input type="text" name="order_no" <%if (bran_order_no != null) {%>value="<%=bran_order_no%>"<%}%> class="form-control" />
                                        </div>                                                                          
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="message" style="margin-bottom:  0px; margin-top: 8px;">Messaging Service :</label><br/>
                                            <input type="checkbox" name="chk"  <%if (bran_message_time != null) {
                                                           if (bran_message_time.contains("order_create")) {%>checked=""<%}
                                                               } %> value="order_create" style=""/>Create Order
                                            <input type="checkbox" name="chk" <%if (bran_message_time != null) {
                                                           if (bran_message_time.contains("order_complete")) {%>checked=""<%}
                                                               } %> value="order_complete" style="margin-left: 8px"/>Complete Order
                                            <input type="checkbox" name="chk"  <%if (bran_message_time != null) {
                                                           if (bran_message_time.contains("order_delivery")) {%>checked=""<%}
                                                               } %> value="order_delivery"  style="margin-left: 8px"/>Delivery Order
                                            <input type="checkbox" name="chk"  <%if (bran_message_time != null) {
                                                           if (bran_message_time.contains("payment_pay")) {%>checked=""<%}
                                                       }
                                                   %> value="payment_pay"  style="margin-left: 8px"/>Payment Pay <br/>
                                            <%
                                                if (bran_id != null) {
                                            %>
                                            <input type="text" value="<%=bran_id%>" name="bran_id" style="display: none"/>
                                            <input type="text" value="<%=bran_image_name%>" name="bran_image_name" style="display: none"/>
                                            <label style="margin-top: 8px">Status<span style="color: red;">*</span></label>
                                            <select name="active_status" class="form-control" required="">
                                                <%
                                                    String bran_active_or_not = null;
                                                    if (bran_status != null) {
                                                        if (bran_status.equals("1")) {
                                                            bran_active_or_not = "Active";
                                                        } else if (bran_status.equals("2")) {
                                                            bran_active_or_not = "Expired";
                                                        } else if (bran_status.equals("3")) {
                                                            bran_active_or_not = "Suspend";
                                                        }
                                                    }
                                                %>
                                                <%
                                                    if (bran_status != null) {
                                                %>
                                                <option value="<%=bran_status%>"><%=bran_active_or_not%></option>
                                                <%
                                                    }
                                                %>                                                
                                                <option value="1">Active</option>
                                                <option value="2">Expired</option>
                                                <option value="3">Suspend</option>
                                            </select>
                                            <%
                                                }
                                            %>
                                        </div>
                                        <div class="col-sm-3">
                                            <label form="logo" style="margin-top: 8px;">Branch Logo<span style="color: red;">*</span></label>                                            
                                            <label class="btn-bs-file btn btn-primary" style="margin-top: 8px">
                                                Browse
                                                <input type="file" name="logo" id="imgInp" style="" <%if (bran_id == null) {%>required=""<%}%> />
                                            </label>
                                            <img src="../images/<%=bran_image_name%>"  style="margin-top: 8px; background: blue" id="blah" class="img-rounded" width="100" height="100" alt=""/>                                            
                                        </div>  
                                    </div>

                                    <div class="row">                            
                                        <div class="col-sm-5"> </div>
                                        <div class="col-sm-5" style="margin-top: 10px">
                                            <input type="submit" class="btn btn-primary" value="Submit" />
                                            <input type="reset" class="btn btn-success" value="Cancel" />
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
            var mail_status = true;
            var mail_pattern = true;
            var mobile_status = true;
            var mobile_pattern = true;

            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#blah').attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
            $("#imgInp").change(function () {
                readURL(this);
            });

            $("#bran_expiredate").datepicker({
                dateFormat: "dd-mm-yy",
                minDate: 365
            });
            $('#bran_open_time').timepicker({
                timeFormat: 'h:mm p',
                interval: 60,
                minTime: '8',
                maxTime: '11:00pm',
                defaultTime: '9',
                startTime: '10:00',
                dynamic: false,
                dropdown: true,
                scrollbar: true
            });

            $('#bran_close_time').timepicker({
                timeFormat: 'h:mm p',
                interval: 60,
                minTime: '8',
                maxTime: '11:00pm',
                defaultTime: '22',
                startTime: '10:00',
                dynamic: false,
                dropdown: true,
                scrollbar: true
            });
            $(function () {
                $(".branch_message").show("slow").delay(3000).hide("slow");
            });

            function mail_check() {
                var bran_email = $("#bran_email").val();
                var e_pattern = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if (e_pattern.test(bran_email)) {
                    $.ajax({
                        type: 'POST',
                        url: "check_mail_exit.jsp",
                        data: {
                            "mail": bran_email
                        },
                        success: function (data, textStatus, jqXHR) {
                            var findata = data.trim();
                            if (findata === "exit") {
                                mail_status = false;
                                $("#exit_mail").text("mail exit");
                            } else {
                                $("#exit_mail").text("");
                                mail_status = true;
                            }
                            console.log(findata);
                        }
                    });
                } else {
                    $("#exit_mail").text("Invalid Email");
                    mail_pattern = false;
                    return false;
                }
            }

            function check_mail_pattern() {
                var e_mail = $("#bran_email").val();
                var e_pattern = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if (e_pattern.test(e_mail)) {
                    mail_pattern = true;
                } else {
                    $("#exit_mail").text("Invalid Email");
                    mail_pattern = false;
                    return false;
                }
            }

            function mobile_check() {
                var mobile = $("#bran_mobile").val();
                var pattern = /^01[56789]\d{8}$/;
                if (mobile === null || mobile === "") {
                    $("#mobile_error").text("mobile required !!");
                    mobile_pattern = false;
                    return false;
                }
                if (pattern.test(mobile)) {
                    $.ajax({
                        type: 'POST',
                        url: "check_mobile_exit.jsp",
                        data: {
                            "mobile": mobile
                        },
                        success: function (data, textStatus, jqXHR) {
                            var findata = data.trim();
                            if (findata === "exit") {
                                $("#mobile_error").text("mobile exit");
                                mobile_status = false;
                            } else {
                                $("#mobile_error").text("");
                                mobile_status = true;
                            }
                            // console.log(data);
                        }
                    });
                } else {
                    $("#mobile_error").text("Invalid mobile");
                    mobile_pattern = false;
                    return false;
                }
               // console.log(pattern.test(mobile) + " test");
            }

            function form_validation() {
                if (!mail_status) {
                    $("#exit_mail").text("mail exit !!");
                    return false;
                }
                if (!mobile_status) {
                    $("#mobile_error").text("mobile exit !!");
                    return false;
                }
                if (!mail_pattern) {
                    $("#exit_mail").text("Invalid Email !!");
                    return false;
                }
                //console.log("mobile status " + mobile_status);
            }
        </script>
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script> 
        <script src="/Tailor/admin/assets/js/custom.js"></script>    
    </body>
</html>
