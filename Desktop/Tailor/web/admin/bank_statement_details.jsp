<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
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
        <meta charset="utf-8"/>
        <meta contenteditable="utf8_general_ci"/>
        <!--        <meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="shortcut icon" type="image/x-icon" href="../admin/assets/img/t_mechin.jpg"/>
        <link href="/Tailor/admin/assets/css/bootstrap.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/css/font-awesome.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />       
        <link href="/Tailor/admin/assets/css/custom.css" rel="stylesheet" />      
        <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/dataTables.jqueryui.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/dataTables.uikit.min.css" rel="stylesheet" type="text/css"/>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />        
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <!--        <link href="assets/css/bootstrap.css" rel="stylesheet" type="text/css"/>
                <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>-->


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
        <style>
            .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
                padding: 2px;
                line-height: 1.42857143;
                vertical-align: top;
                border-top: 1px solid #ddd;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <%
            String acc_slno = request.getParameter("acc_sl");
            String bank_name = request.getParameter("bank_name");
            String account_no = request.getParameter("account_no");
            String branch_name = request.getParameter("branch_name");
        %>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=bank_account"/>
            <!-- /. NAV SIDE  -->            
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <%
                            Calendar first_date = Calendar.getInstance();
                            first_date.set(Calendar.DAY_OF_MONTH, 1);
                            Date dt = first_date.getTime();
                            SimpleDateFormat sdt = new SimpleDateFormat("yyyy-MM-dd");
                            String dddd = sdt.format(dt);
                            //last date of month
                            Calendar c = Calendar.getInstance();
                            c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
                            Date dtlast = c.getTime();
                            String last_date = sdt.format(dtlast);

                            // from data -------------------------------------------------
                            String from_date = request.getParameter("from_date");
                            String to_date = request.getParameter("to_date");

                            if (from_date == null) {
                                from_date = dddd;
                            }
                            if (to_date == null) {
                                to_date = last_date;
                            }
                        %>
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                <span>Bank Name :<%="<b> " + bank_name + "</b>"%>, Branch Name :<%=" <b>" + branch_name + "</b> "%>, Account No : <%="<b> " + account_no + "</b>"%></span>
                                <div class="pull-right">
                                    <form action="bank_statement_details.jsp" method="post">
                                        <form action="customer_statement_details.jsp" method="post">
                                            <input type="text" name="acc_sl" value="<%=acc_slno%>" style="display: none"/>
                                            <input type="text" name="bank_name" value="<%=bank_name%>" style="display: none"/>
                                            <input type="text" name="account_no" value="<%=account_no%>" style="display: none"/>
                                            <input type="text" name="branch_name" value="<%=branch_name%>" style="display: none"/>
                                            From<input type="text" name="from_date" id="from_date" value="<%=from_date%>" style="padding-left: 8px;" />                                       
                                            To<input type="text" name="to_date" id="to_date" value="<%=to_date%>" style="padding-left: 8px;" />
                                            <input type="submit" value="Submit" />
                                        </form>
                                    </form>
                                </div>
                            </div>
                            <div class="panel-body">
                                <table class="table table-striped table-bordered" id="mydata">
                                    <thead>
                                        <th style="text-align: center">SL</th>
                                        <th style="text-align: center">Date</th>
                                        <th style="text-align: left">Description</th>
                                        <th style="text-align: right">Debit</th>
                                        <th style="text-align: right">Credit</th>
                                        <th style="text-align: right">Balance</th>
                                    </thead>
                                    <tbody>
                                        <%
                                            int sl = 1;
                                            double balance = 0;
                                            double total_debit = 0;
                                            double total_credit = 0;
                                            try {
                                                String sql_acc_details = "select * from bank_transaction where bt_bran_id = '" + session.getAttribute("user_bran_id") + "' and bt_account_no = '" + acc_slno + "' and (bt_tdate >= '" + from_date + "' and bt_tdate <= '" + to_date + "')";
                                                PreparedStatement pst_acc_details = DbConnection.getConn(sql_acc_details);
                                                ResultSet rs_acc_details = pst_acc_details.executeQuery();
                                                while (rs_acc_details.next()) {
                                                    String date = rs_acc_details.getString("bt_tdate");
                                                    String bt_ref = rs_acc_details.getString("bt_ref");
                                                    String Debit = rs_acc_details.getString("bt_debit");
                                                    double debit = Double.parseDouble(Debit);
                                                    total_debit += Double.parseDouble(Debit);
                                                    String Credit = rs_acc_details.getString("bt_credit");
                                                    double credit = Double.parseDouble(Credit);
                                                    total_credit += Double.parseDouble(Credit);
                                                    balance = total_credit - total_debit;
                                        %>
                                        <tr>
                                            <td style="text-align: center; width: 5%"><%=sl++%></td>
                                            <td style="width: 10%; text-align: center"><%=date%></td>
                                            <td><%=bt_ref%></td>
                                            <td style="text-align: right; width: 12%"><%if (Debit.equals("0")) {
                                                } else {%><%=NumberFormat.getNumberInstance(Locale.US).format(debit) + ".00"%><%}%></td>
                                            <td style="text-align: right; width: 12%"><%if (Credit.equals("0")) {
                                                } else {%><%=NumberFormat.getNumberInstance(Locale.US).format(credit) + ".00"%><%}%></td>
                                            <td style="text-align: right; width: 15%"><%=NumberFormat.getNumberInstance(Locale.US).format(balance) + ".00"%></td>
                                        </tr>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            }
                                        %>
                                        <tr>
                                            <td style="text-align: center"><%=sl++%></td>
                                            <td></td>
                                            <td><%="total "%></td>
                                            <td style="text-align: right"><b><%=NumberFormat.getNumberInstance(Locale.US).format(total_debit) + ".00"%></b></td>
                                            <td style="text-align: right"><b><%=NumberFormat.getNumberInstance(Locale.US).format(total_credit) + ".00"%></b></td>
                                            <td style="text-align: right"><b><%=NumberFormat.getNumberInstance(Locale.US).format(balance) + ".00"%></b></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>                          
                        </div>                                                    
                    </div>                                                    
                </div>
            </div>
        </div>
        <script>
            $(function () {
                $("#from_date").datepicker({
                    dateFormat: "yy-mm-dd",
                    //                    maxDate: 0,
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2016:' + (new Date()).getFullYear()
                });
            });

            $(function () {
                $("#to_date").datepicker({
                    dateFormat: "yy-mm-dd",
                    //                    maxDate: 0,
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2016:' + (new Date()).getFullYear()
                });
            });
        </script>

        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <script src="assets/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>
        <script>
            $("#mydata").dataTable({
                "pagingType": "simple_numbers",
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search..."
                }
            });
        </script>
    </body>
</html>
