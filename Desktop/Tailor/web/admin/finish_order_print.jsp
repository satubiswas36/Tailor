
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URL"%>
<%@page import="com.satu.service.NumberConvertToWord"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Blob"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.</title>
        <link href="assets/css/bootstrap.css" rel="stylesheet" type="text/css"/>
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
        <div id="printableArea">
            <%
                String com_id = (String) session.getAttribute("user_com_id");
                String bran_id = (String) session.getAttribute("user_bran_id");
                String d_date = request.getParameter("ddate");
                String user_id = null;
                String bran_idd = null;
                String user_name = null;

                // buttoner pase ok lekha gulo remove kora 
                session.removeAttribute("srt_msg");
                session.removeAttribute("pnt_msg");
                session.removeAttribute("blz_msg");
                session.removeAttribute("pht_msg");
                session.removeAttribute("pnjb_msg");
                session.removeAttribute("pjma_msg");
                session.removeAttribute("safari_msg");
                session.removeAttribute("mojib_cort_msg");
                session.removeAttribute("kable_msg");
                session.removeAttribute("koti_msg");


            %>
            <%                String customer_name = null;
                String cus_id = null;
                try {
                    String sql_cus_name = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + session.getAttribute("order_id") + "' ";
                    PreparedStatement pst_cus_name = DbConnection.getConn(sql_cus_name);
                    ResultSet rs_cus_name = pst_cus_name.executeQuery();
                    if (rs_cus_name.next()) {
                        cus_id = rs_cus_name.getString("ord_cutomer_id");
                        String sql_cus_mobile = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + cus_id + "' ";
                        PreparedStatement pst_cus_n = DbConnection.getConn(sql_cus_mobile);
                        ResultSet rs_cus_mobile = pst_cus_n.executeQuery();
                        if (rs_cus_mobile.next()) {
                            customer_name = rs_cus_mobile.getString("cus_name");
                        }
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <%
                // customer mobile 
                String customer_mobile = null;
                String message_time = null;
                try {
                    String sql_cus_id = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + session.getAttribute("order_id") + "' ";
                    PreparedStatement pst_cus_id = DbConnection.getConn(sql_cus_id);
                    ResultSet rs_cus_id = pst_cus_id.executeQuery();
                    if (rs_cus_id.next()) {
                        String cusb = rs_cus_id.getString("ord_cutomer_id");
                        String sql_cus_mobile = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + cusb + "' ";
                        PreparedStatement pst_cus_mobile = DbConnection.getConn(sql_cus_mobile);
                        ResultSet rs_cus_mobile = pst_cus_mobile.executeQuery();
                        if (rs_cus_mobile.next()) {
                            customer_mobile = rs_cus_mobile.getString("cus_mobile");
                            //message_time = rs_cus_mobile.getString("cus_message_time");
                        }
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <%
                //-----------------------------------------------------------customer due------------------------------------------------------------------------
                double total_debit = 0;
                double total_credit = 0;
                double balance = 0;
                double sell_qty = 0;
                //String user_name = null;

                // for debit 
                PreparedStatement pst_debit = null;
                ResultSet rs_debit = null;
                try {
                    String sql_debit = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + cus_id + "' and (pro_deal_type = 5 or pro_deal_type = 1 or pro_deal_type = 4 or pro_deal_type = 6)";
                    pst_debit = DbConnection.getConn(sql_debit);
                    rs_debit = pst_debit.executeQuery();
                    while (rs_debit.next()) {
                        String debit = rs_debit.getString("pro_sell_price");
                        sell_qty = Double.parseDouble(rs_debit.getString("pro_sell_quantity"));
                        String credit = rs_debit.getString("pro_sell_paid");
                        total_debit += (Double.parseDouble(debit) * sell_qty);
                        total_credit += Double.parseDouble(credit);
                    }
                    balance = total_debit - total_credit;
                } catch (Exception e) {
                    out.println(e.toString());
                }
                //-----------------------------------------------------------//customer due------------------------------------------------------------------------
                // --------------------  customer details ----------------------------------------------

                try {
                    String sql_customer_details = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + cus_id + "' ";
                    PreparedStatement pst_customer_details = DbConnection.getConn(sql_customer_details);
                    ResultSet rs_customer_details = pst_customer_details.executeQuery();
                    if (rs_customer_details.next()) {

                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
                //---------------------//customer details ----------------------------------------------
            %>
            <!--         change order status-->
            <%            String sql_order_status = "update ad_order set ord_status = 2, ord_delivery_date = '" + d_date + "' where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + session.getAttribute("order_id") + "' ";
                PreparedStatement pst_order_status = DbConnection.getConn(sql_order_status);
                pst_order_status.execute();
            %>
            <div class="container">
                <center>
                    <%                    // branch image
                        String b64 = null;
                        String bran_name = null;
                        String bran_address = null;
                        String bran_phone = null;
                        String bran_email = null;
                        String bran_mobile = null;
                        String bran_web = null;
                        String bran_logo = null;
                        String bran_sender_id = null;
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
                                bran_phone = rs_img.getString("bran_phone");
                                bran_email = rs_img.getString("bran_email");
                                bran_mobile = rs_img.getString("bran_mobile");
                                bran_web = rs_img.getString("bran_website");
                                bran_logo = rs_img.getString("bran_com_logo");
                                bran_sender_id = rs_img.getString("bran_sender_id");
                                message_time = rs_img.getString("bran_message_time");
                            }
                        } catch (Exception e) {
                            out.println("show_last_invoice branch image " + e.toString());
                        }
                    %>
                    <!--                    current date -->
                    <%
                        String r_date = null;
                        //                        Calendar cl = Calendar.getInstance();
                        //                        int year = cl.get(Calendar.YEAR);
                        //                        int month = cl.get(Calendar.MONTH) + 1;
                        //                        int day = cl.get(Calendar.DATE);
                        //                        String r_date = year + "-" + month + "-" + day;

                        try {
                            String receive_date = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + session.getAttribute("order_id") + "' ";
                            PreparedStatement pst_ddate = DbConnection.getConn(receive_date);
                            ResultSet rs_rdate = pst_ddate.executeQuery();
                            if (rs_rdate.next()) {
                                r_date = rs_rdate.getString("ord_receive_date");
                                // receive date format
                                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                Date re_date = simpleDateFormat.parse(r_date);
                                SimpleDateFormat sd = new SimpleDateFormat("dd-MM-yyyy");
                                r_date = sd.format(re_date);
                            }
                        } catch (Exception e) {
                            out.println(e.toString());
                        }
                    %>                    
                </center>
                <%
                    // user id
                    try {
                        String sql_user_bran_id = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and (pro_buy_quantity = 0 and pro_sell_price != 0) and pro_deal_type = 5";
                        PreparedStatement pst_user_bran_id = DbConnection.getConn(sql_user_bran_id);
                        ResultSet rs_user_bran_id = pst_user_bran_id.executeQuery();
                        if (rs_user_bran_id.next()) {
                            user_id = rs_user_bran_id.getString("pro_user_id");
                            bran_idd = rs_user_bran_id.getString("pro_bran_id");
                        }
                    } catch (Exception e) {
                        out.println("user id " + e.toString());
                    }
                    // user name                         

                    try {
                        String sql_user = "select * from user_user where user_bran_id = '" + session.getAttribute("user_bran_id") + "' and user_id = '" + user_id + "' ";
                        PreparedStatement pst_user = DbConnection.getConn(sql_user);
                        ResultSet rs_user = pst_user.executeQuery();
                        if (rs_user.next()) {
                            user_name = rs_user.getString("user_name");
                        } else {
                            // branch name 
                            try {
                                String sql_branch = "select * from user_branch where bran_id = '" + bran_idd + "' ";
                                PreparedStatement pst_branch = DbConnection.getConn(sql_branch);
                                ResultSet rs_branch = pst_branch.executeQuery();
                                if (rs_branch.next()) {
                                    user_name = rs_branch.getString("bran_name");
                                }
                            } catch (Exception e) {
                                out.println("Branch name " + e.toString());
                            }
                        }
                    } catch (Exception e) {
                        out.println("user name " + e.toString());
                    }

                %>
                <div class="row">
                    <div class="col-md-2 col-sm-2 col-xs-2" style="">
                        <img src="../images/<%=bran_logo%>" alt="" style="width: 50px; height: 50px; margin-top: 5px;" class="img-rounded"/>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6" style="">
                        <table class="center-block">
                            <tr>
                            <center><h3 style="margin: 0px; padding: 0px"><%=bran_name%></h3></center>
                            </tr>
                            <tr>
                            <center><%=bran_address%></center>
                            </tr>
                            <tr>
                            <center><%=bran_email + " || " + bran_web%></center>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-4 col-sm-4 col-xs-4">
                        <table class="pull-right" style="margin-top: 5px;">
                            <tr>
                                <td>Mob : <%=bran_mobile%></td>
                            </tr>
                            <tr>
                                <td>Ph : <%=bran_phone%></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <table class="table-responsive" style="border: none; margin: 0px">                                      

                </table>
                <div class="row">
                    <div class="col-md-5 col-sm-5 col-xs-5">
                        <table>
                            <tr>
                                <td>Name : <%=customer_name%></td>
                            </tr>
                            <tr>
                                <td>Mobile : <%=customer_mobile%></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-4 col-sm-4 col-xs-4">
                        <table>
                            <tr>
                                <td>R Date : <%=r_date%></td>
                            </tr>
                            <tr>
                                <td>D Date : <%=d_date%></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-3 col-sm-3 col-xs-3 pull-right">
                        <table class="pull-right">
                            <tr>
                                <td class="pull-right">Order No : <%=session.getAttribute("order_id")%></td>
                            </tr>
                            <tr>
                                <td>Receiver : <%=user_name%></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div>
                    <table class="table table-bordered table-inverse" style="margin: 0px;">
                        <thead>
                            <tr>
                                <th style="text-align: center; width: 8%;">SL</th>
                                <th style="text-align: left">Product Name</th>
                                <th style="text-align: center; width: 10%;">Quantity</th>
                                <th style="text-align: right; width: 15%;">Price</th>
                                <th style="text-align: right; width: 20%;">Total Price</th>
                                <th style="text-align: center; width: 30%">Sample</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int id = 1;
                                int total_price = 0;
                            %>
                            <!-----------------------------------------------------------------------     shirt   ---------------------------------------------------------------------------------->
                            <%
                                try {

                                    int s_qty = 0;
                                    double s_price = 0;
                                    String sql_s = "select * from ser_shirt where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + session.getAttribute("order_id") + "' ";
                                    PreparedStatement pst_s = DbConnection.getConn(sql_s);
                                    ResultSet rs_s = pst_s.executeQuery();
                                    if (rs_s.next()) {
                                        s_qty = Integer.parseInt(rs_s.getString("qty"));
                                        String shit_long = rs_s.getString(6);


                            %>
                            <tr>
                                <td style="text-align: center"><%=id++%></td>
                                <td style="text-align: left"><%= "Shirt"%></td>
                                <td style="text-align: center"><%= s_qty%></td>


                                <%
                                    String sql_price = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                    PreparedStatement pst = DbConnection.getConn(sql_price);
                                    ResultSet rs_price = pst.executeQuery();
                                    while (rs_price.next()) {
                                        s_price = Double.parseDouble(rs_price.getString("prlist_shirt"));
                                    }
                                %>
                                <td style="text-align: right"><%= s_price + "0"%></td>
                                <% double shir_totalprice = s_price * s_qty;
                                    total_price += shir_totalprice;%>
                                <td style="text-align: right"><%= shir_totalprice + "0"%></td>
                            </tr>

                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("for shirt " + e.toString());
                                }
                            %>
                            <!-- --------------------------------------------------------////shirt------------------------------------------------------------------------------------------------------------------------>
                            <!-- --------------------------------------------------------pant------------------------------------------------------------------------------------------------------------------------>
                            <%
                                int pant_qty = 0;
                                double pant_price = 0;
                                String sql_pant = "select * from ser_pant where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + session.getAttribute("order_id") + "' ";
                                PreparedStatement pst_pant = DbConnection.getConn(sql_pant);
                                ResultSet rs_pant = pst_pant.executeQuery();
                                if (rs_pant.next()) {
                                    pant_qty = Integer.parseInt(rs_pant.getString(23));
                            %>
                            <tr>
                                <td style="text-align: center"><%= id++%></td>
                                <td style="text-align: left"><%= "Pant"%></td>
                                <td style="text-align: center"><%= pant_qty%></td>

                                <%
                                    String sql_price = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                    PreparedStatement pst = DbConnection.getConn(sql_price);
                                    ResultSet rs_price = pst.executeQuery();
                                    while (rs_price.next()) {
                                        pant_price = Double.parseDouble(rs_price.getString("prlist_pant"));
                                    }
                                %>
                                <td style="text-align: right"><%= pant_price + "0"%></td>
                                <% double pant_totalprice = pant_price * pant_qty;
                                    total_price += pant_totalprice;%>
                                <td style="text-align: right"><%= pant_totalprice + "0"%></td>
                            </tr>
                            <%
                                }
                            %>
                            <!------------------------------------------------------------------------------//// pant-------------------------------------------------------------------------------->
                            <!-----------------------------------------------------------------------------blazer-------------------------------------------------------------------------------->
                            <%
                                int blz_qty = 0;
                                double blz_price = 0;
                                String sql_blazer = "select * from ser_blazer where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + session.getAttribute("order_id") + "' ";
                                PreparedStatement pst_blz = DbConnection.getConn(sql_blazer);
                                ResultSet rs_blz = pst_blz.executeQuery();
                                if (rs_blz.next()) {
                                    blz_qty = Integer.parseInt(rs_blz.getString(20));
                            %>
                            <tr>
                                <td style="text-align: center"><%= id++%></td>
                                <td style="text-align: left"><%= "Blazer"%></td>
                                <td style="text-align: center"><%= blz_qty%></td>

                                <%
                                    String sql_price = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                    PreparedStatement pst = DbConnection.getConn(sql_price);
                                    ResultSet rs_price = pst.executeQuery();
                                    while (rs_price.next()) {
                                        blz_price = Double.parseDouble(rs_price.getString("prlist_blazer"));
                                    }
                                %>
                                <td style="text-align: right"><%= blz_price + "0"%></td>
                                <% double blz_totalprice = blz_price * blz_qty;
                                    total_price += blz_totalprice;%>
                                <td style="text-align: right"><%= blz_totalprice + "0"%></td>
                            </tr>
                            <%
                                }
                            %>

                            <!-----------------------------------------------------------------------------photua-------------------------------------------------------------------------------->
                            <%
                                int pht_qty = 0;
                                double pht_price = 0;
                                String sql_pht = "select * from ser_photua where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + session.getAttribute("order_id") + "' ";
                                PreparedStatement pst_pht = DbConnection.getConn(sql_pht);
                                ResultSet rs_pht = pst_pht.executeQuery();
                                if (rs_pht.next()) {
                                    pht_qty = Integer.parseInt(rs_pht.getString(24));
                            %>
                            <tr>
                                <td style="text-align: center"><%= id++%></td>
                                <td style="text-align: left"><%= "Photua"%></td>
                                <td style="text-align: center"><%= pht_qty%></td>

                                <%
                                    String sql_price = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                    PreparedStatement pst = DbConnection.getConn(sql_price);
                                    ResultSet rs_price = pst.executeQuery();
                                    while (rs_price.next()) {
                                        pht_price = Double.parseDouble(rs_price.getString("prlist_photua"));
                                    }
                                %>
                                <td style="text-align: right"><%= pht_price + "0"%></td>
                                <% double pht_totalprice = pht_price * pht_qty;
                                    total_price += pht_totalprice;%>
                                <td style="text-align: right"><%= pht_totalprice + "0"%></td>
                            </tr>
                            <%
                                }

                            %>
                            <!-----------------------------------------------------------------------------////photua-------------------------------------------------------------------------------->
                            <!-----------------------------------------------------------------------------panjabi-------------------------------------------------------------------------------->
                            <%                                int pnjb_qty = 0;
                                double pnjb_price = 0;
                                String sql_pnjb = "select * from ser_panjabi where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + session.getAttribute("order_id") + "' ";
                                PreparedStatement pst_pnjb = DbConnection.getConn(sql_pnjb);
                                ResultSet rs_pnjb = pst_pnjb.executeQuery();
                                if (rs_pnjb.next()) {
                                    pnjb_qty = Integer.parseInt(rs_pnjb.getString("qty"));
                            %>
                            <tr>
                                <td style="text-align: center"><%= id++%></td>
                                <td style="text-align: left"><%= "Panjabi"%></td>
                                <td style="text-align: center"><%= pnjb_qty%></td>

                                <%
                                    String sql_price = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                    PreparedStatement pst = DbConnection.getConn(sql_price);
                                    ResultSet rs_price = pst.executeQuery();
                                    while (rs_price.next()) {
                                        pnjb_price = Double.parseDouble(rs_price.getString("prlist_panjabi"));
                                    }
                                %>
                                <td style="text-align: right"><%= pnjb_price + "0"%></td>
                                <% double pnjb_totalprice = pnjb_price * pnjb_qty;
                                    total_price += pnjb_totalprice;%>
                                <td style="text-align: right"><%= pnjb_totalprice + "0"%></td>
                            </tr>
                            <%
                                }

                            %>
                            <!-----------------------------------------------------------------------------////panjabi-------------------------------------------------------------------------------->
                            <!-----------------------------------------------------------------------------payjama-------------------------------------------------------------------------------->
                            <%                                int pjma_qty = 0;
                                double pjma_price = 0;
                                String sql_pjma = "select * from ser_payjama where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + session.getAttribute("order_id") + "' ";
                                PreparedStatement pst_pjma = DbConnection.getConn(sql_pjma);
                                ResultSet rs_pjma = pst_pjma.executeQuery();
                                if (rs_pjma.next()) {
                                    pjma_qty = Integer.parseInt(rs_pjma.getString("qty"));
                            %>
                            <tr>
                                <td style="text-align: center"><%= id++%></td>
                                <td style="text-align: left"><%= "Payjama"%></td>
                                <td style="text-align: center"><%= pjma_qty%></td>

                                <%
                                    String sql_price = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                    PreparedStatement pst = DbConnection.getConn(sql_price);
                                    ResultSet rs_price = pst.executeQuery();
                                    while (rs_price.next()) {
                                        pjma_price = Double.parseDouble(rs_price.getString("prlist_payjama"));
                                    }
                                %>
                                <td style="text-align: right"><%= pjma_price + "0"%></td>
                                <% double pjma_totalprice = pjma_price * pjma_qty;
                                    total_price += pjma_totalprice;%>
                                <td style="text-align: right"><%= pjma_totalprice + "0"%></td>
                            </tr>
                            <%
                                }
                            %>
                            <!-----------------------------------------------------------------------------////payjama-------------------------------------------------------------------------------->
                            <!-----------------------------------------------------------------------------safari-------------------------------------------------------------------------------->
                            <%
                                int sfr_qty = 0;
                                double sfr_price = 0;
                                String sql_sfr = "select * from ser_safari where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + session.getAttribute("order_id") + "' ";
                                PreparedStatement pst_sfr = DbConnection.getConn(sql_sfr);
                                ResultSet rs_sfr = pst_sfr.executeQuery();
                                if (rs_sfr.next()) {
                                    sfr_qty = Integer.parseInt(rs_sfr.getString("qty"));
                            %>
                            <tr>
                                <td style="text-align: center"><%= id++%></td>
                                <td style="text-align: left"><%= "Safari"%></td>
                                <td style="text-align: center"><%=sfr_qty%></td>

                                <%
                                    String sql_price = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                    PreparedStatement pst = DbConnection.getConn(sql_price);
                                    ResultSet rs_price = pst.executeQuery();
                                    while (rs_price.next()) {
                                        sfr_price = Double.parseDouble(rs_price.getString("prlist_safari"));
                                    }
                                %>
                                <td style="text-align: right"><%= sfr_price + "0"%></td>
                                <% double sfr_totalprice = sfr_price * sfr_qty;
                                    total_price += sfr_totalprice;%>
                                <td style="text-align: right"><%= sfr_totalprice + "0"%></td>
                            </tr>
                            <%
                                }
                            %>
                            <!-----------------------------------------------------------------------------////safari-------------------------------------------------------------------------------->
                            <!-----------------------------------------------------------------------------mojib cort-------------------------------------------------------------------------------->
                            <%
                                int mjc_qty = 0;
                                double mjc_price = 0;
                                String sql_mjc = "select * from ser_mojib_cort where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + session.getAttribute("order_id") + "' ";
                                PreparedStatement pst_mjc = DbConnection.getConn(sql_mjc);
                                ResultSet rs_mjc = pst_mjc.executeQuery();
                                if (rs_mjc.next()) {
                                    mjc_qty = Integer.parseInt(rs_mjc.getString("qty"));
                            %>
                            <tr>
                                <td style="text-align: center"><%= id++%></td>
                                <td style="text-align: left"><%= "Mojib Cort"%></td>
                                <td style="text-align: center"><%=mjc_qty%></td>

                                <%
                                    String sql_price = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                    PreparedStatement pst = DbConnection.getConn(sql_price);
                                    ResultSet rs_price = pst.executeQuery();
                                    while (rs_price.next()) {
                                        mjc_price = Double.parseDouble(rs_price.getString("prlist_mojib_cort"));
                                    }
                                %>
                                <td style="text-align: right"><%= mjc_price + "0"%></td>
                                <% double mjc_totalprice = mjc_price * mjc_qty;
                                    total_price += mjc_totalprice;%>
                                <td style="text-align: right"><%= mjc_totalprice + "0"%></td>
                            </tr>
                            <%
                                }
                            %>
                            <!-----------------------------------------------------------------------------////mojib cort-------------------------------------------------------------------------------->
                            <!-----------------------------------------------------------------------------kable-------------------------------------------------------------------------------->
                            <%
                                int kbl_qty = 0;
                                double kbl_price = 0;
                                String sql_kbl = "select * from ser_kable where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + session.getAttribute("order_id") + "' ";
                                PreparedStatement pst_kbl = DbConnection.getConn(sql_kbl);
                                ResultSet rs_kbl = pst_kbl.executeQuery();
                                if (rs_kbl.next()) {
                                    kbl_qty = Integer.parseInt(rs_kbl.getString("qty"));
                            %>
                            <tr>
                                <td style="text-align: center"><%= id++%></td>
                                <td style="text-align: left"><%= "Kable"%></td>
                                <td style="text-align: center"><%=kbl_qty%></td>

                                <%
                                    String sql_price = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                    PreparedStatement pst = DbConnection.getConn(sql_price);
                                    ResultSet rs_price = pst.executeQuery();
                                    while (rs_price.next()) {
                                        kbl_price = Double.parseDouble(rs_price.getString("prlist_kable"));
                                    }
                                %>
                                <td style="text-align: right"><%= kbl_price + "0"%></td>
                                <% double kbl_totalprice = kbl_price * kbl_qty;
                                    total_price += kbl_totalprice;%>
                                <td style="text-align: right"><%= kbl_totalprice + "0"%></td>
                            </tr>
                            <%
                                }
                            %>
                            <!-----------------------------------------------------------------------------////kable-------------------------------------------------------------------------------->
                            <!-----------------------------------------------------------------------------koti-------------------------------------------------------------------------------->
                            <%
                                int kt_qty = 0;
                                double kt_price = 0;
                                String sql_kt = "select * from ser_koti where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + session.getAttribute("order_id") + "' ";
                                PreparedStatement pst_kt = DbConnection.getConn(sql_kt);
                                ResultSet rs_kt = pst_kt.executeQuery();
                                if (rs_kt.next()) {
                                    kt_qty = Integer.parseInt(rs_kt.getString("qty"));
                            %>
                            <tr>
                                <td style="text-align: center"><%= id++%></td>
                                <td style="text-align: left"><%= "Koti"%></td>
                                <td style="text-align: center"><%=kt_qty%></td>

                                <%
                                    String sql_price = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                    PreparedStatement pst = DbConnection.getConn(sql_price);
                                    ResultSet rs_price = pst.executeQuery();
                                    while (rs_price.next()) {
                                        kt_price = Double.parseDouble(rs_price.getString("prlist_koti"));
                                    }
                                %>
                                <td style="text-align: right"><%= kt_price + "0"%></td>
                                <% double kt_totalprice = kt_price * kt_qty;
                                    total_price += kt_totalprice;%>
                                <td style="text-align: right"><%= kt_totalprice + "0"%></td>
                            </tr>                              
                            <%
                                }
                            %>
                            <!-----------------------------------------------------------------------------////kable-------------------------------------------------------------------------------->
                            <tr>
                                <td style="text-align: center"><%=id++%></td>                            
                                <td colspan="3" style="text-align: right"><b>Total :</b></td>
                                <td style="text-align: right"><b><%=total_price + " Tk."%></b></td>
                            </tr>
                            <tr>
                                <td style="text-align: center"><%=id++%></td>
                                <%String wrd = new NumberConvertToWord().convert(total_price);%>
                                <td colspan="3">Total in word : <i><%=wrd + " tk only"%></i></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-xs-6 pull-left">
                            <p style="margin-top: 12px; padding-top: 12px; text-decoration: overline">Signature by</p>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-6 pull-left" style="margin-top: 5px;">
                            <b>Total due : <%=balance + "0 tk"%></b>
                        </div>
                    </div>                    
                    <center>                        
                        <span style="margin: 0px;">Power By : <b>IGL Web™ Ltd.</b> || 880-1823-037726</span>
                    </center>
                </div>
            </div>            
        </div>
        <input type="button" onclick="printDiv('printableArea')" value="print" style="margin-left: 2%;"/>
        <script>
            function printDiv(divName) {
                var printContents = document.getElementById(divName).innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
            }
        </script>
        <%
            String message_sent = null;
            if (session.getAttribute("order_id").equals(session.getAttribute("already_message_sent"))) {

            } else {
                // for sending message
                // firstly check order_create time message send korar permission ace naki
                if (message_time != null) {
                    if (message_time.contains("order_create")) {
                        String initMsg = "Your order id " + session.getAttribute("order_id") + " is successfully created. Total Due " + balance + "0tk" + ". Please contact for more details " + bran_mobile + " " + bran_name + "";
                        String finalMsg = initMsg.replace(" ", "%20");
                        String msg_url = "http://sms.iglweb.com/smsapi?api_key=C200008259ec2e6ec8f768.04047558&type=text&contacts=" + customer_mobile + "&senderid=" + bran_sender_id + "&msg=" + finalMsg;
                        URL oracle = new URL(msg_url);
                        BufferedReader in = new BufferedReader(new InputStreamReader(oracle.openStream()));
                        String inputLine;
                        while ((inputLine = in.readLine()) != null) {
                            message_sent = inputLine;
                            out.println(inputLine);
                        }
                        in.close();
                        session.setAttribute("already_message_sent", session.getAttribute("order_id"));
                    }
                }
            }
            if (message_sent != null) {
                if (message_sent.length() > 4) {
                    // for message count
                    try {
                        String sql_msg_count = "select * from msg_table where msg_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                        PreparedStatement pst_msg_count = DbConnection.getConn(sql_msg_count);
                        ResultSet rs_msg_count = pst_msg_count.executeQuery();
                        if (rs_msg_count.next()) {
                            int msg_qty = Integer.parseInt(rs_msg_count.getString("msg_qty"));
                            msg_qty++;
                            try {
                                String sql_msg_update = "update msg_table set msg_qty = '" + msg_qty + "' where msg_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                PreparedStatement pst_msg_update = DbConnection.getConn(sql_msg_update);
                                pst_msg_update.executeUpdate();
                            } catch (Exception e) {
                                out.println(e.toString());
                            }
                        } else {
                            try {
                                String sql_msg_insert = "insert into msg_table values(?,?,?,?)";
                                PreparedStatement pst_msg_insert = DbConnection.getConn(sql_msg_insert);
                                pst_msg_insert.setString(1, null);
                                pst_msg_insert.setString(2, (String) session.getAttribute("user_com_id"));
                                pst_msg_insert.setString(3, (String) session.getAttribute("user_bran_id"));
                                pst_msg_insert.setString(4, "1");
                                pst_msg_insert.executeUpdate();
                            } catch (Exception e) {
                                out.println(e.toString());
                            }
                        }
                    } catch (Exception e) {
                        out.println(e.toString());
                    }
                }
            }
        %>

    </body>
</html>
