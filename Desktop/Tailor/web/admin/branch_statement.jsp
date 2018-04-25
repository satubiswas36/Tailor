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
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp"/>
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
                                    String year = request.getParameter("mk_year");
                                    String month = request.getParameter("mk_month");
                                    String year_month = null;
                                   
                                    
                                %>
                            </div>
                            <div class="panel-body">
                                <%
                                    String month_status = null;
                                    if (year != null && month != null) {
                                        if (month.equals("01")) {
                                            month_status = "January";
                                        }
                                        if (month.equals("02")) {
                                            month_status = "February";
                                        }
                                        if (month.equals("03")) {
                                            month_status = "March";
                                        }
                                        if (month.equals("04")) {
                                            month_status = "April";
                                        }
                                        if (month.equals("05")) {
                                            month_status = "May";
                                        }
                                        if (month.equals("06")) {
                                            month_status = "June";
                                        }
                                        if (month.equals("07")) {
                                            month_status = "July";
                                        }
                                        if (month.equals("08")) {
                                            month_status = "August";
                                        }
                                        if (month.equals("09")) {
                                            month_status = "September";
                                        }
                                        if (month.equals("10")) {
                                            month_status = "October";
                                        }
                                        if (month.equals("11")) {
                                            month_status = "November";
                                        }
                                        if (month.equals("12")) {
                                            month_status = "December";
                                        }

                                        // today date 

                                %>
                                <span style="font-size: 18px;"><%= "Statement for " + month_status + " " + year%></span>
                                <%
                                } else {
                                    SimpleDateFormat sim=new SimpleDateFormat("MM-yyyy");
                                    Date currentdate = new Date();
                                    String date = sim.format(currentdate);
                                %>
                                <span style="font-size: 18px;"><%= "Statement for " + date %></span>
                                <%
                                    }
                                %>
                                <div style="float: left;" class="pull-right">
                                    <form action="branch_statement.jsp" method="post">
                                        <table>
                                            <tr>
                                                <td>
                                                    <select name="mk_month" required="">
                                                        <%
                                                            DateFormat dateFormat = new SimpleDateFormat("MM");
                                                            Date date = new Date();
                                                            String c_date = dateFormat.format(date);
                                                            if (month == null) {
                                                                if (c_date.equals("01")) {
                                                                    month_status = "January";
                                                                }
                                                                if (c_date.equals("02")) {
                                                                    month_status = "February";
                                                                }
                                                                if (c_date.equals("03")) {
                                                                    month_status = "March";
                                                                }
                                                                if (c_date.equals("04")) {
                                                                    month_status = "April";
                                                                }
                                                                if (c_date.equals("05")) {
                                                                    month_status = "May";
                                                                }
                                                                if (c_date.equals("06")) {
                                                                    month_status = "June";
                                                                }
                                                                if (c_date.equals("07")) {
                                                                    month_status = "July";
                                                                }
                                                                if (c_date.equals("08")) {
                                                                    month_status = "August";
                                                                }
                                                                if (c_date.equals("09")) {
                                                                    month_status = "September";
                                                                }
                                                                if (c_date.equals("10")) {
                                                                    month_status = "October";
                                                                }
                                                                if (c_date.equals("11")) {
                                                                    month_status = "November";
                                                                }
                                                                if (c_date.equals("12")) {
                                                                    month_status = "December";
                                                                }
                                                            }
                                                        %>
                                                        <option value="<%=c_date%>">
                                                            <%                                                                if (month != null) {
                                                            %>
                                                            <%=month_status%>
                                                            <%
                                                            } else {
                                                            %>
                                                            <%=month_status%>
                                                            <%
                                                                }
                                                            %>
                                                        </option>
                                                        <option value="01">January</option>
                                                        <option value="02">February</option>
                                                        <option value="03">March</option>
                                                        <option value="04">April</option>
                                                        <option value="05">May</option>
                                                        <option value="06">June</option>
                                                        <option value="07">July</option>
                                                        <option value="08">August</option>
                                                        <option value="09">September</option>
                                                        <option value="10">October</option>
                                                        <option value="11">November</option>
                                                        <option value="12">December</option>
                                                    </select>
                                                </td>
                                                <td>
                                                    <select name="mk_year" required="">
                                                        <%
                                                            DateFormat dateF = new SimpleDateFormat("yyyy");
                                                            Date date_year = new Date();
                                                            String d_year = dateF.format(date_year);
                                                            if (month == null || year == null) {
                                                                year_month = d_year + "-" + c_date;
                                                            } else {
                                                                year_month = year + "-" + month;
                                                            }
                                                        %>
                                                        <option value="<%=d_year%>"><%=d_year%></option>     

                                                        <option value="2016">2016</option>                                                        
                                                        <option value="2017">2017</option>                                                        
                                                        <option value="2018">2018</option>                                                   
                                                    </select>
                                                </td>
                                                <td>
                                                    <input type="submit" value="search" />
                                                </td>
                                            </tr>
                                        </table>
                                    </form>
                                </div>
                                <table class="table table-bordered" style="width: 100%;">
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
                                        <th style="text-align: center">Description</th>
                                        <th style="text-align: center">Debit</th>
                                        <th style="text-align: center">Credit</th>
                                        <th style="text-align: center">Balance</th>                                        
                                    </thead>
                                    <%
                                        String sql_payment_statement = "select * from account where acc_pay_date like ? and  acc_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                        PreparedStatement pst_payment_statement = DbConnection.getConn(sql_payment_statement);
                                        pst_payment_statement.setString(1, year_month + "%");
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
                                        <td style="text-align: center"><%= id++%></td>
                                        <td style="text-align: center; width: 13%;"><%= acc_date%></td>
                                        <td style="text-align: left"><%= description%></td>
                                        <td style="text-align: right"><%= Debit + "0"%></td>
                                        <td style="text-align: right"><%= Credit + "0"%></td>
                                        <td style="text-align: right"><%= balance + "0"%></td>                                        
                                    </tr>
                                    <%

                                        }
                                        try {
                                            // calculatjion total discount 
                                            String status = "2";
                                            String sql_discount = "select * from account where acc_pay_date like ? and acc_bran_id = '" + session.getAttribute("user_bran_id") + "' and acc_status = '" + status + "' ";
                                            PreparedStatement pst_discount = DbConnection.getConn(sql_discount);
                                            pst_discount.setString(1, year_month + "%");
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
                                        <td style="text-align: right"><b><%= total_credit-total_discount + "0"%></b></td>
                                        <td style="text-align: right"><b><%= balance-total_discount + "0"%></b></td>
                                    </tr>
                                    <%
                                        } catch (Exception e) {
                                            out.println(e.toString());
                                        }
                                    %>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
