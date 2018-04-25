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

public class Koti_Measurement extends HttpServlet {

    int koti_qty_from_tble = 0;
    double koti_price_from_price_list = 0;
    int koti_qty_diff = 0;
    double updated_price = 0;
    double total_price = 0;

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
        HttpSession session = request.getSession();

        String kt_long = request.getParameter("kt_long");
        String kt_body = request.getParameter("kt_body");
        String kt_belly = request.getParameter("kt_belly");
        String kt_hip = request.getParameter("kt_hip");
        String kt_shoulder = request.getParameter("kt_shoulder");
        //String kt_neck = request.getParameter("kt_neck");
        String kt_body_loose = request.getParameter("kt_body_loose");
        String kt_belly_loose = request.getParameter("kt_belly_loose");
        String kt_hip_loose = request.getParameter("kt_hip_loose");
        String kt_pocket = request.getParameter("kt_pocket");
        String kt_belt = request.getParameter("kt_belt");
        String order_id = request.getParameter("kt_order_no");
        String kt_qty = request.getParameter("kt_qty");
        int koti_qty_from_field = Integer.parseInt(kt_qty);
        String kt_catelog_no = request.getParameter("kt_catelog_no");
        String kt_other = request.getParameter("kt_other");
        String customer_mobile = request.getParameter("customer_mobile");

        ///----------------------------take koti quantity----------------------------------------
        try {
            String sql_pant_quantity = "select * from ser_koti where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
            PreparedStatement pst_pant_qty = DbConnection.getConn(sql_pant_quantity);
            ResultSet rs_pant_qty = pst_pant_qty.executeQuery();
            while (rs_pant_qty.next()) {
                koti_qty_from_tble = Integer.parseInt(rs_pant_qty.getString("qty"));
            }            
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        ///----------------------------//take pant quantity----------------------------------------
         // ----------------------------- take pant price from price_list -------------------------------------
        try {
            String sql_pant_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_pant_price = DbConnection.getConn(sql_pant_price);
            ResultSet rs_pant_price = pst_pant_price.executeQuery();
            while (rs_pant_price.next()) {
                koti_price_from_price_list = Double.parseDouble(rs_pant_price.getString("prlist_koti"));
            }            
        } catch (SQLException e) {
            out.println(e.toString());
        }
        // ----------------------------- take koti price from price_list -------------------------------------
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
        if (koti_qty_from_field <= 0) {            
            double last_price = total_price - (koti_qty_from_tble * koti_price_from_price_list);
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
            // delete koti from ser_koti
            try {
                String sql_pant_delete = "delete from ser_koti where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
                PreparedStatement pst_pnt_delete = DbConnection.getConn(sql_pant_delete);
                pst_pnt_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delect product from maker_order_product_info
            String p_name = "koti";
            try {
                String sql_delete_mk_ord_pro_info = "delete from maker_order_product_info where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' and product_name = '" + p_name + "' ";
                PreparedStatement pst_delete = DbConnection.getConn(sql_delete_mk_ord_pro_info);
                pst_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
        }
        
        // update msr_koti
        try {
            String sql_koti_update = "update msr_koti set kt_long = '"+kt_long+"',kt_body = '"+kt_body+"',kt_body_loose = '"+kt_body_loose+"',kt_belly = '"+kt_belly+"', kt_belly_loose = '"+kt_belly_loose+"',kt_hip = '"+kt_hip+"',kt_hip_loose = '"+kt_hip_loose+"',kt_shoulder = '"+kt_shoulder+"',kt_pocket = '"+kt_pocket+"',kt_belt = '"+kt_belt+"', kt_catelog_no = '"+kt_catelog_no+"',kt_others = '"+kt_other+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '"+customer_mobile+"' ";
            PreparedStatement pst_koti_update = DbConnection.getConn(sql_koti_update);
            pst_koti_update.execute();            
        } catch (SQLException e) {
            out.println("msr koti "+e.toString());
        }
        // update ser_koti
        try {
            String sql_koti_update = "update ser_koti set kt_long = '"+kt_long+"',kt_body = '"+kt_body+"',kt_body_loose = '"+kt_body_loose+"',kt_belly = '"+kt_belly+"', kt_belly_loose = '"+kt_belly_loose+"',kt_hip = '"+kt_hip+"',kt_hip_loose = '"+kt_hip_loose+"',kt_shoulder = '"+kt_shoulder+"',kt_pocket = '"+kt_pocket+"',kt_belt = '"+kt_belt+"', kt_catelog_no = '"+kt_catelog_no+"',kt_others = '"+kt_other+"', qty = '"+kt_qty+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '"+order_id+"' ";
            PreparedStatement pst_koti_update = DbConnection.getConn(sql_koti_update);
          int i = pst_koti_update.executeUpdate();
          if (i > 0) {
                session.setAttribute("koti_msg", "Ok");
                response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
            } else {
                out.println("Faild");
            }
        } catch (SQLException e) {
            out.println("ser koti "+e.toString());
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
