
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    String order_id = null;
    String cus_id = null;
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
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Calendar"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <!--   delete all data from temporary-->
        <%
            order_id = request.getParameter("ord_id");
            cus_id = request.getParameter("customer_id");
            if (cus_id != null) {
                session.setAttribute("customer_id_for_order_details", cus_id);
            }
            String customer_name = null;
            try {
                String sql_cus_name = "select cus_name from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + cus_id + "' ";
                PreparedStatement pst_cus_name = DbConnection.getConn(sql_cus_name);
                ResultSet rs_cus_name = pst_cus_name.executeQuery();
                if (rs_cus_name.next()) {
                    customer_name = rs_cus_name.getString("cus_name");
                }
            } catch (Exception e) {
                out.println(e.toString());
            }

// get delivery and given date difference from
            String ord_delivery_date = null;
            String ord_receive_date = null;
            //String output = null;
            long date_diff = 0;
            long curr_date_diff = 0; 
            try {
                String sql_date_diff = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + order_id + "' ";
                PreparedStatement pst_date_diff = DbConnection.getConn(sql_date_diff);
                ResultSet rs_date_diff = pst_date_diff.executeQuery();
                if (rs_date_diff.next()) {
                    ord_delivery_date = rs_date_diff.getString("ord_delivery_date");
                    ord_receive_date = rs_date_diff.getString("ord_receive_date");

                    DateFormat inputFormatter = new SimpleDateFormat("yyyy-MM-dd");
                    Date date = inputFormatter.parse(ord_receive_date);

                    DateFormat outputFormatter = new SimpleDateFormat("yyyy-MM-dd");
                    ord_receive_date = outputFormatter.format(date); // Output : 01/20/2012
                }
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                // current date
                DateFormat currdateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date date = new Date();
                String date_f = currdateFormat.format(date);
                Date d1 = null;
                Date d2 = null;
                Date curr_date = null;
                try {
                    d2 = format.parse(ord_delivery_date);
                    d1 = format.parse(ord_receive_date);
                    curr_date = format.parse(date_f);
                } catch (ParseException e) {
                    out.println(e.toString());
                }
                long diff = d2.getTime() - d1.getTime();
                long cur_diff = curr_date.getTime() - d1.getTime(); 
                date_diff = diff / (24 * 60 * 60 * 1000);
                curr_date_diff = cur_diff / (24 * 60 * 60 * 1000);
            } catch (Exception e) {
                out.println(e.toString());
            }
        %>
        <div id="wrapper">
            <input type="text" value="<%=date_diff%>" id="date_diff" style="display: none"/>
            <input type="text" value="<%=curr_date_diff%>" id="curr_date_diff" style="display: none"/>
            <jsp:include page="../menu/menu.jsp?page_name=order" />
            <div id="page-wrapper" >
                <div id="page-inner">
                    <aside class="right-side">
                        <section class="content">
                            <div class="row">
                                <div class="col-xs-10">
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title">Order ID : <%=order_id%>  Customer Name : <%=customer_name%>
                                                <%
                                                    if (logger != null) {
                                                        if (logger.equals("branch")) {
                                                %>
                                                <a href=""  data-toggle="modal" data-target="#myModal" style="text-decoration: none">Change Order Delivery Date</a>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </h3>
                                            <!------------------------------------------------------------change order delivery date----------------------------------->
                                            <div class="modal fade" id="myModal" role="dialog">
                                                <div class="modal-dialog modal-md">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                            <h4 class="modal-title">Old Delivery Date : <%=ord_delivery_date%></h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form action="change_order_delivery_date.jsp" method="post">
                                                                <input type="text" value="Enter new delivery date" readonly="" class="col-sm-4" />
                                                                <input type="text" id="new_delivery_date" name="new_delivery_date" class="col-sm-4" required=""/>
                                                                <input type="text" name="order_id" value="<%=order_id%>" style="display: none" />
                                                                <input type="text" name="cus_id" value="<%=cus_id%>" style="display: none" />
                                                                <input type="submit" value="Submit" />
                                                            </form>
                                                        </div>        
                                                    </div>
                                                </div>
                                            </div>
                                            <!-----------------------------------------------------------------------change order delivery date -------------------------------------->
                                        </div>        
                                        <div class="box-body table-responsive">                                          
                                            <table id="DataTable" class="table table-bordered table-hover" style="width: 50%">
                                                <thead>
                                                    <tr>                                                        
                                                        <th style="text-align: center">SL</th>
                                                        <th style="text-align: center">Product Name</th>                                                                                                  
                                                        <th style="text-align: center">Qty</th>
                                                        <th style="text-align: center">Maker</th>                                                   
                                                        <th style="text-align: center">Standard</th>                                                   
                                                        <th style="text-align: center">Classical</th>                                                   
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                    <!----------------------------------------------------------shir qty ----------------------------------------------------------------------------------------->
                                                    <%
                                                        String prodcut_delivery_date = null;
                                                        int id = 1;
                                                        String product_status = null;
                                                        String sql_s = "select * from ser_shirt where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_s = DbConnection.getConn(sql_s);
                                                        ResultSet rs_s = pst_s.executeQuery();
                                                        if (rs_s.next()) {
                                                            // jodi shirt thake tobe shirt dekhaba 
                                                            String sql_shirt = "select * from ser_shirt where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = " + order_id;
                                                            PreparedStatement pst_shirt = DbConnection.getConn(sql_shirt);
                                                            ResultSet rs_shirt = pst_shirt.executeQuery();
                                                            if (rs_shirt.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Shirt"%> </td>
                                                        <td style="text-align: center"><%= rs_shirt.getString("qty")%></td>
                                                        <td style="text-align: center">
                                                            <%
                                                                String productname = "shirt";
                                                                int order_status = 0;
                                                                String order_info_status = null;
                                                                try {
                                                                    // check order_status jodi 4 neca hoy tahole model show korba natuba na 
                                                                    String sql_check_status_ad_order = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + order_id + "' ";
                                                                    PreparedStatement pst_check_status_ad_order = DbConnection.getConn(sql_check_status_ad_order);
                                                                    ResultSet rs_check_status = pst_check_status_ad_order.executeQuery();
                                                                    if (rs_check_status.next()) {
                                                                        String ord_status = rs_check_status.getString("ord_status");
                                                                        order_status = Integer.parseInt(ord_status);
                                                                        //prodcut_delivery_date = rs_check_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                                try {
                                                                    String sql_mk_order_info_status = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_mk_order_info_status = DbConnection.getConn(sql_mk_order_info_status);
                                                                    ResultSet rs_mk_order_info_status = pst_mk_order_info_status.executeQuery();
                                                                    while (rs_mk_order_info_status.next()) {
                                                                        order_info_status = rs_mk_order_info_status.getString("mk_status");
                                                                        prodcut_delivery_date = rs_mk_order_info_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                            

                                                            <%                                                                    String m_name = null;
                                                                String delivery_date = null;
                                                                try {
                                                                    String sql_shirt_maker = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_shirt_maker = DbConnection.getConn(sql_shirt_maker);
                                                                    ResultSet rs_shirt_maker = pst_shirt_maker.executeQuery();
                                                                    while (rs_shirt_maker.next()) {
                                                                        m_name = rs_shirt_maker.getString("mk_name");
                                                                        delivery_date = rs_shirt_maker.getString("mk_delivery_date");
                                                                    }
                                                                    if (m_name != null) {
                                                                        if (order_info_status.equals("1")) {
                                                            %>
                                                            <%=m_name%>
                                                            <%
                                                            } else if (!order_info_status.equals("1")) {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#shirt_btn"><%=m_name%></button>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#shirt_btn"> <%="+"%></button>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                         

                                                            <%
                                                                if (!order_info_status.equals("1")) {
                                                            %>
                                                            <div class="modal fade" id="shirt_btn" role="dialog">
                                                                <div class="modal-dialog">
                                                                    <!-- Modal content-->
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                            <h4 class="modal-title">Modal Header<%=order_info_status%></h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form action="add_maker_order_product.jsp" method="post">
                                                                                <table class="table table-striped" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="product_name" value="shirt" />
                                                                                        </td>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="maker_order" value="<%=order_id%>" />
                                                                                            <input type="text" name="customer_id" value="<%=cus_id%>" style=""/>
                                                                                        </td>                                                                                        
                                                                                        <td>                                                                                            
                                                                                            Maker
                                                                                            <select name="mk_name" class="form-control" required="">
                                                                                                <%
                                                                                                    // je name thakba sai name modal e show kora 
                                                                                                    if (m_name != null) {
                                                                                                %>
                                                                                                <option value="<%=m_name%>"><%=m_name%></option>
                                                                                                <%
                                                                                                } else {
                                                                                                %>
                                                                                                <option></option>
                                                                                                <%
                                                                                                    }
                                                                                                %>
                                                                                                <%
                                                                                                    try {
                                                                                                        String sql = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                                                        PreparedStatement pst = DbConnection.getConn(sql);
                                                                                                        ResultSet rs = pst.executeQuery();
                                                                                                        while (rs.next()) {
                                                                                                            String maker_name = rs.getString("mk_name");
                                                                                                %>
                                                                                                <option ><%= maker_name%></option>
                                                                                                <%
                                                                                                        }
                                                                                                    } catch (Exception e) {
                                                                                                        out.println(e.toString());
                                                                                                    }
                                                                                                %>
                                                                                            </select>                                                                                            
                                                                                        </td>
                                                                                        <td>
                                                                                            <div class="row  form-group">
                                                                                                <div class="col-sm-6">
                                                                                                    <label for="phone" style="margin-bottom:  0px">Delivery Date<span class="" style="color: red">*</span>  </label>  
                                                                                                    <input type="text" class="form-control" name="m_delivery_date" id="cus_birthdate" <%if (delivery_date != null) {%>value="<%=delivery_date%>"<%} else {
                                                                                                        } %>  style="height: 40px" required=""/>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <center><input type="submit" class="form-control" value="Ok" style="width: 40%;"/></center>
                                                                            </form>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%
                                                                }
                                                            %>
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement.jsp?m_name=<%=m_name%>&product_status=shirt&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement_local.jsp?m_name=<%=m_name%>&product_status=shirt&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        } else {

                                                        }
                                                    %>                                                    
                                                    <!---------------------------------------------------------------////shirt qty---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------pant qty---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_p = "select * from ser_pant where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_p = DbConnection.getConn(sql_p);
                                                        ResultSet rs_p = pst_p.executeQuery();
                                                        if (rs_p.next()) {
                                                            String sql_pant = "select * from ser_pant where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = " + order_id;
                                                            PreparedStatement pst_pant = DbConnection.getConn(sql_pant);
                                                            ResultSet rs_pant = pst_pant.executeQuery();
                                                            while (rs_pant.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Pant"%></td>
                                                        <td style="text-align: center"><%= rs_pant.getString("qty")%></td>
                                                        <td style="text-align: center">
                                                            <%
                                                                // check mk_status from maker_order_product_info . product ta jodi complete hoya jay tobe change kora jabe na 
                                                                String order_info_status = null;
                                                                String productname = "pant";
                                                                try {
                                                                    String sql_order_info_pant_status = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "'and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_order_info_pant_status = DbConnection.getConn(sql_order_info_pant_status);
                                                                    ResultSet rs_order_info_pant_status = pst_order_info_pant_status.executeQuery();
                                                                    if (rs_order_info_pant_status.next()) {
                                                                        order_info_status = rs_order_info_pant_status.getString("mk_status");
                                                                        prodcut_delivery_date = rs_order_info_pant_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>

                                                            <%
                                                                String m_name = null;
                                                                String pant_deliverty_date = null;
                                                                try {
                                                                    String sql_shirt_maker = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_shirt_maker = DbConnection.getConn(sql_shirt_maker);
                                                                    ResultSet rs_shirt_maker = pst_shirt_maker.executeQuery();
                                                                    while (rs_shirt_maker.next()) {
                                                                        m_name = rs_shirt_maker.getString("mk_name");
                                                                        pant_deliverty_date = rs_shirt_maker.getString("mk_delivery_date");
                                                                    }
                                                                    if (m_name != null) {
                                                                        if (order_info_status.equals("1")) {
                                                            %>
                                                            <%=m_name%>
                                                            <%
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#btn_pant"><%=m_name%></button>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#btn_pant"> <%="+"%></button>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                          

                                                            <%
                                                                if (!order_info_status.equals("1")) {
                                                            %>
                                                            <div class="modal fade" id="btn_pant" role="dialog">
                                                                <div class="modal-dialog">
                                                                    <!-- Modal content-->
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                            <h4 class="modal-title">Modal Header</h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form action="add_maker_order_product.jsp" method="post">
                                                                                <table class="table table-striped" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="product_name" value="pant" />
                                                                                        </td>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="maker_order" value="<%=order_id%>" />
                                                                                            <input type="text" name="customer_id" value="<%=cus_id%>" style=""/>
                                                                                        </td>                                                                                        
                                                                                        <td>
                                                                                            Maker
                                                                                            <select name="mk_name" class="form-control" required="">
                                                                                                <%
                                                                                                    if (m_name != null) {
                                                                                                %>
                                                                                                <option value="<%=m_name%>"><%=m_name%></option>
                                                                                                <%
                                                                                                } else {
                                                                                                %>
                                                                                                <option></option>
                                                                                                <%
                                                                                                    }
                                                                                                %>

                                                                                                <%
                                                                                                    try {
                                                                                                        String sql = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                                                        PreparedStatement pst = DbConnection.getConn(sql);
                                                                                                        ResultSet rs = pst.executeQuery();
                                                                                                        while (rs.next()) {
                                                                                                            String maker_name = rs.getString("mk_name");
                                                                                                %>
                                                                                                <option ><%= maker_name%></option>
                                                                                                <%
                                                                                                        }
                                                                                                    } catch (Exception e) {
                                                                                                        out.println(e.toString());
                                                                                                    }
                                                                                                %>
                                                                                            </select>                                                                                            
                                                                                        </td>
                                                                                        <td>
                                                                                            <div class="row  form-group">
                                                                                                <div class="col-sm-6">
                                                                                                    <label for="phone" style="margin-bottom:  0px">Delivery Date<span class="" style="color: red">*</span>  </label>  
                                                                                                    <input type="text" class="form-control" name="m_delivery_date" id="pant_d_date" <%if (pant_deliverty_date != null) {%>value="<%=pant_deliverty_date%>"<%} %> style="height: 40px" required=""/>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <center><input type="submit" class="form-control" value="Ok" style="width: 40%;"/></center>
                                                                            </form>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%
                                                                }
                                                            %>
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement.jsp?m_name=<%=m_name%>&product_status=pant&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>  
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement_local.jsp?m_name=<%=m_name%>&product_status=pant&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>  
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    } else {
                                                    %>

                                                    <%
                                                        }
                                                    %>                                                    
                                                    <!---------------------------------------------------------------//pant qty end---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------blazer qty ---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_bl = "select * from ser_blazer where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_bl = DbConnection.getConn(sql_bl);
                                                        ResultSet rs_bl = pst_bl.executeQuery();
                                                        if (rs_bl.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=  id++%></td>
                                                        <td style="text-align: center"><%= "Blazer"%></td>
                                                        <td style="text-align: center"><%= rs_bl.getString("qty")%> </td>
                                                        <td style="text-align: center">
                                                            <%
                                                                // check mk_status from maker_order_product_info . product ta jodi complete hoya jay tobe change kora jabe na 
                                                                String order_info_status = null;
                                                                String productname = "blazer";
                                                                try {
                                                                    String sql_order_info_pant_status = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "'and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_order_info_pant_status = DbConnection.getConn(sql_order_info_pant_status);
                                                                    ResultSet rs_order_info_pant_status = pst_order_info_pant_status.executeQuery();
                                                                    if (rs_order_info_pant_status.next()) {
                                                                        order_info_status = rs_order_info_pant_status.getString("mk_status");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }

                                                                String m_name = null;
                                                                String blazer_delivery_date = null;
                                                                try {
                                                                    String sql_shirt_maker = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_shirt_maker = DbConnection.getConn(sql_shirt_maker);
                                                                    ResultSet rs_shirt_maker = pst_shirt_maker.executeQuery();
                                                                    while (rs_shirt_maker.next()) {
                                                                        m_name = rs_shirt_maker.getString("mk_name");
                                                                        blazer_delivery_date = rs_shirt_maker.getString("mk_delivery_date");
                                                                        prodcut_delivery_date = rs_shirt_maker.getString("mk_delivery_date");
                                                                    }
                                                                    if (m_name != null) {
                                                                        // product banano hoya gale baton dekha na 
                                                                        if (order_info_status.equals("1")) {
                                                            %>
                                                            <%=m_name%>
                                                            <%
                                                            } else if (!order_info_status.equals("1")) {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#btn_blazer"><%=m_name%></button>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#btn_blazer"> <%="+"%></button>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>

                                                            <%
                                                                // order status 1 orthat product banano hoya gale modal kaj korba na 
                                                                if (!order_info_status.equals("1")) {
                                                            %>
                                                            <div class="modal fade" id="btn_blazer" role="dialog">
                                                                <div class="modal-dialog">
                                                                    <!-- Modal content-->
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                            <h4 class="modal-title">Modal Header</h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form action="add_maker_order_product.jsp" method="post">
                                                                                <table class="table table-striped" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="product_name" value="blazer" />
                                                                                        </td>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="maker_order" value="<%=order_id%>" />
                                                                                            <input type="text" name="customer_id" value="<%=cus_id%>" style=""/>
                                                                                        </td>                                                                                        
                                                                                        <td>
                                                                                            Maker
                                                                                            <select name="mk_name" class="form-control" required="">
                                                                                                <%
                                                                                                    if (m_name != null) {
                                                                                                %>
                                                                                                <option value="<%=m_name%>"><%=m_name%></option>
                                                                                                <%
                                                                                                } else {
                                                                                                %>
                                                                                                <option></option>
                                                                                                <%
                                                                                                    }
                                                                                                %>
                                                                                                <%
                                                                                                    try {
                                                                                                        String sql = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                                                        PreparedStatement pst = DbConnection.getConn(sql);
                                                                                                        ResultSet rs = pst.executeQuery();
                                                                                                        while (rs.next()) {
                                                                                                            String maker_name = rs.getString("mk_name");
                                                                                                %>
                                                                                                <option ><%= maker_name%></option>
                                                                                                <%
                                                                                                        }
                                                                                                    } catch (Exception e) {
                                                                                                        out.println(e.toString());
                                                                                                    }
                                                                                                %>
                                                                                            </select>                                                                                            
                                                                                        </td>
                                                                                        <td>
                                                                                            <div class="row  form-group">
                                                                                                <div class="col-sm-6">
                                                                                                    <label for="phone" style="margin-bottom:  0px">Delivery Date<span class="" style="color: red">*</span>  </label>  
                                                                                                    <input type="text" class="form-control" name="m_delivery_date" id="blazer_d_date" <%if (blazer_delivery_date != null) {%>value="<%=blazer_delivery_date%>"<%} %> style="height: 40px" required=""/>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <center><input type="submit" class="form-control" value="Ok" style="width: 40%;"/></center>
                                                                            </form>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%
                                                                }
                                                            %>
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement.jsp?m_name=<%=m_name%>&product_status=blazer&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>  
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement_local.jsp?m_name=<%=m_name%>&product_status=blazer&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>  
                                                        </td>
                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>

                                                    <%
                                                        }
                                                    %>
                                                    <!---------------------------------------------------------------///photua qty ---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_pht = "select * from ser_photua where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_pht = DbConnection.getConn(sql_pht);
                                                        ResultSet rs_pht = pst_pht.executeQuery();
                                                        if (rs_pht.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Photua"%></td>
                                                        <td style="text-align: center"><%= rs_pht.getString("qty")%></td>
                                                        <td style="text-align: center">
                                                            <%
                                                                // check mk_status from maker_order_product_info . product ta jodi complete hoya jay tobe change kora jabe na 
                                                                String order_info_status = null;
                                                                String productname = "photua";
                                                                try {
                                                                    String sql_order_info_pant_status = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "'and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_order_info_pant_status = DbConnection.getConn(sql_order_info_pant_status);
                                                                    ResultSet rs_order_info_pant_status = pst_order_info_pant_status.executeQuery();
                                                                    if (rs_order_info_pant_status.next()) {
                                                                        order_info_status = rs_order_info_pant_status.getString("mk_status");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>

                                                            <%
                                                                String m_name = null;
                                                                String photua_delivery_date = null;
                                                                try {
                                                                    String sql_shirt_maker = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_shirt_maker = DbConnection.getConn(sql_shirt_maker);
                                                                    ResultSet rs_shirt_maker = pst_shirt_maker.executeQuery();
                                                                    while (rs_shirt_maker.next()) {
                                                                        m_name = rs_shirt_maker.getString("mk_name");
                                                                        photua_delivery_date = rs_shirt_maker.getString("mk_delivery_date");
                                                                        prodcut_delivery_date = rs_shirt_maker.getString("mk_delivery_date");
                                                                    }
                                                                    if (m_name != null) {
                                                                        if (order_info_status.equals("1")) {
                                                            %>
                                                            <%=m_name%>
                                                            <%
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#btn_photua"><%=m_name%></button>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#btn_photua"> <%="+"%></button>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                            

                                                            <%
                                                                if (!order_info_status.equals("1")) {
                                                            %>
                                                            <div class="modal fade" id="btn_photua" role="dialog">
                                                                <div class="modal-dialog">
                                                                    <!-- Modal content-->
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                            <h4 class="modal-title">Modal Header</h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form action="add_maker_order_product.jsp" method="post">
                                                                                <table class="table table-striped" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="product_name" value="photua" />
                                                                                        </td>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="maker_order" value="<%=order_id%>" />
                                                                                            <input type="text" name="customer_id" value="<%=cus_id%>" style=""/>
                                                                                        </td>                                                                                        
                                                                                        <td>
                                                                                            Maker
                                                                                            <select name="mk_name" class="form-control" required="">
                                                                                                <%
                                                                                                    if (m_name != null) {
                                                                                                %>
                                                                                                <option value="<%=m_name%>"><%=m_name%></option>
                                                                                                <%
                                                                                                } else {
                                                                                                %>
                                                                                                <option></option>
                                                                                                <%
                                                                                                    }
                                                                                                %>
                                                                                                <option></option>
                                                                                                <%
                                                                                                    try {
                                                                                                        String sql = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                                                        PreparedStatement pst = DbConnection.getConn(sql);
                                                                                                        ResultSet rs = pst.executeQuery();
                                                                                                        while (rs.next()) {
                                                                                                            String maker_name = rs.getString("mk_name");
                                                                                                %>
                                                                                                <option ><%= maker_name%></option>
                                                                                                <%
                                                                                                        }
                                                                                                    } catch (Exception e) {
                                                                                                        out.println(e.toString());
                                                                                                    }
                                                                                                %>
                                                                                            </select>                                                                                            
                                                                                        </td>
                                                                                        <td>
                                                                                            <div class="row  form-group">
                                                                                                <div class="col-sm-6">
                                                                                                    <label for="phone" style="margin-bottom:  0px">Delivery Date<span class="" style="color: red">*</span>  </label>  
                                                                                                    <input type="text" class="form-control" name="m_delivery_date" id="photua_d_date" <%if (photua_delivery_date != null) {%>value="<%=photua_delivery_date%>"<%} %> style="height: 40px" required=""/>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <center><input type="submit" class="form-control" value="Ok" style="width: 40%;"/></center>
                                                                            </form>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement.jsp?m_name=<%=m_name%>&product_status=photua&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>  
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement_local.jsp?m_name=<%=m_name%>&product_status=photua&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>  
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                    <!---------------------------------------------------------------///photua qty ---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------safari qty ---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_safari = "select * from ser_safari where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_safari = DbConnection.getConn(sql_safari);
                                                        ResultSet rs_safari = pst_safari.executeQuery();
                                                        if (rs_safari.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Safari"%></td>
                                                        <td style="text-align: center"><%= rs_safari.getString("qty")%></td>
                                                        <td style="text-align: center">
                                                            <%
                                                                // check mk_status from maker_order_product_info . product ta jodi complete hoya jay tobe change kora jabe na 
                                                                String order_info_status = null;
                                                                String productname = "safari";
                                                                try {
                                                                    String sql_order_info_pant_status = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "'and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_order_info_pant_status = DbConnection.getConn(sql_order_info_pant_status);
                                                                    ResultSet rs_order_info_pant_status = pst_order_info_pant_status.executeQuery();
                                                                    if (rs_order_info_pant_status.next()) {
                                                                        order_info_status = rs_order_info_pant_status.getString("mk_status");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>

                                                            <%
                                                                String m_name = null;
                                                                try {
                                                                    String sql_shirt_maker = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "'  and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_shirt_maker = DbConnection.getConn(sql_shirt_maker);
                                                                    ResultSet rs_shirt_maker = pst_shirt_maker.executeQuery();
                                                                    while (rs_shirt_maker.next()) {
                                                                        m_name = rs_shirt_maker.getString("mk_name");
                                                                    }
                                                                    if (m_name != null) {
                                                                        if (order_info_status.equals("1")) {
                                                            %>
                                                            <%=m_name%>
                                                            <%
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#btn_safari"><%=m_name%></button>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#btn_safari"> <%="+"%></button>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                            

                                                            <%
                                                                if (!order_info_status.equals("1")) {
                                                            %>
                                                            <div class="modal fade" id="btn_safari" role="dialog">
                                                                <div class="modal-dialog">
                                                                    <!-- Modal content-->
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                            <h4 class="modal-title">Modal Header</h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form action="add_maker_order_product.jsp" method="post">
                                                                                <table class="table table-striped" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="product_name" value="safari" />
                                                                                        </td>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="maker_order" value="<%=order_id%>" />
                                                                                            <input type="text" name="customer_id" value="<%=cus_id%>" style=""/>
                                                                                        </td>                                                                                        
                                                                                        <td>
                                                                                            Maker
                                                                                            <select name="mk_name" class="form-control" required="">
                                                                                                <option></option>
                                                                                                <%
                                                                                                    try {
                                                                                                        String sql = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                                                        PreparedStatement pst = DbConnection.getConn(sql);
                                                                                                        ResultSet rs = pst.executeQuery();
                                                                                                        while (rs.next()) {
                                                                                                            String maker_name = rs.getString("mk_name");
                                                                                                %>
                                                                                                <option ><%= maker_name%></option>
                                                                                                <%
                                                                                                        }
                                                                                                    } catch (Exception e) {
                                                                                                        out.println(e.toString());
                                                                                                    }
                                                                                                %>
                                                                                            </select>                                                                                            
                                                                                        </td>
                                                                                        <td>
                                                                                            <div class="row  form-group">
                                                                                                <div class="col-sm-6">
                                                                                                    <label for="phone" style="margin-bottom:  0px">Delivery Date<span class="" style="color: red">*</span>  </label>  
                                                                                                    <input type="text" class="form-control" name="m_delivery_date" id="safari_d_date" placeholder="dd-mm-yyyy"   style="height: 40px" required=""/>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <center><input type="submit" class="form-control" value="Ok" style="width: 40%;"/></center>
                                                                            </form>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement.jsp?m_name=<%=m_name%>&product_status=safari&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>  
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement_local.jsp?m_name=<%=m_name%>&product_status=safari&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>  
                                                        </td>
                                                    </tr>
                                                    <%
                                                        } else {

                                                        }
                                                    %>
                                                    <!---------------------------------------------------------------///safari qty ---------------------------------------------------------------------------->

                                                    <!---------------------------------------------------------------------------------- panjabi --------------------------------------------->
                                                    <%
                                                        String sql_pnjb = "select * from ser_panjabi where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_pnjb = DbConnection.getConn(sql_pnjb);
                                                        ResultSet rs_pnjb = pst_pnjb.executeQuery();
                                                        if (rs_pnjb.next()) {
                                                            // jodi shirt thake tobe shirt dekhaba 
                                                            String sql_panjabi = "select * from ser_panjabi where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = " + order_id;
                                                            PreparedStatement pst_panjabi = DbConnection.getConn(sql_panjabi);
                                                            ResultSet rs_panjabi = pst_panjabi.executeQuery();
                                                            if (rs_panjabi.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Panjabi"%> </td>
                                                        <td style="text-align: center"><%= rs_panjabi.getString("qty")%></td>
                                                        <td style="text-align: center">
                                                            <%
                                                                String productname = "panjabi";
                                                                int order_status = 0;

                                                                String order_info_status = null;
                                                                try {
                                                                    // check order_status jodi 4 neca hoy tahole model show korba natuba na 
                                                                    String sql_check_status_ad_order = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + order_id + "' ";
                                                                    PreparedStatement pst_check_status_ad_order = DbConnection.getConn(sql_check_status_ad_order);
                                                                    ResultSet rs_check_status = pst_check_status_ad_order.executeQuery();
                                                                    if (rs_check_status.next()) {
                                                                        String ord_status = rs_check_status.getString("ord_status");
                                                                        order_status = Integer.parseInt(ord_status);
                                                                        //prodcut_delivery_date = rs_check_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                                try {
                                                                    String sql_mk_order_info_status = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_mk_order_info_status = DbConnection.getConn(sql_mk_order_info_status);
                                                                    ResultSet rs_mk_order_info_status = pst_mk_order_info_status.executeQuery();
                                                                    while (rs_mk_order_info_status.next()) {
                                                                        order_info_status = rs_mk_order_info_status.getString("mk_status");
                                                                        prodcut_delivery_date = rs_mk_order_info_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                            

                                                            <%                                                                    String m_name = null;
                                                                String delivery_date = null;
                                                                try {
                                                                    String sql_shirt_maker = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_shirt_maker = DbConnection.getConn(sql_shirt_maker);
                                                                    ResultSet rs_shirt_maker = pst_shirt_maker.executeQuery();
                                                                    while (rs_shirt_maker.next()) {
                                                                        m_name = rs_shirt_maker.getString("mk_name");
                                                                        delivery_date = rs_shirt_maker.getString("mk_delivery_date");
                                                                    }
                                                                    if (m_name != null) {
                                                                        if (order_info_status.equals("1")) {
                                                            %>
                                                            <%=m_name%>
                                                            <%
                                                            } else if (!order_info_status.equals("1")) {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#pnjb_btn"><%=m_name%></button>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#pnjb_btn"> <%="+"%></button>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                         

                                                            <%
                                                                if (!order_info_status.equals("1")) {
                                                            %>
                                                            <div class="modal fade" id="pnjb_btn" role="dialog">
                                                                <div class="modal-dialog">
                                                                    <!-- Modal content-->
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                            <h4 class="modal-title">Modal Header<%=order_info_status%></h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form action="add_maker_order_product.jsp" method="post">
                                                                                <table class="table table-striped" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="product_name" value="panjabi" />
                                                                                        </td>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="maker_order" value="<%=order_id%>" />
                                                                                            <input type="text" name="customer_id" value="<%=cus_id%>" style=""/>
                                                                                        </td>                                                                                        
                                                                                        <td>
                                                                                            Maker
                                                                                            <select name="mk_name" class="form-control" required="">
                                                                                                <%
                                                                                                    // je name thakba sai name modal e show kora 
                                                                                                    if (m_name != null) {
                                                                                                %>
                                                                                                <option value="<%=m_name%>"><%=m_name%></option>
                                                                                                <%
                                                                                                } else {
                                                                                                %>
                                                                                                <option></option>
                                                                                                <%
                                                                                                    }
                                                                                                %>
                                                                                                <%
                                                                                                    try {
                                                                                                        String sql = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                                                        PreparedStatement pst = DbConnection.getConn(sql);
                                                                                                        ResultSet rs = pst.executeQuery();
                                                                                                        while (rs.next()) {
                                                                                                            String maker_name = rs.getString("mk_name");
                                                                                                %>
                                                                                                <option ><%= maker_name%></option>
                                                                                                <%
                                                                                                        }
                                                                                                    } catch (Exception e) {
                                                                                                        out.println(e.toString());
                                                                                                    }
                                                                                                %>
                                                                                            </select>                                                                                            
                                                                                        </td>
                                                                                        <td>
                                                                                            <div class="row  form-group">
                                                                                                <div class="col-sm-6">
                                                                                                    <label for="phone" style="margin-bottom:  0px">Delivery Date<span class="" style="color: red">*</span></label>  
                                                                                                    <input type="text" class="form-control" name="m_delivery_date" id="panjabi_d_date" <%if (delivery_date != null) {%>value="<%=delivery_date%>"<%} else {
                                                                                                        } %>  style="height: 40px" required=""/>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <center><input type="submit" class="form-control" value="Ok" style="width: 40%;"/></center>
                                                                            </form>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%
                                                                }
                                                            %>
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement.jsp?m_name=<%=m_name%>&product_status=panjabi&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement_local.jsp?m_name=<%=m_name%>&product_status=panjabi&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        } else {

                                                        }
                                                    %>   
                                                    <!----------------------------------------------------------------------------------// panjabi --------------------------------------------->
                                                    <!---------------------------------------------------------------------------------- payjama --------------------------------------------->
                                                    <%
                                                        String sql_pjma = "select * from ser_payjama where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_pjma = DbConnection.getConn(sql_pjma);
                                                        ResultSet rs_pjma = pst_pjma.executeQuery();
                                                        if (rs_pjma.next()) {
                                                            // jodi shirt thake tobe shirt dekhaba 
                                                            String sql_payjama = "select * from ser_payjama where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = " + order_id;
                                                            PreparedStatement pst_payjama = DbConnection.getConn(sql_payjama);
                                                            ResultSet rs_payjama = pst_payjama.executeQuery();
                                                            if (rs_payjama.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Payjama"%> </td>
                                                        <td style="text-align: center"><%= rs_payjama.getString("qty")%></td>
                                                        <td style="text-align: center">
                                                            <%
                                                                String productname = "payjama";
                                                                int order_status = 0;

                                                                String order_info_status = null;
                                                                try {
                                                                    // check order_status jodi 4 neca hoy tahole model show korba natuba na 
                                                                    String sql_check_status_ad_order = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + order_id + "' ";
                                                                    PreparedStatement pst_check_status_ad_order = DbConnection.getConn(sql_check_status_ad_order);
                                                                    ResultSet rs_check_status = pst_check_status_ad_order.executeQuery();
                                                                    if (rs_check_status.next()) {
                                                                        String ord_status = rs_check_status.getString("ord_status");
                                                                        order_status = Integer.parseInt(ord_status);
                                                                        //prodcut_delivery_date = rs_check_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                                try {
                                                                    String sql_mk_order_info_status = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_mk_order_info_status = DbConnection.getConn(sql_mk_order_info_status);
                                                                    ResultSet rs_mk_order_info_status = pst_mk_order_info_status.executeQuery();
                                                                    while (rs_mk_order_info_status.next()) {
                                                                        order_info_status = rs_mk_order_info_status.getString("mk_status");
                                                                        prodcut_delivery_date = rs_mk_order_info_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                            

                                                            <%                                                                    String m_name = null;
                                                                String delivery_date = null;
                                                                try {
                                                                    String sql_shirt_maker = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_shirt_maker = DbConnection.getConn(sql_shirt_maker);
                                                                    ResultSet rs_shirt_maker = pst_shirt_maker.executeQuery();
                                                                    while (rs_shirt_maker.next()) {
                                                                        m_name = rs_shirt_maker.getString("mk_name");
                                                                        delivery_date = rs_shirt_maker.getString("mk_delivery_date");
                                                                    }
                                                                    if (m_name != null) {
                                                                        if (order_info_status.equals("1")) {
                                                            %>
                                                            <%=m_name%>
                                                            <%
                                                            } else if (!order_info_status.equals("1")) {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#pjma_btn"><%=m_name%></button>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#pjma_btn"> <%="+"%></button>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                         

                                                            <%
                                                                if (!order_info_status.equals("1")) {
                                                            %>
                                                            <div class="modal fade" id="pjma_btn" role="dialog">
                                                                <div class="modal-dialog">
                                                                    <!-- Modal content-->
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                            <h4 class="modal-title">Modal Header<%=order_info_status%></h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form action="add_maker_order_product.jsp" method="post">
                                                                                <table class="table table-striped" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="product_name" value="payjama" />
                                                                                        </td>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="maker_order" value="<%=order_id%>" />
                                                                                            <input type="text" name="customer_id" value="<%=cus_id%>" style=""/>
                                                                                        </td>                                                                                        
                                                                                        <td>
                                                                                            Maker
                                                                                            <select name="mk_name" class="form-control" required="">
                                                                                                <%
                                                                                                    // je name thakba sai name modal e show kora 
                                                                                                    if (m_name != null) {
                                                                                                %>
                                                                                                <option value="<%=m_name%>"><%=m_name%></option>
                                                                                                <%
                                                                                                } else {
                                                                                                %>
                                                                                                <option></option>
                                                                                                <%
                                                                                                    }
                                                                                                %>
                                                                                                <%
                                                                                                    try {
                                                                                                        String sql = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                                                        PreparedStatement pst = DbConnection.getConn(sql);
                                                                                                        ResultSet rs = pst.executeQuery();
                                                                                                        while (rs.next()) {
                                                                                                            String maker_name = rs.getString("mk_name");
                                                                                                %>
                                                                                                <option ><%= maker_name%></option>
                                                                                                <%
                                                                                                        }
                                                                                                    } catch (Exception e) {
                                                                                                        out.println(e.toString());
                                                                                                    }
                                                                                                %>
                                                                                            </select>                                                                                            
                                                                                        </td>
                                                                                        <td>
                                                                                            <div class="row  form-group">
                                                                                                <div class="col-sm-6">
                                                                                                    <label for="phone" style="margin-bottom:  0px">Delivery Date<span class="" style="color: red">*</span>  </label>  
                                                                                                    <input type="text" class="form-control" name="m_delivery_date" id="payjama_d_date" <%if (delivery_date != null) {%>value="<%=delivery_date%>"<%} else {
                                                                                                        } %>  style="height: 40px" required=""/>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <center><input type="submit" class="form-control" value="Ok" style="width: 40%;"/></center>
                                                                            </form>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%
                                                                }
                                                            %>
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement.jsp?m_name=<%=m_name%>&product_status=payjama&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement_local.jsp?m_name=<%=m_name%>&product_status=payjama&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        } else {

                                                        }
                                                    %>   
                                                    <!----------------------------------------------------------------------------------// payjama --------------------------------------------->
                                                    <!---------------------------------------------------------------------------------- mojbi cort --------------------------------------------->
                                                    <%
                                                        String sql_mojibcort = "select * from ser_mojib_cort where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_mojibcort = DbConnection.getConn(sql_mojibcort);
                                                        ResultSet rs_mojibcort = pst_mojibcort.executeQuery();
                                                        if (rs_mojibcort.next()) {
                                                            // jodi shirt thake tobe shirt dekhaba 
                                                            String sql_mjc = "select * from ser_mojib_cort where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = " + order_id;
                                                            PreparedStatement pst_mjc = DbConnection.getConn(sql_mjc);
                                                            ResultSet rs_mjc = pst_mjc.executeQuery();
                                                            if (rs_mjc.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Mojib Cort"%> </td>
                                                        <td style="text-align: center"><%= rs_mjc.getString("qty")%></td>
                                                        <td style="text-align: center">
                                                            <%
                                                                String productname = "mojib_cort";
                                                                int order_status = 0;

                                                                String order_info_status = null;
                                                                try {
                                                                    // check order_status jodi 4 neca hoy tahole model show korba natuba na 
                                                                    String sql_check_status_ad_order = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + order_id + "' ";
                                                                    PreparedStatement pst_check_status_ad_order = DbConnection.getConn(sql_check_status_ad_order);
                                                                    ResultSet rs_check_status = pst_check_status_ad_order.executeQuery();
                                                                    if (rs_check_status.next()) {
                                                                        String ord_status = rs_check_status.getString("ord_status");
                                                                        order_status = Integer.parseInt(ord_status);
                                                                        //prodcut_delivery_date = rs_check_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                                try {
                                                                    String sql_mk_order_info_status = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_mk_order_info_status = DbConnection.getConn(sql_mk_order_info_status);
                                                                    ResultSet rs_mk_order_info_status = pst_mk_order_info_status.executeQuery();
                                                                    while (rs_mk_order_info_status.next()) {
                                                                        order_info_status = rs_mk_order_info_status.getString("mk_status");
                                                                        prodcut_delivery_date = rs_mk_order_info_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                            

                                                            <%                                                                    String m_name = null;
                                                                String delivery_date = null;
                                                                try {
                                                                    String sql_shirt_maker = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_shirt_maker = DbConnection.getConn(sql_shirt_maker);
                                                                    ResultSet rs_shirt_maker = pst_shirt_maker.executeQuery();
                                                                    while (rs_shirt_maker.next()) {
                                                                        m_name = rs_shirt_maker.getString("mk_name");
                                                                        delivery_date = rs_shirt_maker.getString("mk_delivery_date");
                                                                    }
                                                                    if (m_name != null) {
                                                                        if (order_info_status.equals("1")) {
                                                            %>
                                                            <%=m_name%>
                                                            <%
                                                            } else if (!order_info_status.equals("1")) {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#mjc_btn"><%=m_name%></button>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#mjc_btn"> <%="+"%></button>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                         

                                                            <%
                                                                if (!order_info_status.equals("1")) {
                                                            %>
                                                            <div class="modal fade" id="mjc_btn" role="dialog">
                                                                <div class="modal-dialog">
                                                                    <!-- Modal content-->
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                            <h4 class="modal-title">Modal Header<%=order_info_status%></h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form action="add_maker_order_product.jsp" method="post">
                                                                                <table class="table table-striped" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="product_name" value="mojib_cort" />
                                                                                        </td>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="maker_order" value="<%=order_id%>" />
                                                                                            <input type="text" name="customer_id" value="<%=cus_id%>" style=""/>
                                                                                        </td>                                                                                        
                                                                                        <td>
                                                                                            Maker
                                                                                            <select name="mk_name" class="form-control" required="">
                                                                                                <%
                                                                                                    // je name thakba sai name modal e show kora 
                                                                                                    if (m_name != null) {
                                                                                                %>
                                                                                                <option value="<%=m_name%>"><%=m_name%></option>
                                                                                                <%
                                                                                                } else {
                                                                                                %>
                                                                                                <option></option>
                                                                                                <%
                                                                                                    }
                                                                                                %>
                                                                                                <%
                                                                                                    try {
                                                                                                        String sql = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                                                        PreparedStatement pst = DbConnection.getConn(sql);
                                                                                                        ResultSet rs = pst.executeQuery();
                                                                                                        while (rs.next()) {
                                                                                                            String maker_name = rs.getString("mk_name");
                                                                                                %>
                                                                                                <option ><%= maker_name%></option>
                                                                                                <%
                                                                                                        }
                                                                                                    } catch (Exception e) {
                                                                                                        out.println(e.toString());
                                                                                                    }
                                                                                                %>
                                                                                            </select>                                                                                            
                                                                                        </td>
                                                                                        <td>
                                                                                            <div class="row  form-group">
                                                                                                <div class="col-sm-6">
                                                                                                    <label for="phone" style="margin-bottom:  0px">Delivery Date<span class="" style="color: red">*</span>  </label>  
                                                                                                    <input type="text" class="form-control" name="m_delivery_date" id="mojib_cort_d_date" <%if (delivery_date != null) {%>value="<%=delivery_date%>"<%} else {
                                                                                                        } %>  style="height: 40px" required=""/>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <center><input type="submit" class="form-control" value="Ok" style="width: 40%;"/></center>
                                                                            </form>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%
                                                                }
                                                            %>
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement.jsp?m_name=<%=m_name%>&product_status=mojib_cort&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement_local.jsp?m_name=<%=m_name%>&product_status=mojib_cort&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        } else {

                                                        }
                                                    %>   
                                                    <!----------------------------------------------------------------------------------// mojib cort --------------------------------------------->
                                                    <!---------------------------------------------------------------------------------- kable--------------------------------------------->
                                                    <%
                                                        String sql_kable = "select * from ser_kable where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_kable = DbConnection.getConn(sql_kable);
                                                        ResultSet rs_kable = pst_kable.executeQuery();
                                                        if (rs_kable.next()) {
                                                            // jodi shirt thake tobe shirt dekhaba 
                                                            String sql_kbl = "select * from ser_kable where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = " + order_id;
                                                            PreparedStatement pst_kbl = DbConnection.getConn(sql_kbl);
                                                            ResultSet rs_kbl = pst_kbl.executeQuery();
                                                            if (rs_kbl.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Kable"%> </td>
                                                        <td style="text-align: center"><%= rs_kbl.getString("qty")%></td>
                                                        <td style="text-align: center">
                                                            <%
                                                                String productname = "kable";
                                                                int order_status = 0;

                                                                String order_info_status = null;
                                                                try {
                                                                    // check order_status jodi 4 neca hoy tahole model show korba natuba na 
                                                                    String sql_check_status_ad_order = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + order_id + "' ";
                                                                    PreparedStatement pst_check_status_ad_order = DbConnection.getConn(sql_check_status_ad_order);
                                                                    ResultSet rs_check_status = pst_check_status_ad_order.executeQuery();
                                                                    if (rs_check_status.next()) {
                                                                        String ord_status = rs_check_status.getString("ord_status");
                                                                        order_status = Integer.parseInt(ord_status);
                                                                        //prodcut_delivery_date = rs_check_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                                try {
                                                                    String sql_mk_order_info_status = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_mk_order_info_status = DbConnection.getConn(sql_mk_order_info_status);
                                                                    ResultSet rs_mk_order_info_status = pst_mk_order_info_status.executeQuery();
                                                                    while (rs_mk_order_info_status.next()) {
                                                                        order_info_status = rs_mk_order_info_status.getString("mk_status");
                                                                        prodcut_delivery_date = rs_mk_order_info_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                            

                                                            <%                                                                    String m_name = null;
                                                                String delivery_date = null;
                                                                try {
                                                                    String sql_shirt_maker = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_shirt_maker = DbConnection.getConn(sql_shirt_maker);
                                                                    ResultSet rs_shirt_maker = pst_shirt_maker.executeQuery();
                                                                    while (rs_shirt_maker.next()) {
                                                                        m_name = rs_shirt_maker.getString("mk_name");
                                                                        delivery_date = rs_shirt_maker.getString("mk_delivery_date");
                                                                    }
                                                                    if (m_name != null) {
                                                                        if (order_info_status.equals("1")) {
                                                            %>
                                                            <%=m_name%>
                                                            <%
                                                            } else if (!order_info_status.equals("1")) {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#kbl_btn"><%=m_name%></button>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#kbl_btn"> <%="+"%></button>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                         

                                                            <%
                                                                if (!order_info_status.equals("1")) {
                                                            %>
                                                            <div class="modal fade" id="kbl_btn" role="dialog">
                                                                <div class="modal-dialog">
                                                                    <!-- Modal content-->
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                            <h4 class="modal-title">Modal Header<%=order_info_status%></h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form action="add_maker_order_product.jsp" method="post">
                                                                                <table class="table table-striped" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="product_name" value="kable" />
                                                                                        </td>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="maker_order" value="<%=order_id%>" />
                                                                                            <input type="text" name="customer_id" value="<%=cus_id%>" style=""/>
                                                                                        </td>                                                                                        
                                                                                        <td>
                                                                                            Maker
                                                                                            <select name="mk_name" class="form-control" required="">
                                                                                                <%
                                                                                                    // je name thakba sai name modal e show kora 
                                                                                                    if (m_name != null) {
                                                                                                %>
                                                                                                <option value="<%=m_name%>"><%=m_name%></option>
                                                                                                <%
                                                                                                } else {
                                                                                                %>
                                                                                                <option></option>
                                                                                                <%
                                                                                                    }
                                                                                                %>
                                                                                                <%
                                                                                                    try {
                                                                                                        String sql = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                                                        PreparedStatement pst = DbConnection.getConn(sql);
                                                                                                        ResultSet rs = pst.executeQuery();
                                                                                                        while (rs.next()) {
                                                                                                            String maker_name = rs.getString("mk_name");
                                                                                                %>
                                                                                                <option ><%= maker_name%></option>
                                                                                                <%
                                                                                                        }
                                                                                                    } catch (Exception e) {
                                                                                                        out.println(e.toString());
                                                                                                    }
                                                                                                %>
                                                                                            </select>                                                                                            
                                                                                        </td>
                                                                                        <td>
                                                                                            <div class="row  form-group">
                                                                                                <div class="col-sm-6">
                                                                                                    <label for="phone" style="margin-bottom:  0px">Delivery Date<span class="" style="color: red">*</span>  </label>  
                                                                                                    <input type="text" class="form-control" name="m_delivery_date" id="kable_d_date" <%if (delivery_date != null) {%>value="<%=delivery_date%>"<%} else {
                                                                                                        } %>  style="height: 40px" required=""/>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <center><input type="submit" class="form-control" value="Ok" style="width: 40%;"/></center>
                                                                            </form>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%
                                                                }
                                                            %>
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement.jsp?m_name=<%=m_name%>&product_status=kable&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement_local.jsp?m_name=<%=m_name%>&product_status=kable&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        } else {

                                                        }
                                                    %>   
                                                    <!----------------------------------------------------------------------------------// kable --------------------------------------------->
                                                    <!---------------------------------------------------------------------------------- Koti--------------------------------------------->
                                                    <%
                                                        String sql_koti = "select * from ser_koti where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_koti = DbConnection.getConn(sql_koti);
                                                        ResultSet rs_koti = pst_koti.executeQuery();
                                                        if (rs_koti.next()) {
                                                            // jodi shirt thake tobe shirt dekhaba 
                                                            String sql_kt = "select * from ser_koti where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = " + order_id;
                                                            PreparedStatement pst_kt = DbConnection.getConn(sql_kt);
                                                            ResultSet rs_kt = pst_kt.executeQuery();
                                                            if (rs_kt.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Koti"%> </td>
                                                        <td style="text-align: center"><%= rs_kt.getString("qty")%></td>
                                                        <td style="text-align: center">
                                                            <%
                                                                String productname = "koti";
                                                                int order_status = 0;

                                                                String order_info_status = null;
                                                                try {
                                                                    // check order_status jodi 4 neca hoy tahole model show korba natuba na 
                                                                    String sql_check_status_ad_order = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_order_id = '" + order_id + "' ";
                                                                    PreparedStatement pst_check_status_ad_order = DbConnection.getConn(sql_check_status_ad_order);
                                                                    ResultSet rs_check_status = pst_check_status_ad_order.executeQuery();
                                                                    if (rs_check_status.next()) {
                                                                        String ord_status = rs_check_status.getString("ord_status");
                                                                        order_status = Integer.parseInt(ord_status);
                                                                        //prodcut_delivery_date = rs_check_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                                try {
                                                                    String sql_mk_order_info_status = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_mk_order_info_status = DbConnection.getConn(sql_mk_order_info_status);
                                                                    ResultSet rs_mk_order_info_status = pst_mk_order_info_status.executeQuery();
                                                                    while (rs_mk_order_info_status.next()) {
                                                                        order_info_status = rs_mk_order_info_status.getString("mk_status");
                                                                        prodcut_delivery_date = rs_mk_order_info_status.getString("mk_delivery_date");
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                            

                                                            <%                                                                    String m_name = null;
                                                                String delivery_date = null;
                                                                try {
                                                                    String sql_shirt_maker = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + productname + "' ";
                                                                    PreparedStatement pst_shirt_maker = DbConnection.getConn(sql_shirt_maker);
                                                                    ResultSet rs_shirt_maker = pst_shirt_maker.executeQuery();
                                                                    while (rs_shirt_maker.next()) {
                                                                        m_name = rs_shirt_maker.getString("mk_name");
                                                                        delivery_date = rs_shirt_maker.getString("mk_delivery_date");
                                                                    }
                                                                    if (m_name != null) {
                                                                        if (order_info_status.equals("1")) {
                                                            %>
                                                            <%=m_name%>
                                                            <%
                                                            } else if (!order_info_status.equals("1")) {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#kt_btn"><%=m_name%></button>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
                                                            <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#kt_btn"> <%="+"%></button>
                                                            <%
                                                                    }
                                                                } catch (Exception e) {
                                                                    out.println(e.toString());
                                                                }
                                                            %>                                                         

                                                            <%
                                                                if (!order_info_status.equals("1")) {
                                                            %>
                                                            <div class="modal fade" id="kt_btn" role="dialog">
                                                                <div class="modal-dialog">
                                                                    <!-- Modal content-->
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                            <h4 class="modal-title">Modal Header<%=order_info_status%></h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form action="add_maker_order_product.jsp" method="post">
                                                                                <table class="table table-striped" style="width: 100%;">
                                                                                    <tr>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="product_name" value="koti" />
                                                                                        </td>
                                                                                        <td style="display: none;">
                                                                                            <input type="text" name="maker_order" value="<%=order_id%>" />
                                                                                            <input type="text" name="customer_id" value="<%=cus_id%>" style=""/>
                                                                                        </td>                                                                                        
                                                                                        <td>
                                                                                            Maker
                                                                                            <select name="mk_name" class="form-control" required="">
                                                                                                <%
                                                                                                    // je name thakba sai name modal e show kora 
                                                                                                    if (m_name != null) {
                                                                                                %>
                                                                                                <option value="<%=m_name%>"><%=m_name%></option>
                                                                                                <%
                                                                                                } else {
                                                                                                %>
                                                                                                <option></option>
                                                                                                <%
                                                                                                    }
                                                                                                %>
                                                                                                <%
                                                                                                    try {
                                                                                                        String sql = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                                                        PreparedStatement pst = DbConnection.getConn(sql);
                                                                                                        ResultSet rs = pst.executeQuery();
                                                                                                        while (rs.next()) {
                                                                                                            String maker_name = rs.getString("mk_name");
                                                                                                %>
                                                                                                <option ><%= maker_name%></option>
                                                                                                <%
                                                                                                        }
                                                                                                    } catch (Exception e) {
                                                                                                        out.println(e.toString());
                                                                                                    }
                                                                                                %>
                                                                                            </select>                                                                                            
                                                                                        </td>
                                                                                        <td>
                                                                                            <div class="row  form-group">
                                                                                                <div class="col-sm-6">
                                                                                                    <label for="phone" style="margin-bottom:  0px">Delivery Date<span class="" style="color: red">*</span>  </label>  
                                                                                                    <input type="text" class="form-control" name="m_delivery_date" id="koti_d_date" <%if (delivery_date != null) {%>value="<%=delivery_date%>"<%} else {
                                                                                                        } %>  style="height: 40px" required=""/>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                                <center><input type="submit" class="form-control" value="Ok" style="width: 40%;"/></center>
                                                                            </form>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <%
                                                                }
                                                            %>
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement.jsp?m_name=<%=m_name%>&product_status=koti&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                        <td>
                                                            <%
                                                                if (order_info_status.equals("0")) {
                                                            %>
                                                            <a href="print_measurement_local.jsp?m_name=<%=m_name%>&product_status=koti&order=<%=order_id%>&delivery_date=<%=prodcut_delivery_date%>" target="_blank" style="text-decoration: none"><button class="btn btn-primary">Print</button></a>
                                                            <%
                                                                }
                                                            %>                                                            
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        } else {

                                                        }
                                                    %>   
                                                    <!----------------------------------------------------------------------------------// koti --------------------------------------------->
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </aside>                                         
                </div>
            </div>
        </div>
        <script>
            $(function () {
                var n = $("#date_diff").val();
                var cur_dat_dif = $("#curr_date_diff").val();
                $("#cus_birthdate").datepicker({
                    dateFormat: "yy-mm-dd",
                    minDate: - cur_dat_dif,
                    maxDate: n - cur_dat_dif
                });
            });
            $(function () {
                var n = $("#date_diff").val();
                var cur_dat_dif = $("#curr_date_diff").val();
                $("#pant_d_date").datepicker({
                   dateFormat: "yy-mm-dd",
                    minDate: - cur_dat_dif,
                    maxDate: n - cur_dat_dif
                });
            });
            $(function () {
                var n = $("#date_diff").val();
                var cur_dat_dif = $("#curr_date_diff").val();
                $("#blazer_d_date").datepicker({
                   dateFormat: "yy-mm-dd",
                    minDate: - cur_dat_dif,
                    maxDate: n - cur_dat_dif
                });
            });
            $(function () {
                var n = $("#date_diff").val();
                var cur_dat_dif = $("#curr_date_diff").val();
                $("#photua_d_date").datepicker({
                    dateFormat: "yy-mm-dd",
                    minDate: - cur_dat_dif,
                    maxDate: n - cur_dat_dif
                });
            });
            $(function () {
                var n = $("#date_diff").val();
                var cur_dat_dif = $("#curr_date_diff").val();
                $("#safari_d_date").datepicker({
                   dateFormat: "yy-mm-dd",
                    minDate: - cur_dat_dif,
                    maxDate: n - cur_dat_dif
                });
            });
            $(function () {
                var n = $("#date_diff").val();
                var cur_dat_dif = $("#curr_date_diff").val();
                $("#panjabi_d_date").datepicker({
                   dateFormat: "yy-mm-dd",
                    minDate: - cur_dat_dif,
                    maxDate: n - cur_dat_dif
                });
            });
            $(function () {
                var n = $("#date_diff").val();
                var cur_dat_dif = $("#curr_date_diff").val();
                $("#payjama_d_date").datepicker({
                    dateFormat: "yy-mm-dd",
                    minDate: - cur_dat_dif,
                    maxDate: n - cur_dat_dif
                });
            });
            $(function () {
                var n = $("#date_diff").val();
                var cur_dat_dif = $("#curr_date_diff").val();
                $("#mojib_cort_d_date").datepicker({
                   dateFormat: "yy-mm-dd",
                    minDate: - cur_dat_dif,
                    maxDate: n - cur_dat_dif
                });
            });
            $(function () {
                var n = $("#date_diff").val();
                var cur_dat_dif = $("#curr_date_diff").val();
                $("#kable_d_date").datepicker({
                   dateFormat: "yy-mm-dd",
                    minDate: - cur_dat_dif,
                    maxDate: n - cur_dat_dif
                });
            });
            $(function () {
                var n = $("#date_diff").val();
                var cur_dat_dif = $("#curr_date_diff").val();
                $("#koti_d_date").datepicker({
                   dateFormat: "yy-mm-dd",
                    minDate: - cur_dat_dif,
                    maxDate: n - cur_dat_dif
                });
            });
            $(function () {
                $("#new_delivery_date").datepicker({
                    dateFormat: "yy-mm-dd",
                    minDate: 0
                });
            });

        </script> 
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script> 
        <script src="/Tailor/admin/assets/js/custom.js"></script> 
    </body>
</html>
