<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
            <jsp:include page="../menu/menu.jsp?page_name=order" />
            <!-- /. NAV SIDE  -->
            <%
                String order_id_by_search = request.getParameter("order_id_search");
                double all_total_price = 0;

                double product_price_shirt = 0;
                double product_price_blazer = 0;
                double product_price_photua = 0;
                double product_price_safari = 0;
                double product_price_panjabi = 0;
                double product_price_payjama = 0;
                double product_price_pant = 0;
                double product_price_mojibcort = 0;
                double product_price_kable = 0;
                double product_price_koti = 0;
            %>

            <%
                // get customer name
                String customer_id = null;
                String customer_name = null;
                try {
                    String sql_customer_id = "select * from ad_order where ord_bran_order = '" + order_id_by_search + "' and ord_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                    PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                    ResultSet rs_customer_id = pst_customer_id.executeQuery();
                    if (rs_customer_id.next()) {
                        customer_id = rs_customer_id.getString("ord_cutomer_id");
                        try {
                            String sql_customer_name = "select * from customer where cus_customer_id = '" + customer_id + "' and cus_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                            PreparedStatement pst_customer_name = DbConnection.getConn(sql_customer_name);
                            ResultSet rs_customer_name = pst_customer_name.executeQuery();
                            if (rs_customer_name.next()) {
                                customer_name = rs_customer_name.getString("cus_name");
                            }
                        } catch (Exception e) {
                            out.println(e.toString());
                        }
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <%
                // receiver or user name 
                String user_id = null;
                String user_name = null;
                String receive_date = null;
                String delivery_date = null;
                try {
                    String sql_user_id = "select * from ad_order where ord_bran_order = '" + order_id_by_search + "' and ord_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                    PreparedStatement pst_user_id = DbConnection.getConn(sql_user_id);
                    ResultSet rs_user_id = pst_user_id.executeQuery();
                    if (rs_user_id.next()) {
                        user_id = rs_user_id.getString("ord_user_id");
                        all_total_price = Double.parseDouble(rs_user_id.getString("ord_total_price"));
                        receive_date = rs_user_id.getString("ord_receive_date");
                        // receive date format
                        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        Date r_date = simpleDateFormat.parse(receive_date);
                        SimpleDateFormat sd = new SimpleDateFormat("dd-MM-yyyy");
                        receive_date = sd.format(r_date);
                        // receive date format
                        delivery_date = rs_user_id.getString("ord_delivery_date");
                        try {
                            String sql_user_name = "select * from user_user where user_id = '" + user_id + "' and user_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                            PreparedStatement pst_user_name = DbConnection.getConn(sql_user_name);
                            ResultSet rs_user_name = pst_user_name.executeQuery();
                            if (rs_user_name.next()) {
                                user_name = rs_user_name.getString("user_name");
                            }
                        } catch (Exception e) {
                            out.println(e.toString());
                        }
                    }
            %>

            <%
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <%
                // product price 
                double shirt_price = 0;
                double pant_price = 0;
                double blazer_price = 0;
                double photua_price = 0;
                double panjabi_price = 0;
                double payjama_price = 0;
                double safari_price = 0;
                double mojibcort_price = 0;
                double kable_price = 0;
                double koti_price = 0;
                try {
                    String sql_product_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                    PreparedStatement pst_product_price = DbConnection.getConn(sql_product_price);
                    ResultSet rs_product_price = pst_product_price.executeQuery();
                    while (rs_product_price.next()) {
                        shirt_price = Double.parseDouble(rs_product_price.getString("prlist_shirt"));
                        pant_price = Double.parseDouble(rs_product_price.getString("prlist_pant"));
                        blazer_price = Double.parseDouble(rs_product_price.getString("prlist_blazer"));
                        photua_price = Double.parseDouble(rs_product_price.getString("prlist_photua"));
                        panjabi_price = Double.parseDouble(rs_product_price.getString("prlist_panjabi"));
                        payjama_price = Double.parseDouble(rs_product_price.getString("prlist_payjama"));
                        safari_price = Double.parseDouble(rs_product_price.getString("prlist_safari"));
                        mojibcort_price = Double.parseDouble(rs_product_price.getString("prlist_mojib_cort"));
                        kable_price = Double.parseDouble(rs_product_price.getString("prlist_kable"));
                        koti_price = Double.parseDouble(rs_product_price.getString("prlist_koti"));
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                <b>Order Details</b>
                                <div class="pull-right">
                                    <form action="order_show_details_searching.jsp" method="post">
                                        <table>
                                            <tr>
                                                <td>Order ID </td>
                                                <td><input type="text" pattern="[0-9]+" name="order_id_search" maxlength="10" required=""/></td>
                                                <td><input type="submit" value="search"/></td>
                                            </tr>
                                        </table>
                                    </form>
                                </div>
                            </div>
                            <div class="panel-body">
                                <%                                    if (order_id_by_search != null) {
                                %>
                                <span style="font-size: 15px;"><%="Order ID :<b> " + order_id_by_search%><%="</b>, Customer Name : <b>" + customer_name + "</b>"%></span>                                
                                <span style="font-size: 15px;"><%=", Order Received by :<b>"%><%if (user_name != null) {%><%=user_name%><%} else {%><%="</b><b> Branch</b>"%><%}%></span>
                                <span style="font-size: 15px;"><%=", Received Date : <b>" + receive_date%><%="</b>, Delivery Date : <b>" + delivery_date + "</b>"%></span>
                                <%
                                    }
                                %>

                                <%
                                    // order_id_by_search jodi null na hoy tahole aigulo dekhaba 
                                    if (order_id_by_search != null) {
                                        // take product price from price_list by bran_id dhore 
                                        try {
                                            String sql_product_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                            PreparedStatement pst_product_price = DbConnection.getConn(sql_product_price);
                                            ResultSet rs_product_price = pst_product_price.executeQuery();
                                            while (rs_product_price.next()) {
                                                product_price_shirt = Double.parseDouble(rs_product_price.getString("prlist_shirt"));
                                                product_price_pant = Double.parseDouble(rs_product_price.getString("prlist_pant"));
                                                product_price_blazer = Double.parseDouble(rs_product_price.getString("prlist_blazer"));
                                                product_price_photua = Double.parseDouble(rs_product_price.getString("prlist_photua"));
                                                product_price_panjabi = Double.parseDouble(rs_product_price.getString("prlist_panjabi"));
                                                product_price_payjama = Double.parseDouble(rs_product_price.getString("prlist_payjama"));
                                                product_price_safari = Double.parseDouble(rs_product_price.getString("prlist_safari"));
                                                product_price_mojibcort = Double.parseDouble(rs_product_price.getString("prlist_mojib_cort"));
                                                product_price_kable = Double.parseDouble(rs_product_price.getString("prlist_kable"));
                                                product_price_koti = Double.parseDouble(rs_product_price.getString("prlist_koti"));

                                            }
                                        } catch (Exception e) {
                                            out.println(e.toString());
                                        }
                                %>
                                <div class="">
                                    <table class="table table-striped table-bordered" style="margin-top: 10px;">                                                
                                        <thead>
                                            <th style="text-align: center">ID</th>
                                            <th style="text-align: center">Product Name</th>
                                            <th style="text-align: center">Maker</th>
                                            <th style="text-align: center">Delivery Date</th>
                                            <th style="text-align: center">Qty</th>
                                            <th style="text-align: center">Price</th>
                                            <th style="text-align: center">Total Price</th>                                           
                                            <th style="text-align: center">Status </th>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <%
                                                    // for shirt 
                                                    int id = 1;
                                                    int shirt_qty = 0;
                                                    String product_status = null;
                                                    String product_delivery_date = null;
                                                    try {
                                                        String sql_shirt = "select * from ser_shirt where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_shirt = DbConnection.getConn(sql_shirt);
                                                        ResultSet rs_shirt = pst_shirt.executeQuery();
                                                        if (rs_shirt.next()) {
                                                            String product_name = "shirt";
                                                            shirt_qty = Integer.parseInt(rs_shirt.getString("qty"));
                                                %>
                                                <td style="text-align: center; width: 6%;"><%= id++%></td>
                                                <td style="text-align: left; width: 14%;"><%="Shirt"%></td>                                          
                                                <td style="text-align: left">
                                                    <%
                                                        // this product maker 
                                                        String maker_name = null;
                                                        try {
                                                            String sql_maker = "select * from maker_order_product_info where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                            PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                                                            ResultSet rs_maker = pst_maker.executeQuery();
                                                            if (rs_maker.next()) {
                                                                maker_name = rs_maker.getString("mk_name");
                                                                String shirt_status = rs_maker.getString("mk_status");
                                                                product_delivery_date = rs_maker.getString("mk_delivery_date");
                                                                if (shirt_status.equals("1")) {
                                                                    product_status = "complete";
                                                                } else {
                                                                    product_status = "incomplete";
                                                                }
                                                            }
                                                    %>
                                                    <%if (maker_name != null) {%><%=maker_name%><%}%>
                                                    <%
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center;width: 13%;"><%if (product_delivery_date != null) {%><%=product_delivery_date%><%}%></td>
                                                <td style="text-align: center; width: 6%;"><%=shirt_qty%></td>
                                                <td style="text-align: right; width: 10%;"><%=shirt_price + "0"%></td>
                                                <td style="text-align: right; width: 10%;"><%= shirt_qty * product_price_shirt + "0"%></td>                                               
                                                <td style="text-align: center; width: 10%;"><%=product_status%></td>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </tr>
                                            <tr>
                                                <%
                                                    // for pant 
                                                    int pant_qty = 0;
                                                    try {
                                                        String sql_pant = "select * from ser_pant where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_pant = DbConnection.getConn(sql_pant);
                                                        ResultSet rs_pant = pst_pant.executeQuery();
                                                        if (rs_pant.next()) {
                                                            String product_name = "pant";
                                                            pant_qty = Integer.parseInt(rs_pant.getString("qty"));
                                                %>
                                                <td style="text-align: center"><%= id++%></td>
                                                <td style="text-align: left"><%="Pant"%></td>                                                
                                                <td style="text-align: left">
                                                    <%
                                                        // this product maker 
                                                        String maker_name = null;
                                                        try {
                                                            String sql_maker = "select * from maker_order_product_info where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                            PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                                                            ResultSet rs_maker = pst_maker.executeQuery();
                                                            if (rs_maker.next()) {
                                                                maker_name = rs_maker.getString("mk_name");
                                                                String pant_status = rs_maker.getString("mk_status");
                                                                product_delivery_date = rs_maker.getString("mk_delivery_date");
                                                                if (pant_status.equals("1")) {
                                                                    product_status = "complete";
                                                                } else {
                                                                    product_status = "incomplete";
                                                                }
                                                            }
                                                    %>
                                                    <%if (maker_name != null) {%><%=maker_name%><%}%>
                                                    <%
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center"><%=product_delivery_date%></td>
                                                <td style="text-align: center"><%= pant_qty%></td>
                                                <td style="text-align: right"><%= pant_price + "0"%></td>
                                                <td style="text-align: right"><%= pant_qty * product_price_pant + "0"%></td>                                                
                                                <td style="text-align: center"><%=product_status%></td>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </tr>
                                            <tr>
                                                <%
                                                    // for blazer ------------------------------------------------------------
                                                    int blazer_qty = 0;
                                                    try {
                                                        String sql_blazer = "select * from ser_blazer where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_blazer = DbConnection.getConn(sql_blazer);
                                                        ResultSet rs_blazer = pst_blazer.executeQuery();
                                                        if (rs_blazer.next()) {
                                                            String product_name = "blazer";
                                                            blazer_qty = Integer.parseInt(rs_blazer.getString("qty"));
                                                %>
                                                <td style="text-align: center"><%= id++%></td>
                                                <td style="text-align: left"><%="Blazer"%></td>                                                
                                                <td style="text-align: left">
                                                    <%
                                                        // this product maker 
                                                        String maker_name = null;
                                                        try {
                                                            String sql_maker = "select * from maker_order_product_info where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                            PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                                                            ResultSet rs_maker = pst_maker.executeQuery();
                                                            if (rs_maker.next()) {
                                                                maker_name = rs_maker.getString("mk_name");
                                                                String bla_status = rs_maker.getString("mk_status");
                                                                product_delivery_date = rs_maker.getString("mk_delivery_date");
                                                                if (bla_status.equals("1")) {
                                                                    product_status = "complete";
                                                                } else {
                                                                    product_status = "incomplete";
                                                                }
                                                            }
                                                    %>
                                                    <%if (maker_name != null) {%><%=maker_name%><%}%>
                                                    <%
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center"><%=product_delivery_date%></td>
                                                <td style="text-align: center"><%=blazer_qty%></td>
                                                <td style="text-align: right"><%=blazer_price + "0"%></td>
                                                <td style="text-align: right"><%=blazer_qty * product_price_blazer + "0"%></td>                                                
                                                <td style="text-align: center"><%= product_status%></td>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </tr>
                                            <tr>
                                                <%
                                                    // for photua ------------------------------------------------------------
                                                    int photua_qty = 0;
                                                    try {
                                                        String sql_photua = "select * from ser_photua where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_photua = DbConnection.getConn(sql_photua);
                                                        ResultSet rs_photua = pst_photua.executeQuery();
                                                        if (rs_photua.next()) {
                                                            String product_name = "photua";
                                                            photua_qty = Integer.parseInt(rs_photua.getString("qty"));
                                                %>
                                                <td style="text-align: center"><%= id++%></td>
                                                <td style="text-align: left"><%="Photua"%></td>                                                
                                                <td style="text-align: left">
                                                    <%
                                                        // this product maker 
                                                        String maker_name = null;
                                                        try {
                                                            String sql_maker = "select * from maker_order_product_info where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                            PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                                                            ResultSet rs_maker = pst_maker.executeQuery();
                                                            if (rs_maker.next()) {
                                                                maker_name = rs_maker.getString("mk_name");
                                                                String photua_status = rs_maker.getString("mk_status");
                                                                product_delivery_date = rs_maker.getString("mk_delivery_date");
                                                                if (photua_status.equals("1")) {
                                                                    product_status = "complete";
                                                                } else {
                                                                    product_status = "incomplete";
                                                                }
                                                            }
                                                    %>
                                                    <%if (maker_name != null) {%><%=maker_name%><%}%>
                                                    <%
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center"><%=product_delivery_date%></td>
                                                <td style="text-align: center"><%=photua_qty%></td>
                                                <td style="text-align: right"><%=photua_price + "0"%></td>
                                                <td style="text-align: right"><%= photua_qty * product_price_photua + "0"%></td>                                                
                                                <td style="text-align: center"><%=product_status%></td>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </tr>
                                            <tr>
                                                <%
                                                    // for panjabi ------------------------------------------------------------
                                                    int panjabi_qty = 0;
                                                    try {
                                                        String sql_panjabi = "select * from ser_panjabi where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_panjabi = DbConnection.getConn(sql_panjabi);
                                                        ResultSet rs_panjabi = pst_panjabi.executeQuery();
                                                        if (rs_panjabi.next()) {
                                                            String product_name = "panjabi";
                                                            panjabi_qty = Integer.parseInt(rs_panjabi.getString("qty"));
                                                %>
                                                <td style="text-align: center"><%= id++%></td>
                                                <td style="text-align: left"><%="Panjabi"%></td>                                                
                                                <td style="text-align: left">
                                                    <%
                                                        // this product maker 
                                                        String maker_name = null;
                                                        try {
                                                            String sql_maker = "select * from maker_order_product_info where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                            PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                                                            ResultSet rs_maker = pst_maker.executeQuery();
                                                            if (rs_maker.next()) {
                                                                maker_name = rs_maker.getString("mk_name");
                                                                String panjabi_status = rs_maker.getString("mk_status");
                                                                product_delivery_date = rs_maker.getString("mk_delivery_date");
                                                                if (panjabi_status.equals("1")) {
                                                                    product_status = "complete";
                                                                } else {
                                                                    product_status = "incomplete";
                                                                }
                                                            }
                                                    %>
                                                    <%if (maker_name != null) {%><%=maker_name%><%}%>
                                                    <%
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center"><%=product_delivery_date%></td>
                                                <td style="text-align: center"><%=panjabi_qty%></td>
                                                <td style="text-align: right"><%=panjabi_price + "0"%></td>
                                                <td style="text-align: right"><%= panjabi_qty * product_price_panjabi + "0"%></td>                                                
                                                <td style="text-align: center"><%=product_status%></td>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </tr>
                                            <tr>
                                                <%
                                                    // for payjama ------------------------------------------------------------
                                                    int payjama_qty = 0;
                                                    try {
                                                        String sql_payjama = "select * from ser_payjama where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_payjama = DbConnection.getConn(sql_payjama);
                                                        ResultSet rs_payjama = pst_payjama.executeQuery();
                                                        if (rs_payjama.next()) {
                                                            String product_name = "payjama";
                                                            payjama_qty = Integer.parseInt(rs_payjama.getString("qty"));
                                                %>
                                                <td style="text-align: center"><%= id++%></td>
                                                <td style="text-align: left"><%="Payjama"%></td>                                                
                                                <td style="text-align: left">
                                                    <%
                                                        // this product maker 
                                                        String maker_name = null;
                                                        try {
                                                            String sql_maker = "select * from maker_order_product_info where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                            PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                                                            ResultSet rs_maker = pst_maker.executeQuery();
                                                            if (rs_maker.next()) {
                                                                maker_name = rs_maker.getString("mk_name");
                                                                String payjama_status = rs_maker.getString("mk_status");
                                                                product_delivery_date = rs_maker.getString("mk_delivery_date");
                                                                if (payjama_status.equals("1")) {
                                                                    product_status = "complete";
                                                                } else {
                                                                    product_status = "incomplete";
                                                                }
                                                            }
                                                    %>
                                                    <%if (maker_name != null) {%><%=maker_name%><%}%>
                                                    <%
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center"><%=product_delivery_date%></td>
                                                <td style="text-align: center"><%=payjama_qty%></td>
                                                <td style="text-align: right"><%=payjama_price + "0"%></td>
                                                <td style="text-align: right"><%= payjama_qty * product_price_payjama + "0"%></td>                                                
                                                <td style="text-align: center"><%=product_status%></td>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </tr>
                                            <tr>
                                                <%
                                                    // for safari ------------------------------------------------------------
                                                    int safari_qty = 0;
                                                    try {
                                                        String sql_safari = "select * from ser_safari where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_safari = DbConnection.getConn(sql_safari);
                                                        ResultSet rs_safari = pst_safari.executeQuery();
                                                        if (rs_safari.next()) {
                                                            String product_name = "safari";
                                                            safari_qty = Integer.parseInt(rs_safari.getString("qty"));
                                                %>
                                                <td style="text-align: center"><%= id++%></td>
                                                <td style="text-align: left"><%="Safari"%></td>                                                
                                                <td style="text-align: left">
                                                    <%
                                                        // this product maker 
                                                        String maker_name = null;
                                                        try {
                                                            String sql_maker = "select * from maker_order_product_info where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                            PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                                                            ResultSet rs_maker = pst_maker.executeQuery();
                                                            if (rs_maker.next()) {
                                                                maker_name = rs_maker.getString("mk_name");
                                                                String safari_status = rs_maker.getString("mk_status");
                                                                product_delivery_date = rs_maker.getString("mk_delivery_date");
                                                                if (safari_status.equals("1")) {
                                                                    product_status = "complete";
                                                                } else {
                                                                    product_status = "incomplete";
                                                                }
                                                            }
                                                    %>
                                                    <%if (maker_name != null) {%><%=maker_name%><%}%>
                                                    <%
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center"><%=product_delivery_date%></td>
                                                <td style="text-align: center"><%=safari_qty%></td>
                                                <td style="text-align: right"><%=safari_price + "0"%></td>
                                                <td style="text-align: right"><%= safari_qty * product_price_safari + "0"%></td>                                                
                                                <td style="text-align: center"><%=product_status%></td>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </tr>
                                            <tr>
                                                <%
                                                    // for mojib cort ------------------------------------------------------------
                                                    int mojib_qty = 0;
                                                    try {
                                                        String sql_mojibcort = "select * from ser_mojib_cort where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_mojibcort = DbConnection.getConn(sql_mojibcort);
                                                        ResultSet rs_mojibcort = pst_mojibcort.executeQuery();
                                                        if (rs_mojibcort.next()) {
                                                            String product_name = "mojib_cort";
                                                            mojib_qty = Integer.parseInt(rs_mojibcort.getString("qty"));
                                                %>
                                                <td style="text-align: center"><%= id++%></td>
                                                <td style="text-align: left"><%="Mojib Cort"%></td>                                                
                                                <td style="text-align: left">
                                                    <%
                                                        // this product maker 
                                                        String maker_name = null;
                                                        try {
                                                            String sql_maker = "select * from maker_order_product_info where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                            PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                                                            ResultSet rs_maker = pst_maker.executeQuery();
                                                            if (rs_maker.next()) {
                                                                maker_name = rs_maker.getString("mk_name");
                                                                String mojibcort_status = rs_maker.getString("mk_status");
                                                                product_delivery_date = rs_maker.getString("mk_delivery_date");
                                                                if (mojibcort_status.equals("1")) {
                                                                    product_status = "complete";
                                                                } else {
                                                                    product_status = "incomplete";
                                                                }
                                                            }
                                                    %>
                                                    <%if (maker_name != null) {%><%=maker_name%><%}%>
                                                    <%
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center"><%=product_delivery_date%></td>
                                                <td style="text-align: center"><%=mojib_qty%></td>
                                                <td style="text-align: right"><%=mojibcort_price + "0"%></td>
                                                <td style="text-align: right"><%= mojib_qty * product_price_mojibcort + "0"%></td>                                                
                                                <td style="text-align: center"><%=product_status%></td>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </tr>
                                            <tr>
                                                <%
                                                    // for kable ------------------------------------------------------------
                                                    int kable_qty = 0;
                                                    try {
                                                        String sql_kable = "select * from ser_kable where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_kable = DbConnection.getConn(sql_kable);
                                                        ResultSet rs_kable = pst_kable.executeQuery();
                                                        if (rs_kable.next()) {
                                                            String product_name = "kable";
                                                            kable_qty = Integer.parseInt(rs_kable.getString("qty"));
                                                %>
                                                <td style="text-align: center"><%= id++%></td>
                                                <td style="text-align: left"><%="Kable"%></td>                                                
                                                <td style="text-align: left">
                                                    <%
                                                        // this product maker 
                                                        String maker_name = null;
                                                        try {
                                                            String sql_maker = "select * from maker_order_product_info where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                            PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                                                            ResultSet rs_maker = pst_maker.executeQuery();
                                                            if (rs_maker.next()) {
                                                                maker_name = rs_maker.getString("mk_name");
                                                                String kable_status = rs_maker.getString("mk_status");
                                                                product_delivery_date = rs_maker.getString("mk_delivery_date");
                                                                if (kable_status.equals("1")) {
                                                                    product_status = "complete";
                                                                } else {
                                                                    product_status = "incomplete";
                                                                }
                                                            }
                                                    %>
                                                    <%if (maker_name != null) {%><%=maker_name%><%}%>
                                                    <%
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center"><%=product_delivery_date%></td>
                                                <td style="text-align: center"><%=kable_qty%></td>
                                                <td style="text-align: right"><%=kable_price + "0"%></td>
                                                <td style="text-align: right"><%= kable_qty * product_price_kable + "0"%></td>                                                
                                                <td style="text-align: center"><%=product_status%></td>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </tr>
                                            <tr>
                                                <%
                                                    // for koti ------------------------------------------------------------
                                                    int koti_qty = 0;
                                                    try {
                                                        String sql_koti = "select * from ser_koti where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_koti = DbConnection.getConn(sql_koti);
                                                        ResultSet rs_koti = pst_koti.executeQuery();
                                                        if (rs_koti.next()) {
                                                            String product_name = "koti";
                                                            koti_qty = Integer.parseInt(rs_koti.getString("qty"));
                                                %>
                                                <td style="text-align: center"><%= id++%></td>
                                                <td style="text-align: left"><%="Koti"%></td>                                                
                                                <td style="text-align: left">
                                                    <%
                                                        // this product maker 
                                                        String maker_name = null;
                                                        try {
                                                            String sql_maker = "select * from maker_order_product_info where order_id = '" + order_id_by_search + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' and product_name = '" + product_name + "' ";
                                                            PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                                                            ResultSet rs_maker = pst_maker.executeQuery();
                                                            if (rs_maker.next()) {
                                                                maker_name = rs_maker.getString("mk_name");
                                                                String koti_status = rs_maker.getString("mk_status");
                                                                product_delivery_date = rs_maker.getString("mk_delivery_date");
                                                                if (koti_status.equals("1")) {
                                                                    product_status = "complete";
                                                                } else {
                                                                    product_status = "incomplete";
                                                                }
                                                            }
                                                    %>
                                                    <%if (maker_name != null) {%><%=maker_name%><%}%>
                                                    <%
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                                    %>
                                                </td>
                                                <td style="text-align: center"><%=product_delivery_date%></td>
                                                <td style="text-align: center"><%=koti_qty%></td>
                                                <td style="text-align: right"><%=koti_price + "0"%></td>
                                                <td style="text-align: right"><%= koti_qty * product_price_koti + "0"%></td>                                                
                                                <td style="text-align: center"><%=product_status%></td>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </tr>

                                            <tr>                                              
                                                <td style="text-align: center"></td>
                                                <td style="text-align: center"></td>
                                                <td style="text-align: center"></td>
                                                <td style="text-align: right"></td>                                               
                                                <td style="text-align: center"></td>                                                 
                                                <td style="text-align: center"></td>
                                                <td style="text-align: right"><b><%=all_total_price + "0"%></b></td>
                                                <td style="text-align: center"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <%                                            }
                                %>
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
