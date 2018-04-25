
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
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
    <jsp:include page="../menu/header.jsp" flush="true"/>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=user" flush="true"/> 
            <!-- /. NAV SIDE  -->
            <%
                String user_id = request.getParameter("userid");
                String user_name = null;
                String user_mail = null;
                String user_password = null;
                String user_mobile = null;
                String user_address = null;
                String user_city = null;
                String user_zipcode = null;
                String user_status = null;
                String user_ref_name = null;
                String user_ref_mobile = null;
                String user_pic = null; 
                if (user_id != null) {
                    try {
                        String sql_user_profile = "select * from user_user where user_bran_id = '" + session.getAttribute("user_bran_id") + "' and user_id = '" + user_id + "' ";
                        PreparedStatement pst_user_profile = DbConnection.getConn(sql_user_profile);
                        ResultSet rs_user_profile = pst_user_profile.executeQuery();
                        if (rs_user_profile.next()) {
                            user_name = rs_user_profile.getString("user_name");
                            user_mail = rs_user_profile.getString("user_email");
                            user_password = rs_user_profile.getString("user_password");
                            user_mobile = rs_user_profile.getString("user_mobile");
                            user_address = rs_user_profile.getString("user_address");
                            user_city = rs_user_profile.getString("user_city");
                            user_zipcode = rs_user_profile.getString("user_zipcode");
                            user_status = rs_user_profile.getString("user_status");
                            user_pic = rs_user_profile.getString("user_pic");
                            user_ref_name = rs_user_profile.getString("user_ref_name");
                            user_ref_mobile = rs_user_profile.getString("user_ref_mobile");
                        }
                    } catch (Exception e) {
                        out.println(e.toString());
                    }
                }
            %>
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                User Registration
                                <%
                                    String set_color = null;
                                    if (session.getAttribute("user_email_check_msg") != null) {
                                        if (session.getAttribute("user_email_check_msg").equals("has")) {
                                            set_color = "red";
                                        }
                                        if (session.getAttribute("user_email_check_msg").equals("inserted")) {
                                            set_color = "green";
                                        }
                                    }
                                %>
                                <center>
                                    <span class="user_check_email_msg" style="color: <%= set_color%>; font-size: 20px;">
                                        <%
                                            if (session.getAttribute("user_email_check_msg") != null) {
                                                if (session.getAttribute("user_email_check_msg").equals("has")) {
                                        %>
                                        <%= "Already taken this email"%>
                                        <%
                                            }
                                            if (session.getAttribute("user_email_check_msg").equals("inserted")) {
                                        %>
                                        <%="Registration successful"%>
                                        <%
                                                }
                                                session.removeAttribute("user_email_check_msg"); 
                                            }
                                        %>
                                    </span>

                                </center>
                            </div>
                            <div class="panel-body">
                                <form action="../user_reg" method="post" <%if (user_id == null) {%>onsubmit="return form_validation()"<%}%> enctype="multipart/form-data">
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">User Name<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="user_name" placeholder="user name" pattern="[A-Za-z ]+" <%if (user_name != null) {%> value="<%=user_name%>"<%} %> style="height: 40px; margin-bottom: 10px;" required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Email<span style="color: red;">*</span></label>
                                            <input type="email" class="form-control" name="user_email" id="user_email" placeholder="email" <%if (user_mail != null) {%>value="<%=user_mail%>"<%} %>  style="height: 40px;" required="" <%if (user_id != null) {
                                                } else {%> onkeyup="mail_check()"<%}%>/>
                                            <span id="mail_exit" style="color: red"></span>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Password<span style="color: red;">*</span></label>
                                            <input type="password" class="form-control" name="user_password" placeholder="password" <%if (user_password != null) {%>value="<%=user_password%>"<%}%> style="height: 40px; margin-bottom: 10px;" required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Mobile<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="user_mobile" id="user_mobile" placeholder="mobile" <%if (user_mobile != null) {%>value="<%=user_mobile%>"<%} %> style="height: 40px;" <%if (user_id != null) {
                                                } else {%> onkeyup="mobile_check()"<%}%>/>
                                            <span id="mobile_exit" style="color: red;"></span>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Address<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="user_address" placeholder="address" <%if (user_address != null) {%>value="<%=user_address%>"<%} %> style="height: 40px; margin-bottom: 10px" required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">City<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="user_city" placeholder="city" pattern="[A-Za-z]+" <%if (user_city != null) {%>value="<%=user_city%>"<%} %> style="height: 40px;" required=""/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Ref. Name</label>
                                            <input type="text" class="form-control" name="user_ref_name" <%if(user_ref_name != null){%>value="<%=user_ref_name%>"<%}%>/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Ref. Mobile</label>
                                            <input type="text" class="form-control" name="user_ref_mobile" <%if(user_ref_mobile != null){%>value="<%=user_ref_mobile%>"<%}%>/>
                                        </div>
                                    </div>
                                    <div class="row">     
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Zip Code</label>
                                            <input type="text" class="form-control" name="user_zipcode" <%if (user_zipcode != null) {%>value="<%=user_zipcode%>"<%}%> maxlength="10" style="height: 40px" />
                                        </div>
                                        <%
                                            if (user_id != null) {
                                        %>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Status</label>
                                            <select name="user_status" class="form-control">
                                                <%
                                                    if (user_status != null) {
                                                        if (user_status.equals("1")) {
                                                %>
                                                <option value="1">Active</option>
                                                <%
                                                } else if (user_status.equals("2")) {
                                                %>
                                                <option value="2">Inactive</option>
                                                <%
                                                        }
                                                    }
                                                %>
                                                <option value="1">Active</option>
                                                <option value="2">Inactive</option>
                                            </select>
                                        </div>
                                        <input type="text" name="user_id" value="<%=user_id%>" style="display: none" />
                                        <input type="text" name="user_pic_old" value="<%=user_pic%>" style="display: none" />
                                        <%
                                            }
                                        %>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">User Pic</label>
                                            <input type="file" class="form-control" id="imgInp" name="user_pic"/>
                                            <img src="../images/<%=user_pic%>"  style="margin-top: 8px; background: blue" id="blah" class="img-rounded" width="100" height="100" alt=""/>
                                        </div>                                        
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5">

                                        </div>
                                        <div class="col-sm-5" style="margin-top: 10px">
                                            
                                            <%
                                                if(user_id != null){
                                                    %>
                                                    <input type="submit" class="btn btn-primary" value="Update" />
                                                    <a href="all_users.jsp" class="btn btn-primary">Cancel</a>
                                                    <%
                                                }else {
                                                    %>
                                                    <input type="submit" class="btn btn-primary" value="Submit" />
                                                    <input type="reset" class="btn btn-success" value="Cancel" />
                                                    <%
                                                }
                                                %>
                                            
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>                                                    <!-- /. PAGE INNER  -->
                </div>                                                    <!-- /. PAGE WRAPPER  -->
            </div>
        </div>
        <script>
            var mail_exit = true;
            var mail_pattern = true;
            var mail_empty = false;
            var mobile_exit = true;
            var mobile_pattern = true;
            var mobile_empty = true;
            
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

            function mail_check() {
                var mail = $("#user_email").val();
                var e_pattern = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if (mail == null || mail == "") {
                    mail_empty = true;
                    $("#mail_exit").text("Mail Required !!");
                    return false;
                } else {
                    $("#mail_exit").text("");
                }
                if (e_pattern.test(mail)) {
                    $("#mail_exit").text("");
                    $.ajax({
                        type: 'POST',
                        url: "check_mail_exit.jsp",
                        data: {
                            "mail": mail
                        },
                        success: function (data, textStatus, jqXHR) {
                            var findata = data.trim();
                            if (findata === "exit") {
                                mail_exit = true;
                                $("#mail_exit").text("mail exit");
                            } else {
                                $("#mail_exit").text("");
                                mail_exit = false;
                            }
                            console.log(findata + " findata");
                        }
                    });
                } else {
                    $("#mail_exit").text("Please enter correct email");
                    mail_pattern = true;
                    return false;
                }
            }

            function mobile_check() {
                var mobile = $("#user_mobile").val();
                var pattern = /^01[56789]\d{8}$/;
                if (mobile == null || mobile == "") {
                    $("#mobile_exit").text("mobile required !!");
                    mobile_empty = true;
                    return false;
                } else {
                    $("#mobile_exit").text("mobile required !!");
                    mobile_empty = false;
                }
                if (pattern.test(mobile)) {
                    mobile_pattern = false;
                    $.ajax({
                        type: 'POST',
                        url: "check_mobile_exit.jsp",
                        data: {
                            "mobile": mobile
                        },
                        success: function (data, textStatus, jqXHR) {
                            var findata = data.trim();
                            if (findata === "exit") {
                                $("#mobile_exit").text("mobile exit");
                                mobile_exit = true;
                            } else {
                                $("#mobile_exit").text("");
                                mobile_exit = false;
                            }
                        }
                    });
                } else {
                    $("#mobile_exit").text("Invalid mobile");
                    mobile_pattern = true;
                    return false;
                }
            }

            function form_validation() {
                if (mail_exit) {
                    $("#mail_exit").text("mail exit !!");
                    return false;
                }

                if (mobile_empty) {
                    $("#mobile_exit").text("You must enter mobile !!");
                    return false;
                }
                if (mobile_exit) {
                    $("#mobile_exit").text("mobile exit !!");
                    return false;
                }
                if (mobile_pattern) {
                    $("#mobile_exit").text("Invalid format !!");
                    return false;
                }
                //console.log("mobile status " + mobile_status);
            }

            $(function () {
                $(".user_check_email_msg").show("slow").delay(3500).hide("slow");
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
