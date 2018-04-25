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
        <!------------------- select2----------end---------------------->
    </head>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=bank_account"/>
            <!-- /. NAV SIDE  -->           
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                Cash Transfer
                                <%
                                    if (session.getAttribute("cash_deposit") != null && session.getAttribute("cash_withdraw") != null) {
                                        if (session.getAttribute("cash_deposit").equals("ok") && session.getAttribute("cash_withdraw").equals("ok")) {
                                %>
                                <span style="color: green" id="cash_transfer_s">Successfully Balance Transfered</span>
                                <%
                                } else {
                                %>
                                <span style="color: red" id="cash_transfer_s">Balance Transfer Failed</span>
                                <%
                                        }
                                        session.removeAttribute("cash_deposit");
                                        session.removeAttribute("cash_withdraw");
                                    }
                                %>
                            </div>
                            <div class="panel-body">
                                <h3>From</h3>
                                <form id="select2Form" name="myform" action="../CashTransfer" method="post" onsubmit="return form_validation()">
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Bank Name</label>  
                                            <select name="from_bank_name" id="from_bank_name" class="form-control select2-select">
                                                <option></option>
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
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Account No</label>  
                                            <select name="from_account_no" id="from_account_no" class="form-control">

                                            </select>
                                            <span id="from_account_no_error" style="color: red"></span>
                                        </div>
                                    </div>
                                    <h3>To</h3>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Bank Name</label>  
                                            <select name="to_bank_name" id="to_bank_name" class="form-control select2-select">
                                                <option></option>
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
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Account No</label>  
                                            <select name="to_account_no" id="to_account_no" class="form-control" required="">

                                            </select>
                                            <span id="acc_error" style="color: red"></span>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Amount</label>  
                                            <input type="text" class="form-control" name="amount" id="amount" onkeyup="check_amount()" placeholder="Enter Amount" required=""/>
                                            <span id="amount_error" style="color: red"></span>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Description</label>  
                                            <input type="text" class="form-control" name="description" id="description" placeholder="Description" required=""/>                                            
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <input type="submit" value="Transfer" class="btn btn-primary"/>
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
            var amount_status;
            var amount_pattern;
            $(function () {
                $('#select2Form')
                        .find('[name="from_bank_name"]')
                        .select2();
            });
            $(function () {
                $('#select2Form')
                        .find('[name="to_bank_name"]')
                        .select2();
            });

            $("#from_bank_name").change(function () {
                var bank_id = $("#from_bank_name").val();

                $.ajax({
                    type: 'POST',
                    url: "/Tailor/aaaa",
                    data: {
                        "bank_id": bank_id,
                        "status": "account_no_by_bank_id_deposit"
                    },
                    success: function (data, textStatus, jqXHR) {
                        $("#from_account_no").load("account_number_by_bank_name.jsp");
                        //console.log(bank_id);
                    }
                });
            });

            $("#to_bank_name").change(function () {
                var bank_id = $("#to_bank_name").val();

                $.ajax({
                    type: 'POST',
                    url: "/Tailor/aaaa",
                    data: {
                        "bank_id": bank_id,
                        "status": "account_no_by_bank_id_deposit"
                    },
                    success: function (data, textStatus, jqXHR) {
                        $("#to_account_no").load("account_number_by_bank_name.jsp");
                        //console.log(bank_id);
                    }
                });
            });

            function check_amount() {
                var amount = $("#amount").val();
                var from_bank = $("#from_bank_name").val();
                var from_account_no = $("#from_account_no").val();
                var reg = /^\d+$/;
                if (reg.test(amount)) {
                    $("#amount_error").text("");
                    amount_pattern = true;
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
                                amount_status = false;
                                $("#amount_error").text("insufficient balance");
                            } else {
                                amount_status = true;
                                $("#amount_error").text("");
                            }
                        }
                    });
                } else {
                    $("#amount_error").text("Only digit allow");
                    amount_pattern = false;
                }
            }

            function form_validation() {
                var from_bank = $("#from_bank_name").val();
                var to_bank = $("#from_bank_name").val();
                var from_account_no = $("#from_account_no").val();
                var to_account_no = $("#to_account_no").val();

                if (from_account_no === null || from_account_no === "") {
                    $("#from_account_no_error").text("Please enter account no");
                }

                if (from_account_no === to_account_no) {
                    $("#acc_error").text("Both account are same !!");
                    return false;
                }
                if (!amount_status) {
                    $("#amount_error").text("Insufficient balance !!");                    
                    return false;
                }
                if(!amount_pattern){
                    $("#amount_error").text("Incorrect format !!");
                    return false;
                }
            }
            $("#cash_transfer_s").fadeIn("slow").delay(3000).fadeOut("slow");
        </script>
        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
