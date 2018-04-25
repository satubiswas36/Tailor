
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

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;"><%
                                String com_email_check = null;
                                if (session.getAttribute("com_email_check_msg") != null) {
                                    if (session.getAttribute("com_email_check_msg").equals("has")) {
                                        com_email_check = "red";
                                    }
                                    if (session.getAttribute("com_email_check_msg").equals("inserted")) {
                                        com_email_check = "green";
                                    }
                                }
                                %>
                                <center><span class="check_email" style="color: <%= com_email_check%>; font-size: 20px;"><%
                                    if (session.getAttribute("com_email_check_msg") != null) {
                                        if (session.getAttribute("com_email_check_msg").equals("has")) {
                                        %>
                                        <%= "Already taken this email"%>
                                        <%
                                            }
                                            if (session.getAttribute("com_email_check_msg").equals("inserted")) {
                                        %>
                                        <%= "Registration successfull"%>
                                        <%
                                                }
                                            }
                                            session.removeAttribute("com_email_check_msg");
                                        %>
                                    </span></center>
                            </div>
                            <div class="panel-body">
                                <form id="com_reg_form" action="../com_reg" method="post" onsubmit="return form_validation()">                                    
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">Company Name<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="com_name" placeholder="company name" pattern="[A-Za-z ]+" id="com_name" <%if (session.getAttribute("com_name") != null) {%>value="<%= session.getAttribute("com_name")%>"<%} %> style="height: 35px; margin-bottom: 10px" required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Email<span style="color: red;">*</span></label>
                                            <input type="email" class="form-control" name="com_email" id="com_email" placeholder="email" <%if (session.getAttribute("com_email") != null) {%>value="<%=session.getAttribute("com_email")%>"<%} %> style="height: 35px;" required="" onkeyup="mail_check()"/>
                                            <span id="mail_exit" style="color: red;"></span>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Password<span style="color: red;">*</span></label>
                                            <input type="password" class="form-control" name="com_password" id="com_password" placeholder="password" style="height: 35px; margin-bottom: 10px" required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Mobile<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="com_mobile" id="com_mobile" pattern="01[56789]\d{8}" <%if (session.getAttribute("com_mobile") != null) {%>value="<%=session.getAttribute("com_mobile")%>"<%} %> placeholder="mobile" maxlength="11" style="height: 35px;" required="" onkeyup="mobile_check()"/>
                                            <span id="mobile_exit" style="color: red;"></span>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Phone</label>
                                            <input type="text" class="form-control" name="com_phone" id="com_phone" placeholder="phone" <%if (session.getAttribute("com_phone") != null) {%>value="<%=session.getAttribute("com_phone")%>"<%} %> style="height: 35px; margin-bottom: 10px;"/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Fax No</label>
                                            <input type="text" class="form-control" name="com_fax" id="com_fax" <%if (session.getAttribute("com_fax") != null) {%>value="<%= session.getAttribute("com_fax")%>"<%} %>  style="height: 35px;"/>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Address<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="com_address" id="com_address" placeholder="address" <%if (session.getAttribute("com_address") != null) {%>value="<%=session.getAttribute("com_address")%>"<%} %> style="height: 35px; margin-bottom: 10px" required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">City<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="com_city" id="com_city" pattern="[A-Za-z ]+" placeholder="city" <%if (session.getAttribute("com_city") != null) {%>value="<%=session.getAttribute("com_city")%>"<%} %> style="height: 35px;" required=""/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Zip Code</label>
                                            <input type="text" class="form-control" name="com_zipcode" id="com_zipcode" <%if (session.getAttribute("com_zipcode") != null) {%>value="<%=session.getAttribute("com_zipcode")%>"<%} %> style="height: 35px;" />
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Business Type</label>
                                            <input type="text" class="form-control" name="com_bus_type" id="com_bus_type" placeholder="company type" <%if (session.getAttribute("com_bus_type") != null) {%>value="<%=session.getAttribute("com_bus_type")%>"<%} %> style="height: 35px; margin-bottom: 10px"/>
                                        </div>
                                    </div>
                                    <div class="row">   
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Open Time</label>
                                            <input type="text" class="form-control"  name="com_open_time" id="com_open_time" style="height: 35px; margin-bottom: 10px;" required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Close Time</label>
                                            <input type="text" class="form-control" name="com_close_time" id="com_close_time" style="height: 35px;" required=""/>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Web Site<span style="color: red;">*</span></label>
                                            <input type="url" class="form-control" name="com_website" id="com_website" placeholder="web site" <%if (session.getAttribute("com_website") != null) {%>value="<%=session.getAttribute("com_website")%>"<%} %> style="height: 35px; margin-bottom: 10px;" required=""/>
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Company Type</label>
                                            <input type="text" class="form-control" name="com_type" id="com_type" <%if (session.getAttribute("com_type") != null) {%>value="<%=session.getAttribute("com_type")%>"<%} %> placeholder="company type" style="height: 35px;"/>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-5" style="margin: 0px">                                            
                                            <label for="com_taxable" style="margin: 0px;">Taxable</label>
                                            <select name="com_taxable" class="form-control">
                                                <%
                                                    String tax = null;
                                                    if (session.getAttribute("com_taxable") != null) {
                                                        if (session.getAttribute("com_taxable").equals("0")) {
                                                            tax = "No";
                                                        } else {
                                                            tax = "Yes";
                                                        }
                                                %>
                                                <option value="<%=session.getAttribute("com_taxable")%>"><%if (session.getAttribute("com_taxable") != null) {%><%=tax%><% } else {%><%="Select One"%><%} %></option>
                                                <%
                                                } else {
                                                %>
                                                <option value="">Select One</option>
                                                <%
                                                    }
                                                %>
                                                <option value="1">Yes</option>
                                                <option value="0">No</option>
                                            </select>
                                        </div>                                        
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Expire Date<span style="color: red;">*</span></label>
                                            <input type="text" class="form-control" name="com_expiredate" id="com_expiredate" <%if (session.getAttribute("com_expiredate") != null) {%>value="<%=session.getAttribute("com_expiredate")%>"<%}%>  style="height: 35px; margin-bottom: 10px" required=""/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px">Company Sender ID</label>
                                            <input type="text" class="form-control" name="com_sender_id" id="com_sender_id"  placeholder="company type" style="height: 35px;"/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-5"></div>
                                        <div class="col-sm-5">
                                            <input type="submit" class="btn btn-primary" value="Submit"/>
                                            <input type="reset" class="btn btn-danger" value="Cancel"/>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /. PAGE INNER  -->
            </div>
            <!-- /. PAGE WRAPPER  -->
        </div>                          
        <script>
            var mail_status;
            var mobile_status;
            var mobile_pattern = true;
            $(function () {
                $("#com_open_time").timeDropper({
                    format: 'h:mm a',
                    autoswitch: false,
                    meridians: false,
                    mousewheel: false,
                    setCurrentTime: true,
                    init_animation: "fadein",
                    primaryColor: "#1977CC",
                    borderColor: "#1977CC",
                    backgroundColor: "#FFF",
                    textColor: '#555'
                });

                $("#com_close_time").timeDropper({
                    format: 'h:mm a',
                    autoswitch: false,
                    meridians: false,
                    mousewheel: false,
                    setCurrentTime: true,
                    init_animation: "fadein",
                    primaryColor: "#1977CC",
                    borderColor: "#1977CC",
                    backgroundColor: "#FFF",
                    textColor: '#555'
                });
                $("#com_expiredate").datepicker({
                    dateFormat: "dd-mm-yy",
                    minDate: 365
                });
            });

            $(function () {
                $(".check_email").fadeIn("slow").delay(3000).fadeOut("slow");
            });
            
            function mail_check() {
                var email = $("#com_email").val();
                $.ajax({
                    type: 'POST',
                    url: "check_mail_exit.jsp",
                    data: {
                        "mail": email
                    },
                    success: function (data, textStatus, jqXHR) {
                        var findata = data.trim();
                        if (findata === "exit") {
                            mail_status = false;
                            $("#mail_exit").text("mail exit");
                        } else {
                            $("#mail_exit").text("");
                            mail_status = true;
                        }
                        //console.log(findata);
                    }
                });
            }

            function mobile_check() {
                var mobile = $("#com_mobile").val();
                var pattern = /^01[56789]\d{8}$/;
                if (mobile === null || mobile === "") {
                    $("#mobile_exit").text("mobile required !!");
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
                                $("#mobile_exit").text("mobile exit");
                                mobile_status = false;
                            } else {
                                $("#mobile_exit").text("");
                                mobile_status = true;
                            }
                            // console.log(findata + " for mobile " + mobile_status);
                        }
                    });
                } else {
                    $("#mobile_exit").text("Invalid mobile");
                    mobile_pattern = false;
                    return false;
                }
                console.log(pattern.test(mobile) + " test");
            }

            function form_validation() {
                if (!mail_status) {
                    $("#mail_exit").text("mail exit !!");
                    return false;
                }
                if (!mobile_status) {
                    $("#mobile_exit").text("mobile exit !!");
                    return false;
                }
                console.log("mobile status " + mobile_status);
            }
        </script>        
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>
        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
