
<%@page import="java.sql.Blob"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%
    String logger = (String) session.getAttribute("logger");
    String branch_id = (String) session.getAttribute("user_bran_id");
    String last_status = null;
    String sl_no = null;
%>

<%
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
            <jsp:include page="../menu/menu.jsp?page_name=account" flush="true"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <%
                            String invoice = request.getParameter("invoice_id");
                            String suppler = request.getParameter("supplier");
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
                                <span style="font-size: 18px;"> Supplier Name : <%=suppler%> , Invoice ID : <%=invoice%> (buy statement)</span>

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
                                        <span style="font-size: 15px;"> Supplier Name : <%=suppler%> , Invoice ID : <%=invoice%> </span>
                                        <table class="table table-bordered" style="width: 100%;" id="recTable">
                                            <thead>
                                                <th style="text-align: center; width: 5%">SL</th>
                                                <th style="text-align: center">Date</th>
                                                <th style="text-align: left">Product Name</th>
                                                <th style="text-align: left">Description</th>
                                                <th style="text-align: center; width: 4%;">Qty</th>
                                                <th style="text-align: right; width: 10%;">Price</th>
                                                <th style="text-align: right; width: 12%;">Total Amount</th>
                                            </thead>
                                            <tbody>
                                                <%
                                                    int sl = 1;
                                                    String product_name = null;
                                                    String product_description = null;
                                                    double total_amount = 0;
                                                    try {
                                                        String sql_invoice = "select * from inventory_details where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + invoice + "' and pro_deal_type = 3 ";
                                                        PreparedStatement pst_invoice = DbConnection.getConn(sql_invoice);
                                                        ResultSet rs_invoice = pst_invoice.executeQuery();
                                                        while (rs_invoice.next()) {
                                                            String product_id = rs_invoice.getString("pro_product_id");
                                                            // product name by prodcut id
                                                            String sql_product_name = "select * from inv_product_name where prn_slid = '" + product_id + "' ";
                                                            PreparedStatement pst_product_name = DbConnection.getConn(sql_product_name);
                                                            ResultSet rs_product_name = pst_product_name.executeQuery();
                                                            if (rs_product_name.next()) {
                                                                product_name = rs_product_name.getString("prn_product_name");
                                                                product_description = rs_product_name.getString("prn_product_desc");
                                                            }
                                                            int qty = Integer.parseInt(rs_invoice.getString("pro_buy_quantity"));
                                                            double price = Double.parseDouble(rs_invoice.getString("pro_buy_price"));
                                                            total_amount += (qty * price);
                                                            String date = rs_invoice.getString("pro_entry_date");
                                                %>
                                                <tr>
                                                    <td style="text-align: center; width: 6%;"><%=sl++%></td>
                                                    <td style="text-align: center; width: 13%"><%=date%></td>
                                                    <td><%=product_name%></td>
                                                    <td><%=product_description%></td>
                                                    <td style="text-align: center"><%=qty%></td>
                                                    <td style="text-align: right"><%=price + "0"%></td>                                                
                                                    <td style="text-align: right"><%=(qty * price) + "0"%></td>                                            
                                                </tr>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td style="text-align: right"><b><%=total_amount + "0"%></b></td>
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
