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

public class Panjabi_Measurement extends HttpServlet {

    int panjabi_qty_from_table = 0;
    double panjabi_price_from_pricelist = 0;
    double total_price = 0;
    int pnjb_qty_diff = 0;
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

        String pnjb_long = request.getParameter("pnjb_long");
        String pnjb_body = request.getParameter("pnjb_body");
        String pnjb_belly = request.getParameter("pnjb_belly");
        String pnjb_hip = request.getParameter("pnjb_hip");
        String pnjb_shoulder = request.getParameter("pnjb_shoulder");
        String pnjb_hand_long = request.getParameter("pnjb_hand_long");
        String pnjb_muhuri = request.getParameter("pnjb_muhuri");
        String pnjb_neck = request.getParameter("pnjb_neck");
        String pnjb_body_loose = request.getParameter("pnjb_body_loose");
        String pnjb_belly_loose = request.getParameter("pnjb_belly_loose");
        String pnjb_hip_loose = request.getParameter("pnjb_hip_loose");
        String pnjb_collar_size = request.getParameter("pnjb_collar_size");
        String pnjb_collar_type = request.getParameter("pnjb_collar_type");
        String pnjb_pocket = request.getParameter("pnjb_pocket");
        String pnjb_inner_pocket = request.getParameter("pnjb_inner_pocket");
        String pnjb_plet = request.getParameter("pnjb_plet");
        String pnjb_other = request.getParameter("pnjb_other");
        String pnjb_qty = request.getParameter("pnjb_qty");
        int panjabi_qty = Integer.parseInt(pnjb_qty);
        String pnjb_order_no = request.getParameter("pnjb_order_no");
        String pnjb_catelog_no = request.getParameter("pnjb_catelog_no");
        String customer_mobile = request.getParameter("customer_mobile");

        // take panjabi qty from ser_panjabi table 
        try {
            String sql_panjabi_qty = "select * from ser_panjabi where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + pnjb_order_no + "' ";
            PreparedStatement pst_panjabi_qty = DbConnection.getConn(sql_panjabi_qty);
            ResultSet rs_panjabi_qty = pst_panjabi_qty.executeQuery();
            if (rs_panjabi_qty.next()) {
                panjabi_qty_from_table = Integer.parseInt(rs_panjabi_qty.getString("qty"));
            }
        } catch (NumberFormatException | SQLException e) {
            out.print("panjabi_qty_from_table" + e.toString());
        }

        // panjabi prie from price_list
        try {
            String sql_panjabi_price = "select * from price_list where prlist_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_panjabi_price = DbConnection.getConn(sql_panjabi_price);
            ResultSet rs_panjabi_price = pst_panjabi_price.executeQuery();
            while (rs_panjabi_price.next()) {
                panjabi_price_from_pricelist = Double.parseDouble(rs_panjabi_price.getString("prlist_panjabi"));
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }

        // total price from ad_order table 
        try {
            String sql_total_price = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "' and ord_bran_order = '" + pnjb_order_no + "' ";
            PreparedStatement pst_total_price = DbConnection.getConn(sql_total_price);
            ResultSet rs_total_price = pst_total_price.executeQuery();
            if (rs_total_price.next()) {
                total_price = Double.parseDouble(rs_total_price.getString("ord_total_price"));
            }
        } catch (NumberFormatException | SQLException e) {
            out.println("Total price from ad_order " + e.toString());
        }

        if (panjabi_qty <= 0) {
            double last_price = total_price - (panjabi_price_from_pricelist * panjabi_qty_from_table);
            // update ad_order table 
            try {
                String sql_update_adorder_tble = "update ad_order set ord_total_price = '" + last_price + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + pnjb_order_no + "' ";
                PreparedStatement pst_update_adorder = DbConnection.getConn(sql_update_adorder_tble);
                pst_update_adorder.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // update inventory_details
            try {
                String sql_invetory_update = "update inventory_details set pro_sell_price = '" + last_price + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + pnjb_order_no + "' and pro_deal_type = 5 ";
                PreparedStatement pst_inventory_update = DbConnection.getConn(sql_invetory_update);
                pst_inventory_update.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delete panjabi from ser_panjabi     
            try {
                String sql_panjabi_delete = "delete from ser_panjabi where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + pnjb_order_no + "' ";
                PreparedStatement pst_pnjb_delete = DbConnection.getConn(sql_panjabi_delete);
                pst_pnjb_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            // delect product from maker_order_product_info
            String p_name = "panjabi";
            try {
                String sql_delete_mk_ord_pro_info = "delete from maker_order_product_info where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + pnjb_order_no + "' and product_name = '" + p_name + "' ";
                PreparedStatement pst_delete = DbConnection.getConn(sql_delete_mk_ord_pro_info);
                pst_delete.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
            response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
        }

        //------------------------check panjabi qty between database(panjabi_qty_from_tble) to textfiel(pnjb_qty)-----------------------------------
        if (panjabi_qty_from_table > panjabi_qty) {
            pnjb_qty_diff = panjabi_qty_from_table - panjabi_qty;
            updated_price = pnjb_qty_diff * panjabi_price_from_pricelist;
            total_price = total_price - updated_price;

            try {
                // update order with price and qty in ad_order 
                String sql_order_update = "update ad_order set ord_total_price = '" + total_price + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + pnjb_order_no + "' ";
                PreparedStatement pst_order_update = DbConnection.getConn(sql_order_update);
                pst_order_update.executeUpdate();

                //update order -with price in inventory_details 
                String sql_inventory = "update inventory_details set pro_sell_price = '" + total_price + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + pnjb_order_no + "' ";
                PreparedStatement pst_inventory = DbConnection.getConn(sql_inventory);
                pst_inventory.executeUpdate();

            } catch (SQLException e) {
                out.println(e.toString());
            }
        } else if (panjabi_qty_from_table < panjabi_qty) {
            pnjb_qty_diff = panjabi_qty - panjabi_qty_from_table;
            updated_price = pnjb_qty_diff * panjabi_price_from_pricelist;
            total_price = total_price + updated_price;

            try {
                // update order with price and qty in ad_order 
                String sql_order_update = "update ad_order set ord_total_price = '" + total_price + "' where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + pnjb_order_no + "' ";
                PreparedStatement pst_order_update = DbConnection.getConn(sql_order_update);
                pst_order_update.executeUpdate();

                //update order -with price in inventory_details 
                String sql_inventory_after = "update inventory_details set pro_sell_price = '" + total_price + "' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '" + pnjb_order_no + "' ";
                PreparedStatement pst_inventory_after = DbConnection.getConn(sql_inventory_after);
                pst_inventory_after.executeUpdate();
            } catch (SQLException e) {
                out.println(e.toString());
            }
        }
        //------------------------check panjabi qty between database(panjabi_qty_from_tble) to textfiel(pnjb_qty)-----------------------------------

        // insert into msr_panjabi
        try {
            String sql_panjabi_update = "update msr_panjabi set pnjb_long = '"+pnjb_long+"', pnjb_body = '"+pnjb_body+"', pnjb_body_loose = '"+pnjb_body_loose+"' , pnjb_belly = '"+pnjb_belly+"' ,pnjb_belly_loose = '"+pnjb_belly_loose+"' , pnjb_hip = '"+pnjb_hip+"', pnjb_hip_loose = '"+pnjb_hip_loose+"',pnjb_shoulder = '"+pnjb_shoulder+"',pnjb_neck = '"+pnjb_neck+"' , pnjb_hand_long = '"+pnjb_hand_long+"',pnjb_muhuri ='"+pnjb_muhuri+"', pnjb_inner_pocket = '"+pnjb_inner_pocket+"', pnjb_plet = '"+pnjb_plet+"', pnjb_collar_type = '"+pnjb_collar_type+"',pnjb_collar_size= '"+pnjb_collar_size+"',pnjb_pocket = '"+pnjb_pocket+"',pnjb_catelog_no = '"+pnjb_catelog_no+"',pnjb_others = '"+pnjb_other+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '"+customer_mobile+"' ";                                                                                                                                                                                 
            PreparedStatement pst_panjabi_update = DbConnection.getConn(sql_panjabi_update);
            pst_panjabi_update.executeUpdate();
        } catch (SQLException e) {
            out.println("panjabi update "+e.toString());
        }
         // insert into ser_panjabi
        try {
            String sql_panjabi_update = "update ser_panjabi set pnjb_long = '"+pnjb_long+"', pnjb_body = '"+pnjb_body+"', pnjb_body_loose = '"+pnjb_body_loose+"' , panjb_belly = '"+pnjb_belly+"' ,pnjb_belly_loose = '"+pnjb_belly_loose+"' , pnjb_hip = '"+pnjb_hip+"', pnjb_hip_loose = '"+pnjb_hip_loose+"',pnjb_shoulder = '"+pnjb_shoulder+"',pnjb_neck = '"+pnjb_neck+"' , pnjb_hand_long = '"+pnjb_hand_long+"',pnjb_muhuri ='"+pnjb_muhuri+"',pnjb_inner_pocket = '"+pnjb_inner_pocket+"', pnjb_plet = '"+pnjb_plet+"', pnjb_collar_type = '"+pnjb_collar_type+"',pnjb_collar_size= '"+pnjb_collar_size+"',pnjb_pocket = '"+pnjb_pocket+"',pnjb_catelog_no = '"+pnjb_catelog_no+"',pnjb_others = '"+pnjb_other+"', qty = '"+panjabi_qty+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '"+pnjb_order_no+"' ";                                                                                                                                                                                 
            PreparedStatement pst_panjabi_update = DbConnection.getConn(sql_panjabi_update);
           int i = pst_panjabi_update.executeUpdate();
             if (i > 0) {
                session.setAttribute("pnjb_msg", "Ok");
                response.sendRedirect("/Tailor/admin/take_measure_for_order.jsp");
            } else {
                out.println("Faild");
            }
        } catch (SQLException e) {
            out.println("panjabi update "+e.toString());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
