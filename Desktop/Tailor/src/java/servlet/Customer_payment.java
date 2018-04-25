package servlet;

import connection.DbConnection;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Customer_payment extends HttpServlet {

    String bran_id = null;
    String user_id = null;

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
        HttpSession session = request.getSession();
        String entry_by = null;
        // current date
        Date dat = new Date();
        SimpleDateFormat sformat = new SimpleDateFormat("yyyy-MM-dd");
        String c_date = sformat.format(dat);
        if (session.getAttribute("user_bran_id") != null) {
            String paymnet_bran_id = (String) session.getAttribute("user_bran_id");
            bran_id = paymnet_bran_id;
        }
        if (session.getAttribute("user_user_id") != null) {
            String paymnet_user_id = (String) session.getAttribute("user_user_id");
            user_id = paymnet_user_id;
            try {
                String user_name = "select * from user_user where user_bran_id = '" + session.getAttribute("user_bran_id") + "' and user_id = '" + user_id + "' ";
                PreparedStatement pst_user_name = DbConnection.getConn(user_name);
                ResultSet rs_user_name = pst_user_name.executeQuery();
                if (rs_user_name.next()) {
                    entry_by = rs_user_name.getString("user_name");
                }
            } catch (SQLException e) {
                out.println(e.toString());
            }
        }
        if (user_id == null) {
            user_id = bran_id;
            entry_by = "Branch";
        }
        String customer_id = request.getParameter("cus_name");
        String customer_description = request.getParameter("customer_description");
        String customer_payment_amount = request.getParameter("customer_payment");
        String customer_payment_date = request.getParameter("customer_payment_date");
        String customer_discount = request.getParameter("customer_discount");
        String bank_id = request.getParameter("bank_id");
        String account_no = request.getParameter("account_no");
        // customer details
        String customer_mobile = null;
        String message_time = null;
        try {
            String sql_customer_details = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + customer_id + "' ";
            PreparedStatement pst_customer_details = DbConnection.getConn(sql_customer_details);
            ResultSet rs_customer_details = pst_customer_details.executeQuery();
            if (rs_customer_details.next()) {
                customer_mobile = rs_customer_details.getString("cus_mobile");
                //message_time = rs_customer_details.getString("cus_message_time");
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
        int order_id = 0;
        if (session.getAttribute("ord_id") != null) {
            order_id = Integer.parseInt(session.getAttribute("ord_id").toString());
        }
        double cus_dis = 0;
        if (customer_discount != null) {
            cus_dis = Double.parseDouble(customer_discount);
        }
        double cus_pay = 0;
        if (customer_payment_amount != null) {
            try {
                cus_pay = Double.parseDouble(customer_payment_amount);
                
                if (cus_pay > 0) {
                    // add account table
                    try {
                        String sql_customer_payment = "insert into account values(?,?,?,?,?,?,?,?,?,?,?,?)";
                        PreparedStatement pst_customer_payment = DbConnection.getConn(sql_customer_payment);
                        pst_customer_payment.setString(1, null);
                        pst_customer_payment.setString(2, (String) session.getAttribute("user_com_id"));
                        pst_customer_payment.setString(3, bran_id);
                        pst_customer_payment.setString(4, user_id);
                        pst_customer_payment.setString(5, "");
                        pst_customer_payment.setString(6, customer_description);
                        pst_customer_payment.setString(7, customer_id);
                        pst_customer_payment.setString(8,  (cus_pay - cus_dis) + "");
                        pst_customer_payment.setString(9, "0");
                        pst_customer_payment.setString(10, customer_payment_date);
                        pst_customer_payment.setString(11, "1");
                        pst_customer_payment.setString(12, "1");
                        pst_customer_payment.execute();
                    } catch (SQLException e) {
                        out.println(e.toString());
                    }
                    try {
                        // add inventory_details table
                        int invoice_id = 101;
                        String sql_insert_invoice = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                        PreparedStatement pst_insert_invoice = DbConnection.getConn(sql_insert_invoice);
                        pst_insert_invoice.setString(1, null);
                        pst_insert_invoice.setString(2, (String) session.getAttribute("user_com_id"));
                        pst_insert_invoice.setString(3, (String) session.getAttribute("user_bran_id"));
                        pst_insert_invoice.setString(4, user_id);
                        pst_insert_invoice.setString(5, customer_id);
                        pst_insert_invoice.setString(6, "0");
                        pst_insert_invoice.setString(7, "0");
                        pst_insert_invoice.setString(8, "0");
                        pst_insert_invoice.setString(9, "0");
                        pst_insert_invoice.setString(10, "0");
                        pst_insert_invoice.setString(11, (cus_pay - cus_dis) + "");
                        pst_insert_invoice.setString(12, "0");
                        pst_insert_invoice.setString(13, "0");
                        pst_insert_invoice.setString(14, "1");
                        pst_insert_invoice.setString(15, c_date);
                        pst_insert_invoice.setString(16, null);
                        pst_insert_invoice.execute();
                        invoice_id++;
                    } catch (SQLException e) {
                        out.println(e.toString());
                    }
                    if (!bank_id.equals("no")) {
                        try {
                            String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
                            PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
                            pst_bank_deposit.setString(1, (String) session.getAttribute("user_com_id"));
                            pst_bank_deposit.setString(2, (String) session.getAttribute("user_bran_id"));
                            pst_bank_deposit.setString(3, bank_id);
                            pst_bank_deposit.setString(4, account_no);
                            pst_bank_deposit.setString(5, "0");
                            pst_bank_deposit.setString(6, (long) cus_pay + "");
                            pst_bank_deposit.setString(7, customer_payment_date);
                            pst_bank_deposit.setString(8, customer_description);
                            pst_bank_deposit.execute();
                            
                        } catch (SQLException e) {
                            out.println(e.toString());
                        }
                    }
                }
            } catch (NumberFormatException e) {
                out.println(e.toString());
            }
        }
        if (customer_discount != null) {
            try {
                cus_dis = Double.parseDouble(customer_discount);
                if (cus_dis > 0) {
                    try {
                        // add inventory_details table
                        int invoice_id = 101;
                        String sql_insert_invoice = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                        PreparedStatement pst_insert_invoice = DbConnection.getConn(sql_insert_invoice);
                        pst_insert_invoice.setString(1, null);
                        pst_insert_invoice.setString(2, (String) session.getAttribute("user_com_id"));
                        pst_insert_invoice.setString(3, (String) session.getAttribute("user_bran_id"));
                        pst_insert_invoice.setString(4, user_id);
                        pst_insert_invoice.setString(5, customer_id);
                        pst_insert_invoice.setString(6, "0");
                        pst_insert_invoice.setString(7, "0");
                        
                        pst_insert_invoice.setString(8, "0");
                        pst_insert_invoice.setString(9, "0");
                        pst_insert_invoice.setString(10, "0");
                        pst_insert_invoice.setString(11, cus_dis + "");
                        pst_insert_invoice.setString(12, "0");
                        pst_insert_invoice.setString(13, "0");
                        pst_insert_invoice.setString(14, "6");
                        pst_insert_invoice.setString(15, c_date);
                        pst_insert_invoice.setString(16, null);
                        pst_insert_invoice.execute();
                        invoice_id++;
                    } catch (SQLException e) {
                        out.println(e.toString());
                    }
                }
            } catch (NumberFormatException e) {
                out.println(e.toString());
            }
        }
        //-----------------------------------------------------------customer due------------------------------------------------------------------------
        double total_debit = 0;
        double total_credit = 0;
        double balance = 0;
        double sell_qty = 0;
        //String user_name = null;
        // for debit
        PreparedStatement pst_debit = null;
        ResultSet rs_debit = null;
        try {
            String sql_debit = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + customer_id + "' and (pro_deal_type = 5 or pro_deal_type = 1 or pro_deal_type = 4 or pro_deal_type = 6)";
            pst_debit = DbConnection.getConn(sql_debit);
            rs_debit = pst_debit.executeQuery();
            while (rs_debit.next()) {
                String debit = rs_debit.getString("pro_sell_price");
                sell_qty = Double.parseDouble(rs_debit.getString("pro_sell_quantity"));
                String credit = rs_debit.getString("pro_sell_paid");
                total_debit += (Double.parseDouble(debit) * sell_qty);
                total_credit += Double.parseDouble(credit);
            }
            balance = total_debit - total_credit;
        } catch (Exception e) {
            out.println(e.toString());
        }
        //-----------------------------------------------------------//customer due------------------------------------------------------------------------
        // bran name and mobile
        String bran_name = null;
        String bran_mobile = null;
        String bran_sender_id = null;
        try {
            String sql_bran = "select * from user_branch where bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_bran = DbConnection.getConn(sql_bran);
            ResultSet rs_bran = pst_bran.executeQuery();
            if (rs_bran.next()) {
                bran_name = rs_bran.getString("bran_name");
                bran_mobile = rs_bran.getString("bran_mobile");
                bran_sender_id = rs_bran.getString("bran_sender_id");
                message_time = rs_bran.getString("bran_message_time");
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
        if (customer_payment_amount != null) {
            if (cus_pay > 0) {
                String message_sent = null;
                if (message_time != null) {
                    if (message_time.contains("payment_pay")) {
                        String initMsg = "Your payment amount is " + (cus_pay - cus_dis) + "0 tk. Total Due " + balance + "0 tk. Please contact for more details " + bran_mobile + " " + bran_name + "";
                        String finalMsg = initMsg.replace(" ", "%20");
                        String msg_url = "http://sms.iglweb.com/smsapi?api_key=C200008259ec2e6ec8f768.04047558&type=text&contacts=" + customer_mobile + "&senderid=" + bran_sender_id + "&msg=" + finalMsg;
                        URL oracle = new URL(msg_url);
                        BufferedReader in = new BufferedReader(new InputStreamReader(oracle.openStream()));
                        String inputLine;
                        while ((inputLine = in.readLine()) != null) {
                            message_sent = inputLine;
                            out.println(inputLine);
                        }
                        in.close();
                    }
                }
                
                if (message_sent != null) {
                    if (message_sent.length() > 4) {
                        try {
                            String sql_msg_count = "select * from msg_table where msg_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                            PreparedStatement pst_msg_count = DbConnection.getConn(sql_msg_count);
                            ResultSet rs_msg_count = pst_msg_count.executeQuery();
                            if (rs_msg_count.next()) {
                                int msg_qty = Integer.parseInt(rs_msg_count.getString("msg_qty"));
                                msg_qty++;
                                try {
                                    String sql_msg_update = "update msg_table set msg_qty = '" + msg_qty + "' where msg_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                    PreparedStatement pst_msg_update = DbConnection.getConn(sql_msg_update);
                                    pst_msg_update.executeUpdate();
                                } catch (Exception e) {
                                    out.println(e.toString());
                                }
                            } else {
                                try {
                                    String sql_msg_insert = "insert into msg_table values(?,?,?,?)";
                                    PreparedStatement pst_msg_insert = DbConnection.getConn(sql_msg_insert);
                                    pst_msg_insert.setString(1, null);
                                    pst_msg_insert.setString(2, (String) session.getAttribute("user_com_id"));
                                    pst_msg_insert.setString(3, (String) session.getAttribute("user_bran_id"));
                                    pst_msg_insert.setString(4, "1");
                                    pst_msg_insert.executeUpdate();
                                } catch (SQLException e) {
                                    out.println(e.toString());
                                }
                            }
                        } catch (NumberFormatException | SQLException e) {
                            out.println(e.toString());
                        }
                    }
                }
            }
        }      
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
