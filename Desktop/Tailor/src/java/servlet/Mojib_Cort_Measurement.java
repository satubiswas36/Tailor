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

public class Mojib_Cort_Measurement extends HttpServlet {

    double total_price = 0;
    double updated_price = 0;
    int mjc_qty_from_table = 0;
    double mjc_price_from_pricelist = 0;
    int mjc_qty_diff = 0;

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

        String mjc_long = request.getParameter("mjc_long");
        String mjc_body = request.getParameter("mjc_body");
        String mjc_body_loose = request.getParameter("mjc_body_loose");
        String mjc_belly = request.getParameter("mjc_belly");
        String mjc_belly_loose = request.getParameter("mjc_belly_loose");
        String mjc_hip = request.getParameter("mjc_hip");
        String mjc_hip_loose = request.getParameter("mjc_hip_loose");
        String mjc_shoulder = request.getParameter("mjc_shoulder");
        String mjc_neck = request.getParameter("mjc_neck");
        String mjc_collar = request.getParameter("mjc_collar");
        String mjc_pocket = request.getParameter("mjc_pocket");
        String mjc_inner_pocket = request.getParameter("mjc_inner_pocket");
        String mjc_open = request.getParameter("mjc_open");
        String mjc_catelog_no = request.getParameter("mjc_catelog_no");
        String mjc_others = request.getParameter("mjc_others");
        String order_id = request.getParameter("mjc_order_no");
        String mjc_qty = request.getParameter("mjc_qty");
        int mjc_qty_from_field = Integer.parseInt(mjc_qty);
        String customer_mobile = request.getParameter("customer_mobile");

        ///----------------------------take mojib cort quantity----------------------------------------
        try {
            String sql_mojibcort_quantity = "select * from ser_mojib_cort where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
            PreparedStatement pst_mojibcort_qty = DbConnection.getConn(sql_mojibcort_quantity);
            ResultSet rs_mojibcort_qty = pst_mojibcort_qty.executeQuery();
            while (rs_mojibcort_qty.next()) {
                mjc_qty_from_table = Integer.parseInt(rs_mojibcort_qty.getString("qty"));
            }
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        ///----------------------------//take mojibcort quantity----------------------------------------
        // ----------------------------- take mojibcort price from price_list -------------------------------------
        try {
            String sql_mojibcort_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_mojibcort_price = DbConnection.getConn(sql_mojibcort_price);
            ResultSet rs_mojibcort_price = pst_mojibcort_price.executeQuery();
            while (rs_mojibcort_price.next()) {
                mjc_price_from_pricelist = Double.parseDouble(rs_mojibcort_price.getString("prlist_mojib_cort"));
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
        // ----------------------------- take mojibcort price from price_list -------------------------------------
        //------------------------ take total price from ad_order ---------------------------------------------------
        try {
            String sql_price_from_ad_order = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + order_id + "' ";
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
        if (mjc_qty_from_field <= 0) {
            double last_price = total_price - (mjc_qty_from_table * mjc_price_from_pricelist);
            // update ad_order table 
            try {
                String sql_update_adorder_tble = "update ad_order set ord_total_price = '" + last_price + "' where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + order_id + "' ";
                PreparedStatement pst_update_adorder = DbConnection.getConn(sql_update_adorder_tble);
                pst_update_adorder.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // update inventory_details
            try {
                String sql_invetory_update = "update inventory_details set pro_sell_price = '" + last_price + "' where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' pro_invoice_id = '" + order_id + "' and pro_deal_type = 5 ";
                PreparedStatement pst_inventory_update = DbConnection.getConn(sql_invetory_update);
                pst_inventory_update.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delete pant from ser_pant            
            try {
                String sql_mojibcort_delete = "delete from ser_mojib_cort where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                PreparedStatement pst_mojibcort_delete = DbConnection.getConn(sql_mojibcort_delete);
                pst_mojibcort_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delect product from maker_order_product_info
            String p_name = "mojib_cort";
            try {
                String sql_delete_mk_ord_pro_info = "delete from maker_order_product_info where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' and product_name = '" + p_name + "' ";
                PreparedStatement pst_delete = DbConnection.getConn(sql_delete_mk_ord_pro_info);
                pst_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
        }

        //------------------------check pant qty between database(pant_qty_from_tble) to textfiel(pnt_qty)-----------------------------------
        if (mjc_qty_from_table > mjc_qty_from_field) {
            mjc_qty_diff = mjc_qty_from_table - mjc_qty_from_field;
            updated_price = mjc_qty_diff * mjc_price_from_pricelist;
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
        } else if (mjc_qty_from_table < mjc_qty_from_field) {
            mjc_qty_diff = mjc_qty_from_field - mjc_qty_from_table;
            updated_price = mjc_qty_diff * mjc_price_from_pricelist;
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
        
        // msr_mojib cort update 
        try {
            String sql_mojibcort_update = "update msr_mojib_cort set mjc_long = '"+mjc_long+"',mjc_body = '"+mjc_body+"',mjc_body_loose = '"+mjc_body_loose+"',mjc_belly = '"+mjc_belly+"',mjc_belly_loose = '"+mjc_belly_loose+"',mjc_hip = '"+mjc_hip+"',mjc_hip_loose = '"+mjc_hip_loose+"',mjc_shoulder = '"+mjc_shoulder+"',mjc_neck = '"+mjc_neck+"',mjc_collar = '"+mjc_collar+"' ,mjc_pocket = '"+mjc_pocket+"',mjc_inner_pocket = '"+mjc_inner_pocket+"', mjc_open = '"+mjc_open+"' ,mjc_catelog_no = '"+mjc_catelog_no+"' ,mjc_others = '"+mjc_others+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '"+customer_mobile+"' ";
            PreparedStatement pst_mojibcort_update = DbConnection.getConn(sql_mojibcort_update);
            pst_mojibcort_update.execute();
        } catch (SQLException e) {
            out.println("msr mojib cort update "+e.toString());
        }
        // ser mojib cort update 
        try {
            String sql_mojibcort_update = "update ser_mojib_cort set mjc_long = '"+mjc_long+"',mjc_body = '"+mjc_body+"',mjc_body_loose = '"+mjc_body_loose+"',mjc_belly = '"+mjc_belly+"',mjc_belly_loose = '"+mjc_belly_loose+"',mjc_hip = '"+mjc_hip+"',mjc_hip_loose = '"+mjc_hip_loose+"',mjc_shoulder = '"+mjc_shoulder+"',mjc_neck = '"+mjc_neck+"',mjc_collar = '"+mjc_collar+"' ,mjc_pocket = '"+mjc_pocket+"',mjc_inner_pocket = '"+mjc_inner_pocket+"', mjc_open = '"+mjc_open+"' ,mjc_catelog_no = '"+mjc_catelog_no+"' ,mjc_others = '"+mjc_others+"', qty = '"+mjc_qty+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '"+order_id+"' ";
            PreparedStatement pst_mojibcort_update = DbConnection.getConn(sql_mojibcort_update);
           int i = pst_mojibcort_update.executeUpdate();
            if (i > 0) {
                session.setAttribute("mojib_cort_msg", "Ok");
                response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
            } else {
                out.println("Faild");
            }
        } catch (SQLException e) {
            out.println("ser mojib cort update "+e.toString());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
