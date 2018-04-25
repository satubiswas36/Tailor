<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
            <jsp:include page="../menu/menu.jsp?page_name=maker"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Order Maker Details
                                <%
                                    String year = request.getParameter("mk_year");
                                    String month = request.getParameter("mk_month");
                                    String maker_name = request.getParameter("maker_name_list");

                                    //maker id
                                    String maker_name_for_id = null;
                                    try {
                                        String sql_maker_id = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' and mk_name = '" + maker_name + "' ";
                                        PreparedStatement pst_maker_id = DbConnection.getConn(sql_maker_id);
                                        ResultSet rs_maker_id = pst_maker_id.executeQuery();
                                        if (rs_maker_id.next()) {
                                            maker_name_for_id = rs_maker_id.getString("mk_slno");
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }

                                    String year_month = year + "-" + month;
                                    out.println(maker_name);
                                    String month_status = null;

                                    if (month != null) {
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
                                    }
                                %>
                            </div>
                            <div class="panel-body">
                                <%
                                    if (maker_name != null) {
                                %>
                                <span style="font-size: 18px;"><%= maker_name + " work details : "%></span>
                                <%
                                    }
                                %>
                                <div style="float: left;" class="pull-right">
                                    <form action="maker_complete_orders.jsp" method="post">
                                        <table>
                                            <tr>
                                                <td>
                                                    <select name="maker_name_list" required="">
                                                        <option></option>
                                                        <%
                                                            try {
                                                                String sql_maker = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                                                                ResultSet rs_maker = pst_maker.executeQuery();
                                                                while (rs_maker.next()) {
                                                        %>
                                                        <option><%=rs_maker.getString("mk_name")%></option>
                                                        <%
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                        %>
                                                    </select>
                                                </td>
                                                <td>
                                                    <select name="mk_month"  required="">
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

                                <!--                                <table class="table table-bordered">
                                                                    <thead>
                                                                        <th style="text-align: center">Order ID</th>
                                                                        <th style="text-align: center">Maker Name</th>
                                                                        <th style="text-align: center">Product</th>
                                                                        <th style="text-align: center">Qty</th>
                                                                        <th style="text-align: center">Receive date</th>
                                                                        <th style="text-align: center">Delivery date</th>
                                                                        <th style="text-align: center">Complete</th>
                                                                    </thead>
                                                                    <tbody>
                                <%
                                    if (year == null || month == null || maker_name == null) {
                                %>
                                <%
                                    try {
                                        String sql_order_maker_details = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' order by slno desc";
                                        PreparedStatement pst_order_maker_details = DbConnection.getConn(sql_order_maker_details);
                                        ResultSet rs_order_maker_details = pst_order_maker_details.executeQuery();
                                        while (rs_order_maker_details.next()) {
                                            Date dtStart = rs_order_maker_details.getTimestamp("date");
                                            SimpleDateFormat sd = new SimpleDateFormat("dd-MM-yyyy");
                                            String s = sd.format(dtStart);


                                %>
                                <tr>
                                    <td style="text-align: center; width: 6%;"><%=rs_order_maker_details.getString("order_id")%></td>
                                    <td style="text-align: center; width: 18%"><%=rs_order_maker_details.getString("mk_name")%></td>
                                    <td style="text-align: center"><%=rs_order_maker_details.getString("product_name")%></td>
                                    <td style="text-align: center"><%= rs_order_maker_details.getString("qty")%></td>
                                    <td style="text-align: center"><%=s%></td>
                                    <td style="text-align: center"><%= rs_order_maker_details.getString("mk_delivery_date")%></td>
                                    <td style="text-align: center">                                                
                                        <button class="btn btn-default">
                                <%
                                    String mk_status = null;
                                    try {
                                        String sql_mk_info_statsus = "select * from maker_order_product_info where order_id = '" + rs_order_maker_details.getString("order_id") + "' and product_name = '" + rs_order_maker_details.getString("product_name") + "' ";
                                        PreparedStatement pst_mk_inof_status = DbConnection.getConn(sql_mk_info_statsus);
                                        ResultSet rs_mk_status = pst_mk_inof_status.executeQuery();
                                        if (rs_mk_status.next()) {
                                            mk_status = rs_mk_status.getString("mk_status");
                                        }
                                        if (mk_status.equals("1")) {
                                %>
                                <%="yes"%>
                                <%
                                } else {
                                %>
                                <%="no"%>
                                <%
                                        }
                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                %>
                            </button>
                        </td>
                    </tr>
                                <%
                                        }
                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                %>
                                <%
                                    }
                                %>
                                <%
                                    int shirt_counter_complete = 0;
                                    int shirt_counter_incomplete = 0;
                                    int pant_counter_complete = 0;
                                    int pant_counter_incomplete = 0;
                                    int blazer_counter_complete = 0;
                                    int blazer_counter_incomplete = 0;
                                    int photua_counter_complete = 0;
                                    int photua_counter_incomplete = 0;
                                    int safari_counter_complete = 0;
                                    int safari_counter_incomplete = 0;
                                    int panjabi_counter_complete = 0;
                                    int panjabi_counter_incomplete = 0;
                                    int payjama_counter_complete = 0;
                                    int payjama_counter_incomplete = 0;
                                    int mojibcort_counter_complete = 0;
                                    int mojibcort_counter_incomplete = 0;
                                    int kable_counter_complete = 0;
                                    int kable_counter_incomplete = 0;
                                    int koti_counter_complete = 0;
                                    int koti_counter_incomplete = 0;
                                    int qty_shirt = 0;
                                    int qty_pant = 0;
                                    int qty_blazer = 0;
                                    int qty_photua = 0;
                                    int qty_safari = 0;
                                    int qty_panjabi = 0;
                                    int qty_payjama = 0;
                                    int qty_mojibcort = 0;
                                    int qty_kable = 0;
                                    int qty_koti = 0;
                                    String product_name = null;
                                    if (maker_name != null && year != null && month != null) {
                                        if (year != null && month != null) {
                                            try {
                                                String sql_search_order = "select * from maker_order_product_info where date like ? and mk_name = '" + maker_name + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' and (mk_status = 0 or mk_status = 1)";
                                                PreparedStatement pst_search_order = DbConnection.getConn(sql_search_order);
                                                pst_search_order.setString(1, "%" + year_month + "%");
                                                ResultSet rs_search_order = pst_search_order.executeQuery();
                                                while (rs_search_order.next()) {
                                                    // date formate
                                                    Date dtStart = rs_search_order.getTimestamp("date");
                                                    SimpleDateFormat sd = new SimpleDateFormat("dd-MM-yyyy");
                                                    String s = sd.format(dtStart);

                                                    product_name = rs_search_order.getString("product_name");
                                                    // shirt qty count 
                                                    if (product_name.equals("shirt")) {
                                                        String shirt_status = rs_search_order.getString("mk_status");
                                                        if (shirt_status.equals("1")) {
                                                            qty_shirt = Integer.parseInt(rs_search_order.getString("qty"));
                                                            shirt_counter_complete += qty_shirt;
                                                        } else if (shirt_status.equals("0")) {
                                                            qty_shirt = Integer.parseInt(rs_search_order.getString("qty"));
                                                            shirt_counter_incomplete += qty_shirt;
                                                        }
                                                    }

                                                    //pant qty count 
                                                    if (product_name.equals("pant")) {
                                                        String pant_status = rs_search_order.getString("mk_status");
                                                        if (pant_status.equals("1")) {
                                                            qty_pant = Integer.parseInt(rs_search_order.getString("qty"));
                                                            pant_counter_complete += qty_pant;
                                                        } else if (pant_status.equals("0")) {
                                                            qty_pant = Integer.parseInt(rs_search_order.getString("qty"));
                                                            pant_counter_incomplete += qty_pant;
                                                        }
                                                    }
                                                    // blazer qty count
                                                    if (product_name.equals("blazer")) {
                                                        String bla_status = rs_search_order.getString("mk_status");
                                                        if (bla_status.equals("1")) {
                                                            qty_blazer = Integer.parseInt(rs_search_order.getString("qty"));
                                                            blazer_counter_complete += qty_blazer;
                                                        } else if (bla_status.equals("0")) {
                                                            qty_blazer = Integer.parseInt(rs_search_order.getString("qty"));
                                                            blazer_counter_incomplete += qty_blazer;
                                                        }
                                                    }

                                                    // photua qty count 
                                                    if (product_name.equals("photua")) {
                                                        String photua_status = rs_search_order.getString("mk_status");
                                                        if (photua_status.equals("1")) {
                                                            qty_photua = Integer.parseInt(rs_search_order.getString("qty"));
                                                            photua_counter_complete += qty_photua;
                                                        } else if (photua_status.equals("0")) {
                                                            qty_photua = Integer.parseInt(rs_search_order.getString("qty"));
                                                            photua_counter_incomplete += qty_photua;
                                                        }
                                                    }

                                                    // safari qty count 
                                                    if (product_name.equals("safari")) {
                                                        String safari_status = rs_search_order.getString("mk_status");
                                                        if (safari_status.equals("1")) {
                                                            qty_safari = Integer.parseInt(rs_search_order.getString("qty"));
                                                            safari_counter_complete += qty_safari;
                                                        } else if (safari_status.equals("0")) {
                                                            qty_safari = Integer.parseInt(rs_search_order.getString("qty"));
                                                            safari_counter_incomplete += qty_safari;
                                                        }
                                                    }
                                                    // panjabi qty count 
                                                    if (product_name.equals("panjabi")) {
                                                        String panjabi_status = rs_search_order.getString("mk_status");
                                                        if (panjabi_status.equals("1")) {
                                                            qty_panjabi = Integer.parseInt(rs_search_order.getString("qty"));
                                                            panjabi_counter_complete += qty_panjabi;
                                                        } else if (panjabi_status.equals("0")) {
                                                            qty_panjabi = Integer.parseInt(rs_search_order.getString("qty"));
                                                            panjabi_counter_incomplete += qty_panjabi;
                                                        }
                                                    }
                                                    // payjama qty count 
                                                    if (product_name.equals("payjama")) {
                                                        String payjama_status = rs_search_order.getString("mk_status");
                                                        if (payjama_status.equals("1")) {
                                                            qty_payjama = Integer.parseInt(rs_search_order.getString("qty"));
                                                            payjama_counter_complete += qty_payjama;
                                                        } else if (payjama_status.equals("0")) {
                                                            qty_payjama = Integer.parseInt(rs_search_order.getString("qty"));
                                                            payjama_counter_incomplete += qty_payjama;
                                                        }
                                                    }
                                                    // mojib cort qty count 
                                                    if (product_name.equals("mojib_cort")) {
                                                        String mojibcort_status = rs_search_order.getString("mk_status");
                                                        if (mojibcort_status.equals("1")) {
                                                            qty_mojibcort = Integer.parseInt(rs_search_order.getString("qty"));
                                                            mojibcort_counter_complete += qty_mojibcort;
                                                        } else if (mojibcort_status.equals("0")) {
                                                            qty_mojibcort = Integer.parseInt(rs_search_order.getString("qty"));
                                                            mojibcort_counter_incomplete += qty_mojibcort;
                                                        }
                                                    }
                                                    // kable qty count 
                                                    if (product_name.equals("kable")) {
                                                        String kable_status = rs_search_order.getString("mk_status");
                                                        if (kable_status.equals("1")) {
                                                            qty_kable = Integer.parseInt(rs_search_order.getString("qty"));
                                                            kable_counter_complete += qty_kable;
                                                        } else if (kable_status.equals("0")) {
                                                            qty_kable = Integer.parseInt(rs_search_order.getString("qty"));
                                                            kable_counter_incomplete += qty_kable;
                                                        }
                                                    }
                                                    // koti qty count 
                                                    if (product_name.equals("koti")) {
                                                        String koti_status = rs_search_order.getString("mk_status");
                                                        if (koti_status.equals("1")) {
                                                            qty_koti = Integer.parseInt(rs_search_order.getString("qty"));
                                                            koti_counter_complete += qty_koti;
                                                        } else if (koti_status.equals("0")) {
                                                            qty_koti = Integer.parseInt(rs_search_order.getString("qty"));
                                                            koti_counter_incomplete += qty_koti;
                                                        }
                                                    }

                                %>
                                <tr>
                                    <td style="text-align: center"><%=rs_search_order.getString("order_id")%></td>
                                    <td style="text-align: center"><%=rs_search_order.getString("mk_name")%></td>
                                    <td style="text-align: center"><%=rs_search_order.getString("product_name")%></td>
                                    <td style="text-align: center"><%= rs_search_order.getString("qty")%></td>
                                    <td style="text-align: center"><%=s%></td>
                                    <td style="text-align: center"><%= rs_search_order.getString("mk_delivery_date")%></td>
                                    <td style="text-align: center">

                                        <button class="btn btn-default">
                                <%
                                    String mk_status = null;
                                    try {
                                        String sql_mk_info_statsus = "select * from maker_order_product_info where order_id = '" + rs_search_order.getString("order_id") + "' and product_name = '" + rs_search_order.getString("product_name") + "' ";
                                        PreparedStatement pst_mk_inof_status = DbConnection.getConn(sql_mk_info_statsus);
                                        ResultSet rs_mk_status = pst_mk_inof_status.executeQuery();
                                        if (rs_mk_status.next()) {
                                            mk_status = rs_mk_status.getString("mk_status");
                                        }
                                        if (mk_status.equals("1")) {
                                %>
                                <%="yes"%>
                                <%
                                } else if (mk_status.equals("0")) {
                                %>
                                <%="no"%>
                                <%
                                } else {
                                %>
                                <%="no status"%>
                                <%
                                        }

                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                %>
                            </button>
                        </td>
                    </tr>
                                <%
                                                }

                                            } catch (Exception e) {
                                                out.println("nuber format exception " + e.toString());
                                            }
                                        }
                                    }
                                %>                                        
                            </tbody>
                        </table>-->

                                <%
                                    double total_payment = 0;
                                    double total_pending_payment = 0;
                                    try {
                                        String sql_worker_salary = "select * from worker_salary where ws_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                        PreparedStatement pst_worker_salary = DbConnection.getConn(sql_worker_salary);
                                        ResultSet rs_worker_salary = pst_worker_salary.executeQuery();
                                        while (rs_worker_salary.next()) {
                                            String shirt_p = rs_worker_salary.getString("ws_shirt");
                                            String pant_p = rs_worker_salary.getString("ws_pant");
                                            String blazer_p = rs_worker_salary.getString("ws_blazer");
                                            String photua_p = rs_worker_salary.getString("ws_photua");
                                            String safari_p = rs_worker_salary.getString("ws_safari");
                                            String panjabi_p = rs_worker_salary.getString("ws_panjabi");
                                            String payjama_p = rs_worker_salary.getString("ws_payjama");
                                            String mojibcort_p = rs_worker_salary.getString("ws_mojib_cort");
                                            String kable_p = rs_worker_salary.getString("ws_kable");
                                            String koti_p = rs_worker_salary.getString("ws_koti");
                                            total_payment += shirt_counter_complete * Double.parseDouble(shirt_p);
                                            total_pending_payment += shirt_counter_incomplete * Double.parseDouble(shirt_p);
                                            total_payment += pant_counter_complete * Double.parseDouble(pant_p);
                                            total_pending_payment += pant_counter_incomplete * Double.parseDouble(pant_p);
                                            total_payment += blazer_counter_complete * Double.parseDouble(blazer_p);
                                            total_pending_payment += blazer_counter_incomplete * Double.parseDouble(blazer_p);
                                            total_payment += photua_counter_complete * Double.parseDouble(photua_p);
                                            total_pending_payment += photua_counter_incomplete * Double.parseDouble(photua_p);
                                            total_payment += safari_counter_complete * Double.parseDouble(safari_p);
                                            total_pending_payment += safari_counter_incomplete * Double.parseDouble(safari_p);
                                            total_payment += panjabi_counter_complete * Double.parseDouble(panjabi_p);
                                            total_pending_payment += panjabi_counter_incomplete * Double.parseDouble(panjabi_p);
                                            total_payment += payjama_counter_complete * Double.parseDouble(payjama_p);
                                            total_pending_payment += payjama_counter_incomplete * Double.parseDouble(payjama_p);
                                            total_payment += mojibcort_counter_complete * Double.parseDouble(mojibcort_p);
                                            total_pending_payment += mojibcort_counter_incomplete * Double.parseDouble(mojibcort_p);
                                            total_payment += kable_counter_complete * Double.parseDouble(kable_p);
                                            total_pending_payment += kable_counter_incomplete * Double.parseDouble(kable_p);
                                            total_payment += koti_counter_complete * Double.parseDouble(koti_p);
                                            total_pending_payment += koti_counter_incomplete * Double.parseDouble(koti_p);
                                        }
                                    } catch (Exception e) {
                                        out.println("e --------- " + e.toString());
                                    }
                                %>

                                <table class="table table-striped table-bordered" style="width: 50%;">
                                    <thead>
                                        <th style="text-align: center">SL</th>
                                        <th style="text-align: center">Product Name</th>
                                        <th style="text-align: center">Complete</th>
                                        <th style="text-align: center">Incomplete</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td style="text-align: center">1</td>
                                            <td style="text-align: center">Shirt</td>
                                            <td style="text-align: center"><%=shirt_counter_complete%></td>
                                            <td style="text-align: center"><%=shirt_counter_incomplete%></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">2</td>
                                            <td style="text-align: center">Pant</td>
                                            <td style="text-align: center"><%=pant_counter_complete%></td>
                                            <td style="text-align: center"><%=pant_counter_incomplete%></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">3</td>
                                            <td style="text-align: center">Blazer</td>
                                            <td style="text-align: center"><%=blazer_counter_complete%></td>
                                            <td style="text-align: center"><%=blazer_counter_incomplete%></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">4</td>
                                            <td style="text-align: center">Photua</td>
                                            <td style="text-align: center"><%=photua_counter_complete%></td>
                                            <td style="text-align: center"><%=photua_counter_incomplete%></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">5</td>
                                            <td style="text-align: center">Panjabi</td>
                                            <td style="text-align: center"><%=panjabi_counter_complete%></td>
                                            <td style="text-align: center"><%=panjabi_counter_incomplete%></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">6</td>
                                            <td style="text-align: center">Payjama</td>
                                            <td style="text-align: center"><%=payjama_counter_complete%></td>
                                            <td style="text-align: center"><%=payjama_counter_incomplete%></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">7</td>
                                            <td style="text-align: center">Safari</td>
                                            <td style="text-align: center"><%=safari_counter_complete%></td>
                                            <td style="text-align: center"><%=safari_counter_incomplete%></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">8</td>
                                            <td style="text-align: center">Mojib Cort</td>
                                            <td style="text-align: center"><%=mojibcort_counter_complete%></td>
                                            <td style="text-align: center"><%=mojibcort_counter_incomplete%></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">9</td>
                                            <td style="text-align: center">Kable</td>
                                            <td style="text-align: center"><%=kable_counter_complete%></td>
                                            <td style="text-align: center"><%=kable_counter_incomplete%></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">10</td>
                                            <td style="text-align: center">Koti</td>
                                            <td style="text-align: center"><%=koti_counter_complete%></td>
                                            <td style="text-align: center"><%=koti_counter_incomplete%></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>Total Complete Payment : <b><%=total_payment + "0"%></b></td>
                                            <td>Total Pending Payment : <b><%= total_pending_payment + "0"%></b></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <%
                                                String maker_id = null;
                                                double maker_complete_paid = 0;
                                                double complete_paid = 0;
                                                try {
                                                    String sql_maker_id = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' and mk_name = '" + maker_name + "' ";
                                                    PreparedStatement pst_maker_id = DbConnection.getConn(sql_maker_id);
                                                    ResultSet rs_maker_id = pst_maker_id.executeQuery();
                                                    if (rs_maker_id.next()) {
                                                        maker_id = rs_maker_id.getString("mk_slno");
                                                    }
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                            <%
                                                try {
                                                    String sql_maker_paid = "select * from account where acc_pay_date like ? and acc_bran_id = '" + session.getAttribute("user_bran_id") + "' and acc_customer_id = '" + maker_id + "' and acc_status=3 ";
                                                    PreparedStatement pst_maker_paid = DbConnection.getConn(sql_maker_paid);
                                                    pst_maker_paid.setString(1, year_month + "%");
                                                    ResultSet rs_maker_paid = pst_maker_paid.executeQuery();
                                                    while (rs_maker_paid.next()) {
                                                        String mk_paid = rs_maker_paid.getString("acc_debit");
                                                        maker_complete_paid += Double.parseDouble(mk_paid);
                                                    }
                                                } catch (Exception e) {
                                                    out.println("from account " + e.toString());
                                                }

                                            %>
                                            <%                                                        try {
                                                    String sql_ = "";
                                                } catch (Exception e) {

                                                }
                                            %>
                                            <%
                                                // maker bonus 
                                                double maker_bonus = 0;

                                                try {
                                                    String sql_maker_bonus = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + maker_name_for_id + "' and pro_deal_type = 7";
                                                    PreparedStatement pst_maker_bonus = DbConnection.getConn(sql_maker_bonus);
                                                    ResultSet rs_maker_bonus = pst_maker_bonus.executeQuery();
                                                    while (rs_maker_bonus.next()) {
                                                        maker_bonus += Double.parseDouble(rs_maker_bonus.getString("pro_buy_paid"));
                                                    }
                                                } catch (Exception e) {
                                                    out.println(" error s " + e.toString());
                                                }
                                                complete_paid = (maker_complete_paid - maker_bonus);
                                            %>
                                            <td><b> Complete paid : <%= complete_paid + "0"%></b></td>
                                            <td> : <b>The Rest : <%= ((total_payment - complete_paid)) + "0"%> </b></td>
                                            <td><b><%="Bonus : " + maker_bonus + "0"%></b></td>
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
        </script>
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
