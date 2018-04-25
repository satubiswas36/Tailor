<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        <%
            String month = request.getParameter("month");
            String year = request.getParameter("year");

            String strDate = null;
            if (month == null) {
                SimpleDateFormat sdfDate = new SimpleDateFormat("MM");//dd/MM/yyyy
                Date now = new Date();
                month = sdfDate.format(now);
            }
            if (year == null) {
                SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy");//dd/MM/yyyy
                Date now = new Date();
                year = sdfDate.format(now);
            }
            String month_status = null;
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
        %>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=cost"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                <span style="font-size: 18px;"><%=month_status + " " + year%></span>
                            </div>
                            <div class="panel-body">
                                <div style="float: left;" class="pull-right">
                                    <form action="total_income_spend.jsp" method="post">
                                        <table>
                                            <tr>
                                                <td>
                                                    <select name="month" required="">
                                                        <option></option>
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
                                                    <select name="year" required="">
                                                        <option></option>                                                        
                                                        <option value="2017">2017</option>                                                        
                                                    </select>
                                                </td>
                                                <td>
                                                    <input type="submit" value="search" />
                                                </td>
                                            </tr>
                                        </table>
                                    </form>
                                </div>
                            </div>
                            <%

                                double shirt_spend = 0;
                                double pant_spend = 0;
                                double blazer_spend = 0;
                                double photua_spend = 0;
                                double safari_spend = 0;
                                double panjabi_spend = 0;
                                double payjama_spend = 0;

                                double total_shirt_spend = 0;
                                double total_pant_spend = 0;
                                double total_blazer_spend = 0;
                                double total_photua_spend = 0;
                                double total_safari_spend = 0;
                                double total_panjabi_spend = 0;
                                double total_payjama_spend = 0;

                                double shirt_price = 0;
                                double blzer_price = 0;
                                double pant_price = 0;
                                double photua_price = 0;
                                double safari_price = 0;
                                double panjabi_price = 0;
                                double payjama_price = 0;

                                int shirt_qty = 0;
                                int pant_qty = 0;
                                int blazer_qty = 0;
                                int photua_qty = 0;
                                int panjabi_qty = 0;
                                int payjama_qty = 0;
                                int safari_qty = 0;

                                double shirt_income = 0;
                                double pant_income = 0;
                                double blazer_income = 0;
                                double photua_income = 0;
                                double safari_income = 0;
                                double panjabi_income = 0;
                                double payjama_income = 0;
                                double total_income = 0;
                                double total_spend = 0;

                                int receiveQty = 0;
                            %>
                            <table class="table table-striped table-bordered" style="width: 50%">
                                <thead>
                                    <th style="text-align: center">SL</th>
                                    <th style="text-align: center">Product</th>
                                    <th style="text-align: center">Receive Qty</th>
                                    <th style="text-align: center">Complete Qty</th>
                                    <th style="text-align: center">Maker Charge</th>
                                    <th style="text-align: center">Total MC</th>
                                    <th style="text-align: center">Price</th>
                                    <th style="text-align: center">Income</th>
                                    <th style="text-align: center">Debit</th>
                                    <th style="text-align: center">Credit</th>
                                    <th style="text-align: center">Discount</th>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td style="text-align: center">1</td>
                                        <td style="text-align: center">Shirt</td>
                                        <td style="text-align: center">
                                            <%
                                                String product = "shirt";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        receiveQty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=receiveQty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                                receiveQty = 0;
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                String product_name = "shirt";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' and mk_status = '" + 1 + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        shirt_qty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=shirt_qty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_spend = "select * from worker_salary where ws_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_spend);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        shirt_spend = Double.parseDouble(rs_spend.getString("ws_shirt"));
                                                        total_shirt_spend = shirt_qty * shirt_spend;
                                                        total_spend += total_shirt_spend;
                                                    }
                                            %>
                                            <%=shirt_spend%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%=total_shirt_spend%></td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_price);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        shirt_price = Double.parseDouble(rs_spend.getString("prlist_shirt"));
                                                    }
                                                    shirt_income = ((shirt_qty * shirt_price) - total_shirt_spend);
                                                    total_income += shirt_income;
                                            %>
                                            <%=shirt_price%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%=shirt_income%>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                // debit and credit and discount calculation
                                                double total_debit = 0;
                                                double total_credit = 0;
                                                double credit = 0;
                                                double total_discount = 0;
                                                try {
                                                    String sql_dcd = "select * from account where acc_pay_date like ? and acc_bran_id = '" + session.getAttribute("user_bran_id") + "'  ";
                                                    PreparedStatement pst_dcd = DbConnection.getConn(sql_dcd);
                                                    pst_dcd.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_dcd = pst_dcd.executeQuery();
                                                    while (rs_dcd.next()) {
                                                        String s_debit = rs_dcd.getString("acc_debit");
                                                        String s_credit = rs_dcd.getString("acc_credit");
                                                        total_debit += Double.parseDouble(s_debit);
                                                        total_credit += Double.parseDouble(s_credit);                                                        
                                                    }
                                                    credit  = total_credit;
                                            %>
                                            <b><%=total_debit%></b>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                String discount = "2";
                                                try {
                                                    String sql_credit = "select * from account where acc_pay_date like ? and acc_bran_id = '" + session.getAttribute("user_bran_id") + "' and acc_status = '"+discount+"' ";
                                                    PreparedStatement pst_credit = DbConnection.getConn(sql_credit);
                                                    pst_credit.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_credit = pst_credit.executeQuery();
                                                    while (rs_credit.next()) {
                                                        String acc_discount = rs_credit.getString("acc_credit");
                                                        total_discount += Double.parseDouble(acc_discount);
                                                        credit = total_credit - total_discount;
                                                    }
                                                    %>
                                                    <b><%=(credit+total_discount) %></b>
                                                    <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                            <td style="text-align: center"><b><%=total_discount%></b></td>
                                    </tr>
                                    <!-------------------------------------------- for pant ----------------------------------------->
                                    <tr>
                                        <td style="text-align: center">2</td>
                                        <td style="text-align: center">Pant</td>
                                        <td style="text-align: center">
                                            <%
                                                // Receive product qty 
                                                product_name = "pant";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        receiveQty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=receiveQty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                                receiveQty = 0;
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                product_name = "pant";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' and mk_status = '" + 1 + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        pant_qty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=pant_qty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_spend = "select * from worker_salary where ws_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_spend);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        pant_spend = Double.parseDouble(rs_spend.getString("ws_pant"));
                                                        total_pant_spend = pant_qty * pant_spend;
                                                        total_spend += total_pant_spend;
                                                    }
                                            %>
                                            <%=pant_spend%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%=total_pant_spend%></td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_price);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        pant_price = Double.parseDouble(rs_spend.getString("prlist_pant"));
                                                    }
                                                    pant_income = ((pant_qty * pant_price) - total_pant_spend);
                                                    total_income += pant_income;
                                            %>
                                            <%=pant_price%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%=pant_income%></td>
                                    </tr>
                                    <!--------------------------------------------- for blazer ---------------------------------- -->
                                    <tr>
                                        <td style="text-align: center">3</td>
                                        <td style="text-align: center">Blazer</td>
                                        <td style="text-align: center">
                                            <%
                                                product_name = "blazer";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        receiveQty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=receiveQty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                                receiveQty = 0;
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                product_name = "blazer";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' and mk_status = '" + 1 + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        blazer_qty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=blazer_qty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_spend = "select * from worker_salary where ws_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_spend);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        blazer_spend = Double.parseDouble(rs_spend.getString("ws_blazer"));
                                                        total_blazer_spend = blazer_qty * blazer_spend;
                                                        total_spend += total_blazer_spend;
                                                    }
                                            %>
                                            <%=blazer_spend%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%=total_blazer_spend%></td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_price);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        blzer_price = Double.parseDouble(rs_spend.getString("prlist_blazer"));
                                                    }
                                                    blazer_income = ((blazer_qty * blzer_price) - total_blazer_spend);
                                                    total_income += blazer_income;
                                            %>
                                            <%= blzer_price%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%=blazer_income%></td>
                                    </tr>       
                                    <!----------------------------------------------------------  for photua ------------------------------------------------------>
                                    <tr>
                                        <td style="text-align: center">4</td>
                                        <td style="text-align: center">Photua</td>
                                        <td style="text-align: center">
                                            <%
                                                product_name = "photua";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        receiveQty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=receiveQty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                                receiveQty = 0;
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                product_name = "photua";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' and mk_status = '" + 1 + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        photua_qty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=photua_qty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_spend = "select * from worker_salary where ws_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_spend);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        photua_spend = Double.parseDouble(rs_spend.getString("ws_photua"));
                                                        total_photua_spend = photua_qty * photua_spend;
                                                        total_spend += total_photua_spend;
                                                    }
                                            %>
                                            <%= photua_spend%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%= total_photua_spend%></td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_price);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        photua_price = Double.parseDouble(rs_spend.getString("prlist_photua"));
                                                    }
                                                    photua_income = ((photua_qty * photua_price) - total_photua_spend);
                                                    total_income += photua_income;
                                            %>
                                            <%= photua_price%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%= photua_income%></td>
                                    </tr>                             
                                    <!----------------------------------------------------------  for safari ------------------------------------------------------>
                                    <tr>
                                        <td style="text-align: center">5</td>
                                        <td style="text-align: center">Safari</td>
                                        <td style="text-align: center">
                                            <%
                                                product_name = "safari";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        receiveQty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=receiveQty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                                receiveQty = 0;
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                product_name = "safari";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' and mk_status = '" + 1 + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        safari_qty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=safari_qty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_spend = "select * from worker_salary where ws_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_spend);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        safari_spend = Double.parseDouble(rs_spend.getString("ws_safari"));
                                                        total_safari_spend = safari_qty * safari_spend;
                                                        total_spend += total_safari_spend;
                                                    }
                                            %>
                                            <%= safari_spend%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%= total_safari_spend%></td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_price);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        safari_price = Double.parseDouble(rs_spend.getString("prlist_safari"));
                                                    }
                                                    safari_income = ((safari_qty * safari_price) - total_safari_spend);
                                                    total_income += safari_income;
                                            %>
                                            <%= safari_price%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%= safari_income%></td>
                                    </tr>                             
                                    <!----------------------------------------------------------  for panjabi ------------------------------------------------------>
                                    <tr>
                                        <td style="text-align: center">6</td>
                                        <td style="text-align: center">Panjabi</td>
                                        <td style="text-align: center">
                                            <%
                                                product_name = "panjabi";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        receiveQty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=receiveQty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                                receiveQty = 0;
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                product_name = "panjabi";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' and mk_status = '" + 1 + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        panjabi_qty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%=panjabi_qty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_spend = "select * from worker_salary where ws_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_spend);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        panjabi_spend = Double.parseDouble(rs_spend.getString("ws_panjabi"));
                                                        total_panjabi_spend = panjabi_qty * panjabi_spend;
                                                        total_spend += total_panjabi_spend;
                                                    }
                                            %>
                                            <%= panjabi_spend%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%= total_panjabi_spend%></td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_price);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        panjabi_price = Double.parseDouble(rs_spend.getString("prlist_panjabi"));
                                                    }
                                                    panjabi_income = ((panjabi_qty * panjabi_price) - total_panjabi_spend);
                                                    total_income += panjabi_income;
                                            %>
                                            <%=  panjabi_price%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%= panjabi_income%></td>
                                    </tr>                             
                                    <!----------------------------------------------------------  for payjama ------------------------------------------------------>
                                    <tr>
                                        <td style="text-align: center">7</td>
                                        <td style="text-align: center">Payjama</td>
                                        <td style="text-align: center">
                                            <%
                                                product_name = "payjama";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        receiveQty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%= receiveQty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                                receiveQty = 0;
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                product_name = "payjama";
                                                try {
                                                    String sql_shirt_qty = "select * from maker_order_product_info where date like ? and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' and mk_status = '" + 1 + "' ";
                                                    PreparedStatement pst_shirt_qty = DbConnection.getConn(sql_shirt_qty);
                                                    pst_shirt_qty.setString(1, year + "-" + month + "%");
                                                    ResultSet rs_shirt_qty = pst_shirt_qty.executeQuery();
                                                    while (rs_shirt_qty.next()) {
                                                        String qty = rs_shirt_qty.getString("qty");
                                                        payjama_qty += Double.parseDouble(qty);
                                                    }
                                            %>
                                            <%= payjama_qty%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_spend = "select * from worker_salary where ws_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_spend);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        payjama_spend = Double.parseDouble(rs_spend.getString("ws_payjama"));
                                                        total_payjama_spend = payjama_qty * payjama_spend;
                                                        total_spend += total_payjama_spend;
                                                    }
                                            %>
                                            <%=  payjama_spend%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%= total_payjama_spend%></td>
                                        <td style="text-align: center">
                                            <%
                                                try {
                                                    String sql_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                    PreparedStatement pst_spend = DbConnection.getConn(sql_price);
                                                    ResultSet rs_spend = pst_spend.executeQuery();
                                                    while (rs_spend.next()) {
                                                        payjama_price = Double.parseDouble(rs_spend.getString("prlist_payjama"));
                                                    }
                                                    payjama_income = ((payjama_qty * payjama_price) - total_payjama_spend);
                                                    total_income += panjabi_income;
                                            %>
                                            <%= payjama_price%>
                                            <%
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </td>
                                        <td style="text-align: center"><%= payjama_income%></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td style="text-align: center"><b>Total spend = </b></td>
                                        <td style="text-align: center"><b><%=total_spend%></b></td>
                                        <td style="text-align: center"><b>Total Income =</b></td>
                                        <td style="text-align: center"><b><%=total_income%></b></td>
                                    </tr>
                                </tbody>
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
