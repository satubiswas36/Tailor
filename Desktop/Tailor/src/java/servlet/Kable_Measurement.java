package servlet;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Kable_Measurement", urlPatterns = {"/Kable_Measurement"})
public class Kable_Measurement extends HttpServlet {

    int kable_qty_from_table = 0;
    double total_price = 0;
    double kable_price_from_price_list = 0;
    int kable_qty_diff = 0;
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
        HttpSession session = request.getSession(true);

        String kbl_long = request.getParameter("kbl_long");
        String kbl_body = request.getParameter("kbl_body");
        String kbl_belly = request.getParameter("kbl_belly");
        String kbl_hip = request.getParameter("kbl_hip");
        String kbl_shoulder = request.getParameter("kbl_shoulder");
        String kbl_hand_long = request.getParameter("kbl_hand_long");
        String kbl_muhuri = request.getParameter("kbl_muhuri");
        String kbl_neck = request.getParameter("kbl_neck");
        String kbl_body_loose = request.getParameter("kbl_body_loose");
        String kbl_belly_loose = request.getParameter("kbl_belly_loose");
        String kbl_hip_loose = request.getParameter("kbl_hip_loose");
        String kbl_collar_size = request.getParameter("kbl_collar_size");
        String kbl_collar_type = request.getParameter("kbl_collar_type");
        String kbl_pocket = request.getParameter("kbl_pocket");
        String kbl_plet = request.getParameter("kbl_plet");
        String kbl_other = request.getParameter("kbl_other");
        String order_id = request.getParameter("kbl_order_no");
        String kbl_qty = request.getParameter("kbl_qty");
        int kable_qty_from_field = Integer.parseInt(kbl_qty);
        String customer_mobile = request.getParameter("customer_mobile");
        String kbl_catelog_no = request.getParameter("kbl_catelog_no");

        ///----------------------------take kable quantity----------------------------------------
        try {
            String sql_kable_quantity = "select * from ser_kable where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
            PreparedStatement pst_kable_qty = DbConnection.getConn(sql_kable_quantity);
            ResultSet rs_kable_qty = pst_kable_qty.executeQuery();
            while (rs_kable_qty.next()) {
                kable_qty_from_table = Integer.parseInt(rs_kable_qty.getString("qty"));
            }            
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        ///----------------------------//take kable quantity----------------------------------------
         // ----------------------------- take pant price from price_list -------------------------------------
        try {
            String sql_kable_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_kable_price = DbConnection.getConn(sql_kable_price);
            ResultSet rs_kable_price = pst_kable_price.executeQuery();
            while (rs_kable_price.next()) {
                kable_price_from_price_list = Double.parseDouble(rs_kable_price.getString("prlist_kable"));
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
            out.println(e.toString());
        }
        //------------------------ take total price from ad_order ---------------------------------------------------
        //jodi pant qty 0 hoy tahole ati delete korta hobe total price update korta hoble ad_order and inventory details thaka---------------------------------------
        if (kable_qty_from_field <= 0) {            
            double last_price = total_price - (kable_qty_from_table * kable_price_from_price_list);
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
                String sql_kable_delete = "delete from ser_kable where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
                PreparedStatement pst_kable_delete = DbConnection.getConn(sql_kable_delete);
                pst_kable_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delect product from maker_order_product_info
            String p_name = "kable";
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
        if (kable_qty_from_table > kable_qty_from_field) {
            kable_qty_diff = kable_qty_from_table - kable_qty_from_field;
            updated_price = kable_qty_diff * kable_price_from_price_list;
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
        } else if (kable_qty_from_table < kable_qty_from_field) {
            kable_qty_diff = kable_qty_from_field - kable_qty_from_table;
            updated_price = kable_qty_diff * kable_price_from_price_list;
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
        
        // msr_kable update 
        try {
            String sql_kable_update = "update msr_kable set kbl_long = '"+kbl_long+"',kbl_body = '"+kbl_body+"',kbl_body_loose = '"+kbl_body_loose+"',kbl_belly = '"+kbl_belly+"',kbl_belly_loose = '"+kbl_belly_loose+"',kbl_hip = '"+kbl_hip+"',kbl_hip_loose = '"+kbl_hip_loose+"',kbl_shoulder = '"+kbl_shoulder+"',kbl_neck = '"+kbl_neck+"',kbl_hand_long = '"+kbl_hand_long+"',kbl_muhuri = '"+kbl_muhuri+"',kbl_plet = '"+kbl_plet+"',kbl_collar_type = '"+kbl_collar_type+"',kbl_collar_size = '"+kbl_collar_size+"',kbl_pocket = '"+kbl_pocket+"',kbl_catelog_no = '"+kbl_catelog_no+"',kbl_others = '"+kbl_other+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '"+customer_mobile+"' ";                                                                                                                                                                 
            PreparedStatement pst_kable_update = DbConnection.getConn(sql_kable_update);
            pst_kable_update.execute();
            
        } catch (SQLException e) {
            out.println("msr kable "+e.toString());
        }
        // ser_kable update 
        try {
            String sql_kable_update = "update ser_kable set kbl_long = '"+kbl_long+"',kbl_body = '"+kbl_body+"',kbl_body_loose = '"+kbl_body_loose+"',kbl_belly = '"+kbl_belly+"',kbl_belly_loose = '"+kbl_belly_loose+"',kbl_hip = '"+kbl_hip+"',kbl_hip_loose = '"+kbl_hip_loose+"',kbl_shoulder = '"+kbl_shoulder+"',kbl_neck = '"+kbl_neck+"',kbl_hand_long = '"+kbl_hand_long+"',kbl_muhuri = '"+kbl_muhuri+"',kbl_plet = '"+kbl_plet+"',kbl_collar_type = '"+kbl_collar_type+"',kbl_collar_size = '"+kbl_collar_size+"',kbl_pocket = '"+kbl_pocket+"',kbl_catelog_no = '"+kbl_catelog_no+"',kbl_others = '"+kbl_other+"', qty = '"+kbl_qty+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '"+order_id+"' ";                                                                                                                                                                 
            PreparedStatement pst_kable_update = DbConnection.getConn(sql_kable_update);
            int i =pst_kable_update.executeUpdate();
            if (i > 0) {
                session.setAttribute("kable_msg", "Ok");
                response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
            } else {
                out.println("Faild");
            } 
        } catch (SQLException e) {
            out.println("msr kable "+e.toString());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
