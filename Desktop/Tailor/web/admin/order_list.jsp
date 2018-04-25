<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
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
    </head>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=order" />
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                <center><b><span class="deliver_msg" style="color: green"><%
                                    String deliver_status = (String) session.getAttribute("delivered");
                                    String from_date = request.getParameter("from_date");
                                    String to_date = request.getParameter("to_date");
                                    //first date of current month
                                    Calendar first_date = Calendar.getInstance();
                                    first_date.set(Calendar.DAY_OF_MONTH, 1);
                                    Date dt = first_date.getTime();
                                    SimpleDateFormat sdt = new SimpleDateFormat("yyyy-MM-dd");
                                    String first_date_of_month = sdt.format(dt);
                                    //last date of month
                                    Calendar c = Calendar.getInstance();
                                    c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
                                    Date dtlast = c.getTime();
                                    String last_date_of_month = sdt.format(dtlast);
                                    if (from_date == null) {
                                        from_date = first_date_of_month;
                                    }
                                    if (to_date == null) {
                                        to_date = last_date_of_month;
                                    }
                                    String delivered_page_status = request.getParameter("delivered_page_status");
                                    if (session != null) {
                                        if (deliver_status == "delivered") {
                                            %>
                                            <%="Delivered Successfully !!"%>
                                            <%
                                                    }
                                                }
                                                session.removeAttribute("delivered");
                                            %></span></b></center>    
                            </div>
                            <div class="panel-body">                                
                                <div class="bs-example">
                                    <ul class="nav nav-tabs" id="myTab">
                                        <li class="<%if (session.getAttribute("delivereded_msg") == null && delivered_page_status == null) {%><%="active"%><% }%>"><a data-toggle="tab" href="#receive_order">Received Orders</a></li>
                                        <li><a data-toggle="tab" href="#processing_order">Processing Orders</a></li>
                                        <li class="<%if (session.getAttribute("delivereded_msg") != null) {%><%="active"%><% }%>"><a data-toggle="tab" href="#complet_order">Completed Orders</a></li>
                                        <li class="<%if (delivered_page_status != null) {%><%="active"%><% }%>"><a data-toggle="tab" href="#delivere_order">Delivered Orders</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="receive_order" class="tab-pane fade in <%if (session.getAttribute("delivereded_msg") == null && delivered_page_status == null) {%><%="active"%><% }%>">
                                            <h3>Received Orders </h3>
                                            <table class="table table-striped table-bordered" id="mydata">
                                                <thead>
                                                    <th style="text-align: center">SL</th>
                                                    <th style="text-align: center">Receive Date</th>
                                                    <th style="text-align: center">Delivery Date</th>
                                                    <th style="text-align: left">Receiver</th>
                                                    <th style="text-align: center">Order ID</th>
                                                    <th style="text-align: left">Customer Name</th>
                                                    <th style="text-align: center">Mobile</th>                                    
                                                </thead>
                                                <tbody>
                                                    <%
                                                        int id = 1;
                                                        String order_status = "2";
                                                        String order_id = null;
                                                        String delivery_date = null;
                                                        String receive_date = null;
                                                        String user_id = null;
                                                        String user_nam = null;
                                                        String customer_id = null;
                                                        String customer_name = null;
                                                        String customer_mobile = null;

                                                        double total_debit = 0;
                                                        double total_credit = 0;
                                                        double sell_qty = 0;
                                                        double due = 0;
                                                        try {
                                                            String sql_order = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and (ord_status = 2 or ord_status = 3) order by ord_snlo desc";
                                                            PreparedStatement pst_order = DbConnection.getConn(sql_order);
                                                            ResultSet rs_order = pst_order.executeQuery();
                                                            while (rs_order.next()) {
                                                                order_id = rs_order.getString("ord_bran_order");

                                                                // date format
                                                                receive_date = rs_order.getString("ord_receive_date");
                                                                delivery_date = rs_order.getString("ord_delivery_date");
                                                                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                                Date r_date = simpleDateFormat.parse(receive_date);
                                                                SimpleDateFormat sd = new SimpleDateFormat("dd-MM-yyyy");
                                                                receive_date = sd.format(r_date);

                                                                user_id = rs_order.getString("ord_user_id");
                                                                customer_id = rs_order.getString("ord_cutomer_id");
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center; width: 8%;"><%=id++%></td>
                                                        <td style="text-align: center; width: 13%;"><%=receive_date%></td>
                                                        <td style="text-align: center; width: 13%;"><%if (delivery_date != null) {%><%=delivery_date%><%} %></td>
                                                        <td>
                                                            <%
                                                                try {
                                                                    String sql_user_name = "select * from user_user where user_id = '" + user_id + "' ";
                                                                    PreparedStatement pst_user_name = DbConnection.getConn(sql_user_name);
                                                                    ResultSet rs_user_name = pst_user_name.executeQuery();
                                                                    if (rs_user_name.next()) {
                                                                        user_nam = rs_user_name.getString("user_name");
                                                                    } else {
                                                                        user_nam = "Branch";
                                                                    }
                                                            %>
                                                            <%= user_nam%>
                                                            <%
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>
                                                        </td>
                                                        <td style="text-align: center; width: 10%"><%=order_id%></td>
                                                        <td style="width: 22%;">
                                                            <%
                                                                try {
                                                                    String sql_customer_name = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + customer_id + "' ";
                                                                    PreparedStatement pst_customer_name = DbConnection.getConn(sql_customer_name);
                                                                    ResultSet rs_customer_name = pst_customer_name.executeQuery();
                                                                    if (rs_customer_name.next()) {
                                                                        customer_name = rs_customer_name.getString("cus_name");
                                                                        customer_mobile = rs_customer_name.getString("cus_mobile");
                                                                    }
                                                            %>
                                                            <%=customer_name%>
                                                            <%
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }

                                                            %>
                                                        </td>
                                                        <td style="text-align: center; width: 13%;"><%=customer_mobile%></td>

                                                    </tr>
                                                    <%
                                                            }
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div id="processing_order" class="tab-pane fade">
                                            <h3>Processing Orders</h3>
                                            <table class="table table-striped table-bordered" id="myprocessingdata">
                                                <thead>
                                                    <th style="text-align: center; width: 3%;">SL</th>
                                                    <th style="text-align: center">Receive Date</th>
                                                    <th style="text-align: center">Delivery Date</th>
                                                    <th style="text-align: center">Receiver</th>
                                                    <th style="text-align: center">Order ID</th>
                                                    <th style="text-align: center">Customer Name</th>
                                                    <th style="text-align: center">Mobile</th>                                    
                                                </thead>
                                                <tbody>
                                                    <%
                                                        int pro_ord_id = 1;
                                                        String pro_ord_order_status = "0";
                                                        String pro_ord_order_id = null;
                                                        String pro_ord_delivery_date = null;
                                                        String pro_ord_receive_date = null;
                                                        String pro_ord_user_id = null;
                                                        String pro_ord_user_nam = null;
                                                        String pro_ord_customer_id = null;
                                                        String pro_ord_customer_name = null;
                                                        String pro_ord_customer_mobile = null;
                                                        try {
                                                            String sql_processing_order = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_status = 0 order by ord_snlo desc";
                                                            PreparedStatement pst_processing_order = DbConnection.getConn(sql_processing_order);
                                                            ResultSet rs_processing_order = pst_processing_order.executeQuery();
                                                            while (rs_processing_order.next()) {
                                                                pro_ord_order_id = rs_processing_order.getString("ord_bran_order");
                                                                pro_ord_delivery_date = rs_processing_order.getString("ord_delivery_date");
                                                                pro_ord_receive_date = rs_processing_order.getString("ord_receive_date");
                                                                //receive date format
                                                                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                                Date r_date = simpleDateFormat.parse(pro_ord_receive_date);
                                                                SimpleDateFormat sd = new SimpleDateFormat("dd-MM-yyyy");
                                                                //receive date format
                                                                pro_ord_receive_date = sd.format(r_date);
                                                                pro_ord_user_id = rs_processing_order.getString("ord_user_id");
                                                                pro_ord_customer_id = rs_processing_order.getString("ord_cutomer_id");
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center;"><%=pro_ord_id++%></td>
                                                        <td style="text-align: center; width: 13%;"><%=pro_ord_receive_date%></td>
                                                        <td style="text-align: center; width: 13%;"><%=pro_ord_delivery_date%></td>
                                                        <td>
                                                            <%
                                                                try {
                                                                    String sql_user_name = "select * from user_user where user_bran_id = '" + session.getAttribute("user_bran_id") + "' and user_id = '" + pro_ord_user_id + "' ";
                                                                    PreparedStatement pst_user_name = DbConnection.getConn(sql_user_name);
                                                                    ResultSet rs_user_name = pst_user_name.executeQuery();
                                                                    if (rs_user_name.next()) {
                                                                        pro_ord_user_nam = rs_user_name.getString("user_name");
                                                                    } else {
                                                                        pro_ord_user_nam = "Branch";
                                                                    }
                                                            %>
                                                            <%= pro_ord_user_nam%>
                                                            <%
                                                                } catch (Exception e) {
                                                                    out.println("user id " + e.toString());
                                                                }
                                                            %>
                                                        </td>
                                                        <td style="text-align: center; width: 10%"><%=pro_ord_order_id%></td>
                                                        <td style="width: 22%;">
                                                            <%
                                                                try {
                                                                    String sql_customer_name = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + pro_ord_customer_id + "' ";
                                                                    PreparedStatement pst_customer_name = DbConnection.getConn(sql_customer_name);
                                                                    ResultSet rs_customer_name = pst_customer_name.executeQuery();
                                                                    if (rs_customer_name.next()) {
                                                                        pro_ord_customer_name = rs_customer_name.getString("cus_name");
                                                                        pro_ord_customer_mobile = rs_customer_name.getString("cus_mobile");
                                                                    }
                                                            %>
                                                            <%=pro_ord_customer_name%>
                                                            <%
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }

                                                            %>
                                                        </td>
                                                        <td style="text-align: center; width: 13%;"><%=pro_ord_customer_mobile%></td>

                                                    </tr>
                                                    <%
                                                            }
                                                        } catch (Exception e) {
                                                            out.println(" order " + e.toString());
                                                            e.printStackTrace();
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div id="complet_order" class="tab-pane fade in <%if (session.getAttribute("delivereded_msg") != null) {%><%="active"%><% }%>">
                                            <h3>Completed Orders</h3>                                         
                                            <table class="table table-striped table-bordered" id="mycomdata">
                                                <thead>
                                                    <th style="text-align: center">SL</th>
                                                    <th style="text-align: center">Receive Date</th>
                                                    <th style="text-align: center">Delivery Date</th>
                                                    <th style="text-align: center">Receiver</th>
                                                    <th style="text-align: center">Order ID</th>
                                                    <th style="text-align: center">Customer Name</th>
                                                    <th style="text-align: center">Mobile</th>
                                                    <th style="text-align: center">Due</th>
                                                    <th style="text-align: center">Delivered Order</th>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        int com_id = 1;
                                                        String com_order_status = "4";
                                                        String com_order_id = null;
                                                        String com_delivery_date = null;
                                                        String com_receive_date = null;
                                                        String com_user_id = null;
                                                        String com_user_nam = null;
                                                        String com_customer_id = null;
                                                        String com_customer_name = null;
                                                        String com_customer_mobile = null;

                                                        try {
                                                            String sql_order = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_status = '" + com_order_status + "' order by ord_snlo desc ";
                                                            PreparedStatement pst_order = DbConnection.getConn(sql_order);
                                                            ResultSet rs_order = pst_order.executeQuery();
                                                            while (rs_order.next()) {
                                                                com_order_id = rs_order.getString("ord_bran_order");
                                                                com_delivery_date = rs_order.getString("ord_delivery_date");
                                                                com_receive_date = rs_order.getString("ord_receive_date");
                                                                //recevie date format
                                                                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                                Date r_date = simpleDateFormat.parse(com_receive_date);
                                                                SimpleDateFormat sd = new SimpleDateFormat("dd-MM-yyyy");
                                                                // receive date format
                                                                com_receive_date = sd.format(r_date);
                                                                com_user_id = rs_order.getString("ord_user_id");
                                                                com_customer_id = rs_order.getString("ord_cutomer_id");

                                                                //-----------------------------------------------------------customer due------------------------------------------------------------------------
                                                                PreparedStatement pst_debit = null;
                                                                ResultSet rs_debit = null;

                                                                try {
                                                                    String sql_debit = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + com_customer_id + "' and (pro_deal_type = 5 or pro_deal_type = 1 or pro_deal_type = 4 or pro_deal_type = 6)";
                                                                    pst_debit = DbConnection.getConn(sql_debit);
                                                                    rs_debit = pst_debit.executeQuery();
                                                                    while (rs_debit.next()) {
                                                                        String debit = rs_debit.getString("pro_sell_price");
                                                                        sell_qty = Double.parseDouble(rs_debit.getString("pro_sell_quantity"));
                                                                        String credit = rs_debit.getString("pro_sell_paid");
                                                                        total_debit += (Double.parseDouble(debit) * sell_qty);
                                                                        total_credit += Double.parseDouble(credit);
                                                                    }
                                                                    due = total_debit - total_credit;
                                                                    
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                                //-----------------------------------------------------------//customer due------------------------------------------------------------------------
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center;width: 8%;"><%=com_id++%></td>
                                                        <td style="text-align: center; width: 13%;"><%=com_receive_date%></td>
                                                        <td style="text-align: center; width: 13%;"><%=com_delivery_date%></td>
                                                        <td>
                                                            <%
                                                                try {
                                                                    String sql_user_name = "select * from user_user where user_id = '" + com_user_id + "' ";
                                                                    PreparedStatement pst_user_name = DbConnection.getConn(sql_user_name);
                                                                    ResultSet rs_user_name = pst_user_name.executeQuery();
                                                                    if (rs_user_name.next()) {
                                                                        com_user_nam = rs_user_name.getString("user_name");
                                                                    } else {
                                                                        com_user_nam = "Branch";
                                                                    }
                                                            %>
                                                            <%= com_user_nam%>
                                                            <%
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>
                                                        </td>
                                                        <td style="text-align: center; width: 10%"><%=com_order_id%></td>
                                                        <td style="width: 20%;">
                                                            <%
                                                                try {
                                                                    String sql_customer_name = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + com_customer_id + "' ";
                                                                    PreparedStatement pst_customer_name = DbConnection.getConn(sql_customer_name);
                                                                    ResultSet rs_customer_name = pst_customer_name.executeQuery();
                                                                    if (rs_customer_name.next()) {
                                                                        com_customer_name = rs_customer_name.getString("cus_name");
                                                                        com_customer_mobile = rs_customer_name.getString("cus_mobile");
                                                                    }
                                                            %>
                                                            <%=com_customer_name%>
                                                            <%
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>
                                                        </td>
                                                        <td style="text-align: center; width: 13%;"><%=com_customer_mobile%></td>
                                                        <td style="text-align: right;"><%= due + "0"%></td>
                                                        <td style="text-align: center; width: 6%;">
                                                            <a href="order_delivery.jsp?ord=<%=com_order_id%>&com_due=<%=due%>" style="color: black; text-decoration: none;"><button class="btn btn-primary">Yes</button></a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                                due = 0;
                                                                total_debit = 0;
                                                                total_credit = 0;
                                                            }
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div id="delivere_order" class="tab-pane fade in <%if (delivered_page_status != null) {%><%="active"%><% }%>">
                                            <div class="pull-left"><h3>Delivered Orders</h3></div>
                                            <div class="pull-right">
                                                <form action="order_list.jsp" method="post" class="pull-right" style="">
                                                    <input type="text" name="from_date" value="<%=from_date%>" id="fromdate" placeholder="from" required="" style="width: 150px;"/>
                                                    <input type="text" name="to_date" id="todate" value="<%=to_date%>" placeholder="to" required="" style="width: 150px;"/>
                                                    <input type="text" name="delivered_page_status" value="something here" style="display: none" />
                                                    <input type="submit" value="Submit"/>
                                                </form>
                                            </div>                                            
                                            <table class="table table-striped table-bordered" id="mydeldata">
                                                <thead>
                                                    <th style="text-align: center">SL</th>
                                                    <th style="text-align: center">Receive Date</th>
                                                    <th style="text-align: center">Delivery Date</th>
                                                    <th style="text-align: left">Receiver</th>
                                                    <th style="text-align: center">Order ID</th>
                                                    <th style="text-align: left">Customer Name</th>
                                                    <th style="text-align: center">Mobile</th>

                                                </thead>
                                                <tbody>
                                                    <%
                                                        int del_id = 1;
                                                        String del_order_status = "5";
                                                        String del_order_id = null;
                                                        String del_delivery_date = null;
                                                        String del_receive_date = null;
                                                        String del_user_id = null;
                                                        String del_user_nam = null;
                                                        String del_customer_id = null;
                                                        String del_customer_name = null;
                                                        String del_customer_mobile = null;
                                                        try {
                                                            String sql_order = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and  ord_status = '" + del_order_status + "' and (ord_delivery_date >= '" + from_date + "' and ord_delivery_date <= '" + to_date + "') order by ord_snlo desc";

                                                            PreparedStatement pst_order = DbConnection.getConn(sql_order);
                                                            ResultSet rs_order = pst_order.executeQuery();
                                                            while (rs_order.next()) {
                                                                del_order_id = rs_order.getString("ord_bran_order");
                                                                del_delivery_date = rs_order.getString("ord_delivery_date");
                                                                del_receive_date = rs_order.getString("ord_receive_date");
                                                                // receive date format
                                                                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                                Date r_date = simpleDateFormat.parse(del_receive_date);
                                                                SimpleDateFormat sd = new SimpleDateFormat("dd-MM-yyyy");
                                                                // receive date format
                                                                del_receive_date = sd.format(r_date);
                                                                del_user_id = rs_order.getString("ord_user_id");
                                                                del_customer_id = rs_order.getString("ord_cutomer_id");
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center;width: 8%;"><%=id++%></td>
                                                        <td style="text-align: center; width: 13%;"><%=del_receive_date%></td>
                                                        <td style="text-align: center; width: 13%;"><%=del_delivery_date%></td>
                                                        <td>
                                                            <%
                                                                try {
                                                                    String sql_user_name = "select * from user_user where user_id = '" + del_user_id + "' ";
                                                                    PreparedStatement pst_user_name = DbConnection.getConn(sql_user_name);
                                                                    ResultSet rs_user_name = pst_user_name.executeQuery();
                                                                    if (rs_user_name.next()) {
                                                                        del_user_nam = rs_user_name.getString("user_name");
                                                                    } else {
                                                                        del_user_nam = "Branch";
                                                                    }
                                                            %>
                                                            <%= del_user_nam%>
                                                            <%
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>
                                                        </td>
                                                        <td style="text-align: center; width: 10%"><%=del_order_id%></td>
                                                        <td style="width: 22%;">
                                                            <%
                                                                try {
                                                                    String sql_customer_name = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + del_customer_id + "' ";
                                                                    PreparedStatement pst_customer_name = DbConnection.getConn(sql_customer_name);
                                                                    ResultSet rs_customer_name = pst_customer_name.executeQuery();
                                                                    if (rs_customer_name.next()) {
                                                                        del_customer_name = rs_customer_name.getString("cus_name");
                                                                        del_customer_mobile = rs_customer_name.getString("cus_mobile");
                                                                    }
                                                            %>
                                                            <%=del_customer_name%>
                                                            <%
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }

                                                            %>
                                                        </td>
                                                        <td style="text-align: center; width: 13%;"><%=del_customer_mobile%></td>

                                                    </tr>
                                                    <%
                                                            }
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                        session.removeAttribute("delivereded_msg");
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                                                    
                </div>
            </div>
        </div>
        <script>
            $(function () {
                $(".deliver_msg").fadeIn("slow").delay(3000).fadeOut("slow");
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                    localStorage.setItem('activeTab', $(e.target).attr('href'));
                });
                var activeTab = localStorage.getItem('activeTab');
                if (activeTab) {
                    $('#myTab a[href="' + activeTab + '"]').tab('show');
                }
            });
            $(function () {
                $("#fromdate").datepicker({
                    dateFormat: "yy-mm-dd",
//                    maxDate: 0,
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2017:' + (new Date()).getFullYear()
                });
            });
            $(function () {
                $("#todate").datepicker({
                    dateFormat: "yy-mm-dd",
//                    maxDate: 0,
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2017:' + (new Date()).getFullYear()
                });
            });
        </script>
        <!--        <script src="assets/js/jquery.js" type="text/javascript"></script>-->
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
            $("#myprocessingdata").dataTable({
                "pagingType": "simple_numbers",
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search..."
                }
            });
            $("#mydeldata").dataTable({
                "pagingType": "simple_numbers",
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search..."
                }
            });
            $("#mycomdata").dataTable({
                "pagingType": "simple_numbers",
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search..."
                }
            });
        </script>  

    </body>
</html>
