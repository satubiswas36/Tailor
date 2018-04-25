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

public class Payjama_Measurement extends HttpServlet {

    int payjama_qty_from_table = 0;
    double payjama_price_from_pricelist = 0;
    double total_price = 0;
    double last_price = 0;
    int payjama_qty_diff = 0;
    double update_price = 0;

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

        String pjma_long = request.getParameter("pjma_long");
        String pjma_comor = request.getParameter("pjma_comor");
        String pjma_hip = request.getParameter("pjma_hip");
        String pjma_muhuri = request.getParameter("pjma_muhuri");
        String pjma_thai = request.getParameter("pjma_thai");
        String pjma_fly = request.getParameter("pjma_fly");
        String pjma_high = request.getParameter("pjma_high");
        String pjma_hip_loose = request.getParameter("pjma_hip_loose");
        String pjma_pocket = request.getParameter("pjma_pocket");
        String pjma_qty = request.getParameter("pjma_qty");
        int payjama_qty_from_form = Integer.parseInt(pjma_qty);
        String pjma_other = request.getParameter("pjma_other");
        String order_no = request.getParameter("pjma_order_no");
        String pjma_catelog_no = request.getParameter("pjma_catelog_no");
        String customer_mobile = request.getParameter("customer_mobile");

        ///----------------------------take payjama quantity----------------------------------------
        try {
            String sql_payjama_quantity = "select * from ser_payjama where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_no + "' ";
            PreparedStatement pst_payjama_qty = DbConnection.getConn(sql_payjama_quantity);
            ResultSet rs_payjama_qty = pst_payjama_qty.executeQuery();
            while (rs_payjama_qty.next()) {
                payjama_qty_from_table = Integer.parseInt(rs_payjama_qty.getString("qty"));
            }
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        ///----------------------------//take payjama quantity----------------------------------------
        // ----------------------------- take payjama price from price_list -------------------------------------
        try {
            String sql_payjama_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_payjama_price = DbConnection.getConn(sql_payjama_price);
            ResultSet rs_payjama_price = pst_payjama_price.executeQuery();
            while (rs_payjama_price.next()) {
                payjama_price_from_pricelist = Double.parseDouble(rs_payjama_price.getString("prlist_payjama"));
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
        // ----------------------------- take payjama price from price_list -------------------------------------

        //------------------------ take total price from ad_order ---------------------------------------------------
        try {
            String sql_price_from_ad_order = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_no + "' ";
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
        if (payjama_qty_from_form <= 0) {
            double last_price = total_price - (payjama_qty_from_table * payjama_price_from_pricelist);
            // update ad_order table 
            try {
                String sql_update_adorder_tble = "update ad_order set ord_total_price = '" + last_price + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_no + "' ";
                PreparedStatement pst_update_adorder = DbConnection.getConn(sql_update_adorder_tble);
                pst_update_adorder.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // update inventory_details
            try {
                String sql_invetory_update = "update inventory_details set pro_sell_price = '" + last_price + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_no + "' and pro_deal_type = 5 ";
                PreparedStatement pst_inventory_update = DbConnection.getConn(sql_invetory_update);
                pst_inventory_update.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delete pant from ser_pant            
            try {
                String sql_payjama_delete = "delete from ser_payjama where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_no + "' ";
                PreparedStatement pst_payjama_delete = DbConnection.getConn(sql_payjama_delete);
                pst_payjama_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delect product from maker_order_product_info
            String p_name = "payjama";
            try {
                String sql_delete_mk_ord_pro_info = "delete from maker_order_product_info where order_id = '" + order_no + "' and product_name = '" + p_name + "' ";
                PreparedStatement pst_delete = DbConnection.getConn(sql_delete_mk_ord_pro_info);
                pst_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
        }

        //------------------------check payjama qty between database(pant_qty_from_tble) to textfiel(pnt_qty)-----------------------------------
        if (payjama_qty_from_table > payjama_qty_from_form) {
            payjama_qty_diff = payjama_qty_from_table - payjama_qty_from_form;
            update_price = payjama_qty_diff * payjama_price_from_pricelist;
            total_price = total_price - update_price;

            try {
                // update order with price and qty in ad_order 
                String sql_order_update = "update ad_order set ord_total_price = '" + total_price + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_no + "' ";
                PreparedStatement pst_order_update = DbConnection.getConn(sql_order_update);
                pst_order_update.executeUpdate();

                //update order -with price in inventory_details 
                String sql_inventory = "update inventory_details set pro_sell_price = '" + total_price + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_no + "' ";
                PreparedStatement pst_inventory = DbConnection.getConn(sql_inventory);
                pst_inventory.executeUpdate();

            } catch (SQLException e) {
                out.println(e.toString());
            }
        } else if (payjama_qty_from_table < payjama_qty_from_form) {
            payjama_qty_diff = payjama_qty_from_form - payjama_qty_from_table;
            update_price = payjama_qty_diff * payjama_price_from_pricelist;
            total_price = total_price + update_price;

            try {
                // update order with price and qty in ad_order 
                String sql_order_update = "update ad_order set ord_total_price = '" + total_price + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_no + "' ";
                PreparedStatement pst_order_update = DbConnection.getConn(sql_order_update);
                pst_order_update.executeUpdate();

                //update order -with price in inventory_details 
                String sql_inventory_after = "update inventory_details set pro_sell_price = '" + total_price + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_no + "' ";
                PreparedStatement pst_inventory_after = DbConnection.getConn(sql_inventory_after);
                pst_inventory_after.executeUpdate();
            } catch (SQLException e) {
                out.println(e.toString());
            }
        }
        //------------------------check payjama qty between database(payjama_qty_from_tble) to textfiel(pnt_qty)-----------------------------------        
        // update msr_payjama
        try {
            String sql_payjama_update = "update msr_payjama set pjma_long= '" + pjma_long + "',pjma_comor = '" + pjma_comor + "',pjma_hip = '" + pjma_hip + "', pjma_hip_loose = '" + pjma_hip_loose + "', pjma_mohuri = '" + pjma_muhuri + "', pjma_thai = '" + pjma_thai + "',pjma_fly = '" + pjma_fly + "',pjma_high = '" + pjma_high + "',pjma_pocket = '" + pjma_pocket + "',pjma_catelog_no = '" + pjma_catelog_no + "',pjma_others = '" + pjma_other + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
            PreparedStatement pst_payjama_update = DbConnection.getConn(sql_payjama_update);
            pst_payjama_update.executeUpdate();
        } catch (SQLException e) {
            out.println("msr payjama update " + e.toString());
        }
        // update ser_payjama
        try {
            String sql_payjama_update = "update ser_payjama set pjma_long= '" + pjma_long + "',pjma_comor = '" + pjma_comor + "',pjma_hip = '" + pjma_hip + "', pjma_hip_loose = '" + pjma_hip_loose + "', pjma_mohuri = '" + pjma_muhuri + "', pjma_thai = '" + pjma_thai + "',pjma_fly = '" + pjma_fly + "',pjma_high = '" + pjma_high + "',pjma_pocket = '" + pjma_pocket + "',pjma_catelog_no = '" + pjma_catelog_no + "',pjma_others = '" + pjma_other + "', qty = '"+pjma_qty+"' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '"+order_no+"' ";
            PreparedStatement pst_payjama_update = DbConnection.getConn(sql_payjama_update);
            int i = pst_payjama_update.executeUpdate();
            if (i > 0) {
                session.setAttribute("pjma_msg", "Ok");
                response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
            } else {
                out.println("Faild");
            }
        } catch (SQLException e) {
            out.println("ser payjama update " + e.toString());
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
