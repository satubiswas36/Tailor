<%@page import="java.sql.Blob"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
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
<%
    Calendar first_date = Calendar.getInstance();
    first_date.set(Calendar.DAY_OF_MONTH, 1);
    Date dt = first_date.getTime();
    SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
    String dddd = sd.format(dt);
    //last date of month
    Calendar c = Calendar.getInstance();
    c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
    Date dtlast = c.getTime();
    String last_date = sd.format(dtlast);
%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp"/>
    <style>
        .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
            padding: 2px;
            line-height: 1.42857143;
            vertical-align: top;
            border-top: 1px solid #ddd;
            font-size: 14px;
        }
        @page {
            size: A4;
            font-size: 28px;
            min-height: 50px;
        }
        @media print {
            html, body {
                width: 100%;
                min-height: 10mm;
                font-size: 18px;
            }
            /* ... the rest of the rules ... */
        }
    </style>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=account"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                <%
                                    String from_date = request.getParameter("from_date");
                                    String to_date = request.getParameter("to_date");
                                    if (from_date == null) {
                                        from_date = dddd;
                                    }
                                    if (to_date == null) {
                                        to_date = last_date;
                                    }
                                    String year_month = null;
                                    // branch image
                                    String b64 = null;
                                    String bran_name = null;
                                    String bran_address = null;
                                    String bran_phone = null;
                                    String bran_email = null;
                                    String bran_logo = null;
                                    try {
                                        Blob img = null;
                                        String sql_img = "select * from user_branch where bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                        PreparedStatement pst_img = DbConnection.getConn(sql_img);
                                        ResultSet rs_img = pst_img.executeQuery();
                                        while (rs_img.next()) {
                                            img = rs_img.getBlob("bran_com_logo");
                                            byte[] imgByte = img.getBytes(1, (int) img.length());
                                            b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imgByte);
                                            bran_name = rs_img.getString("bran_name");
                                            bran_address = rs_img.getString("bran_address");
                                            bran_phone = rs_img.getString("bran_mobile");
                                            bran_email = rs_img.getString("bran_email");
                                            bran_logo =rs_img.getString("bran_com_logo");
                                        }
                                    } catch (Exception e) {
                                        out.println("show_last_invoice branch image " + e.toString());
                                    }
                                %>
                                <div style="float: left;" class="pull-right">
                                    <form action="branch_expend_statement.jsp" method="post">
                                        From <input type="text" name="from_date" value="<%=from_date%>" id="from_date" placeholder="From" />
                                        To <input type="text" name="to_date" value="<%=to_date%>" id="to_date" placeholder="To" />
                                        <input type="submit" value="Submit" />
                                    </form>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div id="printableArea">
                                    <table class="table-responsive" style="border: none; margin: 0px; display: none" id="bran_image">
                                        <tr>
                                            <td><img src="../images/<%=bran_logo%>" alt="" style="width: 50px; height: 50px;"/></td>
                                            <td style="text-align: right">
                                                <h4 style="margin: 0px"><%=bran_name%></h4>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style="text-align: right">
                                                <h5 style="margin: 0px;">Address : <%=bran_address%></h5>                            
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style="text-align: right"><h5 style="margin: 0px;">Phone : <%=bran_phone%></h5></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style="text-align: right"><h5 style="margin: 0px;">Email : <%=bran_email%></h5></td>
                                        </tr>
                                    </table><hr style="margin: 0px;">
                                        <%
                                            if (from_date != null || to_date != null) {
                                        %>
                                        <span >Account Statement From <%=from_date + " <b>To</b> " + to_date%></span>
                                        <%
                                            }
                                        %>
                                        <table class="table table-bordered topics" style="width: 100%;">
                                            <%
                                                int id = 1;
                                                double balance = 0;
                                                double total_debit = 0;
                                                double total_credit = 0;
                                                double total_discount = 0;

                                                try {
                                            %>

                                            <thead>
                                                <th style="text-align: center">SL</th>
                                                <th style="text-align: center">Date</th>
                                                <th style="text-align: left">Description</th>
                                                <th style="text-align: right">Debit</th>
                                                <th style="text-align: right">Credit</th>
                                                <th style="text-align: right">Balance</th>                                        
                                            </thead>
                                            <%
                                                String sql_payment_statement = "select * from account where (acc_pay_date >= '" + from_date + "' and acc_pay_date <= '" + to_date + "') and  acc_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                PreparedStatement pst_payment_statement = DbConnection.getConn(sql_payment_statement);
                                                ResultSet rs_payment_statement = pst_payment_statement.executeQuery();
                                                while (rs_payment_statement.next()) {
                                                    String description = rs_payment_statement.getString("acc_description");
                                                    String Debit = rs_payment_statement.getString("acc_debit");
                                                    double acc_debit = Double.parseDouble(Debit);
                                                    total_debit += acc_debit;
                                                    if (Debit.equals("0")) {
                                                        Debit = "";
                                                    }
                                                    String Credit = rs_payment_statement.getString("acc_credit");
                                                    double acc_credit = Double.parseDouble(Credit);
                                                    total_credit += acc_credit;
                                                    if (Credit.equals("0")) {
                                                        Credit = "";
                                                    }
                                                    balance = balance + (acc_credit - acc_debit);
                                                    String acc_date = rs_payment_statement.getString("acc_pay_date");
                                            %>
                                            <tr>
                                                <td style="text-align: center; width: 6%"><%= id++%></td>
                                                <td style="text-align: center; width: 13%;"><%= acc_date%></td>
                                                <td style="text-align: left"><%= description%></td>
                                                    <td style="text-align: right"><%if (acc_debit == 0) {
                                                    } else {%><%= acc_debit + "0"%><%} %></td>

                                                    <td style="text-align: right"><%if (acc_credit == 0) {
                                                    } else {%><%= acc_credit + "0"%><%}%></td>
                                                <td style="text-align: right"><%= balance + "0"%></td>                                        
                                            </tr>
                                            <%

                                                }
                                                try {
                                                    // calculatjion total discount 
                                                    String status = "2";
                                                    String sql_discount = "select * from account where (acc_pay_date >= '" + from_date + "' and acc_pay_date <= '" + to_date + "')  and acc_bran_id = '" + session.getAttribute("user_bran_id") + "' and acc_status = '" + status + "' ";
                                                    PreparedStatement pst_discount = DbConnection.getConn(sql_discount);
                                                    ResultSet rs_discount = pst_discount.executeQuery();
                                                    while (rs_discount.next()) {
                                                        String acc_discount = rs_discount.getString("acc_credit");
                                                        total_discount += Double.parseDouble(acc_discount);
                                                    }
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td style="text-align: right"><b>Total Discount =  <%=total_discount + "0"%></b></td>
                                                <td style="text-align: right"><b><%= total_debit + "0"%></b></td>
                                                <td style="text-align: right"><b><%= total_credit - total_discount + "0"%></b></td>
                                                <td style="text-align: right"><b><%= balance - total_discount + "0"%></b></td>
                                            </tr>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </table>
                                        <center> <span>Power By : <b>IGL Web™ Ltd. </b>|| 880-1823-037726</span></center>
                                </div>
                            </div>
                            <input type="button" onclick="printDiv('printableArea')" value="print" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(function () {
                $("#from_date").datepicker({
                    dateFormat: "yy-mm-dd",
                    changeMonth: true,
                    changeYear: true
                });
            });
            $(function () {
                $("#to_date").datepicker({
                    dateFormat: "yy-mm-dd",
                    changeMonth: true,
                    changeYear: true
                });
            });
            function printDiv(divName) {
                 $("#bran_image").show();
                var printContents = document.getElementById(divName).innerHTML;
                $("#bran_image").hide();
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
                location.reload();
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
