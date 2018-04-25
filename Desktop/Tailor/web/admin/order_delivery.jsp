
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">     
    </head>
    <body>
        <%
            String order_id = request.getParameter("ord");
            String com_due = request.getParameter("com_due");
            String customer_id = null;
            String bran_name = null;
            String bran_mobile = null;
            String bran_sender_id = null;

            String customer_mobile = null;
            String message_time = null;

            try {
                String sql_order_status_update = "update ad_order set ord_status = 5 where ord_bran_order = '" + order_id + "' ";
                PreparedStatement pst_order_status_update = DbConnection.getConn(sql_order_status_update);
                pst_order_status_update.execute();
                try {
                    // customer id 
                    String sql_cus_id = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + order_id + "' ";
                    PreparedStatement pst_cus_id = DbConnection.getConn(sql_cus_id);
                    ResultSet rs_cus_id = pst_cus_id.executeQuery();
                    if (rs_cus_id.next()) {
                        customer_id = rs_cus_id.getString("ord_cutomer_id");
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
                try {
                    String sql_customer_details = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + customer_id + "' ";
                    PreparedStatement pst_customer_details = DbConnection.getConn(sql_customer_details);
                    ResultSet rs_customer_details = pst_customer_details.executeQuery();
                    if (rs_customer_details.next()) {
                        customer_mobile = rs_customer_details.getString("cus_mobile");
                       // message_time = rs_customer_details.getString("cus_message_time");
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
                try {
                    String sql_bran = "select * from user_branch where bran_id = '" + session.getAttribute("user_bran_id") + "'";
                    PreparedStatement pst_bran = DbConnection.getConn(sql_bran);
                    ResultSet rs_bran = pst_bran.executeQuery();
                    if (rs_bran.next()) {
                        bran_name = rs_bran.getString("bran_name");
                        bran_mobile = rs_bran.getString("bran_mobile");
                        bran_sender_id = rs_bran.getString("bran_sender_id");
                        message_time = rs_bran.getString("bran_message_time");
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
                String message_sent = null;
                if (message_time != null) {
                    if (message_time.contains("order_delivery")) {
                        String initMsg = "Your order id " + order_id + " has been delivered. Total Due " + com_due + ". Please contact for more details " + bran_mobile + " " + bran_name + "";
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
                session.setAttribute("delivered", "delivered");
                session.setAttribute("delivereded_msg", "delivered");
                session.setAttribute("deliver_order", order_id);
                response.sendRedirect("/Tailor/admin/order_list.jsp");

            } catch (Exception e) {
                out.println(e.toString());
            }
        %>
    </body>
</html>
