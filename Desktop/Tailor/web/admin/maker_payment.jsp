
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%
    String logger = (String) session.getAttribute("logger");
    String branch_id = (String) session.getAttribute("user_bran_id");
    String last_status = null;
    String sl_no = null;

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

<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Calendar"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
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
            <jsp:include page="../menu/menu.jsp?page_name=maker" flush="true"/> 
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 45px">
                                Maker Payment :<span class="payment_status" style="color: green; font-size: 18px; margin-left: 10%"><% if (session.getAttribute("maker_payment_status") != null) {%><%="Successfully added!!"%><%} %></span><%session.removeAttribute("maker_payment_status"); %>
                                <%
                                    String baseUrl = request.getRequestURL().substring(0, request.getRequestURL().length() - request.getRequestURI().length()) + request.getContextPath();
                                    
                                %>
                                <%=baseUrl %>
                            </div>
                            <div class="panel-body">
                                <form action="" id="select2Form" class="form-horizontal"  method="post">
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="selectbasic">Maker Name</label>
                                        <div class="col-md-4">
                                            <select name="maker_name" id="maker_name"  class="form-control select2-select"
                                                    data-placeholder="Please Select Customer" required="">

                                                <option value="">Select maker</option>
                                                <%
                                                    String maker_name = null;
                                                    String maker_id = null;
                                                    try {
                                                        String sql_maker_name = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' order by mk_name asc";
                                                        PreparedStatement pst_maker_name = DbConnection.getConn(sql_maker_name);
                                                        ResultSet rs_maker_name = pst_maker_name.executeQuery();
                                                        while (rs_maker_name.next()) {
                                                            maker_name = rs_maker_name.getString("mk_name");
                                                            maker_id = rs_maker_name.getString("mk_slno");
                                                %>
                                                <option value="<%=maker_id%>"><%=maker_name%></option>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="description">Description</label>
                                        <div class="col-md-4">
                                            <input type="text" name="description" id="description" class="form-control" maxlength="40" required=""/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="customer_description">Bank</label>
                                        <div class="col-md-4">
                                            <select name="bank_name" id="bank_name" class="form-control select2-select">
                                                <option value="no">Select</option>
                                                <%
                                                    try {
                                                        String bank_id = null;
                                                        //String acc_no = null;
                                                        String sql_bank_id = "SELECT DISTINCT bk_name FROM bank_account WHERE bk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_bank_id = DbConnection.getConn(sql_bank_id);
                                                        ResultSet rs_bank_id = pst_bank_id.executeQuery();
                                                        while (rs_bank_id.next()) {
                                                            bank_id = rs_bank_id.getString("bk_name");
                                                            // acc_no = rs_bank_id.getString("bk_account_no");
                                                            String sql_bank_name = "select bank_name from bank where sl = '" + bank_id + "' ";
                                                            PreparedStatement pst_bank_name = DbConnection.getConn(sql_bank_name);
                                                            ResultSet rs_bank_name = pst_bank_name.executeQuery();
                                                            if (rs_bank_name.next()) {
                                                %>
                                                <option value="<%=bank_id%>"><%=rs_bank_name.getString("bank_name")%></option>
                                                <%
                                                            }
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="customer_description">Account No</label>
                                        <div class="col-md-4">
                                            <select name="account_no" id="account_no" class="form-control">

                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="payment">Payment</label>
                                        <div class="col-md-2">
                                            <input type="text" name="amount" pattern="^[1-9][0-9]*$" id="amount" class="form-control" maxlength="8"  placeholder="amount" onkeyup="check_amount()" onclick="return checkBankSelect()"/>
                                            <span id="amount_error" style="color: red"></span>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="text" name="bonus" pattern="^[1-9][0-9]*$" id="bonus" class="form-control" placeholder="bonus" maxlength="8" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="date">Payment Date</label>
                                        <div class="col-md-4">
                                            <%
                                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                Date date = new Date();
                                                String date_f = dateFormat.format(date);
                                            %>
                                            <input type="text" class="form-control" value="<%= date_f%>" name="date" id="date" placeholder="dd-mm-yyyy"   style="height: 40px" required=""/>
                                        </div>
                                        <input type="text" name="page_status" id="page_status" value="maker_payment" style="display: none" />
                                    </div>
                                    <center> <input type="button" class="btn btn-success" id="btnsubmit" value="Submit" /></center>
                                </form>
                            </div>  
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            var amount_pattern_true = true;
            var amount_insaffient = false;

            function checkBankSelect() {
                var from_bank = $("#bank_name").val();
                if (from_bank == "no") {
                    $("#amount_error").text("Select bank firstly !!");
                    $("#bank_name").focus();
                    return false;
                }
            }

            function check_amount() {
                var amount = $("#amount").val();
                var from_bank = $("#bank_name").val();
                var from_account_no = $("#account_no").val();
                var reg = /^\d+$/;
                if (reg.test(amount)) {
                    $("#amount_error").text("");
                    amount_pattern_true = true;
                    $.ajax({
                        type: 'POST',
                        url: "check_amount.jsp",
                        data: {
                            "amount": amount,
                            "bank_id": from_bank,
                            "account_no": from_account_no
                        },
                        success: function (data, textStatus, jqXHR) {
                            var fin_data = data.trim();
                            console.log(fin_data);

                            if (fin_data === "insufficient") {
                                amount_insaffient = true;
                                $("#amount_error").text("insufficient balance");
                            } else {
                                amount_insaffient = false;
                                $("#amount_error").text("");
                            }
                        }
                    });
                } else {
                    $("#amount_error").text("Only digit allow");
                    amount_pattern_true = false;
                }
            }
            $("#btnsubmit").click(function () {
                $("#btnsubmit").attr("disabled", "disabled");
                var maker_name = $("#maker_name").val();
                var description = $("#description").val();
                var amount = $("#amount").val();
                var bonus = $("#bonus").val();
                var date = $("#date").val();
                var bank_id = $("#bank_name").val();
                var account_no = $("#account_no").val();
                var page_status = $("#page_status").val();

                if (maker_name == null || maker_name == "") {
                    alert("Please select maker");
                    $("#btnsubmit").removeAttr("disabled");
                    return false;
                }
                if (description == "") {
                    alert("Please enter description");
                    $("#btnsubmit").removeAttr("disabled");
                    return false;
                }
                if (amount == "" && bonus == "") {
                    alert("Please select amount or bonus");
                    $("#btnsubmit").removeAttr("disabled");
                    return false;
                }
                if (isNaN(amount) || isNaN(bonus)) {
                    alert("Please enter amount or bonus");
                    $("#btnsubmit").removeAttr("disabled");
                    return false;
                }
                if (!amount_pattern_true) {
                    alert("Someting wrong with digit !!");
                    $("#btnsubmit").removeAttr("disabled");
                    return false;
                }
                if (amount_insaffient) {
                    alert("Your balance is insufficient !!");
                    $("#btnsubmit").removeAttr("disabled");
                    return false;
                }

                $.ajax({
                    type: 'POST',
                    url: "/Tailor/Expend",
                    data: {
                        "maker_name": maker_name,
                        "description": description,
                        "amount": amount,
                        "bonus": bonus,
                        "date": date,
                        "bank_id": bank_id,
                        "account_no": account_no,
                        "page_status": page_status
                    },
                    success: function (data, textStatus, jqXHR) {
                        alert("Successfully Inserted !!");
                        location.reload();
                    }
                });
            });

//            function check_customer() {
//                var customer = $("#cus_name").val();
//                var amount = $("#amount").val();
//                var bonus = $("#bonus").val();
//                if ((amount == null || amount == "") && (bonus == null || bonus == "")) {
//                    alert("Pleasse Insert Amount or Bonus");
//                    return false;
//                }
//            }

            $(function () {
                $('#select2Form')
                        .find('[name="maker_name"]')
                        .select2();
            });

            $(function () {
                $("#date").datepicker({
                    dateFormat: "dd-mm-yy",
                    maxDate: 0
                });
            });

            $("#bank_name").change(function () {
                var bank_id = $("#bank_name").val();

                $.ajax({
                    type: 'POST',
                    url: "/Tailor/aaaa",
                    data: {
                        "bank_id": bank_id,
                        "status": "account_no_by_bank_id_deposit"
                    },
                    success: function (data, textStatus, jqXHR) {
                        $("#account_no").load("account_number_by_bank_name.jsp");
                        console.log(bank_id);
                    }
                });
            });

            $(function () {
                $('#select2Form')
                        .find('[name="cus_name"]')
                        .select2();
            });
            $(function () {
                $('#select2Form')
                        .find('[name="bank_name"]')
                        .select2();
            });

            $(function () {
                $(".payment_status").fadeIn("slow").delay(3000).fadeOut("slow");
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
