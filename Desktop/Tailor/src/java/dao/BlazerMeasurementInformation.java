package dao;

import connection.DbConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BlazerMeasurementInformation {

    public int qtyOfBlazer(String bran_id, String order_number) {
        int blz_qty_from_tbl = 0;
        try {
            //-------------------------take blazer qty from ser_blazer----------------------------------------
            String sql_blz_qty_from_tbl = "select * from ser_blazer where bran_id = '" + bran_id + "' and order_id = '" + order_number + "' ";
            PreparedStatement pst_blz_qty_from_tbl = DbConnection.getConn(sql_blz_qty_from_tbl);
            ResultSet rs_blz_qty_from_tbl = pst_blz_qty_from_tbl.executeQuery();
            if (rs_blz_qty_from_tbl.next()) {
                blz_qty_from_tbl = Integer.parseInt(rs_blz_qty_from_tbl.getString("qty"));
            }
            return blz_qty_from_tbl;
        } catch (NumberFormatException | SQLException e) {
            System.out.println(e.toString());
            return 0;
        }
    }

    public double priceOfBlazer(String blz_bran_id) {
        double blz_price_from_price_list_table = 0;
        try {
            String sql_blz_price_from_price_list = "select * from price_list where prlist_bran_id = '" + blz_bran_id + "' ";
            PreparedStatement pst_blz_price_from_p_list = DbConnection.getConn(sql_blz_price_from_price_list);
            ResultSet rs_blz_price_from_p_list = pst_blz_price_from_p_list.executeQuery();
            if (rs_blz_price_from_p_list.next()) {
                blz_price_from_price_list_table = Double.parseDouble(rs_blz_price_from_p_list.getString("prlist_blazer"));
            }
            return blz_price_from_price_list_table;
        } catch (NumberFormatException | SQLException e) {
            System.out.println(e.toString());
            return 0;
        }
    }

    public double takeTotalPriceFromad_order(String bran_id, String order_number) {
        double total_price_from_ad_order = 0;
        try {
            String sql_totalprice_from_ad_order = "select * from ad_order where ord_bran_id = '" + bran_id + "' and ord_bran_order = '" + order_number + "' ";
            PreparedStatement pst_totalprice_from_ad_order = DbConnection.getConn(sql_totalprice_from_ad_order);
            ResultSet rs_totalprice_from_ad_order = pst_totalprice_from_ad_order.executeQuery();
            if (rs_totalprice_from_ad_order.next()) {
                total_price_from_ad_order = Double.parseDouble(rs_totalprice_from_ad_order.getString("ord_total_price"));
            }
            return total_price_from_ad_order;
        } catch (NumberFormatException | SQLException e) {
            System.out.println(e.toString());
            return 0;
        }
    }

    public int updateTotalPriceInad_Order(double last_price, String bran_id, String order_number) {
        try {
            String sql_update_adorder_tble = "update ad_order set ord_total_price = '" + last_price + "' where ord_bran_id = '" + bran_id + "' and ord_bran_order = '" + order_number + "' ";
            PreparedStatement pst_update_adorder = DbConnection.getConn(sql_update_adorder_tble);
            return pst_update_adorder.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.toString());
            return 0;
        }
    }

    public void updateTotalPriceInInventoryDetails(double last_price, String bran_id, String order_number) {
        try {
            String sql_invetory_update = "update inventory_details set pro_sell_price = '" + last_price + "' where pro_bran_id = '" + bran_id + "' and pro_invoice_id = '" + order_number + "' and pro_deal_type = 5 ";
            PreparedStatement pst_inventory_update = DbConnection.getConn(sql_invetory_update);
            pst_inventory_update.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.toString());
        }
    }

    public void deleteBlazerFromSer_Blazer(String bran_id, String order_number) {
        try {
            String sql_pant_delete = "delete from ser_blazer where bran_id = '" + bran_id + "' and order_id = '" + order_number + "' ";
            PreparedStatement pst_pnt_delete = DbConnection.getConn(sql_pant_delete);
            pst_pnt_delete.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }

    public void deleteFrom_maker_order_product_info(String bran_id, String order_number, String p_name) {
        try {
            String sql_delete_mk_ord_pro_info = "delete from maker_order_product_info where bran_id = '" + bran_id + "' and order_id = '" + order_number + "' and product_name = '" + p_name + "' ";
            PreparedStatement pst_delete = DbConnection.getConn(sql_delete_mk_ord_pro_info);
            pst_delete.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }

    public void updatePriceInOrder(double total_price_from_ad_order, String bran_id, String order_number) {
        try {
            // update order with price in ad_order 
            String sql_update_ad_order = "update ad_order set ord_total_price = '" + total_price_from_ad_order + "' where ord_bran_id = '" + bran_id + "' and ord_bran_order = '" + order_number + "' ";
            PreparedStatement pst_update_ad_order = DbConnection.getConn(sql_update_ad_order);
            pst_update_ad_order.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }

    public void updatePriceInInventoryDetails(double total_price_from_ad_order, String bran_id, String order_number) {
        try {
            String sql_inventory = "update inventory_details set pro_sell_price = '" + total_price_from_ad_order + "' where pro_bran_id = '" + bran_id + "' and pro_invoice_id = '" + order_number + "' ";
            PreparedStatement pst_inventory = DbConnection.getConn(sql_inventory);
            pst_inventory.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }
}
