
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String user_name = null;
            String com_id = (String) session.getAttribute("user_com_id");
            String bran_id = (String) session.getAttribute("user_bran_id");
            String user_id = (String) session.getAttribute("user_user_id");

            // branch mobile number
            String bran_mobile = null;
            String bran_name = null;
            String bran_sender_id = null;
            String message_time = null;
            try {
                String sql_bran_mobile = "select * from user_branch where bran_id = '" + bran_id + "' ";
                PreparedStatement pst_bran_mobile = DbConnection.getConn(sql_bran_mobile);
                ResultSet rs_bran_mobile = pst_bran_mobile.executeQuery();
                if (rs_bran_mobile.next()) {
                    bran_mobile = rs_bran_mobile.getString("bran_mobile");
                    bran_name = rs_bran_mobile.getString("bran_name");
                    bran_sender_id = rs_bran_mobile.getString("bran_sender_id");
                    message_time = rs_bran_mobile.getString("bran_message_time");
                }
            } catch (Exception e) {
                out.println(e.toString());
            }

            if (user_id == null) {
                user_name = "Branch";
                user_id = bran_id;
            } else {
                try {
                    String sql_user_name = "select * from user_user where user_bran_id = '" + session.getAttribute("user_bran_id") + "' and user_id = '" + user_id + "' ";
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
            // change maker_order_product_info table status
            String complete_order_id = request.getParameter("order_complete_order");
            String complete_product = request.getParameter("complete_product");
            String maker_name = request.getParameter("mk_name");
            String product_qty = request.getParameter("product_qty");
            double qty = Double.parseDouble(product_qty);
            double total_price = 0;

            // customer mobile number
            String customer_mobile = null;
            String customer_id = null;
            

           
            try {
                // customer id from ad_order table
                String sql_customer_id = "select ord_cutomer_id from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + complete_order_id + "' ";
                PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                ResultSet rs_customer_id = pst_customer_id.executeQuery();
                if (rs_customer_id.next()) {
                    customer_id = rs_customer_id.getString("ord_cutomer_id");
                }
            } catch (Exception e) {
                out.println(e.toString());
            }
            // customer mobile from customer table(customer mobile number necce karon ai number e sms pathata hobe)
            try {
                String sql_cus_mobile = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + customer_id + "' ";
                PreparedStatement pst_cus_mobile = DbConnection.getConn(sql_cus_mobile);
                ResultSet rs_cus_mobile = pst_cus_mobile.executeQuery();
                if (rs_cus_mobile.next()) {
                    customer_mobile = rs_cus_mobile.getString("cus_mobile");
                    //message_time = rs_cus_mobile.getString("cus_message_time");
                }
            } catch (Exception e) {
                out.println(e.toString());
            }

            //------------- customer due-----------------------------
            double balance = 0;
            double credit = 0;
            double debit = 0;
            double total_debit = 0;
            double total_credit = 0;
            double total_discount = 0;
            double sell_qty = 0;
            String acc_date_debit = null;
            //String user_name = null;
            String order_id = null;
            double total_for_one_inv = 0;
            String status = "";
            try {
                String sql_debit_customer = "select * from inventory_details where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_party_id = '" + customer_id + "' and (pro_deal_type = 5 or pro_deal_type = 1 or pro_deal_type = 4 or pro_deal_type = 6)";
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
                            String sql_total_balace = "select * from inventory_details where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + invoice_id + "' and pro_deal_type = 4";
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
                    balance = total_debit - total_credit;
                }
            } catch (Exception e) {
                out.println(e.toString());
            }
            //------------- customer due//-----------------------------

            //set product_invoice id 
            String product_invoice_id = null;

            // get maker id from maker table 
            String maker_id = null;
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

            // get product making cost from worker_salary table 
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
                String sql_product_making_cost = "select * from worker_salary where ws_bran_id = '" + bran_id + "'  ";
                PreparedStatement pst_pro_making_cost = DbConnection.getConn(sql_product_making_cost);
                ResultSet rs_pro_making_cost = pst_pro_making_cost.executeQuery();
                while (rs_pro_making_cost.next()) {
                    shirt_price = Double.parseDouble(rs_pro_making_cost.getString("ws_shirt"));
                    pant_price = Double.parseDouble(rs_pro_making_cost.getString("ws_pant"));
                    blazer_price = Double.parseDouble(rs_pro_making_cost.getString("ws_blazer"));
                    photua_price = Double.parseDouble(rs_pro_making_cost.getString("ws_photua"));
                    panjabi_price = Double.parseDouble(rs_pro_making_cost.getString("ws_panjabi"));
                    payjama_price = Double.parseDouble(rs_pro_making_cost.getString("ws_payjama"));
                    safari_price = Double.parseDouble(rs_pro_making_cost.getString("ws_safari"));
                    mojibcort_price = Double.parseDouble(rs_pro_making_cost.getString("ws_mojib_cort"));
                    kable_price = Double.parseDouble(rs_pro_making_cost.getString("ws_kable"));
                    koti_price = Double.parseDouble(rs_pro_making_cost.getString("ws_koti"));

                    if (complete_product.equals("shirt")) {
                        total_price = shirt_price;
                        product_invoice_id = "1";
                    }
                    if (complete_product.equals("pant")) {
                        total_price = pant_price;
                        product_invoice_id = "2";
                    }
                    if (complete_product.equals("blazer")) {
                        total_price = blazer_price;
                        product_invoice_id = "3";
                    }
                    if (complete_product.equals("photua")) {
                        total_price = photua_price;
                        product_invoice_id = "4";
                    }
                    if (complete_product.equals("panjabi")) {
                        total_price = panjabi_price;
                        product_invoice_id = "5";
                    }
                    if (complete_product.equals("payjama")) {
                        total_price = payjama_price;
                        product_invoice_id = "6";
                    }
                    if (complete_product.equals("safari")) {
                        total_price = safari_price;
                        product_invoice_id = "7";
                    }
                    if (complete_product.equals("mojib_cort")) {
                        total_price = mojibcort_price;
                        product_invoice_id = "8";
                    }
                    if (complete_product.equals("kable")) {
                        total_price = kable_price;
                        product_invoice_id = "9";
                    }
                    if (complete_product.equals("koti")) {
                        total_price = koti_price;
                        product_invoice_id = "10";
                    }
                }
            } catch (Exception e) {
                out.println(e.toString());
            }

            try {
                String sql_order_complete = "update maker_order_product_info set mk_status = 1 where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + complete_order_id + "' and product_name = '" + complete_product + "' ";
                PreparedStatement pst_order_complete = DbConnection.getConn(sql_order_complete);
                pst_order_complete.execute();
            } catch (Exception e) {
                out.println(e.toString());
            }
        %>

        <%
            // after complete product then add maker cost in inventory_details
            // current date
            Date dat = new Date();
            SimpleDateFormat sformat = new SimpleDateFormat("yyyy-MM-dd");
            String c_date = sformat.format(dat);
            try {
                String sql_maker_cost = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement pst_maker_cost = DbConnection.getConn(sql_maker_cost);
                pst_maker_cost.setString(1, null);
                pst_maker_cost.setString(2, (String) session.getAttribute("user_com_id"));
                pst_maker_cost.setString(3, bran_id);
                pst_maker_cost.setString(4, user_id);
                pst_maker_cost.setString(5, maker_id);
                pst_maker_cost.setString(6, product_invoice_id);
                pst_maker_cost.setString(7, "0");
                pst_maker_cost.setString(8, product_qty + "");
                pst_maker_cost.setString(9, "0");
                pst_maker_cost.setString(10, "0");
                pst_maker_cost.setString(11, "0");
                pst_maker_cost.setString(12, total_price + "");
                pst_maker_cost.setString(13, "0");
                pst_maker_cost.setString(14, "2");
                pst_maker_cost.setString(15, c_date);
                pst_maker_cost.setString(16, null);
                pst_maker_cost.execute();
            } catch (Exception e) {
                out.println(e.toString());
            }
            out.println("total Pirce " + total_price);

        %>

        <%            // check any status of  mk_status is 0 or not
            String chage_status = null;
            String mk_last_status = null;
            try {
                String sql_check_status_maker_order_product_info = "select * from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + complete_order_id + "' ";
                PreparedStatement pst_check_maker_order_product_info = DbConnection.getConn(sql_check_status_maker_order_product_info);
                ResultSet rs_check_status_maker_order_product_info = pst_check_maker_order_product_info.executeQuery();
                while (rs_check_status_maker_order_product_info.next()) {
                    chage_status = rs_check_status_maker_order_product_info.getString("mk_status");
                    if (chage_status.equals("0") || chage_status.equals("2")) {
                        mk_last_status = "0";
                        response.sendRedirect("/Tailor/admin/order_maker_details.jsp");
                    }
                }
            } catch (Exception e) {
                out.println(e.toString());
            }
        %>

        <%
            if (mk_last_status == null) {
                try {
                    String sql_change_ad_order_status = "update ad_order set ord_status = 4 where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + complete_order_id + "' ";
                    PreparedStatement pst_change_ad_order_id = DbConnection.getConn(sql_change_ad_order_status);
                    pst_change_ad_order_id.execute();
                    String message_sent = null;
                    if (message_time != null) {
                        if (message_time.contains("order_complete")) {
                            String initMsg = "Your order id " + complete_order_id + " has been completed. Waiting for delivery. Total Due " + balance + "0tk. Please contact for more details " + bran_mobile + " " + bran_name + "";
                            String finalMsg = initMsg.replace(" ", "%20");
                            String msg_url = "http://sms.iglweb.com/smsapi?api_key=C200008259ec2e6ec8f768.04047558&type=text&contacts="+customer_mobile+"&senderid="+bran_sender_id+"&msg=" + finalMsg;
                            URL oracle = new URL(msg_url);
                            BufferedReader in = new BufferedReader(new InputStreamReader(oracle.openStream()));
                            String inputLine;
                            while ((inputLine = in.readLine()) != null) {
                                message_sent = inputLine;
                                out.println(inputLine);
                            }
                            in.close();
                        }
                    }

                    if (message_sent != null) {
                        if (message_sent.length() > 4) {
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
                    response.sendRedirect("/Tailor/admin/order_maker_details.jsp");
                } catch (Exception e) {
                    out.println(e.toString());
                }
            }
        %>
    </body>
</html>
