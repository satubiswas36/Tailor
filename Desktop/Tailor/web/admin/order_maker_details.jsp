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
<%
    // worker cost jodi set na kore tahole product complete korta parba na. tar jonno check kortace cost set kora ace kina 
    String has_cost = null;
    try {
        String sql_has_worker_cost = "select * from worker_salary where ws_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
        PreparedStatement pst_worker_cost = DbConnection.getConn(sql_has_worker_cost);
        ResultSet rs_worker_cost = pst_worker_cost.executeQuery();
        if (rs_worker_cost.next()) {
            has_cost = "yes";
        } else {
            has_cost = "no";
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
                            <div class="panel-heading">
                                Order Maker Details <%=logger%>
                                <%

                                    //current month and year
                                    // for year
                                    DateFormat dateF = new SimpleDateFormat("yyyy");
                                    Date date_year = new Date();
                                    String d_year = dateF.format(date_year);
                                    //for month
                                    DateFormat dateM = new SimpleDateFormat("MM");
                                    Date date_month = new Date();
                                    String m_month = dateM.format(date_month);

                                %>
                            </div>
                            <div class="panel-body">
                                <%                                    // current date with format
                                    Date mdate = new Date();
                                    SimpleDateFormat sdm = new SimpleDateFormat("yyyy");
                                    SimpleDateFormat sdy = new SimpleDateFormat("MM");
                                    String mDate = sdm.format(mdate);
                                    String yDate = sdy.format(mdate);
                                %>                              

                                <table class="table table-bordered" id="mydata">
                                    <thead>                                        
                                        <th style="text-align: center; width: 2%;">SL</th>
                                        <th style="text-align: center">Order ID</th>
                                        <th style="text-align: left">Maker Name</th>
                                        <th style="text-align: left">Product</th>
                                        <th style="text-align: center; width: 4%">Qty</th>
                                        <th style="text-align: center; width: 8%">Receive date</th>
                                        <th style="text-align: center; width: 8%">Delivery date</th>
                                        <th style="text-align: center; width: 5%">Complete</th>
                                    </thead>
                                    <tbody>

                                        <%
                                            int sl = 1;
                                            int qty_shirt = 0;
                                            int qty_pant = 0;
                                            int qty_blazer = 0;
                                            int qty_photua = 0;
                                            int qty_safari = 0;
                                            int qty_panjabi = 0;
                                            int qty_payjama = 0;
                                            String product_name = null;
                                            try {
                                                String sql_search_order = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and (mk_status = 0 or mk_status = 1) order by slno desc ";
                                                PreparedStatement pst_search_order = DbConnection.getConn(sql_search_order);
                                                ResultSet rs_search_order = pst_search_order.executeQuery();
                                                while (rs_search_order.next()) {
                                                    Date dtStart = rs_search_order.getTimestamp("date");
                                                    String maker_name = rs_search_order.getString("mk_name");
                                                    String product_qty = rs_search_order.getString("qty");
                                                    SimpleDateFormat sd = new SimpleDateFormat("dd-MM-yyyy");
                                                    String s = sd.format(dtStart);
                                        %>
                                        <tr>
                                            <td style="text-align: center"><%=sl++%></td>
                                            <td style="text-align: center; width: 10%;"><%=rs_search_order.getString("order_id")%></td>
                                            <td style="text-align: left"><%=maker_name%></td>
                                            <td style="text-align: left"><%=rs_search_order.getString("product_name").substring(0, 1).toUpperCase() + rs_search_order.getString("product_name").substring(1).toLowerCase()%></td>
                                            <td style="text-align: center; width: 6%;"><%= rs_search_order.getString("qty")%></td>
                                            <td style="text-align: center"><%=s%></td>
                                            <td style="text-align: center"><%= rs_search_order.getString("mk_delivery_date")%></td>
                                            <td style="text-align: center">                                                
                                                <%
                                                    // check mk_status , jodi 1 hoy link kaj korba na 
                                                    String mk_status = null;
                                                    try {
                                                        String sql_mk_info_statsus = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + rs_search_order.getString("order_id") + "' and product_name = '" + rs_search_order.getString("product_name") + "' ";
                                                        PreparedStatement pst_mk_inof_status = DbConnection.getConn(sql_mk_info_statsus);
                                                        ResultSet rs_mk_status = pst_mk_inof_status.executeQuery();
                                                        if (rs_mk_status.next()) {
                                                            mk_status = rs_mk_status.getString("mk_status");
                                                        }
                                                        if (mk_status.equals("1")) {
                                                %>                                                        
                                                <span style="text-decoration: none; display: block" ><%="Yes"%></span>
                                                <%
                                                } else {
                                                %>
                                                <%
                                                    if (has_cost.equals("yes")) {
                                                %>
                                                <a href="order_complete.jsp?order_complete_order=<%=rs_search_order.getString("order_id")%>&complete_product=<%=rs_search_order.getString("product_name")%>&mk_name=<%=maker_name%>&product_qty=<%=product_qty%>" style="text-decoration: none;"><button class="btn btn-primary"><%="No"%></button></a>
                                                    <%
                                                    } else {
                                                    %>
                                                <span style="color: red; font-size: 14px;"><%="Set Making Cost"%></span>
                                                <%
                                                    }
                                                %>                                                
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>                                               
                                            </td>
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
                        </div>                                                    <!-- /. PAGE INNER  -->
                    </div>                                                    <!-- /. PAGE WRAPPER  -->
                </div>
            </div>
        </div>
        <script>
            $(function () {
                $("#mk_year_date").datepicker({
                    dateFormat: "yy",
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2016:' + (new Date).getFullYear()
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
        </script>
    </body>
</html>
