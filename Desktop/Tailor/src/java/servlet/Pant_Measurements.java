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

public class Pant_Measurements extends HttpServlet {

    String pr_fr_mr = "pant";
    String p_com_id = null;
    String p_bran_id = null;
    String p_user_id;
    HttpSession session = null;
    int pant_qty_from_tble = 0;
    double pant_price_from_price_list = 0;
    int pant_qty_diff = 0;
    double updated_price = 0;
    double total_updated_price = 0;
    double total_price = 0;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        PrintWriter out = response.getWriter();
        String order_id = request.getParameter("pnt_order_id");

        out.println(order_id);
    }
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        PrintWriter out = response.getWriter();

        session = request.getSession(false);
//        p_com_id =(String) session.getAttribute("s_com_id");
//        p_bran_id =(String) session.getAttribute("s_bran_id");
//        p_user_id = (String) session.getAttribute("s_user_id");
        try {
            if (session.getAttribute("user_com_id") != null) {
                p_com_id = session.getAttribute("user_com_id").toString();
            }
            if (session.getAttribute("user_bran_id") != null) {
                p_bran_id = (String) session.getAttribute("user_bran_id");
            }
            if (session.getAttribute("user_user_id") != null) {
                p_user_id = session.getAttribute("user_user_id").toString();
            }

        } catch (Exception e) {
            out.println(e.toString());
        }

        out.println("com id " + p_com_id);
        out.println("bran id " + p_bran_id);
        out.println("user id " + p_user_id);

        String order_id = request.getParameter("pnt_order_id");
        String pnt_long = request.getParameter("pnt_long");
        String pnt_comor = request.getParameter("pant_comor");
        String pnt_muhuri = request.getParameter("pnt_muhuri");
        String pnt_run = request.getParameter("pnt_run");
        String pnt_high = request.getParameter("pnt_high");
        String pnt_fly = request.getParameter("pnt_fly");
        String pnt_hip = request.getParameter("pnt_hip");
        String pnt_pocket_type = request.getParameter("pnt_pocket_type");
        String pnt_pocket_back = request.getParameter("pnt_pocket_back");
        String pnt_pocket_inner = request.getParameter("pnt_pocket_inner");
        String pnt_muhuri_type = request.getParameter("pnt_muhuri_type");
        String pnt_loop = request.getParameter("pnt_loop");
        String pnt_loop_size = request.getParameter("pnt_loop_side");
        String pnt_catelog_no = request.getParameter("pnt_catelog_no");
        String pnt_kuci = request.getParameter("pnt_is_kuci");
        String pnt_other = request.getParameter("pnt_other");
        String pnt_qty = request.getParameter("pnt_number");
        int pant_qty_from_field = Integer.parseInt(pnt_qty);
        String customer_mobile = request.getParameter("customer_mobile");

        out.println("order id is " + order_id + "<br/>");
        out.println("pant_qty_field id is " + pant_qty_from_field + "<br/>");
        ///----------------------------take pant quantity----------------------------------------
        try {
            String sql_pant_quantity = "select * from ser_pant where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
            PreparedStatement pst_pant_qty = DbConnection.getConn(sql_pant_quantity);
            ResultSet rs_pant_qty = pst_pant_qty.executeQuery();
            while (rs_pant_qty.next()) {
                pant_qty_from_tble = Integer.parseInt(rs_pant_qty.getString("qty"));
            }
            out.println("pant_qty_from_tble is " + pant_qty_from_tble + "<br/>");
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        ///----------------------------//take pant quantity----------------------------------------
        // ----------------------------- take pant price from price_list -------------------------------------
        try {
            String sql_pant_price = "select * from price_list where prlist_bran_id = '" + p_bran_id + "' ";
            PreparedStatement pst_pant_price = DbConnection.getConn(sql_pant_price);
            ResultSet rs_pant_price = pst_pant_price.executeQuery();
            while (rs_pant_price.next()) {
                pant_price_from_price_list = Double.parseDouble(rs_pant_price.getString("prlist_pant"));
            }
            out.println("pant_price_from_price_list is " + pant_price_from_price_list + "<br/>");
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
            out.println("total price " + total_price);
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        //------------------------ take total price from ad_order ---------------------------------------------------

//jodi pant qty 0 hoy tahole ati delete korta hobe total price update korta hoble ad_order and inventory details thaka---------------------------------------
        if (pant_qty_from_field <= 0) {
            out.println("field qty aca " + pnt_qty);
            double last_price = total_price - (pant_qty_from_tble * pant_price_from_price_list);
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
                String sql_pant_delete = "delete from ser_pant where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
                PreparedStatement pst_pnt_delete = DbConnection.getConn(sql_pant_delete);
                pst_pnt_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delect product from maker_order_product_info
            String p_name = "pant";
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
        if (pant_qty_from_tble > pant_qty_from_field) {
            pant_qty_diff = pant_qty_from_tble - pant_qty_from_field;
            updated_price = pant_qty_diff * pant_price_from_price_list;
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
        } else if (pant_qty_from_tble < pant_qty_from_field) {
            pant_qty_diff = pant_qty_from_field - pant_qty_from_tble;
            updated_price = pant_qty_diff * pant_price_from_price_list;
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

        // insert into msr_pant         
        try {
            String sql_pant_update = "update msr_pant set pnt_long = '" + pnt_long + "', pnt_comor = '" + pnt_comor + "', pnt_hip = '" + pnt_hip + "', pnt_mohuri = '" + pnt_muhuri + "', pnt_run = '" + pnt_run + "', pnt_high = '" + pnt_high + "', pnt_fly = '" + pnt_fly + "', pnt_kuci = '" + pnt_kuci + "', pnt_pocket_type = '" + pnt_pocket_type + "', pnt_pocket_backside = '" + pnt_pocket_back + "', pnt_pocket_inner = '" + pnt_pocket_inner + "', pnt_mohuri_type = '" + pnt_muhuri_type + "', pnt_loop = '" + pnt_loop + "', pnt_loop_size = '" + pnt_loop_size + "', pnt_catelog_no = '" + pnt_catelog_no + "', pnt_others = '" + pnt_other + "' where customer_mobile = '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_pant_update = DbConnection.getConn(sql_pant_update);
            int i = pst_pant_update.executeUpdate();
        } catch (SQLException e) {
            out.println(e.toString());
        }

        try {
            String sql_pant_update = "update ser_pant set pnt_long = '" + pnt_long + "', pnt_comor = '" + pnt_comor + "', pnt_hip = '" + pnt_hip + "', pnt_mohuri = '" + pnt_muhuri + "', pnt_run = '" + pnt_run + "', pnt_high = '" + pnt_high + "', pnt_fly = '" + pnt_fly + "', pnt_kuci = '" + pnt_kuci + "', pnt_pocket_type = '" + pnt_pocket_type + "', pnt_pocket_backside = '" + pnt_pocket_back + "', pnt_pocket_inner = '" + pnt_pocket_inner + "', pnt_mohuri_type = '" + pnt_muhuri_type + "', pnt_loop = '" + pnt_loop + "', pnt_loop_size = '" + pnt_loop_size + "', pnt_catelog_no = '" + pnt_catelog_no + "', pnt_others = '" + pnt_other + "', qty = '" + pnt_qty + "' where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
            PreparedStatement pst_pant_update = DbConnection.getConn(sql_pant_update);
            int i = pst_pant_update.executeUpdate();
            if (i > 0) {
                session.setAttribute("pnt_msg", "Ok");
                response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
            } else {
                out.println("Faild");
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
