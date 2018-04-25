<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
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
            <jsp:include page="../menu/menu.jsp?page_name=account" flush="true"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <%                            // first date of current month
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
                                <span style="font-size: 18px">Product Buy Statement:</span>
                                <div class="pull-right">
                                    <form action="buy_product_statement.jsp" method="post">                                        
                                        From <input type="text" name="from_date" id="from_date" value="<%=from_date%>" style="padding-left: 8px;" />                                       
                                        To <input type="text" name="to_date" id="to_date" value="<%=to_date%>" style="padding-left: 8px;" />
                                        <input type="submit" value="Submit" />
                                    </form>
                                </div>
                            </div>
                            <div class="panel-body">                                
                                <table class="table table-bordered" id="mydata">
                                    <thead>
                                        <th style="text-align: center; width: 3%;">SL</th>
                                        <th style="text-align: center; width: 12%">Date</th>
                                        <th style="text-align: left">Supplier</th>
                                        <th style="width: 14%">Invoice ID</th>
                                        <th style="text-align: right; width: 15%">Amount</th>
                                        <th style="width: 5%">Details</th>
                                    </thead>
                                    
                                    <tbody>

                                        <%                                            int sl = 1;
                                            double amount = 0;
                                            double total_amount = 0;
                                            int qty = 0;
                                            double price = 0;
                                            String status = "";
                                            String supplier_name = null;
                                            try {
                                                String sql_buy_invoice = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_deal_type = 3 and (pro_buy_price != 0)  and (pro_entry_date>= '" + from_date + "' and pro_entry_date <= '" + to_date + "' )";
                                                PreparedStatement pst_buy_invoice = DbConnection.getConn(sql_buy_invoice);
                                                ResultSet rs_buy_invoice = pst_buy_invoice.executeQuery();
                                                while (rs_buy_invoice.next()) {
                                                    String invoiceid = rs_buy_invoice.getString("pro_invoice_id");
                                                    String in_date = rs_buy_invoice.getString("pro_entry_date");
                                                    String supplier_id = rs_buy_invoice.getString("pro_party_id");
                                                    /// supplier name 
                                                    String sql_supplier = "select * from supplier where suplr_bran_id = '" + session.getAttribute("user_bran_id") + "' and supplier_id = '" + supplier_id + "' ";
                                                    PreparedStatement pst_suppler = DbConnection.getConn(sql_supplier);
                                                    ResultSet rs_supplier = pst_suppler.executeQuery();
                                                    if (rs_supplier.next()) {
                                                        supplier_name = rs_supplier.getString("suplr_name");
                                                    }
                                                    if (status.equals(invoiceid)) {
                                                        continue;
                                                    } else {
                                                        status = invoiceid;
                                                        // total amount by invoice id 
                                                        String sql_amount = "select * from inventory_details where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + invoiceid + "' and pro_deal_type = 3 ";
                                                        PreparedStatement pst_amount = DbConnection.getConn(sql_amount);
                                                        ResultSet rs_amount = pst_amount.executeQuery();
                                                        while (rs_amount.next()) {
                                                            qty = Integer.parseInt(rs_amount.getString("pro_buy_quantity"));
                                                            price = Double.parseDouble(rs_amount.getString("pro_buy_price"));
                                                            amount += (qty * price);
                                                        }
                                                    }
                                        %>                                        
                                        <tr>
                                            <td style="text-align: center"><%=sl++%></td>
                                            <td style="text-align: center"><%=in_date%></td>
                                            <td style="text-align: left;"><%=supplier_name%></td>
                                            <td style="text-align: left"><%=invoiceid%></td>
                                            <td style="text-align: right"><%=amount + "0"%></td>
                                            <td><a class="btn btn-success" href="buy_product_statement_details.jsp?invoice_id=<%=invoiceid%>&supplier=<%=supplier_name%>">Details</a></td>
                                        </tr>                                      

                                        <%
                                                    total_amount += amount;
                                                    amount = 0;
                                                }
                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            }
                                        %>                                        
                                    </tbody>
                                    <tbody>
                                        <tr>
                                            <td colspan="5" style="text-align: right"><b>Total : <%=total_amount+"0"%></b></td>
                                            <td></td>
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
