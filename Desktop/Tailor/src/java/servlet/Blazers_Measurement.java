package servlet;

import connection.DbConnection;
import dao.BlazerMeasurementInformation;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Blazers_Measurement", urlPatterns = {"/Blazers_Measurement"})
public class Blazers_Measurement extends HttpServlet {
    
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
        BlazerMeasurementInformation blazerMeasurementInformation = new BlazerMeasurementInformation();
        session = request.getSession(false);
        
        blz_com_id = (String) session.getAttribute("user_com_id");
        blz_bran_id = (String) session.getAttribute("user_bran_id");
        blz_user_id = (String) session.getAttribute("user_user_id");
        
        String blz_long = request.getParameter("blz_long");
        String blz_body = request.getParameter("blz_body");
        String blz_bally = request.getParameter("blz_bally");
        String blz_hip = request.getParameter("blz_hip");
        String blz_shoulder = request.getParameter("blz_shoulder");
        String blz_hand_long = request.getParameter("blz_hand_long");
        String blz_mohuri = request.getParameter("blz_mohuri");
        String blz_crass_back = request.getParameter("blz_crass_back");
        String button = request.getParameter("button");
        String nepel = request.getParameter("nepel");
        String blz_side = request.getParameter("blz_side");
        String blz_catelog = request.getParameter("blz_catelog");
        String blz_other = request.getParameter("blz_other");
        String blz_best = request.getParameter("best");
        String blz_under = request.getParameter("neca");
        String blz_qty = request.getParameter("blz_qty");
        String order_number = request.getParameter("blz_order_id");
        int blz_qty_from_field = Integer.parseInt(blz_qty);
        String customer_mobile = request.getParameter("customer_mobile");

        // print all id-------------------------------------
        out.println("order id " + order_number + "<br/>");
        out.println("com id " + blz_com_id + "<br/>");
        out.println("bran id " + blz_bran_id + "<br/>");
        out.println("user id " + blz_user_id + "<br/>");

        // blazer qty from ser_blazer
        blz_qty_from_tbl = blazerMeasurementInformation.qtyOfBlazer(blz_bran_id, order_number);
//        try {
//            //-------------------------take blazer qty from ser_blazer----------------------------------------
//            String sql_blz_qty_from_tbl = "select * from ser_blazer where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_number + "' ";
//            PreparedStatement pst_blz_qty_from_tbl = DbConnection.getConn(sql_blz_qty_from_tbl);
//            ResultSet rs_blz_qty_from_tbl = pst_blz_qty_from_tbl.executeQuery();
//            if(rs_blz_qty_from_tbl.next()) {
//                blz_qty_from_tbl = Integer.parseInt(rs_blz_qty_from_tbl.getString("qty"));
//            }
//            out.println("blz qty from tbl " + blz_qty_from_tbl);
//
//        } catch (NumberFormatException | SQLException e) {
//            out.println(e.toString());
//        }
        //-------------------------//take blazer qty from ser_blazer----------------------------------------
        //---------------------------- blz price from price list -----------------------------------
        blz_price_from_price_list_table = blazerMeasurementInformation.priceOfBlazer(blz_bran_id);
//        try {
//            String sql_blz_price_from_price_list = "select * from price_list where prlist_bran_id = '" + blz_bran_id + "' ";
//            PreparedStatement pst_blz_price_from_p_list = DbConnection.getConn(sql_blz_price_from_price_list);
//            ResultSet rs_blz_price_from_p_list = pst_blz_price_from_p_list.executeQuery();
//            while (rs_blz_price_from_p_list.next()) {
//                blz_price_from_price_list_table = Double.parseDouble(rs_blz_price_from_p_list.getString("prlist_blazer"));
//            }
//            out.println("blz_price_from_price_list_table is " + blz_price_from_price_list_table);
//        } catch (NumberFormatException | SQLException e) {
//            out.println(e.toString());
//        }
        //----------------------------// blz price from price list -----------------------------------
        // -------------------------------- take total price from ad_order ----------------------------------------
        total_price_from_ad_order = blazerMeasurementInformation.takeTotalPriceFromad_order(blz_bran_id, order_number);
//        try {
//            String sql_totalprice_from_ad_order = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_order_id = '" + order_number + "' ";
//            PreparedStatement pst_totalprice_from_ad_order = DbConnection.getConn(sql_totalprice_from_ad_order);
//            ResultSet rs_totalprice_from_ad_order = pst_totalprice_from_ad_order.executeQuery();
//            while (rs_totalprice_from_ad_order.next()) {
//                total_price_from_ad_order = Double.parseDouble(rs_totalprice_from_ad_order.getString("ord_total_price"));
//            }
//            out.println("total_price_from_ad_order is " + total_price_from_ad_order + "<br/>");
//        } catch (NumberFormatException | SQLException e) {
//            out.println(e.toString());
//        }
        // --------------------------------// take total price from ad_order ----------------------------------------

        //jodi pant qty 0 hoy tahole ati delete korta hobe total price update korta hoble ad_order and inventory details thaka---------------------------------------
        if (blz_qty_from_field <= 0) {
            
            double last_price = total_price_from_ad_order - (blz_qty_from_tbl * blz_price_from_price_list_table);
            // update ad_order table 
            blazerMeasurementInformation.updateTotalPriceInad_Order(last_price, blz_bran_id, order_number);
//            try {
//                String sql_update_adorder_tble = "update ad_order set ord_total_price = '" + last_price + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_order_id = '" + order_number + "' ";
//                PreparedStatement pst_update_adorder = DbConnection.getConn(sql_update_adorder_tble);
//                pst_update_adorder.execute();
//            } catch (SQLException e) {
//                out.println(e.toString());
//            }
            // update inventory_details
            blazerMeasurementInformation.updateTotalPriceInInventoryDetails(last_price, blz_bran_id, order_number);
//            try {
//                String sql_invetory_update = "update inventory_details set pro_sell_price = '" + last_price + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_number + "' and pro_deal_type = 5 ";
//                PreparedStatement pst_inventory_update = DbConnection.getConn(sql_invetory_update);
//                pst_inventory_update.execute();
//            } catch (SQLException e) {
//                out.println(e.toString());
//            }
            // delete blazer from ser_blazer
            blazerMeasurementInformation.deleteBlazerFromSer_Blazer(blz_bran_id, order_number);
//            try {
//                String sql_pant_delete = "delete from ser_blazer where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_number + "' ";
//                PreparedStatement pst_pnt_delete = DbConnection.getConn(sql_pant_delete);
//                pst_pnt_delete.execute();
//            } catch (SQLException e) {
//                out.println(e.toString());
//            }
            // delect product from maker_order_product_info
            String p_name = "blazer";
            blazerMeasurementInformation.deleteFrom_maker_order_product_info(blz_bran_id, order_number, p_name);
//            try {
//                String sql_delete_mk_ord_pro_info = "delete from maker_order_product_info where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_number + "' and product_name = '" + p_name + "' ";
//                PreparedStatement pst_delete = DbConnection.getConn(sql_delete_mk_ord_pro_info);
//                pst_delete.execute();
//            } catch (SQLException e) {
//                out.println(e.toString());
//            }
            response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
        }

        //-------------------------------------------- order price update --------------------------------------------------
        if (blz_qty_from_tbl > blz_qty_from_field) {
            blz_qty_diff = blz_qty_from_tbl - blz_qty_from_field;
            blz_update_price = blz_qty_diff * blz_price_from_price_list_table;
            total_price_from_ad_order = total_price_from_ad_order - blz_update_price;
// update order with price in ad_order 
            blazerMeasurementInformation.updatePriceInOrder(total_price_from_ad_order, blz_bran_id, order_number);
            // update order with price in inventory_details
            blazerMeasurementInformation.updatePriceInInventoryDetails(total_price_from_ad_order, blz_bran_id, order_number);
//            try {
//                // update order with price in ad_order 
////                String sql_update_ad_order = "update ad_order set ord_total_price = '" + total_price_from_ad_order + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_number + "' ";
////                PreparedStatement pst_update_ad_order = DbConnection.getConn(sql_update_ad_order);
////                pst_update_ad_order.executeUpdate();
//
//                // update order with price in inventory_details
//                String sql_inventory = "update inventory_details set pro_sell_price = '" + total_price_from_ad_order + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_number + "' ";
//                PreparedStatement pst_inventory = DbConnection.getConn(sql_inventory);
//                pst_inventory.executeUpdate();
//            } catch (SQLException e) {
//                out.println(e.toString());
//            }
        } else if (blz_qty_from_tbl < blz_qty_from_field) {
            blz_qty_diff = blz_qty_from_field - blz_qty_from_tbl;
            blz_update_price = blz_qty_diff * blz_price_from_price_list_table;
            total_price_from_ad_order = total_price_from_ad_order + blz_update_price;
            // update order with price in ad_order
            blazerMeasurementInformation.updatePriceInOrder(total_price_from_ad_order, blz_bran_id, order_number);
            // update order with price in Inventory_details
            blazerMeasurementInformation.updatePriceInInventoryDetails(total_price_from_ad_order, blz_bran_id, order_number);
//            try {
//                // update order with price in ad_order
////                String sql_update_ad_order = "update ad_order set ord_total_price = '" + total_price_from_ad_order + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_number + "' ";
////                PreparedStatement pst_update_ad_order = DbConnection.getConn(sql_update_ad_order);
////                pst_update_ad_order.executeUpdate();
//
//                // update order with price in Inventory_details
//                String sql_inventory = "update inventory_details set pro_sell_price = '" + total_price_from_ad_order + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_number + "' ";
//                PreparedStatement pst_inventory = DbConnection.getConn(sql_inventory);
//                pst_inventory.executeUpdate();
//            } catch (SQLException e) {
//                out.println(e.toString());
//            }
        } else if (blz_qty_from_tbl == blz_qty_from_field) {
            try {
                String sql_update_ad_order = "update ad_order set ord_total_price = '" + total_price_from_ad_order + "' where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + order_number + "' ";
                PreparedStatement pst_update_ad_order = DbConnection.getConn(sql_update_ad_order);
                pst_update_ad_order.executeUpdate();
            } catch (SQLException e) {
                out.println(e.toString());
            }
        }
        //-------------------------------------------- order price update --------------------------------------------------

        // insert into msr_blazer 
        try {
            String sql_blz_update = "update msr_blazer set blz_long = '" + blz_long + "', blz_body = '" + blz_body + "', blz_bally = '" + blz_bally + "', "
                    + "blz_hip = '" + blz_hip + "', blz_shoulder = '" + blz_shoulder + "', blz_hand_long = '" + blz_hand_long + "', blz_hand_mohuri = '" + blz_mohuri + "',"
                    + " blz_cross_back = '" + blz_crass_back + "' , blz_button_num = '" + button + "', blz_nepel = '" + nepel + "', blz_side = '" + blz_side + "',"
                    + " blz_catelog_no = '" + blz_catelog + "', blz_others = '" + blz_other + "', best = '" + blz_best + "', "
                    + "under = '" + blz_under + "' where customer_mobile = '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_blz_update = DbConnection.getConn(sql_blz_update);
            int i = pst_blz_update.executeUpdate();
            
        } catch (SQLException e) {
            out.println(e.toString());
        }
        
        try {
            String sql_blz_update = "update ser_blazer set blz_long = '" + blz_long + "', blz_body = '" + blz_body + "', blz_bally = '" + blz_bally + "', "
                    + "blz_hip = '" + blz_hip + "', blz_shoulder = '" + blz_shoulder + "', blz_hand_long = '" + blz_hand_long + "', blz_hand_mohuri = '" + blz_mohuri + "',"
                    + " blz_cross_back = '" + blz_crass_back + "' , blz_button_num = '" + button + "', blz_nepel = '" + nepel + "', blz_side = '" + blz_side + "',"
                    + " blz_catelog_no = '" + blz_catelog + "', blz_others = '" + blz_other + "', qty = '" + blz_qty + "', best = '" + blz_best + "', "
                    + "under = '" + blz_under + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_number + "'  ";
            PreparedStatement pst_blz_update = DbConnection.getConn(sql_blz_update);
            int i = pst_blz_update.executeUpdate();
            if (i > 0) {
                session.setAttribute("blz_msg", "Ok");
                response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
    
}
