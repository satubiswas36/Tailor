package servlet;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ordered extends HttpServlet {
    
    String session_id = null;
    double p = 0;
    double totalprice = 0;
    double acc_price = 0;
    int order_id;
    int bran_order_id;
    String customer_id;
    String customer_mobile;
    HttpSession session;
    String com_id;
    String bran_id;
    String user_id;
    
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
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        PrintWriter out = response.getWriter();
        session = request.getSession(false);
        // get com_id , bran_id from
        if (session.getAttribute("user_com_id") != null) {
            com_id = (String) session.getAttribute("user_com_id");
        }
        if (session.getAttribute("user_bran_id") != null) {
            bran_id = (String) session.getAttribute("user_bran_id");
        }
        if (session.getAttribute("user_user_id") != null) {
            user_id = (String) session.getAttribute("user_user_id");
        } else {
            user_id = bran_id;
        }
        // create ordered id end
        session_id = request.getParameter("sid");
        customer_id = request.getParameter("cutomer_id");

        //set order id from database 
        try {
            String slq = "select * from ad_order ORDER BY ord_snlo desc limit 1";
            PreparedStatement pst = DbConnection.getConn(slq);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                order_id = Integer.parseInt(rs.getString("ord_order_id"));
                order_id++;
            } else {
                order_id = 1;                
            }
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        
        try {
            // order for branch uniqly
            String sql_bran_order_id = "select * from ad_order where ord_bran_id = '" + session.getAttribute("user_bran_id") + "'  ORDER BY ord_snlo desc limit 1";
            PreparedStatement pst_bran_order_id = DbConnection.getConn(sql_bran_order_id);
            ResultSet rs_bran_order_id = pst_bran_order_id.executeQuery();
            if (rs_bran_order_id.next()) {
                bran_order_id = rs_bran_order_id.getInt("ord_bran_order");
                bran_order_id++;
                session.setAttribute("ord_id", bran_order_id);
            } else {
                try {
                    String sql_bran_details = "select * from user_branch where bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                    PreparedStatement pst_bran_details = DbConnection.getConn(sql_bran_details);
                    ResultSet rs_bran_details = pst_bran_details.executeQuery();
                    if (rs_bran_details.next()) {
                        bran_order_id = Integer.parseInt(rs_bran_details.getString("bran_order_no"));
                        session.setAttribute("ord_id", bran_order_id);
                    }
                } catch (NumberFormatException | SQLException e) {
                    out.println(e.toString());
                }                
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
        // take customer mobile from customer in way customer id
        try {
            String sql_customer_mobile = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + customer_id + "' ";
            PreparedStatement pst_customer_mobile = DbConnection.getConn(sql_customer_mobile);
            ResultSet rs_customer_mobile = pst_customer_mobile.executeQuery();
            if (rs_customer_mobile.next()) {
                customer_mobile = rs_customer_mobile.getString("cus_mobile");
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
        
        try {
            String ssss = "select * from temporary where session_id = '" + session_id + "' ";
            PreparedStatement pppp = DbConnection.getConn(ssss);
            ResultSet rrrr = pppp.executeQuery();
            while (rrrr.next()) {
                String pro_name = rrrr.getString(3);
                String qty = rrrr.getString(6);
                // p = Float.parseFloat(rrrr.getString(5));
                p = Double.parseDouble(rrrr.getString(5));
                totalprice = totalprice + p;  // get total price from temporary table

                try {
                    String shirt_pant = "insert into " + "ser_" + pro_name + "(com_id,bran_id,user_id,order_id,qty)" + "values( '" + com_id + "', '" + bran_id + "', '" + user_id + "' ,'" + bran_order_id + "','" + qty + "')";   // insert order id all table
                    PreparedStatement pst_shirt_pant = DbConnection.getConn(shirt_pant);
                    pst_shirt_pant.execute();
                } catch (SQLException e) {
                    e.toString();
                }
                try {
                    String sql_check_msr_shirt = "select * from " + "msr_" + pro_name + " where bran_id = '" + bran_id + "' and customer_mobile = '" + customer_mobile + "' ";
                    PreparedStatement pst_check_msr_shirt = DbConnection.getConn(sql_check_msr_shirt);
                    ResultSet rs_check_msr_shirt = pst_check_msr_shirt.executeQuery();
                    if (rs_check_msr_shirt.next()) {
                        
                    } else {
                        String shirt_pant = "insert into " + "msr_" + pro_name + "(com_id,bran_id,user_id,customer_mobile)" + "values( '" + com_id
                                + "', '" + bran_id + "', '" + user_id + "' ,'" + customer_mobile + "')";   // insert order id all table
                        PreparedStatement pst_shirt_pant = DbConnection.getConn(shirt_pant);
                        pst_shirt_pant.execute();
                    }
                    
                } catch (SQLException e) {
                    e.toString();
                }
                // product name dhore maker_order_product_info table add kora 
                try {
                    String sql_add_maker_order_info = "insert into maker_order_product_info(com_id,bran_id,user_id,order_id,product_name,mk_status) values(?,?,?,?,?,?)";
                    PreparedStatement pst_add_maker_order_info = DbConnection.getConn(sql_add_maker_order_info);
                    
                    pst_add_maker_order_info.setString(1, (String) session.getAttribute("user_com_id"));
                    pst_add_maker_order_info.setString(2, bran_id);
                    pst_add_maker_order_info.setString(3, user_id);
                    pst_add_maker_order_info.setString(4, bran_order_id + "");
                    pst_add_maker_order_info.setString(5, pro_name);
                    pst_add_maker_order_info.setString(6, "2");
                    pst_add_maker_order_info.execute();
                } catch (SQLException e) {
                    e.toString();
                }
            }
        } catch (NumberFormatException | SQLException e) {
            e.toString();
        }

        // -------------------------------delete all data from temporary table--------------------------------------------
        try {
            PreparedStatement pst_delet_tem = null;
            String sql_delet_tem = "delete from temporary where session_id = '" + session_id + "' ";
            pst_delet_tem = DbConnection.getConn(sql_delet_tem);
            pst_delet_tem.execute();
        } catch (SQLException e) {
            out.println(e.toString());
        }

        // -------------------------------//delete all data from temporary table--------------------------------------------
        try {

            // get company id from session
//            String com_id = (String) session.getAttribute("user_com_id");
//            String bran_id = (String) session.getAttribute("user_bran_id");
            String sql = "insert into ad_order(ord_com_id,ord_bran_id,ord_user_id,ord_cutomer_id,ord_order_id,ord_total_price,ord_status,ord_bran_order) value(?,?,?,?,?,?,?,?)";
            PreparedStatement pst = DbConnection.getConn(sql);
            pst.setString(1, com_id);
            pst.setString(2, bran_id);
            pst.setString(4, customer_id);
            pst.setString(3, user_id);
            pst.setString(5, order_id + "");
            pst.setString(7, "1");
            pst.setString(6, totalprice + "");
            pst.setString(8, bran_order_id + "");
            pst.execute();
        } catch (SQLException e) {
            out.println(e.toString());
        } finally {
            acc_price = totalprice;
            totalprice = 0;
        }

        //user name 
        String usr_name = (String) session.getAttribute("user_user_id");
        
        if (usr_name != null) {
            try {
                String sql_user_name = "select * from user_user where user_bran_id = '" + session.getAttribute("user_bran_id") + "' and user_id = '" + usr_name + "' ";
                PreparedStatement pst_user_name = DbConnection.getConn(sql_user_name);
                ResultSet rs_user_name = pst_user_name.executeQuery();
                if (rs_user_name.next()) {
                    usr_name = rs_user_name.getString("user_name");
                }
            } catch (SQLException e) {
                out.println(e.toString());
            }
        } else {
            usr_name = "Branch";
        }
        
        try {
            // add inventory_details table 
            // current date 
            Date dat = new Date();
            SimpleDateFormat sformat = new SimpleDateFormat("yyyy-MM-dd");
            String c_date = sformat.format(dat);
            
            int invoice_id = 101;
            String sql_insert_invoice = "insert into inventory_details(pro_com_id,pro_bran_id,pro_user_id,pro_party_id,pro_product_id,pro_invoice_id,pro_buy_quantity,pro_sell_quantity,pro_buy_paid,pro_sell_paid,pro_buy_price,pro_sell_price,pro_deal_type,pro_entry_date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst_insert_invoice = DbConnection.getConn(sql_insert_invoice);
            
            pst_insert_invoice.setString(1, (String) session.getAttribute("user_com_id"));
            pst_insert_invoice.setString(2, (String) session.getAttribute("user_bran_id"));
            pst_insert_invoice.setString(3, user_id);
            pst_insert_invoice.setString(4, customer_id);
            pst_insert_invoice.setString(5, "0");
            pst_insert_invoice.setString(6, bran_order_id + "");
            pst_insert_invoice.setString(7, "0");
            pst_insert_invoice.setString(8, "1");
            pst_insert_invoice.setString(9, "0");
            pst_insert_invoice.setString(10, "0");
            pst_insert_invoice.setString(11, "0");
            pst_insert_invoice.setString(12, acc_price + "");
            pst_insert_invoice.setString(13, "5");
            pst_insert_invoice.setString(14, c_date);
            pst_insert_invoice.execute();
            invoice_id++;
        } catch (SQLException e) {
            out.println(e.toString());
        }

        //--------------------------------- check msr_shirt if measurement is availabl then insert into ser_shirt---------------------------
        String shirt_long = null;
        String srt_long = null;
        String srt_body = null;
        String srt_body_lose = null;
        String srt_bally_loose = null;
        String srt_hip_loose = null;
        String srt_bally = null;
        String srt_hip = null;
        String srt_shoulder = null;
        String srt_neck = null;
        String srt_hand_long = null;
        String srt_hand_moja = null;
        String srt_hand_qunu = null;
        String srt_hand_cuff = null;
        String srt_types = null;
        String srt_plet = null;
        String srt_collar = null;
        String srt_collar_size = null;
        String srt_cuff_size = null;
        String srt_pocket = null;
        String srt_pocket_inner = null;
        String srt_catelog_no = null;
        String srt_others = null;
        try {
            String sql_msr_shirt = "select * from msr_shirt where customer_mobile = '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_msr_shirt = DbConnection.getConn(sql_msr_shirt);
            ResultSet rs_msr_shirt = pst_msr_shirt.executeQuery();
            while (rs_msr_shirt.next()) {
                shirt_long = rs_msr_shirt.getString("srt_long");
            }
            if (shirt_long != null) {
                try {
                    String sql_take_shirt_msr = "select * from msr_shirt where customer_mobile= '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                    PreparedStatement pst_take = DbConnection.getConn(sql_take_shirt_msr);
                    ResultSet rs_take = pst_take.executeQuery();
                    while (rs_take.next()) {
                        srt_long = rs_take.getString("srt_long");
                        srt_body = rs_take.getString("srt_body");
                        srt_body_lose = rs_take.getString("srt_body_loose");
                        srt_bally_loose = rs_take.getString("srt_bally_loose");
                        srt_hip_loose = rs_take.getString("srt_bally_loose");
                        srt_bally = rs_take.getString("srt_bally");
                        srt_hip = rs_take.getString("srt_hip");
                        srt_shoulder = rs_take.getString("srt_shoulder");
                        srt_neck = rs_take.getString("srt_neck");
                        srt_hand_long = rs_take.getString("srt_hand_long");
                        srt_hand_moja = rs_take.getString("srt_hand_moja");
                        srt_hand_qunu = rs_take.getString("srt_hand_qunu");
                        srt_hand_cuff = rs_take.getString("srt_hand_cuff");
                        srt_types = rs_take.getString("srt_types");
                        srt_plet = rs_take.getString("srt_plet");
                        srt_collar = rs_take.getString("srt_collar");
                        srt_collar_size = rs_take.getString("srt_collar_size");
                        srt_cuff_size = rs_take.getString("srt_cuff_size");
                        srt_pocket = rs_take.getString("srt_pocket");
                        srt_pocket_inner = rs_take.getString("srt_pocket_inner");
                        srt_catelog_no = rs_take.getString("srt_catelog_no");
                        srt_others = rs_take.getString("srt_others");
                    } // while ended

                    String sql_update = "update ser_shirt set srt_long = '" + srt_long + "', srt_body = '" + srt_body + "' , srt_body_loose = '" + srt_body_lose + "', srt_bally = '" + srt_bally + "', srt_hip = '" + srt_hip + "', srt_shoulder = '" + srt_shoulder + "', srt_bally_loose = '" + srt_bally_loose + "',srt_hip_loose = '" + srt_hip_loose + "', srt_neck = '" + srt_neck + "', srt_hand_long = '" + srt_hand_long + "', srt_hand_moja = '" + srt_hand_moja + "', srt_hand_qunu = '" + srt_hand_qunu + "', srt_hand_cuff = '" + srt_hand_cuff + "', srt_types = '" + srt_types + "', srt_plet = '" + srt_plet + "', srt_collar = '" + srt_collar + "', srt_collar_size = '" + srt_collar_size + "', srt_cuff_size = '" + srt_cuff_size + "', srt_pocket = '" + srt_pocket + "', srt_pocket_inner = '" + srt_pocket_inner + "', srt_catelog_no = '" + srt_catelog_no + "', srt_others = '" + srt_others + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + bran_order_id + "' ";
                    PreparedStatement pst_update = DbConnection.getConn(sql_update);
                    int i = pst_update.executeUpdate();
                    session.setAttribute("srt_msg", "ok");
                } catch (SQLException e) {
                    out.println(e.toString());
                }
                
            } // if(shirt_long) ended
        } catch (SQLException e) {
            out.println(e.toString());
        }
        // -------------------------------check msr_pant if measurement is availabl then insert into ser_pant---------------------end

        // ----------------------------------// check msr_pant if measurement is availabl then insert into ser_pant-------------------------------------
        String pant_long = null;
        String pnt_long = null;
        String pnt_comor = null;
        String pnt_hip = null;
        String pnt_mohuri = null;
        String pnt_run = null;
        String pnt_high = null;
        String pnt_fly = null;
        String pnt_kuci = null;
        String pnt_pocket_type = null;
        String pnt_pocket_backside = null;
        String pnt_pocket_inner = null;
        String pnt_mohuri_type = null;
        String pnt_loop = null;
        String pnt_loop_size = null;
        String pnt_catelog_no = null;
        String pnt_others = null;
        try {
            String sql_msr_pant = "select * from msr_pant where customer_mobile = '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_msr_pant = DbConnection.getConn(sql_msr_pant);
            ResultSet rs_msr_pant = pst_msr_pant.executeQuery();
            while (rs_msr_pant.next()) {
                pant_long = rs_msr_pant.getString("pnt_long");
            }
            if (pant_long != null) {
                try {
                    String sql_take_pant = "select * from msr_pant where customer_mobile = '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                    PreparedStatement pst_take_pant = DbConnection.getConn(sql_take_pant);
                    ResultSet rs_take_pant = pst_take_pant.executeQuery();
                    while (rs_take_pant.next()) {
                        pnt_long = rs_take_pant.getString("pnt_long");
                        pnt_comor = rs_take_pant.getString("pnt_comor");
                        pnt_hip = rs_take_pant.getString("pnt_hip");
                        pnt_mohuri = rs_take_pant.getString("pnt_mohuri");
                        pnt_run = rs_take_pant.getString("pnt_run");
                        pnt_high = rs_take_pant.getString("pnt_high");
                        pnt_fly = rs_take_pant.getString("pnt_fly");
                        pnt_kuci = rs_take_pant.getString("pnt_kuci");
                        pnt_pocket_type = rs_take_pant.getString("pnt_pocket_type");
                        pnt_pocket_backside = rs_take_pant.getString("pnt_pocket_backside");
                        pnt_pocket_inner = rs_take_pant.getString("pnt_pocket_inner");
                        pnt_mohuri_type = rs_take_pant.getString("pnt_mohuri_type");
                        pnt_loop = rs_take_pant.getString("pnt_loop");
                        pnt_loop_size = rs_take_pant.getString("pnt_loop_size");
                        pnt_catelog_no = rs_take_pant.getString("pnt_catelog_no");
                        pnt_others = rs_take_pant.getString("pnt_others");
                    }
                    String sql_pant_update = "update ser_pant set pnt_long = '" + pnt_long + "', pnt_comor = '" + pnt_comor + "', pnt_hip = '" + pnt_hip + "', pnt_mohuri = '" + pnt_mohuri + "', pnt_run = '" + pnt_run + "', pnt_high = '" + pnt_high + "', pnt_fly = '" + pnt_fly + "', pnt_kuci = '" + pnt_kuci + "', pnt_pocket_type = '" + pnt_pocket_type + "', pnt_pocket_backside = '" + pnt_pocket_backside + "', pnt_pocket_inner = '" + pnt_pocket_inner + "', pnt_mohuri_type = '" + pnt_mohuri_type + "', pnt_loop = '" + pnt_loop + "', pnt_loop_size = '" + pnt_loop_size + "', pnt_catelog_no = '" + pnt_catelog_no + "', pnt_others = '" + pnt_others + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + bran_order_id + "' ";
                    PreparedStatement pst_pant_update = DbConnection.getConn(sql_pant_update);
                    int i = pst_pant_update.executeUpdate();
                    session.setAttribute("pnt_msg", "ok");
                } catch (SQLException e) {
                    out.println(e.toString());
                }
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
        // ----------------------------------// check msr_pant if measurement is availabl then insert into ser_pant-------end-------------------------------------
        // ----------------------------------// check msr_blazer if measurement is availabl then insert into msr_blazer--------------------------------------------

        String blazer_long = null;
        String blz_long = null;
        String blz_body = null;
        String blz_bally = null;
        String blz_hip = null;
        String blz_shoulder = null;
        String blz_hand_long = null;
        String blz_hand_mohuri = null;
        String blz_cross_back = null;
        String blz_button_num = null;
        String blz_nepel = null;
        String blz_side = null;
        String blz_catelog_no = null;
        String blz_others = null;
        String best = null;
        String under = null;
        try {
            String sql_msr_blz = "select * from msr_blazer where customer_mobile = '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_msr_blz = DbConnection.getConn(sql_msr_blz);
            ResultSet rs_msr_blz = pst_msr_blz.executeQuery();
            while (rs_msr_blz.next()) {
                blazer_long = rs_msr_blz.getString("blz_long");
            }
            if (blazer_long != null) {
                try {
                    String sql_take_blz = "select * from msr_blazer where customer_mobile = '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                    PreparedStatement pst_take_blz = DbConnection.getConn(sql_take_blz);
                    ResultSet rs_take_blz = pst_take_blz.executeQuery();
                    while (rs_take_blz.next()) {
                        blz_long = rs_take_blz.getString("blz_long");
                        blz_body = rs_take_blz.getString("blz_body");
                        blz_bally = rs_take_blz.getString("blz_bally");
                        blz_hip = rs_take_blz.getString("blz_hip");
                        blz_shoulder = rs_take_blz.getString("blz_shoulder");
                        blz_hand_long = rs_take_blz.getString("blz_hand_long");
                        blz_hand_mohuri = rs_take_blz.getString("blz_hand_mohuri");
                        blz_cross_back = rs_take_blz.getString("blz_cross_back");
                        blz_button_num = rs_take_blz.getString("blz_button_num");
                        blz_nepel = rs_take_blz.getString("blz_nepel");
                        blz_side = rs_take_blz.getString("blz_side");
                        blz_catelog_no = rs_take_blz.getString("blz_catelog_no");
                        blz_others = rs_take_blz.getString("blz_others");
                        best = rs_take_blz.getString("best");
                        under = rs_take_blz.getString("under");
                    }
                    String sql_blz_update = "update ser_blazer set blz_long = '" + blz_long + "', blz_body = '" + blz_body + "', blz_bally = '" + blz_bally + "', "
                            + "blz_hip = '" + blz_hip + "', blz_shoulder = '" + blz_shoulder + "', blz_hand_long = '" + blz_hand_long + "', blz_hand_mohuri = '" + blz_hand_mohuri + "',"
                            + " blz_cross_back = '" + blz_cross_back + "' , blz_button_num = '" + blz_button_num + "', blz_nepel = '" + blz_nepel + "', blz_side = '" + blz_side + "',"
                            + " blz_catelog_no = '" + blz_catelog_no + "', blz_others = '" + blz_others + "', best = '" + best + "', "
                            + "under = '" + under + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + bran_order_id + "'  ";
                    PreparedStatement pst_blz_update = DbConnection.getConn(sql_blz_update);
                    int i = pst_blz_update.executeUpdate();
                    session.setAttribute("blz_msg", "ok");
                } catch (SQLException e) {
                    out.println(e.toString());
                }
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
        // ----------------------------------// check msr_blazer if measurement is availabl then insert into msr_blazer-------end-------------------------------------
        // ----------------------------------// check msr_photua if measurement is availabl then insert into msr_photua--------------------------------------------

        String photua_long = null;
        String pht_long = null;
        String pht_body = null;
        String pht_body_loose = null;
        String pht_bally = null;
        String pht_hip = null;
        String pht_shoulder = null;
        String pht_neck = null;
        String pht_hand_long = null;
        String pht_hand_moja = null;
        String pht_hand_qunu = null;
        String pht_hand_cuff = null;
        String pht_types = null;
        String pht_plet = null;
        String pht_collar = null;
        String pht_collar_size = null;
        String pht_cuff_size = null;
        String pht_pocket = null;
        String pht_pocket_inner = null;
        String pht_catelog_no = null;
        String pht_others = null;
        String pht_open = null;
        try {
            String sql_msr_photua = "select * from msr_photua where customer_mobile = '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_msr_photua = DbConnection.getConn(sql_msr_photua);
            ResultSet rs_msr_photua = pst_msr_photua.executeQuery();
            while (rs_msr_photua.next()) {
                photua_long = rs_msr_photua.getString("pht_long");
            }
            if (photua_long != null) {
                try {
                    String sql_take_pht = "select * from msr_photua where customer_mobile = '" + customer_mobile + "' and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                    PreparedStatement pst_take_pht = DbConnection.getConn(sql_take_pht);
                    ResultSet rs_take_pht = pst_take_pht.executeQuery();
                    while (rs_take_pht.next()) {
                        pht_long = rs_take_pht.getString("pht_long");
                        pht_body = rs_take_pht.getString("pht_body");
                        pht_body_loose = rs_take_pht.getString("pht_body_loose");
                        pht_bally = rs_take_pht.getString("pht_bally");
                        pht_hip = rs_take_pht.getString("pht_hip");
                        pht_shoulder = rs_take_pht.getString("pht_shoulder");
                        pht_neck = rs_take_pht.getString("pht_neck");
                        pht_hand_long = rs_take_pht.getString("pht_hand_long");
                        pht_hand_moja = rs_take_pht.getString("pht_hand_moja");
                        pht_hand_qunu = rs_take_pht.getString("pht_hand_qunu");
                        pht_hand_cuff = rs_take_pht.getString("pht_hand_cuff");
                        pht_types = rs_take_pht.getString("pht_types");
                        pht_plet = rs_take_pht.getString("pht_plet");
                        pht_collar = rs_take_pht.getString("pht_collar");
                        pht_collar_size = rs_take_pht.getString("pht_collar_size");
                        pht_cuff_size = rs_take_pht.getString("pht_cuff_size");
                        pht_pocket = rs_take_pht.getString("pht_pocket");
                        pht_pocket_inner = rs_take_pht.getString("pht_pocket_inner");
                        pht_catelog_no = rs_take_pht.getString("pht_catelog_no");
                        pht_others = rs_take_pht.getString("pht_others");
                        pht_open = rs_take_pht.getString("pht_open");
                    }
                    String pht_update = "update ser_photua set pht_long = '" + pht_long + "', pht_body = '" + pht_body + "', pht_body_loose = '" + pht_body_loose + "', "
                            + "pht_bally = '" + pht_bally + "', pht_hip = '" + pht_hip + "', pht_shoulder = '" + pht_shoulder + "', pht_neck = '" + pht_neck + "',"
                            + " pht_hand_long = '" + pht_hand_long + "', pht_hand_moja = '" + pht_hand_moja + "', pht_hand_qunu = '" + pht_hand_qunu + "',"
                            + " pht_hand_cuff = '" + pht_hand_cuff + "', pht_open = '" + pht_open + "', pht_types = '" + pht_types + "', pht_plet = '" + pht_plet + "', pht_collar = '" + pht_collar + "'," + " pht_collar_size = '" + pht_collar_size + "', pht_cuff_size = '" + pht_cuff_size + "', pht_pocket = '" + pht_pocket + "', pht_pocket_inner = '" + pht_pocket_inner + "',  pht_catelog_no = '" + pht_catelog_no + "', pht_others = '" + pht_others + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + bran_order_id + "' ";
                    PreparedStatement pst_pht_update = DbConnection.getConn(pht_update);
                    int i = pst_pht_update.executeUpdate();
                    session.setAttribute("pht_msg", "ok");
                } catch (SQLException e) {
                    out.println(e.toString());
                }
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
        // ----------------------------------// check msr_photua if measurement is availabl then insert into ser_photua-------end-------------------------------------
        // ---------------------------------- check msr_panjabi if measurement is availabl then insert into ser_panjabi-------end-------------------------------------

        String panjabi_long = null, pnjb_long = null, pnjb_body = null, pnjb_body_loose = null, pnjb_belly = null,
                pnjb_belly_loose = null, pnjb_hip = null, pnjb_hip_loose = null, pnjb_shoulder = null, pnjb_neck = null, pnjb_hand_long = null,
                pnjb_muhuri = null, pnjb_plet = null, pnjb_inner_pocket = null, pnjb_collar_type = null, pnjb_collar_size = null, pnjb_pocket = null, pnjb_catelog_no = null, pnjb_others = null;
        
        try {
            String sql_panjabi = "select * from msr_panjabi where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
            PreparedStatement pst_panjabi = DbConnection.getConn(sql_panjabi);
            ResultSet rs_panjabi = pst_panjabi.executeQuery();
            while (rs_panjabi.next()) {
                panjabi_long = rs_panjabi.getString("pnjb_long");
            }
            if (panjabi_long != null) {
                try {
                    String sql_pnjb = "select * from msr_panjabi where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
                    PreparedStatement pst_pnjb = DbConnection.getConn(sql_pnjb);
                    ResultSet rs_pnjb = pst_pnjb.executeQuery();
                    while (rs_pnjb.next()) {
                        pnjb_long = rs_pnjb.getString("pnjb_long");
                        pnjb_body = rs_pnjb.getString("pnjb_body");
                        pnjb_body_loose = rs_pnjb.getString("pnjb_body_loose");
                        pnjb_belly = rs_pnjb.getString("pnjb_belly");
                        pnjb_belly_loose = rs_pnjb.getString("pnjb_belly_loose");
                        pnjb_hip = rs_pnjb.getString("pnjb_hip");
                        pnjb_hip_loose = rs_pnjb.getString("pnjb_hip_loose");
                        pnjb_shoulder = rs_pnjb.getString("pnjb_shoulder");
                        pnjb_neck = rs_pnjb.getString("pnjb_neck");
                        pnjb_hand_long = rs_pnjb.getString("pnjb_hand_long");
                        pnjb_muhuri = rs_pnjb.getString("pnjb_muhuri");
                        pnjb_plet = rs_pnjb.getString("pnjb_plet");
                        pnjb_collar_type = rs_pnjb.getString("pnjb_collar_type");
                        pnjb_collar_size = rs_pnjb.getString("pnjb_collar_size");
                        pnjb_pocket = rs_pnjb.getString("pnjb_pocket");
                        pnjb_inner_pocket = rs_pnjb.getString("pnjb_inner_pocket");
                        pnjb_catelog_no = rs_pnjb.getString("pnjb_catelog_no");
                        pnjb_others = rs_pnjb.getString("pnjb_others");
                    }
                    String sql_panjabi_update = "update ser_panjabi set pnjb_long = '" + pnjb_long + "',pnjb_body = '" + pnjb_body + "', pnjb_body_loose = '" + pnjb_body_loose + "',  panjb_belly = '" + pnjb_belly + "', pnjb_belly_loose = '" + pnjb_belly_loose + "', pnjb_hip = '" + pnjb_hip + "', pnjb_hip_loose = '" + pnjb_hip_loose + "', pnjb_shoulder = '" + pnjb_shoulder + "', pnjb_neck = '" + pnjb_neck + "', pnjb_inner_pocket = '" + pnjb_inner_pocket + "', pnjb_hand_long = '" + pnjb_hand_long + "', pnjb_muhuri = '" + pnjb_muhuri + "',pnjb_plet = '" + pnjb_plet + "',pnjb_collar_type = '" + pnjb_collar_type + "',pnjb_collar_size = '" + pnjb_collar_size + "', pnjb_pocket = '" + pnjb_pocket + "',pnjb_catelog_no = '" + pnjb_catelog_no + "',pnjb_others = '" + pnjb_others + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + bran_order_id + "' ";
                    PreparedStatement pst_panjabi_update = DbConnection.getConn(sql_panjabi_update);
                    int i = pst_panjabi_update.executeUpdate();
                    session.setAttribute("pnjb_msg", "ok");
                } catch (SQLException e) {
                    out.println(e.toString());
                }
            }
        } catch (SQLException e) {
            out.println("insert into ser_panjabi from msr_panjabi " + e.toString());
        }
        // ----------------------------------// check msr_panjabi if measurement is availabl then insert into ser_panjabi-------end-------------------------------------

        // ----------------------------------check msr_payjamaif measurement is availabl then insert into ser_payjama--------------------------------------------
        String payjama_long = null;
        String pjma_long = null, pjma_comor = null, pjma_hip = null, pjma_hip_loose = null, pjma_mohuri = null, pjma_thai = null, pjma_fly = null, pjma_high = null,
                pjma_pocket = null, pjma_catelog_no = null, pjma_others = null;
        
        try {
            String sql_payjama_msr = "select * from msr_payjama where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
            PreparedStatement pst_payjama_msr = DbConnection.getConn(sql_payjama_msr);
            ResultSet rs_payjama_msr = pst_payjama_msr.executeQuery();
            while (rs_payjama_msr.next()) {
                payjama_long = rs_payjama_msr.getString("pjma_long");
            }
            if (payjama_long != null) {
                try {
                    String sql_pjma = "select * from msr_payjama where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
                    PreparedStatement pst_pjma = DbConnection.getConn(sql_pjma);
                    ResultSet rs_pjma = pst_pjma.executeQuery();
                    while (rs_pjma.next()) {
                        pjma_long = rs_pjma.getString("pjma_long");
                        pjma_comor = rs_pjma.getString("pjma_comor");
                        pjma_hip = rs_pjma.getString("pjma_hip");
                        pjma_hip_loose = rs_pjma.getString("pjma_hip_loose");
                        pjma_mohuri = rs_pjma.getString("pjma_mohuri");
                        pjma_thai = rs_pjma.getString("pjma_thai");
                        pjma_fly = rs_pjma.getString("pjma_fly");
                        pjma_high = rs_pjma.getString("pjma_high");
                        pjma_pocket = rs_pjma.getString("pjma_pocket");
                        pjma_catelog_no = rs_pjma.getString("pjma_catelog_no");
                        pjma_others = rs_pjma.getString("pjma_others");
                    }
                    String sql_payjama_update = "update ser_payjama set pjma_long = '" + pjma_long + "', pjma_comor = '" + pjma_comor + "', pjma_hip = '" + pjma_hip + "', pjma_hip_loose = '" + pjma_hip_loose + "', pjma_mohuri = '" + pjma_mohuri + "', pjma_thai = '" + pjma_thai + "',pjma_fly = '" + pjma_fly + "', pjma_high = '" + pjma_high + "', pjma_pocket = '" + pjma_pocket + "',pjma_catelog_no = '" + pjma_catelog_no + "', pjma_others = '" + pjma_others + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + bran_order_id + "' ";
                    PreparedStatement pst_payjama_update = DbConnection.getConn(sql_payjama_update);
                    int i = pst_payjama_update.executeUpdate();
                    session.setAttribute("pjma_msg", "ok");
                } catch (SQLException e) {
                    out.println("payjama update " + e.toString());
                }
            }
        } catch (SQLException e) {
            out.println("payjama " + e.toString());
        }
        // ----------------------------------check msr_payjamaif measurement is availabl then insert into ser_payjama-------end-------------------------------------
        // ----------------------------------check msr_safari measurement is availabl then insert into ser_safari--------------------------------------------
        String safari_long = null;
        String sfr_long = null, sfr_body = null, sfr_body_loose = null, sfr_belly = null, sfr_belly_loose = null, sfr_hip = null, sfr_hip_loose = null,
                sfr_shoulder = null, sfr_cross_back = null, sfr_neck = null, sfr_hand_long = null, sfr_hand_cuff = null, sfr_plet = null, sfr_collar = null, sfr_collar_size = null,
                sfr_pocket = null, sfr_back_side = null, sfr_inner_pocket = null, sfr_type = null, sfr_catelog_no = null, sfr_others = null;
        try {
            String sql_safari_msr = "select * from msr_safari where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
            PreparedStatement pst_safari_msr = DbConnection.getConn(sql_safari_msr);
            ResultSet rs_safari_msr = pst_safari_msr.executeQuery();
            if (rs_safari_msr.next()) {
                safari_long = rs_safari_msr.getString("sfr_long");
            }
            if (safari_long != null) {
                try {
                    String sql_sfr = "select * from msr_safari where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
                    PreparedStatement pst_sfr = DbConnection.getConn(sql_sfr);
                    ResultSet rs_sfr = pst_sfr.executeQuery();
                    if (rs_sfr.next()) {
                        sfr_long = rs_sfr.getString("sfr_long");
                        sfr_body = rs_sfr.getString("sfr_body");
                        sfr_body_loose = rs_sfr.getString("sfr_body_loose");
                        sfr_belly = rs_sfr.getString("sfr_belly");
                        sfr_belly_loose = rs_sfr.getString("sfr_belly_loose");
                        sfr_hip = rs_sfr.getString("sfr_hip");
                        sfr_hip_loose = rs_sfr.getString("sfr_hip_loose");
                        sfr_shoulder = rs_sfr.getString("sfr_shoulder");
                        sfr_cross_back = rs_sfr.getString("sfr_cross_back");
                        sfr_neck = rs_sfr.getString("sfr_neck");
                        sfr_hand_long = rs_sfr.getString("sfr_hand_long");
                        sfr_hand_cuff = rs_sfr.getString("sfr_hand_cuff");
                        sfr_plet = rs_sfr.getString("sfr_plet");
                        sfr_collar = rs_sfr.getString("sfr_collar");
                        sfr_collar_size = rs_sfr.getString("sfr_collar_size");
                        sfr_pocket = rs_sfr.getString("sfr_pocket");
                        sfr_inner_pocket = rs_sfr.getString("sfr_inner_pocket");
                        sfr_type = rs_sfr.getString("sfr_type");
                        sfr_back_side = rs_sfr.getString("sfr_back_side");
                        sfr_catelog_no = rs_sfr.getString("sfr_catelog_no");
                        sfr_others = rs_sfr.getString("sfr_others");
                    }
                    String sql_sfr_update = "update ser_safari set sfr_long = '" + sfr_long + "',sfr_body = '" + sfr_body + "',sfr_body_loose = '" + sfr_body_loose + "',sfr_belly = '" + sfr_belly + "',sfr_belly_loose = '" + sfr_belly_loose + "',sfr_hip = '" + sfr_hip + "',sfr_hip_loose = '" + sfr_hip_loose + "',sfr_shoulder = '" + sfr_shoulder + "',sfr_cross_back = '" + sfr_cross_back + "',sfr_neck = '" + sfr_neck + "',sfr_hand_long = '" + sfr_hand_long + "',sfr_hand_cuff = '" + sfr_hand_cuff + "',sfr_plet = '" + sfr_plet + "',sfr_collar = '" + sfr_collar + "',sfr_collar_size = '" + sfr_collar_size + "', sfr_inner_pocket = '" + sfr_inner_pocket + "', sfr_type = '" + sfr_type + "', sfr_pocket = '" + sfr_pocket + "',sfr_back_side = '" + sfr_back_side + "',sfr_catelog_no = '" + sfr_catelog_no + "',sfr_others = '" + sfr_others + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + bran_order_id + "' ";
                    PreparedStatement pst_sfr_update = DbConnection.getConn(sql_sfr_update);
                    pst_sfr_update.executeUpdate();
                    session.setAttribute("safari_msg", "ok");
                } catch (SQLException e) {
                    out.println(" safari != null" + e.toString());
                }
            }
        } catch (SQLException e) {
            out.println("take measurement from msr_safari" + e.toString());
        }
        // ----------------------------------check msr_safari measurement is availabl then insert into ser_safari-------end-------------------------------------
        // ----------------------------------check msr_mojib_cort measurement is availabl then insert into ser_mojib_cort--------------------------------------------
        String mojibcort_long = null;
        String mjc_long = null, mjc_body = null, mjc_body_loose = null, mjc_belly = null, mjc_belly_loose = null, mjc_hip = null, mjc_hip_loose = null, mjc_shoulder = null,
                mjc_neck = null, mjc_collar = null, mjc_pocket = null, mjc_inner_pocket = null, mjc_open = null, mjc_catelog_no = null, mjc_others = null;
        try {
            String sql_mojibcort_msr = "select * from msr_mojib_cort where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
            PreparedStatement pst_mojibcort_msr = DbConnection.getConn(sql_mojibcort_msr);
            ResultSet rs_mojibcort_msr = pst_mojibcort_msr.executeQuery();
            if (rs_mojibcort_msr.next()) {
                mojibcort_long = rs_mojibcort_msr.getString("mjc_long");
            }
            if (mojibcort_long != null) {
                try {
                    String sql_mjc = "select * from msr_mojib_cort where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
                    PreparedStatement pst_mjc = DbConnection.getConn(sql_mjc);
                    ResultSet rs_mjc = pst_mjc.executeQuery();
                    if (rs_mjc.next()) {
                        mjc_long = rs_mjc.getString("mjc_long");
                        mjc_body = rs_mjc.getString("mjc_body");
                        mjc_body_loose = rs_mjc.getString("mjc_body_loose");
                        mjc_belly = rs_mjc.getString("mjc_belly");
                        mjc_belly_loose = rs_mjc.getString("mjc_belly_loose");
                        mjc_hip = rs_mjc.getString("mjc_hip");
                        mjc_hip_loose = rs_mjc.getString("mjc_hip_loose");
                        mjc_shoulder = rs_mjc.getString("mjc_shoulder");
                        mjc_neck = rs_mjc.getString("mjc_neck");
                        mjc_collar = rs_mjc.getString("mjc_collar");
                        mjc_pocket = rs_mjc.getString("mjc_pocket");
                        mjc_inner_pocket = rs_mjc.getString("mjc_inner_pocket");
                        mjc_open = rs_mjc.getString("mjc_open");
                        mjc_catelog_no = rs_mjc.getString("mjc_catelog_no");
                        mjc_others = rs_mjc.getString("mjc_others");
                    }
                    String sql_mojibcort_update = "update ser_mojib_cort set mjc_long = '" + mjc_long + "',mjc_body = '" + mjc_body + "',mjc_body_loose = '" + mjc_body_loose + "',mjc_belly = '" + mjc_belly + "',mjc_belly_loose = '" + mjc_belly_loose + "',mjc_hip = '" + mjc_hip + "',mjc_hip_loose = '" + mjc_hip_loose + "',mjc_shoulder = '" + mjc_shoulder + "', mjc_neck = '" + mjc_neck + "',mjc_collar = '" + mjc_collar + "',mjc_pocket = '" + mjc_pocket + "',mjc_open = '" + mjc_open + "',mjc_catelog_no = '" + mjc_catelog_no + "',mjc_others = '" + mjc_others + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + bran_order_id + "' ";
                    PreparedStatement pst_mojibcort_update = DbConnection.getConn(sql_mojibcort_update);
                    pst_mojibcort_update.executeUpdate();
                    session.setAttribute("mojib_cort_msg", "ok");
                } catch (SQLException e) {
                    out.println(" mojibcort_long != null " + e.toString());
                }
            }
        } catch (SQLException e) {
            out.println("mojib cort measurement " + e.toString());
        }
        // ----------------------------------check msr_mojib_cort measurement is availabl then insert into ser_mojib_cort-------end-------------------------------------
        // ----------------------------------check msr_kable measurement is availabl then insert into ser_mojib_kable-------------------------------------------
        String kable_long = null;
        String kbl_long = null, kbl_body = null, kbl_body_loose = null, kbl_belly = null, kbl_belly_loose = null, kbl_hip = null, kbl_hip_loose = null, kbl_shoulder = null,
                kbl_neck = null, kbl_hand_long = null, kbl_muhuri = null, kbl_plet = null, kbl_collar_type = null, kbl_collar_size = null, kbl_pocket = null, kbl_catelog_no = null,
                kbl_others = null;
        try {
            String sql_kable = "select * from msr_kable where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
            PreparedStatement pst_kable = DbConnection.getConn(sql_kable);
            ResultSet rs_kable = pst_kable.executeQuery();
            if (rs_kable.next()) {
                kable_long = rs_kable.getString("kbl_long");
            }
            if (kable_long != null) {
                String sql_kbl = "select * from msr_kable where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
                PreparedStatement pst_kbl = DbConnection.getConn(sql_kbl);
                ResultSet rs_kbl = pst_kbl.executeQuery();
                if (rs_kbl.next()) {
                    kbl_long = rs_kbl.getString("kbl_long");
                    kbl_body = rs_kbl.getString("kbl_body");
                    kbl_body_loose = rs_kbl.getString("kbl_body_loose");
                    kbl_belly = rs_kbl.getString("kbl_belly");
                    kbl_belly_loose = rs_kbl.getString("kbl_belly_loose");
                    kbl_hip = rs_kbl.getString("kbl_hip");
                    kbl_hip_loose = rs_kbl.getString("kbl_hip_loose");
                    kbl_shoulder = rs_kbl.getString("kbl_shoulder");
                    kbl_neck = rs_kbl.getString("kbl_neck");
                    kbl_hand_long = rs_kbl.getString("kbl_hand_long");
                    kbl_muhuri = rs_kbl.getString("kbl_muhuri");
                    kbl_plet = rs_kbl.getString("kbl_plet");
                    kbl_collar_type = rs_kbl.getString("kbl_collar_type");
                    kbl_collar_size = rs_kbl.getString("kbl_collar_size");
                    kbl_pocket = rs_kbl.getString("kbl_pocket");
                    kbl_catelog_no = rs_kbl.getString("kbl_catelog_no");
                    kbl_others = rs_kbl.getString("kbl_others");
                }
                String sql_kbl_update = "update ser_kable set kbl_long = '" + kbl_long + "',kbl_body = '" + kbl_body + "',kbl_body_loose = '" + kbl_body_loose + "',kbl_belly = '" + kbl_belly + "',kbl_belly_loose = '" + kbl_belly_loose + "',kbl_hip = '" + kbl_hip + "',kbl_hip_loose = '" + kbl_hip_loose + "',kbl_shoulder = '" + kbl_shoulder + "',kbl_neck = '" + kbl_neck + "',kbl_hand_long = '" + kbl_hand_long + "',kbl_muhuri = '" + kbl_muhuri + "',kbl_plet = '" + kbl_plet + "',kbl_collar_type = '" + kbl_collar_type + "',kbl_collar_size = '" + kbl_collar_size + "',kbl_pocket = '" + kbl_pocket + "',kbl_catelog_no = '" + kbl_catelog_no + "',kbl_others = '" + kbl_others + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + bran_order_id + "' ";
                PreparedStatement pst_kbl_update = DbConnection.getConn(sql_kbl_update);
                pst_kbl_update.executeUpdate();
                session.setAttribute("kable_msg", "ok");
            }
        } catch (SQLException e) {
            out.println("measurement kable " + e.toString());
        }
        // ----------------------------------check msr_kable measurement is availabl then insert into ser_kable------end-------------------------------------
        // ----------------------------------check msr_koti measurement is availabl then insert into ser_koti-------------------------------------------
        String koti_long = null;
        String kt_long = null, kt_body = null, kt_body_loose = null, kt_belly = null, kt_belly_loose = null, kt_hip = null, kt_hip_loose = null, kt_shoulder = null,
                kt_pocket = null, kt_belt = null, kt_catelog_no = null, kt_others = null;
        try {
            String sql_koti = "select * from msr_koti where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
            PreparedStatement pst_koti = DbConnection.getConn(sql_koti);
            ResultSet rs_koti = pst_koti.executeQuery();
            if (rs_koti.next()) {
                koti_long = rs_koti.getString("kt_long");
            }
            if (koti_long != null) {
                String sql_kt = "select * from msr_koti where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile + "' ";
                PreparedStatement pst_kt = DbConnection.getConn(sql_kt);
                ResultSet rs_kt = pst_kt.executeQuery();
                if (rs_kt.next()) {
                    kt_long = rs_kt.getString("kt_long");
                    kt_body = rs_kt.getString("kt_body");
                    kt_body_loose = rs_kt.getString("kt_body_loose");
                    kt_belly = rs_kt.getString("kt_belly");
                    kt_belly_loose = rs_kt.getString("kt_belly_loose");
                    kt_hip = rs_kt.getString("kt_hip");
                    kt_hip_loose = rs_kt.getString("kt_hip_loose");
                    kt_shoulder = rs_kt.getString("kt_shoulder");
                    //kt_neck = rs_kt.getString("kt_neck");
                    kt_pocket = rs_kt.getString("kt_pocket");
                    kt_belt = rs_kt.getString("kt_belt");
                    kt_catelog_no = rs_kt.getString("kt_catelog_no");
                    kt_others = rs_kt.getString("kt_others");
                }
                String sql_kt_update = "update ser_koti set kt_long = '" + kt_long + "',kt_body = '" + kt_body + "',kt_body_loose = '" + kt_body_loose + "',kt_belly = '" + kt_belly + "',kt_belly_loose = '" + kt_belly_loose + "',kt_hip = '" + kt_hip + "',kt_hip_loose = '" + kt_hip_loose + "',kt_shoulder = '" + kt_shoulder + "',kt_pocket = '" + kt_pocket + "',kt_belt = '" + kt_belt + "',kt_catelog_no = '" + kt_catelog_no + "',kt_others = '" + kt_others + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + bran_order_id + "' ";
                PreparedStatement pst_kt_update = DbConnection.getConn(sql_kt_update);
                pst_kt_update.executeUpdate();
                session.setAttribute("koti_msg", "ok");
            }
        } catch (SQLException e) {
            out.println("koti measurement " + e.toString());
        }
        // ----------------------------------check msr_koti measurement is availabl then insert into ser_koti------end-------------------------------------
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
