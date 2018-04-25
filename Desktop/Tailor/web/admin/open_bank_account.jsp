<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String logger = (String) session.getAttribute("logger");
%>

<%
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
            <%
                String bank_id = request.getParameter("bank_id");
                String account_no = request.getParameter("account_no");
                String branch_name = request.getParameter("branch_name");
                String open_date = request.getParameter("opening_date");
                String bank_name = null;
                try {
                    String sql_bank_name = "select bank_name from bank where sl = '" + bank_id + "' ";
                    PreparedStatement pst_bank_name = DbConnection.getConn(sql_bank_name);
                    ResultSet rs_bank_name = pst_bank_name.executeQuery();
                    if (rs_bank_name.next()) {
                        bank_name = rs_bank_name.getString("bank_name");
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Add Bank Information
                                <%
                                    if (session.getAttribute("bank_account_reg_ok") != null) {
                                        if (session.getAttribute("bank_account_reg_ok").equals("ok")) {
                                %>
                                <span id="bnkrgs" style="color: green; font-size: 18px">Account Registration Successful</span>
                                <%
                                } else {
                                %>
                                <span id="bnkrgs" style="color: red; font-size: 18px">Account Registration Failed !!</span>
                                <%
                                        }
                                        session.removeAttribute("bank_account_reg_ok");
                                    }
                                %>                                

                            </div>
                            <div class="panel-body">
                                <form action="../Bank_Account" id="select2Form" class="bank_account" method="post">
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Bank Name</label>  
                                            <select name="bank_name" id="bank_name" class="form-control select2-select"
                                                    data-placeholder="Please Select Customer" required="">
                                                <%
                                                    if (bank_id != null) {
                                                %>
                                                <option value="<%=bank_id%>"><%=bank_name%></option>
                                                <%
                                                } else {
                                                %>
                                                <option></option>
                                                <%
                                                    }
                                                %>                                                
                                                <%
                                                    try {
                                                        String sql_bank = "select * from bank order by bank_name asc";
                                                        PreparedStatement pst_bank = DbConnection.getConn(sql_bank);
                                                        ResultSet rs_bank = pst_bank.executeQuery();
                                                        while (rs_bank.next()) {
                                                %>
                                                <option value="<%=rs_bank.getString("sl")%>"><%=rs_bank.getString("bank_name")%></option>
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
                                            <label for="name" style="margin-bottom:  0px">Branch Name</label>  
                                            <input type="text" class="form-control" name="branch_name" id="group_name" <%if (branch_name != null) {%> value="<%=branch_name%>"<%}%> placeholder=" Branch Name" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Account No</label>  
                                            <input type="text" class="form-control" name="account_no" id="account_no" <%if (account_no != null) {%>value="<%=account_no%>"<%}%> onkeyup="check_account()" placeholder=" Account Number" required=""/>
                                            <span id="account_no_msg" style="color: red"></span>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Open Date</label>  
                                            <input type="text" class="form-control" name="open_date" <%if (open_date != null) {%>value="<%=open_date%>"<%}%> id="account_open_date" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <%
                                                if (bank_id != null) {
                                            %>
                                            <input type="submit" value="Update Account" class="btn btn-primary" />
                                            <input type="text" name="old_bank_id" value="<%=bank_id%>" style="display: none"/>
                                            <input type="text" name="old_account_no" value="<%=account_no%>" style="display: none"/>
                                            <input type="text" name="old_branch_name" value="<%=branch_name%>" style="display: none"/>
                                            <%
                                            } else {
                                            %>
                                            <input type="submit" value="Create New" class="btn btn-primary" />
                                            <%
                                                }
                                            %>                                            
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
            $(function () {
                $('#select2Form')
                        .find('[name="bank_name"]')
                        .select2();
            });
            $(function () {
                $("#account_open_date").datepicker({
                    dateFormat: "yy-mm-dd"
                });
            });
            $("#bnkrgs").fadeIn("slow").delay(3000).fadeOut("slow");
            $("#account_no_msg").fadeIn(1000);

            function check_account() {
                var account_no = $("#account_no").val();
                var bank_id = $("#bank_name").val();
                $.ajax({
                    type: 'POST',
                    url: "check_bank_acc.jsp",
                    data: {
                        "acc_no": account_no,
                        "bank_id": bank_id
                    },
                    success: function (data, textStatus, jqXHR) {
                        var fin_data = data.trim();
                        if (fin_data === 'exit') {
                            document.getElementById("account_no_msg").innerHTML = "account exit !!";
                            return false;
                        } else {
                            document.getElementById("account_no_msg").innerHTML = "";
                            return true;
                        }
                    }
                });
            }
        </script>
        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <script src="assets/js/bootstrap.min.js"></script>   
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>    
    </body>
</html>
