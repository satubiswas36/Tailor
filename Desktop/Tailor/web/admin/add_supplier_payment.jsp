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
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
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
            <jsp:include page="../menu/menu.jsp?page_name=supplier_information"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Add Supplier Payment
                                <span id="supplierpayment">
                                    <%
                                        if (session.getAttribute("supplierpayment") != null) {
                                            if (session.getAttribute("supplierpayment").equals("ok")) {
                                    %>
                                    <span style="color: green">Successfully Added !!</span>
                                    <%
                                    } else {
                                    %>
                                    <span style="color: red">Failed !! Try Again.</span>
                                    <%
                                            }
                                        }
                                        if (session.getAttribute("supplierpayment") != null) {
                                            session.removeAttribute("supplierpayment");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="panel-body">
                                <form action="" id="select2Form" class="form-horizontal" method="post">
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Supplier Name</label>  
                                            <select name="supplier_id" id="supplier_id"  class="form-control select2-select"
                                                    data-placeholder="Please Select Supplier" required="">
                                                <option></option>
                                                <%
                                                    try {
                                                        String sql_company_name = "select * from supplier where suplr_bran_id= '" + session.getAttribute("user_bran_id") + "' order by suplr_name asc ";
                                                        PreparedStatement pst_company_name = DbConnection.getConn(sql_company_name);
                                                        ResultSet rs_company_name = pst_company_name.executeQuery();
                                                        while (rs_company_name.next()) {
                                                            String company_name = rs_company_name.getString("suplr_name");
                                                            String company_id = rs_company_name.getString("supplier_id");
                                                %>
                                                <option value="<%=company_id%>"><%=company_name%></option>
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
                                            <label for="name" style="margin-bottom:  0px">Description</label>  
                                            <input type="text" class="form-control" name="description" id="description" placeholder="Description"/>
                                        </div>
                                    </div>                                    
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Bank</label>  
                                            <select name="bank_name" id="bank_name" class="form-control select2-select" required="">
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
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Account No</label>  
                                            <select name="account_no" id="account_no" class="form-control" required="">

                                            </select>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-3">
                                            <label for="name" style="margin-bottom:  0px">Amount</label>  
                                            <input type="text" class="form-control" name="amount" maxlength="10" id="amount" onkeyup="check_amount()" placeholder="Enter  Amount" />
                                            <span id="amount_error" style="color: red"></span>
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="name" style="margin-bottom:  0px">Discount</label>  
                                            <input type="text" class="form-control" name="discount" maxlength="5" id="discount" placeholder="Discount" onkeyup="payble_amount()"/>
                                        </div>
                                        = <span id="payble" style="line-height: 5"></span>tk.                                        
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Payment Date </label>  
                                            <%
                                                Date dd = new Date();
                                                SimpleDateFormat formt = new SimpleDateFormat("yyyy-MM-dd");
                                                String datedemo = formt.format(dd);
                                            %>
                                            <input type="text" class="form-control" value="<%= datedemo%>" name="cdate" id="cdate" placeholder="<%= datedemo%>" readonly=""/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <input type="button" class="btn btn-primary" id="supplierbtn" value="Payment">
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
            var amount_pattern_true=true;
            var amount_insaffient = false;
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
            $("#supplierbtn").click(function () {
                $("#supplierbtn").attr("disabled", "disabled");
                var supplier_id = $("#supplier_id").val();
                var description = $("#description").val();
                var amount = 0;
                if ($("#amount").val() != "") {
                    amount = $("#amount").val();
                }
                var discount = 0;
                if ($("#discount").val() != "") {
                    discount = $("#discount").val();
                }
                var cdate = $("#cdate").val();
                var bank_id = $("#bank_name").val();
                var accountno = $("#account_no").val();

                if (supplier_id == null || supplier_id == "") {
                    alert("Please select supplier");
                    $("#supplierbtn").removeAttr("disabled");
                    return false;
                }
                if (description == null || description == "") {
                    alert("Please enter description");
                    $("#supplierbtn").removeAttr("disabled");
                    return false;
                }
                if (amount == "" && discount == "") {
                    alert("Please enter amount or discount");
                    $("#supplierbtn").removeAttr("disabled");
                    return false;
                }
                if (isNaN(amount) || isNaN(discount)) {
                    alert("Amont and discount must numer !!");
                    $("#supplierbtn").removeAttr("disabled");
                    return false;
                }
                if(!amount_pattern_true){
                    $("#amount_error").text("Amount pattern false");
                    $("#supplierbtn").removeAttr("disabled");
                    return false;
                }
                if(amount_insaffient){
                    $("#amount_error").text("Your balance is insafficient");
                    $("#supplierbtn").removeAttr("disabled");
                    return false;
                }
                $.ajax({
                    type: 'POST',
                    url: "/Tailor/AddSupplierPyament",
                    data: {
                        "supplier_id": supplier_id,
                        "amount": amount,
                        "description": description,
                        "cdate": cdate,
                        "discount": discount,
                        "bank_id": bank_id,
                        "accountno": accountno
                    },
                    success: function (data, textStatus, jqXHR) {                        
                        alert("Successfully added !!");
                       location.reload();
                    }
                });
            });

            $(function () {
                $('#select2Form')
                        .find('[name="supplier_id"]')
                        .select2();
            });
            $(function () {
                $('#select2Form')
                        .find('[name="bank_name"]')
                        .select2();
            });
            $(function () {
                $("#supplierpayment").fadeIn(4000).delay(500).fadeOut("slow");
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

            function payble_amount() {
                var am = $("#amount").val();
                var dis = $("#discount").val();
                $("#payble").text(am - dis);
            }
            
            $("#supplier_id").change(function(){
                var sid = $("#supplier_id").val();
                $.ajax({
                    type: 'POST',
                    url: "supplier_balance_by_sid.jsp",
                    data: {
                        "sid": sid
                    },
                    success: function (data, textStatus, jqXHR) {
                        $("#amount").val(data+"0");
                        console.log(data);
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
