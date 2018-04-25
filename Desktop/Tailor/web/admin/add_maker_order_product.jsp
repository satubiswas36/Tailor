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
            
            String bran_id = null;
            String user_id = null;
            if(session.getAttribute("user_bran_id") != null){
                String ad_mk_bran_id = (String)session.getAttribute("user_bran_id");
                bran_id = ad_mk_bran_id;
            }
            if(session.getAttribute("user_user_id") != null){
                 String ad_mk_user_id = (String)session.getAttribute("user_user_id");
                 user_id = ad_mk_user_id;
            }
            if(user_id == null){
                user_id = bran_id;
            }

            String maker_name = request.getParameter("mk_name");
            String product_name = request.getParameter("product_name");
            String maker_order = request.getParameter("maker_order");
            String customer_id = request.getParameter("customer_id");
            String maker_deliver_date = request.getParameter("m_delivery_date");
            out.println(product_name+" "+maker_name+" "+maker_order);
            
            // take qty from every product table 
            String qty = null;
            try {
                    String sql_take_qty = "select * from ser_"+product_name+" where order_id = '"+maker_order+"' ";
                    PreparedStatement pst_take_qty = DbConnection.getConn(sql_take_qty);
                    ResultSet rs_take_qty = pst_take_qty.executeQuery();
                    while(rs_take_qty.next()){
                        qty=rs_take_qty.getString("qty");
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }

            try {
                // check order id and product name is available or not 
                String sql_check_has_maker = "select * from maker_order_product_info where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + maker_order + "' and product_name = '" + product_name + "' ";
                PreparedStatement pst_check_has_maker = DbConnection.getConn(sql_check_has_maker);
                ResultSet rs_check_has_maker = pst_check_has_maker.executeQuery();
                if (rs_check_has_maker.next()) {
                    String sql_update_maker = "update maker_order_product_info set mk_name = '" + maker_name + "', mk_delivery_date = '"+maker_deliver_date+"', mk_status = 0, qty = '"+qty+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + maker_order + "' and product_name = '" + product_name + "' ";
                    PreparedStatement pst_update_maker = DbConnection.getConn(sql_update_maker);
                    pst_update_maker.execute();
                    
                    // order status change to 3
                    try {
                        String sql_change_order_status = "update ad_order set ord_status = 3 where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + maker_order + "' ";
                        PreparedStatement pst_change_order_status = DbConnection.getConn(sql_change_order_status);
                        pst_change_order_status.execute();
                    } catch (Exception e) {
                        out.println(e.toString());
                    }
                    
                    // check mk_status from make_order_product_info table, jodi aktao 2 na thake tahole ad_order status 0 change hobe 
                    try {
                            String sql_check_mk_status = "select * from maker_order_product_info where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '"+maker_order+"' and mk_status = 2";
                            PreparedStatement pst_sql_check_mk_status = DbConnection.getConn(sql_check_mk_status);
                            ResultSet rs_mk_status = pst_sql_check_mk_status.executeQuery();
                            if(rs_mk_status.next()){
                                
                            }else {
                                // jodi akta tao mk_status 2 na thake tahole ad_order status 0 hoya jabe
                                try {
                                        String sql_ad_order_status_change = "update ad_order set ord_status = 0 where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '"+maker_order+"' ";
                                        PreparedStatement pst_ad_order_status = DbConnection.getConn(sql_ad_order_status_change);
                                        pst_ad_order_status.execute();
                                        out.println("Ok");
                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                            }
                        } catch (Exception e) {
                            out.println(e.toString());
                        }
                    
                   response.sendRedirect("/Tailor/admin/order_details.jsp?ord_id=" + maker_order+"&customer_id="+customer_id);
                } //else {
//                    try {
//                        // if not available then isert it
//                        String sql_add_maker_order_info = "insert into maker_order_product_info values(?,?,?,?,?,?,?,?,?,?,?)";
//                        PreparedStatement pst_add_maker_order_info = DbConnection.getConn(sql_add_maker_order_info);
//                        pst_add_maker_order_info.setString(1, null);
//                        pst_add_maker_order_info.setString(2, (String) session.getAttribute("user_com_id"));
//                        pst_add_maker_order_info.setString(3, bran_id);
//                        pst_add_maker_order_info.setString(4, user_id);
//                        pst_add_maker_order_info.setString(5, maker_order);
//                        pst_add_maker_order_info.setString(6, maker_name);
//                        pst_add_maker_order_info.setString(7, product_name);
//                        pst_add_maker_order_info.setString(8, qty);
//                        pst_add_maker_order_info.setString(9, null);
//                        pst_add_maker_order_info.setString(10, maker_deliver_date);
//                        pst_add_maker_order_info.setString(11, "0");
//                        pst_add_maker_order_info.execute();
//                        try {
//                            String sql_change_order_status = "update ad_order set ord_status = 3 where ord_order_id = '" + maker_order + "' ";
//                            PreparedStatement pst_change_order_status = DbConnection.getConn(sql_change_order_status);
//                            pst_change_order_status.execute();
//                        } catch (Exception e) {
//                            out.println(e.toString());
//                        }
//                        response.sendRedirect("/Tailor/admin/order_details.jsp?ord_id=" + maker_order);
//                    } catch (Exception e) {
//                        out.println(e.toString());
//                    }
//                }
            } catch (Exception e) {
                out.println(e.toString());
            }
        %>
    </body>
</html>
