
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
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
                            <div class="panel-heading">
                                Add Bank Withdraw
                                <%
                                    if (session.getAttribute("withdraw_status") != null) {
                                        if (session.getAttribute("withdraw_status").equals("ok")) {
                                %>
                                <span id="bank_deposit" style="font-size: 18px; color: green">Amount Added</span>
                                <%
                                } else {
                                %>
                                <span id="bank_deposit" style="color: red; font-size: 18px">Amount Not Add</span>
                                <%
                                        }
                                        session.removeAttribute("withdraw_status");
                                    }
                                %>
                            </div>
                            <div class="panel-body">
                                <form action="../Bank_Deposit" id="select2Form" method="post" onsubmit="return form_validation()">
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Bank Name</label>  
                                            <select name="bank_name" id="bank_name" class="form-control">
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
                                            <select name="account_no" id="account_no" class="form-control">

                                            </select>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Payment Amount (Debit)</label>  
                                            <input type="text" class="form-control" name="payment_amount" id="payment_amount" onkeyup="check_amount()" placeholder="Enter payment" required=""/>
                                            <span id="payment_amount_error" style="color: red"></span>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">References</label>  
                                            <input type="text" class="form-control" name="reference" id="reference" placeholder="Enter Referencs" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">WithDraw Date</label>  
                                            <%
                                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                Date date = new Date();
                                                String date_f = dateFormat.format(date);
                                            %>
                                            <input type="text" class="form-control" name="to_date" value="<%=date_f%>" id="to_date" />
                                            <input type="text" name="p_status" value="withdraw" style="display: none"/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <input type="submit" value="WithDraw" class="btn btn-primary" />
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>          
                    </div>                                                
                </div>                                                
            </div>
        </div>
        </div>
        <script>
            var amount_status;
            var amount_check_digit_or_not;
            $(function () {
                $("#to_date").datepicker({
                    dateFormat: "yy-mm-dd"
                });
            });

            $(function () {
                $('#select2Form')
                        .find('[name="bank_name"]')
                        .select2();
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

            function check_amount() {
                var amount = $("#payment_amount").val();
                var bank_id = $("#bank_name").val();
                var account_no = $("#account_no").val();
                var reg = /^\d+$/;
                if(reg.test(amount)){
                    amount_check_digit_or_not = true;
                     $.ajax({
                    type: 'POST',
                    url: "check_amount.jsp",
                    data: {
                        "amount": amount,
                        "bank_id": bank_id,
                        "account_no": account_no
                    },
                    success: function (data, textStatus, jqXHR) {
                        var fin_data = data.trim();
                        if (fin_data === 'insufficient') {
                            amount_status = false;
                            $("#payment_amount_error").text("insufficient balance");
                        } else {
                            amount_status = true;
                            $("#payment_amount_error").text("");
                        }
                    }
                });
                }else {
                    $("#payment_amount_error").text("only digit allow");
                    amount_check_digit_or_not = false;
                }               
            }

            function form_validation() {
                if(!amount_check_digit_or_not){
                    $("#payment_amount_error").text("Only digit allow !!");
                    return false;
                }
                if (!amount_status) {
                    $("#payment_amount_error").text("Insufficient balance");                    
                    return false;
                }
            }
            
            $("#bank_deposit").fadeIn("slow").delay(3000).fadeOut("slow");
        </script>
        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
