
package servlet;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class Safari_Measurement extends HttpServlet {
    
     int safari_qty_from_table = 0 ;
     double total_price =  0;
     double safari_price_from_pricelist = 0;
     int safari_qty_diff = 0;
     double updated_price = 0;
     

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
    }

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        
       String sfr_long = request.getParameter("sfr_long");
       String sfr_body = request.getParameter("sfr_body");
       String sfr_belly = request.getParameter("sfr_belly");
       String sfr_hip = request.getParameter("sfr_hip");
       String sfr_shoulder = request.getParameter("sfr_shoulder");
       String sfr_crossback = request.getParameter("sfr_crossback");
       String sfr_hand_long = request.getParameter("sfr_hand_long");
       String sfr_hand_cup = request.getParameter("sfr_hand_cup");
       String sfr_neck = request.getParameter("sfr_neck");
       String sfr_body_loose = request.getParameter("sfr_body_loose");
       String sfr_belly_loose = request.getParameter("sfr_belly_loose");
       String sfr_hip_loose = request.getParameter("sfr_hip_loose");
       String sfr_collar_size = request.getParameter("sfr_collar_size");
       String sfr_plet = request.getParameter("sfr_plet");
       String sfr_pocket = request.getParameter("sfr_pocket");
       String sfr_inner_pocket = request.getParameter("sfr_inner_pocket");
       String sfr_type = request.getParameter("sfr_type");
       String sfr_back_side = request.getParameter("sfr_back_side");
       String sfr_collar_type = request.getParameter("sfr_collar_type");
       String sfr_qty = request.getParameter("sfr_qty");
       int safari_qty_from_field = Integer.parseInt(sfr_qty);
       String sfr_catelog_no = request.getParameter("sfr_catelog_no");
       String order_id = request.getParameter("sfr_order_no");
       String sfr_other = request.getParameter("sfr_other");
       String customer_mobile = request.getParameter("customer_mobile");
       
       
       ///----------------------------take safari quantity----------------------------------------
        try {
            String sql_safari_quantity = "select * from ser_safari where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
            PreparedStatement pst_safari_qty = DbConnection.getConn(sql_safari_quantity);
            ResultSet rs_safari_qty = pst_safari_qty.executeQuery();
            while (rs_safari_qty.next()) {
                safari_qty_from_table = Integer.parseInt(rs_safari_qty.getString("qty"));
            }            
        } catch (NumberFormatException | SQLException e) {
            out.println("safari qty "+e.toString());
        }
        ///----------------------------//take pant quantity----------------------------------------
        // ----------------------------- take pant price from price_list -------------------------------------
        try {
            String sql_safari_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_safari_price = DbConnection.getConn(sql_safari_price);
            ResultSet rs_safari_price = pst_safari_price.executeQuery();
            while (rs_safari_price.next()) {
                safari_price_from_pricelist = Double.parseDouble(rs_safari_price.getString("prlist_safari"));
            }            
        } catch (SQLException e) {
            out.println(e.toString());
        }
        // ----------------------------- take pant price from price_list -------------------------------------
        //------------------------ take total price from ad_order ---------------------------------------------------
        try {
            String sql_price_from_ad_order = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_id + "' ";
            PreparedStatement pst_price_from_ad_order = DbConnection.getConn(sql_price_from_ad_order);
            ResultSet rs_price_from_ad_order = pst_price_from_ad_order.executeQuery();
            while (rs_price_from_ad_order.next()) {
                total_price = Double.parseDouble(rs_price_from_ad_order.getString("ord_total_price"));
            }            
        } catch (NumberFormatException | SQLException e) {
            out.println("take total price from ad_order "+e.toString());
        }
        //------------------------ take total price from ad_order ---------------------------------------------------
        //jodi pant qty 0 hoy tahole ati delete korta hobe total price update korta hoble ad_order and inventory details thaka---------------------------------------
        if (safari_qty_from_field <= 0) {            
            double last_price = total_price - (safari_qty_from_table * safari_price_from_pricelist);
            // update ad_order table 
            try {
                String sql_update_adorder_tble = "update ad_order set ord_total_price = '" + last_price + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_id + "' ";
                PreparedStatement pst_update_adorder = DbConnection.getConn(sql_update_adorder_tble);
                pst_update_adorder.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // update inventory_details
            try {
                String sql_invetory_update = "update inventory_details set pro_sell_price = '" + last_price + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_id + "' and pro_deal_type = 5 ";
                PreparedStatement pst_inventory_update = DbConnection.getConn(sql_invetory_update);
                pst_inventory_update.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delete pant from ser_pant            
            try {
                String sql_safari_delete = "delete from ser_safari where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
                PreparedStatement pst_safari_delete = DbConnection.getConn(sql_safari_delete);
                pst_safari_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delect product from maker_order_product_info
            String p_name = "safari";
            try {
                String sql_delete_mk_ord_pro_info = "delete from maker_order_product_info where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' and product_name = '" + p_name + "' ";
                PreparedStatement pst_delete = DbConnection.getConn(sql_delete_mk_ord_pro_info);
                pst_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
        }
        
        //------------------------check pant qty between database(pant_qty_from_tble) to textfiel(pnt_qty)-----------------------------------
        if (safari_qty_from_table > safari_qty_from_field) {
            safari_qty_diff = safari_qty_from_table - safari_qty_from_field;
            updated_price = safari_qty_diff * safari_price_from_pricelist;
            total_price = total_price - updated_price;

            try {
                // update order with price and qty in ad_order 
                String sql_order_update = "update ad_order set ord_total_price = '" + total_price + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_id + "' ";
                PreparedStatement pst_order_update = DbConnection.getConn(sql_order_update);
                pst_order_update.executeUpdate();

                //update order -with price in inventory_details 
                String sql_inventory = "update inventory_details set pro_sell_price = '" + total_price + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_id + "' ";
                PreparedStatement pst_inventory = DbConnection.getConn(sql_inventory);
                pst_inventory.executeUpdate();

            } catch (SQLException e) {
                out.println(e.toString());
            }
        } else if (safari_qty_from_table < safari_qty_from_field) {
            safari_qty_diff = safari_qty_from_field - safari_qty_from_table;
            updated_price = safari_qty_diff * safari_price_from_pricelist;
            total_price = total_price + updated_price;

            try {
                // update order with price and qty in ad_order 
                String sql_order_update = "update ad_order set ord_total_price = '" + total_price + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_id + "' ";
                PreparedStatement pst_order_update = DbConnection.getConn(sql_order_update);
                pst_order_update.executeUpdate();

                //update order -with price in inventory_details 
                String sql_inventory_after = "update inventory_details set pro_sell_price = '" + total_price + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_id + "' ";
                PreparedStatement pst_inventory_after = DbConnection.getConn(sql_inventory_after);
                pst_inventory_after.executeUpdate();
            } catch (SQLException e) {
                out.println(e.toString());
            }
        }
        //------------------------check pant qty between database(pant_qty_from_tble) to textfiel(pnt_qty)-----------------------------------
        
        //  update msr_safari 
        try {
            String sql_safari_update = "update msr_safari set sfr_long = '"+sfr_long+"',sfr_body = '"+sfr_body+"', sfr_body_loose = '"+sfr_body_loose+"',sfr_belly = '"+sfr_belly+"' ,sfr_belly_loose = '"+sfr_belly_loose+"',sfr_hip = '"+sfr_hip+"',sfr_hip_loose = '"+sfr_hip_loose+"',sfr_shoulder = '"+sfr_shoulder+"',sfr_cross_back = '"+sfr_crossback+"',sfr_neck = '"+sfr_neck+"',sfr_hand_long = '"+sfr_hand_long+"',sfr_hand_cuff = '"+sfr_hand_cup+"', sfr_plet = '"+sfr_plet+"',sfr_collar = '"+sfr_collar_type+"',sfr_collar_size = '"+sfr_collar_size+"',sfr_pocket = '"+sfr_pocket+"',sfr_back_side = '"+sfr_back_side+"', sfr_catelog_no = '"+sfr_catelog_no+"', sfr_inner_pocket = '"+sfr_inner_pocket+"', sfr_type = '"+sfr_type+"', sfr_others = '"+sfr_other+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '"+customer_mobile+"' "; 
            PreparedStatement pst_safari_update = DbConnection.getConn(sql_safari_update);
            pst_safari_update.execute();
        } catch (SQLException e) {
            out.println("msr safari update "+ e.toString());
        }
        // ser_safari update
        try {
            String sql_safari_update = "update ser_safari set sfr_long = '"+sfr_long+"',sfr_body = '"+sfr_body+"', sfr_body_loose = '"+sfr_body_loose+"',sfr_belly = '"+sfr_belly+"' ,sfr_belly_loose = '"+sfr_belly_loose+"',sfr_hip = '"+sfr_hip+"',sfr_hip_loose = '"+sfr_hip_loose+"',sfr_shoulder = '"+sfr_shoulder+"',sfr_cross_back = '"+sfr_crossback+"',sfr_neck = '"+sfr_neck+"',sfr_hand_long = '"+sfr_hand_long+"',sfr_hand_cuff = '"+sfr_hand_cup+"', sfr_plet = '"+sfr_plet+"',sfr_collar = '"+sfr_collar_type+"',sfr_collar_size = '"+sfr_collar_size+"',sfr_pocket = '"+sfr_pocket+"',sfr_back_side = '"+sfr_back_side+"', sfr_catelog_no = '"+sfr_catelog_no+"', sfr_inner_pocket = '"+sfr_inner_pocket+"', sfr_type = '"+sfr_type+"', sfr_others = '"+sfr_other+"', qty = '"+sfr_qty+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '"+order_id+"' ";                                                                                                                                                                                                           
            PreparedStatement pst_safari_update = DbConnection.getConn(sql_safari_update);
           int i = pst_safari_update.executeUpdate();
           if (i > 0) {
                session.setAttribute("safari_msg", "Ok");
                response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
            } else {
                out.println("Faild");
            }
        } catch (SQLException e) {
            out.println("ser safari update "+ e.toString());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
