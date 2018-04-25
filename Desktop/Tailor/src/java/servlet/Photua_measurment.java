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

public class Photua_measurment extends HttpServlet {

    String blz_com_id;
    String blz_bran_id;
    String blz_user_id;
    HttpSession session;

    int blz_qty_from_tbl = 0;
    double blz_price_from_price_list_table = 0;
    double total_price_from_ad_order = 0;
    int blz_qty_diff = 0;
    double blz_update_price = 0;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        session = request.getSession(false);

        if (session.getAttribute("user_com_id") != null) {
            blz_com_id = (String) session.getAttribute("user_com_id");
        }
        if (session.getAttribute("user_bran_id") != null) {
            blz_bran_id = (String) session.getAttribute("user_bran_id");
        }

        if (session.getAttribute("user_user_id") != null) {
            blz_user_id = (String) session.getAttribute("user_user_id");
        }

        String order_id = request.getParameter("order_no");
        String pht_long = request.getParameter("pht_long");
        String pht_body = request.getParameter("pht_body");
        String pht_body_loose = request.getParameter("pht_body_loose");
        String pht_hip = request.getParameter("pht_hip");
        String pht_shoulder = request.getParameter("pht_shoulder");
        String pht_neck = request.getParameter("pht_neck");
        String pht_bally = request.getParameter("pht_bally");
        String pht_hand_cuff = request.getParameter("pht_hand_cuff");
        String pht_hand_quni = request.getParameter("pht_hand_kuni");
        String pht_hand_moja = request.getParameter("pht_hand_moja");
        String pht_hand_long = request.getParameter("pht_hand_long");
        String pht_type = request.getParameter("pht_type");
        String pht_plet = request.getParameter("pht_plet");
        String pht_collar = request.getParameter("pht_collar");
        String pht_collar_size = request.getParameter("pht_collar_size");
        String pht_cuff_size = request.getParameter("pht_cuff_size");
        String pht_pocket = request.getParameter("pht_pocket");
        String pht_pocket_inner = request.getParameter("pht_pocket_inner");
        String pht_qty = request.getParameter("pht_number");
        String pht_open = request.getParameter("pht_open");
        String pht_catelog_no = request.getParameter("pht_catelog_no");
        String pht_other = request.getParameter("pht_other");
        int blz_qty_from_field = Integer.parseInt(pht_qty);
        String customer_mobile = request.getParameter("customer_mobile");

        // print all id-------------------------------------
        out.println("order id " + order_id + "<br/>");
        out.println("com id " + blz_com_id + "<br/>");
        out.println("bran id " + blz_bran_id + "<br/>");
        out.println("user id " + blz_user_id + "<br/>");

        try {
            //-------------------------take blazer qty from ser_blazer----------------------------------------
            String sql_blz_qty_from_tbl = "select * from ser_photua where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
            PreparedStatement pst_blz_qty_from_tbl = DbConnection.getConn(sql_blz_qty_from_tbl);
            ResultSet rs_blz_qty_from_tbl = pst_blz_qty_from_tbl.executeQuery();
            while (rs_blz_qty_from_tbl.next()) {
                blz_qty_from_tbl = Integer.parseInt(rs_blz_qty_from_tbl.getString("qty"));
            }
            out.println("blz qty from tbl " + blz_qty_from_tbl);

        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        //-------------------------//take blazer qty from ser_blazer----------------------------------------
        //---------------------------- blz price from price list -----------------------------------
        try {
            String sql_blz_price_from_price_list = "select * from price_list where prlist_bran_id = '" + blz_bran_id + "' ";
            PreparedStatement pst_blz_price_from_p_list = DbConnection.getConn(sql_blz_price_from_price_list);
            ResultSet rs_blz_price_from_p_list = pst_blz_price_from_p_list.executeQuery();
            while (rs_blz_price_from_p_list.next()) {
                blz_price_from_price_list_table = Double.parseDouble(rs_blz_price_from_p_list.getString("prlist_photua"));
            }
            out.println("blz_price_from_price_list_table is " + blz_price_from_price_list_table);
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        //----------------------------// blz price from price list -----------------------------------
        // -------------------------------- take total price from ad_order ----------------------------------------
        try {
            String sql_totalprice_from_ad_order = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_id + "' ";
            PreparedStatement pst_totalprice_from_ad_order = DbConnection.getConn(sql_totalprice_from_ad_order);
            ResultSet rs_totalprice_from_ad_order = pst_totalprice_from_ad_order.executeQuery();
            while (rs_totalprice_from_ad_order.next()) {
                total_price_from_ad_order = Double.parseDouble(rs_totalprice_from_ad_order.getString("ord_total_price"));
            }
            out.println("total_price_from_ad_order is " + total_price_from_ad_order + "<br/>");
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        // --------------------------------// take total price from ad_order ----------------------------------------

        //jodi pant qty 0 hoy tahole ati delete korta hobe total price update korta hoble ad_order and inventory details thaka---------------------------------------
        if (blz_qty_from_field <= 0) {

            double last_price = total_price_from_ad_order - (blz_qty_from_tbl * blz_price_from_price_list_table);
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
                String sql_pant_delete = "delete from ser_photua where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
                PreparedStatement pst_pnt_delete = DbConnection.getConn(sql_pant_delete);
                pst_pnt_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delect product from maker_order_product_info
            String p_name = "photua";
            try {
                String sql_delete_mk_ord_pro_info = "delete from maker_order_product_info where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' and product_name = '" + p_name + "' ";
                PreparedStatement pst_delete = DbConnection.getConn(sql_delete_mk_ord_pro_info);
                pst_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
        }

        //-------------------------------------------- order price update --------------------------------------------------
        if (blz_qty_from_tbl > blz_qty_from_field) {
            blz_qty_diff = blz_qty_from_tbl - blz_qty_from_field;
            blz_update_price = blz_qty_diff * blz_price_from_price_list_table;
            total_price_from_ad_order = total_price_from_ad_order - blz_update_price;

            try {
                // update order with price in ad_order 
                String sql_update_ad_order = "update ad_order set ord_total_price = '" + total_price_from_ad_order + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_id + "' ";
                PreparedStatement pst_update_ad_order = DbConnection.getConn(sql_update_ad_order);
                pst_update_ad_order.executeUpdate();

                // update order with price in inventory_details
                String sql_inventory = "update inventory_details set pro_sell_price = '" + total_price_from_ad_order + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_id + "' ";
                PreparedStatement pst_inventory = DbConnection.getConn(sql_inventory);
                pst_inventory.executeUpdate();
            } catch (SQLException e) {
                out.println(e.toString());
            }
        } else if (blz_qty_from_tbl < blz_qty_from_field) {
            blz_qty_diff = blz_qty_from_field - blz_qty_from_tbl;
            blz_update_price = blz_qty_diff * blz_price_from_price_list_table;
            total_price_from_ad_order = total_price_from_ad_order + blz_update_price;

            try {
                // order update with price in ad_order
                String sql_update_ad_order = "update ad_order set ord_total_price = '" + total_price_from_ad_order + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_id + "' ";
                PreparedStatement pst_update_ad_order = DbConnection.getConn(sql_update_ad_order);
                pst_update_ad_order.executeUpdate();

                // update order with price in inventory_details
                String sql_inventory = "update inventory_details set pro_sell_price = '" + total_price_from_ad_order + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_id + "' ";
                PreparedStatement pst_inventory = DbConnection.getConn(sql_inventory);
                pst_inventory.executeUpdate();
            } catch (SQLException e) {
                out.println(e.toString());
            }
        } else if (blz_qty_from_tbl == blz_qty_from_field) {
            try {
                String sql_update_ad_order = "update ad_order set ord_total_price = '" + total_price_from_ad_order + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_id + "' ";
                PreparedStatement pst_update_ad_order = DbConnection.getConn(sql_update_ad_order);
                pst_update_ad_order.executeUpdate();
            } catch (SQLException e) {
                out.println(e.toString());
            }
        }
        //-------------------------------------------- order price update --------------------------------------------------

        // insert into msr_photua
        try {
            String pht_update = "update msr_photua set pht_long = '" + pht_long + "', pht_body = '" + pht_body + "', pht_body_loose = '" + pht_body_loose + "', "
                    + "pht_bally = '" + pht_bally + "', pht_hip = '" + pht_hip + "', pht_shoulder = '" + pht_shoulder + "', pht_neck = '" + pht_neck + "',"
                    + " pht_hand_long = '" + pht_hand_long + "', pht_hand_moja = '" + pht_hand_moja + "', pht_hand_qunu = '" + pht_hand_quni + "',"
                    + " pht_hand_cuff = '" + pht_hand_cuff + "', pht_types = '" + pht_type + "', pht_plet = '" + pht_plet + "', pht_collar = '" + pht_collar + "',"
                    + " pht_collar_size = '" + pht_collar_size + "', pht_cuff_size = '" + pht_cuff_size + "', pht_pocket = '" + pht_pocket + "', pht_pocket_inner = '" + pht_pocket_inner + "', "
                    + " pht_catelog_no = '" + pht_catelog_no + "', pht_open = '"+pht_open+"', pht_others = '" + pht_other + "' where customer_mobile = '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_pht_update = DbConnection.getConn(pht_update);
            int i = pst_pht_update.executeUpdate();

        } catch (SQLException e) {
            out.println(e.toString());
        }

        try {
            String pht_update = "update ser_photua set pht_long = '" + pht_long + "', pht_body = '" + pht_body + "', pht_body_loose = '" + pht_body_loose + "', "
                    + "pht_bally = '" + pht_bally + "', pht_hip = '" + pht_hip + "', pht_shoulder = '" + pht_shoulder + "', pht_neck = '" + pht_neck + "',"
                    + " pht_hand_long = '" + pht_hand_long + "', pht_hand_moja = '" + pht_hand_moja + "', pht_hand_qunu = '" + pht_hand_quni + "',"
                    + " pht_hand_cuff = '" + pht_hand_cuff + "', pht_types = '" + pht_type + "', pht_plet = '" + pht_plet + "', pht_collar = '" + pht_collar + "',"
                    + " pht_collar_size = '" + pht_collar_size + "', pht_cuff_size = '" + pht_cuff_size + "', pht_pocket = '" + pht_pocket + "', pht_pocket_inner = '" + pht_pocket_inner + "', "
                    + "qty = '" + pht_qty + "', pht_open = '"+pht_open+"', pht_catelog_no = '" + pht_catelog_no + "', pht_others = '" + pht_other + "' where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
            PreparedStatement pst_pht_update = DbConnection.getConn(pht_update);
            int i = pst_pht_update.executeUpdate();

            if (i > 0) {
                session.setAttribute("pht_msg", "Ok");
                response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
            } else {
                out.println("failed");
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }

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

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
