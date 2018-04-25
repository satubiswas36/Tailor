
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
            <jsp:include page="../menu/menu.jsp?page_name=customer" flush="true"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 45px">
                                Customer Payment :<span class="payment_status" style="color: green; font-size: 18px; margin-left: 10%"><% if (session.getAttribute("customer_payment_msg") != null) {%><%="Payment successfully added!!"%><%} %></span><%session.removeAttribute("customer_payment_msg"); %>
                            </div>
                            <div class="panel-body">
                                <form action="" id="select2Form" class="form-horizontal" method="post">
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="selectbasic">Customer Name</label>
                                        <div class="col-md-4">
                                            <select name="cus_name" id="cus_name"  class="form-control select2-select"
                                                    data-placeholder="Please Select Customer" required="">
                                                <option value="">Select customer</option>
                                                <%                                                        try {
                                                        String sql_customer = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "'  order by cus_name";

                                                        PreparedStatement pst_customer = DbConnection.getConn(sql_customer);
                                                        ResultSet rs_customer = pst_customer.executeQuery();
                                                        while (rs_customer.next()) {
                                                %>                                                    
                                                <option value="<%=rs_customer.getString("cus_customer_id")%>"><%=rs_customer.getString("cus_name")%><%=" (" + rs_customer.getString("cus_mobile") + ")"%></option>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        e.printStackTrace();
                                                    } finally {

                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>                                    
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="customer_description">Description</label>
                                        <div class="col-md-4">
                                            <input type="text" name="customer_description"  id="customer_description" class="form-control" maxlength="40" required=""/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label" for="customer_payment">Payment</label>
                                        <div class="col-md-2">
                                            <input type="text" name="customer_payment" id="customer_payment" pattern="^[1-9][0-9]*$" class="form-control" maxlength="8"  placeholder="amount" />
                                        </div>
                                        <div class="col-md-2">
                                            <input type="text" name="customer_discount" id="customer_discount" pattern="^[1-9][0-9]*$" class="form-control" placeholder="discount" maxlength="8" onkeyup="define_payble_amount()"/>
                                        </div>
                                        <div class="col-md-2"><span >=</span><span id="payble_amount" style="margin-left: 5px;"></span> tk.</div>
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
                                        <label class="col-md-4 control-label" for="customer_date">Payment Date</label>
                                        <div class="col-md-4">
                                            <%
                                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                Date date = new Date();
                                                String date_f = dateFormat.format(date);
                                            %>
                                            <input type="text" class="form-control" value="<%= date_f%>" name="customer_payment_date" id="customer_payment_date" placeholder="dd-mm-yyyy"   style="height: 40px" required=""/>
                                        </div>
                                    </div>
                                    <center> <input type="button" class="btn btn-success" value="Submit" id="submittedbtn"/></center>
                                </form>     
                            </div>                        
                        </div>
                    </div>                                          
                </div>
            </div>
        </div>
        <script>
            $("#submittedbtn").click(function () {
                $("#submittedbtn").attr('disabled', 'disabled');
                var cus_name = $("#cus_name").val();
                var customer_description = $("#customer_description").val();
                var customer_payment = 0;
                if($("#customer_payment").val() != ""){
                    customer_payment = $("#customer_payment").val();
                }                
                var customer_discount = 0;
                if($("#customer_discount").val() != ""){
                    customer_discount = $("#customer_discount").val();
                }
                var customer_payment_date = $("#customer_payment_date").val();
                var bank_id = $("#bank_name").val();
                var account_no = $("#account_no").val();
                //alert(cus_name);       
                if (cus_name == null || cus_name == "") {
                    alert("Please Select Customer");
                    $("#submittedbtn").removeAttr('disabled');
                    return false;
                }
                if (customer_description == null || customer_description == "") {
                    alert("Description needed");
                    $("#submittedbtn").removeAttr('disabled');
                    return false;
                }
                if (isNaN(customer_payment) || isNaN(customer_discount)) {
                    alert("Amount and discount must be number only");
                    $("#submittedbtn").removeAttr('disabled');
                    return false;
                }
                if (customer_payment == "" && customer_discount == "") {
                    alert("Please enter amount or discount");
                    $("#submittedbtn").removeAttr('disabled');
                    return false;
                }

                $.ajax({
                    type: 'POST',
                    url: "/Tailor/Customer_payment",
                    data: {
                        "cus_name": cus_name,
                        "customer_description": customer_description,
                        "customer_payment": customer_payment,
                        "customer_discount": customer_discount,
                        "customer_payment_date": customer_payment_date,
                        "bank_id": bank_id,
                        "account_no": account_no
                    },
                    success: function (data, textStatus, jqXHR) {
                        alert("Successfully Payment Added");
                        $("#submittedbtn").removeAttr('disabled');
                        location.reload();
                    }
                });
            });


            $("#cus_name").change(function () {
                var cus_id = $("#cus_name").val();

                $.ajax({
                    type: 'POST',
                    url: "customer_due_by_customer_id.jsp",
                    data: {
                        "cus_id": cus_id
                    },
                    success: function (data, textStatus, jqXHR) {
                        var findata;
                        if (data == 0.0) {
                            findata = "";
                        } else {
                            findata = data;
                        }
                        $("#customer_payment").val(findata + "0");
                        console.log(findata);
                    }
                });
            });
            
            function define_payble_amount(){
                var customer_payment = $("#customer_payment").val();
                var customer_discount = $("#customer_discount").val();
                var fin = customer_payment - customer_discount;
                $("#payble_amount").text(fin);
            }

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
                $("#customer_payment_date").datepicker({
                    dateFormat: "dd-mm-yy",
                    maxDate: 0
                });
            });

            $(function () {
                $(".payment_status").fadeIn("slow").delay(3000).fadeOut("slow");
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

        </script>
        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <script src="assets/js/bootstrap.min.js"></script>   
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
