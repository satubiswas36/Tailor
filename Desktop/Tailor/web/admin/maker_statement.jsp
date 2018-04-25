<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
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
        <link href="/Tailor/admin/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
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
        <!--      for time picker-->
        <link href="../admin/assets/css/timedropper.css" rel="stylesheet" type="text/css"/>
        <script src="../admin/assets/js/timedropper.js" type="text/javascript"></script>
        <!--    <script src="../admin/assets/js/jquery.js" type="text/javascript"></script>-->

        <style>
            .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
                padding: 2px;
                line-height: 1.42857143;
                vertical-align: top;
                border-top: 1px solid #ddd;
                font-size: 14px;
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
                    font-size: 18px;
                }
                /* ... the rest of the rules ... */
            }
        </style>
    </head>
    <body>
        <div id="wrapper">              
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=maker"/>
            <!-- /. NAV SIDE  -->
            <%
                String mkr_name = request.getParameter("mk_nam");

                // first date of current month
                String maker_name_for_id = null;
                Calendar first_date = Calendar.getInstance();
                first_date.set(Calendar.DAY_OF_MONTH, 1);
                Date dt = first_date.getTime();
                SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
                String dddd = sd.format(dt);
                //last date of month
                Calendar c = Calendar.getInstance();
                c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
                Date dtlast = c.getTime();
                String last_date = sd.format(dtlast);

                // product making cost 
//                double shirt_price = 0;
//                double pant_price = 0;
//                double blazer_price = 0;
//                double photua_price = 0;
//                double panjabi_price = 0;
//                double payjama_price = 0;
//                double safari_price = 0;
                try {
                    String sql_product_cost = "select * from worker_salary where ws_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                    PreparedStatement pst_produc_cost = DbConnection.getConn(sql_product_cost);
                    ResultSet rs_product_cost = pst_produc_cost.executeQuery();
                    while (rs_product_cost.next()) {
//                        shirt_price = Double.parseDouble(rs_product_cost.getString("ws_shirt"));
//                        pant_price = Double.parseDouble(rs_product_cost.getString("ws_pant"));
//                        blazer_price = Double.parseDouble(rs_product_cost.getString("ws_blazer"));
//                        photua_price = Double.parseDouble(rs_product_cost.getString("ws_photua"));
//                        panjabi_price = Double.parseDouble(rs_product_cost.getString("ws_panjabi"));
//                        payjama_price = Double.parseDouble(rs_product_cost.getString("ws_payjama"));
//                        safari_price = Double.parseDouble(rs_product_cost.getString("ws_safari"));

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
                                <%
                                    String from_date = request.getParameter("from_date");
                                    String to_date = request.getParameter("to_date");
                                    String m_name = request.getParameter("mk_name");
                                    if (mkr_name != null) {
                                        m_name = mkr_name;
                                    }
                                    if (from_date == null && to_date == null) {
                                        from_date = dddd;
                                        to_date = last_date;
                                    }
                                %>
                                <%
                                    try {
                                        String sql_maker_name = "select * from maker where mk_name= '" + m_name + "' and mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                        PreparedStatement pst_maker_name = DbConnection.getConn(sql_maker_name);
                                        ResultSet rs_maker_name = pst_maker_name.executeQuery();
                                        if (rs_maker_name.next()) {
                                            maker_name_for_id = rs_maker_name.getString("mk_slno");
                                        }
                                    } catch (Exception e) {
                                        out.println(e.toString());
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
                                <div class="pull-right">
                                    <form method="post">
                                        <table>
                                            <tr>
                                                <td><input type="text" name="mk_name" value="<%=m_name%>" readonly="" style="display: none"/></td>
                                                <td>From<input type="text" name="from_date" value="<%=from_date%>" id="from_date" style="padding-left: 5px; font-size: 14px;"/></td>
                                                <td> To<input type="text" name="to_date" value="<%=to_date%>" id="to_date" style="padding-left: 5px; font-size: 14px;" /></td>
                                                <td><input type="submit" value="Submit" /></td>
                                            </tr>
                                        </table>
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
                                    <table class="table table-bordered" style="width: 100%;" id="recTable">
                                        <span><%= "Maker Name : <b>" + m_name + ".</b> From "%></span>
                                        <span><%=from_date%></span>
                                        <span><%=" to "+to_date%></span>
                                        <thead>
                                            <th style="text-align: center; width: 5%;">SL</th>
                                            <th style="text-align: center; width: 13%;">Date</th>
                                            <th style="text-align: left">Description</th>
                                            <th style="text-align: right; width: 12%;">Debit</th>
                                            <th style="text-align: right; width: 12%;">Credit</th>
                                            <th style="text-align: right; width: 12%">Balance</th>
                                        </thead>
                                        <%
                                            String product_name = null;
                                            String description = null;
                                            int sl = 1;

                                            double debit = 0;
                                            double credit = 0;
                                            double total_debit = 0;
                                            double total_credit = 0;
                                            double balance = 0;
                                            double p_qty = 0;
                                            double bb = 0;
                                            try {
                                                // for debit (cost) 
                                                String prdct_name = null;
                                                String sql_maker_statement = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + maker_name_for_id + "' and pro_deal_type = 2 and ( pro_entry_date  >= '" + from_date + "' and pro_entry_date <= '" + to_date + "')";
                                                PreparedStatement pst_maker_statement = DbConnection.getConn(sql_maker_statement);
                                                ResultSet rs_maker_statement = pst_maker_statement.executeQuery();
                                                while (rs_maker_statement.next()) {
                                                    String product = rs_maker_statement.getString("pro_product_id");
                                                    if (product.equals("1")) {
                                                        prdct_name = "shirt";
                                                    }
                                                    if (product.equals("2")) {
                                                        prdct_name = "pant";
                                                    }
                                                    if (product.equals("3")) {
                                                        prdct_name = "blazer";
                                                    }
                                                    if (product.equals("4")) {
                                                        prdct_name = "photua";
                                                    }
                                                    if (product.equals("5")) {
                                                        prdct_name = "panjabi";
                                                    }
                                                    if (product.equals("6")) {
                                                        prdct_name = "payjama";
                                                    }
                                                    if (product.equals("7")) {
                                                        prdct_name = "safari";
                                                    }
                                                    if(product.equals("8")){
                                                        prdct_name = "mojib cort";
                                                    }
                                                    if(product.equals("9")){
                                                        prdct_name = "kable";
                                                    }
                                                    if(product.equals("10")){
                                                        prdct_name = "koti";
                                                    }
                                                    String product_qty = rs_maker_statement.getString("pro_buy_quantity");
                                                    p_qty = Double.parseDouble(product_qty);
                                                    String date = rs_maker_statement.getString("pro_entry_date");
                                                    String Debit = rs_maker_statement.getString("pro_buy_price");
                                                    String Credit = rs_maker_statement.getString("pro_buy_paid");
                                                    if (Credit.equals("0")) {
                                                        description = "Prodcut : " + prdct_name + " Qty : " + product_qty;
                                                    } else if (Debit.equals("0")) {
                                                        description = "payment paid";
                                                    }

                                                    debit = Double.parseDouble(Debit);
                                                    total_debit += (debit * p_qty);
                                                    bb = (debit * p_qty);
                                                    credit = Double.parseDouble(Credit);

                                                    total_credit += credit;
                                                    balance += bb;
                                                    balance -= credit;
                                        %>
                                        <tr>
                                            <td style="text-align: center;"><%=sl++%></td>
                                            <td style="text-align: center"><%=date%></td>
                                            <td style="height: 1px;"><%=description%></td>                                                      
                                            <td style="text-align: right;"><%if (credit == 0) {%><% } else {%><%=credit + "0"%><%} %></td>

                                            <td style="text-align: right;"><%if (bb == 0) {%><% } else {%><%=debit * p_qty + "0"%><%}%></td>
                                            <td style="text-align: right;"><%=balance + "0"%></td>
                                        </tr>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                out.println(e.toString());
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
                                                out.println(e.toString());
                                            }
                                        %>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right"><b>Total Bonus : <%=maker_bonus + "0"%></b></td>
                                            <td style="text-align: right"><b><%= total_credit + "0"%></b></td>
                                            <td style="text-align: right"><b><%=total_debit + "0"%></b></td>                                            
                                            <td style="text-align: right"><b><%=balance + "0"%></b></td>
                                        </tr>
                                    </table>
                                    <center> <span>Power By : <b>IGL Web™ Ltd. </b>|| 880-1823-037726</span></center>
                                </div>
                                <input type="button" onclick="printDiv('printableArea')" value="print" />
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
        </script>
        <!--            <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <!--        <script type="text/javascript">
                    function googleTranslateElementInit() {
                        new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
                    }
                </script>-->
        <!--        <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>-->
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
