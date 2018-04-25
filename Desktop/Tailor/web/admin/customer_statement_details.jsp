
<%@page import="java.sql.Blob"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%
    String logger = (String) session.getAttribute("logger");
    String branch_id = (String) session.getAttribute("user_bran_id");
    String last_status = null;
    String sl_no = null;

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
    <head>
        <title>Tailor</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta charset="utf-8" />
        <meta contenteditable="utf8_general_ci" />
        <!--        <meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" type="image/x-icon" href="../admin/assets/img/t_mechin.jpg"/>
        <link href="/Tailor/admin/assets/css/bootstrap.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/css/font-awesome.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />       
        <link href="/Tailor/admin/assets/css/custom.css" rel="stylesheet" />      
        <link href="/Tailor/admin/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />        
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script src="http://mymaplist.com/js/vendor/TweenLite.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
        <link rel="stylesheet" href="/resources/demos/style.css" />
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <!--      for time picker-->
        <link href="../admin/assets/css/timedropper.css" rel="stylesheet" type="text/css" />
        <script src="../admin/assets/js/timedropper.js" type="text/javascript"></script>
        <!--    <script src="../admin/assets/js/jquery.js" type="text/javascript"></script>-->

        <!------------------- select2-------------------------------->
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2-bootstrap.min.css" />
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.css" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.js"></script>
        <!------------------- select2----------end---------------------->

        <style>
            .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
                padding: 2px;
                line-height: 1.42857143;
                vertical-align: top;
                border-top: 1px solid #ddd;
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
                    font-size: 14px;
                }
                /* ... the rest of the rules ... */
            }
        </style>
    </head>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=customer" flush="true"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <%
                            String customer_id = null;
                            String cust_id = request.getParameter("customer_id");
                            if (cust_id != null) {
                                customer_id = cust_id;
                            }

                        %>
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
                                    bran_logo = rs_img.getString("bran_com_logo");
                                }
                            } catch (Exception e) {
                                out.println("show_last_invoice branch image " + e.toString());
                            }
                        %>
                        <div class="panel panel-default" >
                            <div class="panel-heading" style="height: 45px">
                                <%                                    String customer_name = null;
                                    try {
                                        String sql_cus_name = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + customer_id + "' ";
                                        PreparedStatement pst_cus_name = DbConnection.getConn(sql_cus_name);
                                        ResultSet rs_cust_name = pst_cus_name.executeQuery();
                                        if (rs_cust_name.next()) {
                                            customer_name = rs_cust_name.getString("cus_name");
                                        }
                                %>
                                <%="Statement for : "%><b><%=customer_name%></b>
                                <%
                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                %>
                                <div class="pull-right">
                                    <form action="customer_statement_details.jsp" method="post">
                                        <input type="text" name="customer_id" value="<%=customer_id%>" style="display: none"/>
                                        From<input type="text" name="from_date" id="from_date" value="<%=from_date%>" style="padding-left: 8px;" />                                       
                                        To<input type="text" name="to_date" id="to_date" value="<%=to_date%>" style="padding-left: 8px;" />
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
                                        <span style="margin: 5px;">Customer Name : <%=customer_name%></span>
                                        <table class="table table-bordered" style="width: 100%;" id="recTable">
                                            <%
                                                int id = 1;
                                                double balance = 0;
                                                double credit = 0;
                                                double debit = 0;
                                                double total_debit = 0;
                                                double total_credit = 0;
                                                double total_discount = 0;
                                                double sell_qty = 0;
                                            %>
                                            <thead>
                                                <th style="text-align: center">SL</th>
                                                <th style="text-align: center">Date</th>
                                                <th style="text-align: left">Description</th>
                                                <th style="text-align: right">Debit</th>
                                                <th style="text-align: right">Credit</th>
                                                <th style="text-align: right">Balance</th>                                        
                                            </thead>
                                            <%                                        // debit for customer 
                                                // age debit gulo inventory table thaka neya print korci
                                                String acc_date_debit = null;
                                                String user_name = null;
                                                String order_id = null;
                                                double total_for_one_inv = 0;
                                                String status = "";
                                                try {
                                                    String sql_debit_customer = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + customer_id + "' and (pro_deal_type = 5 or pro_deal_type = 1 or pro_deal_type = 4 or pro_deal_type = 6) and (pro_entry_date>= '" + from_date + "' and pro_entry_date <= '" + to_date + "' )";
                                                    PreparedStatement pst_debit_customer = DbConnection.getConn(sql_debit_customer);
                                                    ResultSet rs_debit_customer = pst_debit_customer.executeQuery();
                                                    while (rs_debit_customer.next()) {
                                                        String deal_type_for_discoutn = rs_debit_customer.getString("pro_deal_type");
                                                        String invoice_id = rs_debit_customer.getString("pro_invoice_id");
                                                        if (deal_type_for_discoutn.equals("4")) {
                                                            if (status.equals(invoice_id)) {
                                                                continue;
                                                            } else {
                                                                status = invoice_id;
                                                                String sql_total_balace = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_invoice_id = '" + invoice_id + "' and pro_deal_type = 4";
                                                                PreparedStatement pst_total_balance = DbConnection.getConn(sql_total_balace);
                                                                ResultSet rs_total_balance = pst_total_balance.executeQuery();
                                                                while (rs_total_balance.next()) {
                                                                    double sell_qty_in = Double.parseDouble(rs_total_balance.getString("pro_sell_quantity"));
                                                                    double sell_price_in = Double.parseDouble(rs_total_balance.getString("pro_sell_price"));
                                                                    total_for_one_inv += (sell_price_in * sell_qty_in);
                                                                }
                                                            }
                                                        }

                                                        String Debit = rs_debit_customer.getString("pro_sell_price");
                                                        sell_qty = Double.parseDouble(rs_debit_customer.getString("pro_sell_quantity"));
                                                        debit = Double.parseDouble(Debit);
                                                        String Credit = rs_debit_customer.getString("pro_sell_paid");
                                                        credit = Double.parseDouble(Credit);
                                                        // discount 
                                                        if (deal_type_for_discoutn.equals("6")) {
                                                            total_discount += Double.parseDouble(Credit);
                                                        }

                                                        if (deal_type_for_discoutn.equals("4")) {
                                                            total_debit += total_for_one_inv;

                                                        } else {
                                                            total_debit += (Double.parseDouble(Debit) * sell_qty);
                                                            total_credit += Double.parseDouble(Credit);
                                                        }
                                                        acc_date_debit = rs_debit_customer.getString("pro_entry_date");
                                                        order_id = rs_debit_customer.getString("pro_invoice_id");
                                                        // date format
                                                        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                                        Date debit_date = format.parse(acc_date_debit);
                                                        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
                                                        acc_date_debit = sd.format(debit_date);
                                                        // order receive by 
                                                        String user = rs_debit_customer.getString("pro_user_id");
                                                        // user name 
                                                        String sql_user_name = "select * from user_user where user_id = '" + user + "' ";
                                                        PreparedStatement pst_user_name = DbConnection.getConn(sql_user_name);
                                                        ResultSet rs_user_name = pst_user_name.executeQuery();
                                                        if (rs_user_name.next()) {
                                                            user_name = rs_user_name.getString("user_name");
                                                        } else {
                                                            user_name = "Branch";
                                                        }

                                                        balance = total_credit - total_debit;
                                                        // deal type check kore description thik kora 
                                                        String description = null;
                                                        if (deal_type_for_discoutn.equals("5")) {
                                                            description = "order receive by " + user_name + "(" + order_id + ")";
                                                        }
                                                        if (deal_type_for_discoutn.equals("1")) {
                                                            description = "Payment receive by " + user_name;
                                                        }
                                                        if (deal_type_for_discoutn.equals("6")) {
                                                            description = "Discount";
                                                        }
                                                        if (deal_type_for_discoutn.equals("4")) {
                                                            description = "product buy, invoice is ";
                                                        }
                                            %>
                                            <%
                                                if (deal_type_for_discoutn.equals("4")) {
                                            %>
                                            <tr>                                            
                                                <td style="text-align: center"><%= id++%></td>
                                                <td style="text-align: center; width: 13%;"><%= acc_date_debit%></td>
                                                <td style="text-align: left"><%=description%>
                                                    <a href="" data-toggle="modal" data-target="#myModal<%=order_id%>" style="text-decoration: none"><%=order_id%></a> <a class="" href="javascript:void(0)" onclick="window.open('invoice_print_by_invoice_id.jsp?invoice=<%=order_id%>', '_blank', 'location=yes,height=570,width=720,scrollbars=yes,status=yes');" style="text-decoration: none">print</a>
                                                    <!-- Modal -->
                                                    <div class="modal fade" id="myModal<%=order_id%>" role="dialog">
                                                        <div class="modal-dialog modal-lg">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                    <h4 class="modal-title"><%=order_id%></h4>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <table class="table table-bordered">
                                                                        <thead>
                                                                            <th style="text-align: center">SL</th>
                                                                            <th>Product Name</th>
                                                                            <th>Description</th>
                                                                            <th style="text-align: center">Qty</th>
                                                                            <th style="text-align: right">Price</th>
                                                                            <th style="text-align: right">Amount</th>
                                                                        </thead>
                                                                        <tbody>
                                                                            <%
                                                                                String product_name = null;
                                                                                String sell_price = null;
                                                                                String product_description = null;
                                                                                double amount = 0;
                                                                                double total_amount = 0;
                                                                                int sl = 1;
                                                                                String sql_product = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_invoice_id = '" + order_id + "' and pro_deal_type = 4";
                                                                                PreparedStatement pst_product = DbConnection.getConn(sql_product);
                                                                                ResultSet rs_product = pst_product.executeQuery();
                                                                                while (rs_product.next()) {
                                                                                    String product_id = rs_product.getString("pro_product_id");
                                                                                    // product name by product id
                                                                                    String sql_product_name = "select * from inv_product_name where prn_bran_id = '" + session.getAttribute("user_bran_id") + "' and prn_slid = '" + product_id + "' ";
                                                                                    PreparedStatement pst_product_name = DbConnection.getConn(sql_product_name);
                                                                                    ResultSet rs_product_name = pst_product_name.executeQuery();
                                                                                    if (rs_product_name.next()) {
                                                                                        product_name = rs_product_name.getString("prn_product_name");
                                                                                    }
                                                                                    String qty = rs_product.getString("pro_sell_quantity");
                                                                                    sell_price = rs_product.getString("pro_sell_price");
                                                                                    amount = (Double.parseDouble(qty) * Double.parseDouble(sell_price));
                                                                                    total_amount += amount;
                                                                                    // get all information form inv_product
                                                                                    String sql_product_inv_product = "select * from inv_product where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' and pr_product_name = '" + product_id + "' ";
                                                                                    PreparedStatement pst_inv_product = DbConnection.getConn(sql_product_inv_product);
                                                                                    ResultSet rs_inv_product = pst_inv_product.executeQuery();
                                                                                    if (rs_inv_product.next()) {
                                                                                        //sell_price = rs_inv_product.getString("pr_sell_price");                                                                                    
                                                                                        product_description = rs_inv_product.getString("pr_product_detail");
                                                                                    }
                                                                            %>
                                                                            <tr>
                                                                                <td style="text-align: center;"><%=sl++%></td>
                                                                                <td><%=product_name%></td>
                                                                                <td><%=product_description%></td>
                                                                                <td style="text-align: center"><%=qty%></td>
                                                                                <td style="text-align: right"><%=sell_price + ".00"%></td>
                                                                                <td style="text-align: right"><%=amount + "0"%></td>
                                                                            </tr>
                                                                            <%
                                                                                }
                                                                            %>
                                                                        </tbody>                                                                  
                                                                    </table>      
                                                                    <span class="pull-right" style="margin: 0px"><b>Total : <%=total_amount + "0"%></b></span>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--                                    // modal -->
                                                </td>
                                                    <td style="text-align: right"><%if (debit == 0) {
                                                    } else {%><%= (total_for_one_inv) + "0"%><%} %></td>                                        
                                                    <td style="text-align: right"><%if (credit == 0) {
                                                    } else {%><%= credit + "0"%><%}%></td>
                                                <td style="text-align: right"><%= balance + "0"%></td>                                        
                                            </tr>
                                            <%
                                            } else {
                                            %>
                                            <tr>
                                                <td style="text-align: center"><%= id++%></td>
                                                <td style="text-align: center; width: 13%;"><%= acc_date_debit%></td>
                                                <td style="text-align: left"><%=description%></td>
                                                    <td style="text-align: right"><%if (debit == 0) {
                                                    } else {%><%= (debit * sell_qty) + "0"%><%} %></td>                                        
                                                    <td style="text-align: right"><%if (credit == 0) {
                                                    } else {%><%= credit + "0"%><%}%></td>
                                                <td style="text-align: right"><%= balance + "0"%></td>                                        
                                            </tr>
                                            <%
                                                }
                                            %>

                                            <%
                                                        total_for_one_inv = 0;
                                                    }
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>                                   

                                            <tbody>
                                                <td></td>
                                                <td></td>
                                                <td style="text-align: right"><b>Total Discount : <%=total_discount + "0"%></b></td>
                                                <td style="text-align: right"><b><%=total_debit + "0"%></b></td>
                                                <td style="text-align: right"><b><%=total_credit + "0"%></b></td>
                                                <td style="text-align: right"><b><%=balance + "0"%></b></td>
                                            </tbody>
                                        </table>
                                        <center> <span>Power By : <b>IGL Web™ Ltd. </b>|| 880-1823-037726</span></center>
                                </div>
                            </div>
                        </div>
                        <input type="button" onclick="printDiv('printableArea')" value="print" />
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

            $(function () {
                $('#select2Form')
                        .find('[name="cus_name"]')
                        .select2();
            });

            $(function () {
                $("#customer_payment_date").datepicker({
                    dateFormat: "dd-mm-yy",
                    maxDate: 0
                });
            });

            $(function () {
                $(".check_data").fadeIn("slow");
            });

            $(function () {
                $('#cus_name').bind('change', function () {
                    var url = $(this).val();
                    if (url) {
                        window.location = "/Tailor/admin/customer_payment_statement.jsp?" + "customer_id=" + url; // redirect
                    }
                    return false;
                });
            });

        </script>

        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->

        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>  

    </body>
</html>
