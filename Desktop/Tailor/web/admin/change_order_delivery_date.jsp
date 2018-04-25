<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String new_delivery_date = request.getParameter("new_delivery_date");
    String order_id = request.getParameter("order_id");
    String cus_id = request.getParameter("cus_id");

    // user details 
    String customer_mobile = null;
    try {
        String sql_customer = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + cus_id + "' ";
        PreparedStatement pst_customer = DbConnection.getConn(sql_customer);
        ResultSet rs_customer = pst_customer.executeQuery();
        if (rs_customer.next()) {
            customer_mobile = rs_customer.getString("cus_mobile");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }

    // old delivery date from ad_order
    String old_delivery_date = null;
    try {
        String sql_old_delivery_date = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + order_id + "' ";
        PreparedStatement pst_delivery_date = DbConnection.getConn(sql_old_delivery_date);
        ResultSet rs_delivery_date = pst_delivery_date.executeQuery();
        if (rs_delivery_date.next()) {
            old_delivery_date = rs_delivery_date.getString("ord_delivery_date");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }
    // sender id form branch 
    String bran_sender_id = null;
    try {
        String sql_sender_id = "select * from user_branch where bran_id = '" + session.getAttribute("user_bran_id") + "' ";
        PreparedStatement pst_sender_id = DbConnection.getConn(sql_sender_id);
        ResultSet rs_sender_id = pst_sender_id.executeQuery();
        if (rs_sender_id.next()) {
            bran_sender_id = rs_sender_id.getString("bran_sender_id");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }

    try {
        String sql_change_delivery_date = "update ad_order set ord_delivery_date = '" + new_delivery_date + "' where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_cutomer_id = '" + cus_id + "' and ord_bran_order = '" + order_id + "' ";
        PreparedStatement pst_change_delivery_date = DbConnection.getConn(sql_change_delivery_date);
        pst_change_delivery_date.executeUpdate();
        response.sendRedirect("/Tailor/admin/order_details.jsp?ord_id=" + order_id + "&customer_id=" + cus_id);
    } catch (Exception e) {
        out.println(e.toString());
    }

    String message_sent = null;

    // for sending message
    // firstly check order_create time message send korar permission ace naki
    String initMsg = "We are unable to delivery order id "+order_id+" this date "+old_delivery_date+". Next date is "+new_delivery_date+". Sorry for inconvenience. THANK YOU.";
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

