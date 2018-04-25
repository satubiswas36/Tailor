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

@WebServlet(name = "Shirt_Measurements", urlPatterns = {"/Shirt_Measurements"})
public class Shirt_Measurements extends HttpServlet {

    HttpSession session;

    String s_com_id;
    String s_bran_id;
    String s_user_id;
    int s_order_id = 1;
    double diffent_price = 0;
    double fix_price = 0;
    int shirt_diff = 0;
    int qty = 0;
    double total_price = 0;
    double total_price_after_cal = 0;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        session = request.getSession();
        s_com_id = (String) session.getAttribute("user_com_id");
        s_bran_id = (String) session.getAttribute("user_bran_id");
        s_user_id = (String) session.getAttribute("user_user_id");
        PrintWriter out = response.getWriter();
        request.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("ISO-8859-1");
        response.setContentType("text/html;charset=ISO-8859-1");

        String order_no = request.getParameter("order_no");
        String srt_long = request.getParameter("srt_long");
        String srt_body = request.getParameter("srt_body");
        String srt_bally = request.getParameter("srt_bally");
        String srt_hip = request.getParameter("srt_hip");
        String srt_shoulder = request.getParameter("srt_shoulder");
        String srt_neck = request.getParameter("srt_neck");
        String srt_body_loose = request.getParameter("srt_body_loose");
        String srt_bally_loose = request.getParameter("srt_bally_loose");
        String srt_hip_loose = request.getParameter("srt_hip_loose");
        String srt_hand_cuff = request.getParameter("srt_hand_cuff");
        String srt_hand_kuni = request.getParameter("srt_hand_kuni");
        String srt_hand_moja = request.getParameter("srt_hand_moja");
        String srt_hand_long = request.getParameter("srt_hand_long");
        String srt_type = request.getParameter("srt_type");
        String srt_plet = request.getParameter("srt_plet");
        String srt_collar = request.getParameter("srt_collar");
        String srt_collar_size = request.getParameter("srt_collar_size");
        String srt_cuff_size = request.getParameter("srt_cuff_size");
        String pocket = request.getParameter("pocket");
        String pocket_inner = request.getParameter("pocket_inner");
        // String srt_number = request.getParameter("srt_number");
        String srt_catelog_no = request.getParameter("srt_catelog_no");
        String srt_other = request.getParameter("srt_other");
        int srt_number = Integer.parseInt(request.getParameter("srt_number"));
        String customer_mobile = request.getParameter("customer_mobile");

        //-------------------------------------------------------------------- take shirt qty ---------------------------------------------------------------------------------------------
        try {
            String sql_br = "select * from ser_shirt where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_no + "' ";
            PreparedStatement pst_br = DbConnection.getConn(sql_br);
            ResultSet rs_br = pst_br.executeQuery();
            if (rs_br.next()) {
                qty = Integer.parseInt(rs_br.getString("qty"));
            }
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        //---------------------------------------------take price for shirt-----------------------------------------
        try {
            String sql_pri = "select * from price_list where prlist_bran_id = '" + s_bran_id + "' ";
            PreparedStatement pst_pri = DbConnection.getConn(sql_pri);
            ResultSet rs_pri = pst_pri.executeQuery();
            if (rs_pri.next()) {
                fix_price = Double.parseDouble(rs_pri.getString("prlist_shirt"));
            }
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }

        try {
            String sql_order = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_no + "' ";
            PreparedStatement pst_order = DbConnection.getConn(sql_order);
            ResultSet rs_order = pst_order.executeQuery();
            while (rs_order.next()) {
                total_price = Double.parseDouble(rs_order.getString("ord_total_price"));
            }
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        // jodi zero hoy tahole product ta delete korta hobe 
        out.println("srt qty "+srt_number);
        if (srt_number <= 0) {
            //jodi pant qty 0 hoy tahole ati delete korta hobe total price update korta hoble ad_order and inventory details thaka---------------------------------------
            
                
                double last_price = total_price - (qty * fix_price);
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
                    String sql_pant_delete = "delete from ser_shirt where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_no + "' ";
                    PreparedStatement pst_pnt_delete = DbConnection.getConn(sql_pant_delete);
                    pst_pnt_delete.execute();
                } catch (SQLException e) {
                    out.println(e.toString());
                }
                // delect product from maker_order_product_info
                String p_name = "shirt";
                try {
                    String sql_delete_mk_ord_pro_info = "delete from maker_order_product_info where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_no + "' and product_name = '" + p_name + "' ";
                    PreparedStatement pst_delete = DbConnection.getConn(sql_delete_mk_ord_pro_info);
                    pst_delete.execute();
                } catch (SQLException e) {
                    out.println(e.toString());
                }
                response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");            
        } 
            if (qty > srt_number) {
                shirt_diff = qty - srt_number;
                diffent_price = shirt_diff * fix_price;
                total_price_after_cal = total_price - diffent_price;
                try {
                    // order update for ad_order 
                    String sql_up_order = "update ad_order set ord_total_price = '" + total_price_after_cal + "'  where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_no + "' ";
                    PreparedStatement pst_up_order = DbConnection.getConn(sql_up_order);
                    pst_up_order.executeUpdate();
                    // order update for inventory_details
                    String sql_up_inventory = "update inventory_details set pro_sell_price = '" + total_price_after_cal + "'  where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_no + "' ";
                    PreparedStatement pst_up_inventory = DbConnection.getConn(sql_up_inventory);
                    pst_up_inventory.executeUpdate();
                } catch (SQLException e) {
                    out.println(e.toString());
                }
            } else if (qty < srt_number) {
                shirt_diff = srt_number - qty;
                diffent_price = shirt_diff * fix_price;
                total_price_after_cal = total_price + diffent_price;
                try {
                    String sql_up_order = "update ad_order set ord_total_price = '" + total_price_after_cal + "'  where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_no + "' ";
                    PreparedStatement pst_up_order = DbConnection.getConn(sql_up_order);
                    pst_up_order.executeUpdate();
                    // out.println("Qty<Total price " + total_price + "after updated price " + total_price_after_cal);
                    // order update for inventory 
                    String sql_up_inventory_after = "update inventory_details set pro_sell_price = '" + total_price_after_cal + "'  where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + order_no + "' ";
                    PreparedStatement pst_up_inventory_after = DbConnection.getConn(sql_up_inventory_after);
                    pst_up_inventory_after.executeUpdate();
                } catch (SQLException e) {
                    out.println(e.toString());
                }
            } else if (qty == srt_number) {
                try {
                    String sql_up_order = "update ad_order set ord_total_price = '" + total_price + "'  where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + order_no + "' ";
                    PreparedStatement pst_up_order = DbConnection.getConn(sql_up_order);
                    pst_up_order.executeUpdate();
                } catch (SQLException e) {
                    out.println(e.toString());
                }            
        }

        try {
            // update msr_shirt
            String sql_update = "update msr_shirt set srt_long = '" + srt_long + "', srt_body = '" + srt_body + "' , srt_body_loose = '" + srt_body_loose + "', srt_bally = '" + srt_bally + "',srt_bally_loose = '"+srt_bally_loose+"', srt_hip = '" + srt_hip + "',srt_hip_loose = '"+srt_hip_loose+"' ,srt_shoulder = '" + srt_shoulder + "', srt_neck = '" + srt_neck + "', srt_hand_long = '" + srt_hand_long + "', srt_hand_moja = '" + srt_hand_moja + "', srt_hand_qunu = '" + srt_hand_kuni + "', srt_hand_cuff = '" + srt_hand_cuff + "', srt_types = '" + srt_type + "', srt_plet = '" + srt_plet + "', srt_collar = '" + srt_collar + "', srt_collar_size = '" + srt_collar_size + "', srt_cuff_size = '" + srt_cuff_size + "', srt_pocket = '" + pocket + "', srt_pocket_inner = '" + pocket_inner + "', srt_catelog_no = '" + srt_catelog_no + "', srt_others = '" + srt_other + "' where customer_mobile = '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_update = DbConnection.getConn(sql_update);
            int i = pst_update.executeUpdate();

        } catch (SQLException e) {
            out.println(e.toString());
        }

        try {
            // update ser_shirt
            String sql_update = "update ser_shirt set srt_long = '" + srt_long + "', srt_body = '" + srt_body + "' , srt_body_loose = '" + srt_body_loose + "', srt_bally = '" + srt_bally + "',srt_bally_loose = '"+srt_bally_loose+"',srt_hip = '" + srt_hip + "',srt_hip_loose = '"+srt_hip_loose+"' ,srt_shoulder = '" + srt_shoulder + "', srt_neck = '" + srt_neck + "', srt_hand_long = '" + srt_hand_long + "', srt_hand_moja = '" + srt_hand_moja + "', srt_hand_qunu = '" + srt_hand_kuni + "', srt_hand_cuff = '" + srt_hand_cuff + "', srt_types = '" + srt_type + "', srt_plet = '" + srt_plet + "', srt_collar = '" + srt_collar + "', srt_collar_size = '" + srt_collar_size + "', srt_cuff_size = '" + srt_cuff_size + "', srt_pocket = '" + pocket + "', srt_pocket_inner = '" + pocket_inner + "', srt_catelog_no = '" + srt_catelog_no + "', srt_others = '" + srt_other + "', qty = '" + srt_number + "' where order_id = '" + order_no + "' ";
            PreparedStatement pst_update = DbConnection.getConn(sql_update);
            int i = pst_update.executeUpdate();
            if (i > 0) {
                session.setAttribute("srt_msg", "Ok");
                response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
            } else {
                out.println("failed");
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
