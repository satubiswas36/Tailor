package servlet;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
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

public class Expend extends HttpServlet {

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

        // current date
        Date dat = new Date();
        SimpleDateFormat sformat = new SimpleDateFormat("yyyy-MM-dd");
        String c_date = sformat.format(dat);

        String amount = request.getParameter("amount");
        String description = request.getParameter("description");
        String maker_id = request.getParameter("maker_name");
        String bonus = request.getParameter("bonus");
        String date = request.getParameter("date");
        String bank_id = request.getParameter("bank_id");
        String account_no = request.getParameter("account_no");
        String page = request.getParameter("page_status");

        String entry_by = null;
        double m_amount = 0;
        double m_bonus = 0;

        // user id
        String user_id = (String) session.getAttribute("user_user_id");
        if (user_id == null) {
            user_id = (String) session.getAttribute("user_bran_id");
            entry_by = "Branch";
        } else {
            try {
                String sql_entrier_name = "select * from user_user where user_bran_id = '" + user_id + "' and user_id = '" + user_id + "' ";
                PreparedStatement pst_entrier_name = DbConnection.getConn(sql_entrier_name);
                ResultSet rs_entrier_name = pst_entrier_name.executeQuery();
                if (rs_entrier_name.next()) {
                    entry_by = rs_entrier_name.getString("user_name");
                }
            } catch (SQLException e) {
                out.println(e.toString());
            }
        }

        String status = null;
        if (page.equals("expend")) {
            status = "4";
            try {
                String sql_customer_payment = "insert into account values(?,?,?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement pst_customer_payment = DbConnection.getConn(sql_customer_payment);
                pst_customer_payment.setString(1, null);
                pst_customer_payment.setString(2, (String) session.getAttribute("user_com_id"));
                pst_customer_payment.setString(3, (String) session.getAttribute("user_bran_id"));
                pst_customer_payment.setString(4, user_id);
                pst_customer_payment.setString(5, "");
                pst_customer_payment.setString(6, description);
                pst_customer_payment.setString(7, maker_id);
                pst_customer_payment.setString(8, "0.0");
                pst_customer_payment.setString(9, amount + ".0");
                pst_customer_payment.setString(10, date);
                pst_customer_payment.setString(11, "1");
                pst_customer_payment.setString(12, status);
                pst_customer_payment.execute();
            } catch (SQLException e) {
                out.println(e.toString());
            }
        } else if (page.equals("maker_payment")) {
            status = "3";
            if (amount != null) {
                try {
                    m_amount = Double.parseDouble(amount);
                } catch (NumberFormatException e) {
                    out.println(e.toString());
                }
                if (m_amount > 0) {
                    try {
                        //  maker payment insert into account table
                        String sql_customer_payment = "insert into account values(?,?,?,?,?,?,?,?,?,?,?,?)";
                        PreparedStatement pst_customer_payment = DbConnection.getConn(sql_customer_payment);
                        pst_customer_payment.setString(1, null);
                        pst_customer_payment.setString(2, (String) session.getAttribute("user_com_id"));
                        pst_customer_payment.setString(3, (String) session.getAttribute("user_bran_id"));
                        pst_customer_payment.setString(4, user_id);
                        pst_customer_payment.setString(5, "");
                        pst_customer_payment.setString(6, description);
                        pst_customer_payment.setString(7, maker_id);
                        pst_customer_payment.setString(8, "0.0");
                        pst_customer_payment.setString(9, amount + ".0");
                        pst_customer_payment.setString(10, date);
                        pst_customer_payment.setString(11, "1");
                        pst_customer_payment.setString(12, status);
                        pst_customer_payment.execute();
                    } catch (SQLException e) {
                        out.println(e.toString());
                    }

                    try {
                        String sql_maker_cost = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                        PreparedStatement pst_maker_cost = DbConnection.getConn(sql_maker_cost);
                        pst_maker_cost.setString(1, null);
                        pst_maker_cost.setString(2, (String) session.getAttribute("user_com_id"));
                        pst_maker_cost.setString(3, (String) session.getAttribute("user_bran_id"));
                        pst_maker_cost.setString(4, user_id);
                        pst_maker_cost.setString(5, maker_id);
                        pst_maker_cost.setString(6, "0");
                        pst_maker_cost.setString(7, "0");

                        pst_maker_cost.setString(8, "0");
                        pst_maker_cost.setString(9, "0");
                        pst_maker_cost.setString(10, amount);
                        pst_maker_cost.setString(11, "0");
                        pst_maker_cost.setString(12, "0");
                        pst_maker_cost.setString(13, "0");
                        pst_maker_cost.setString(14, "2");
                        pst_maker_cost.setString(15, c_date);
                        pst_maker_cost.setString(16, null);
                        pst_maker_cost.execute();
                    } catch (SQLException e) {
                        out.println(e.toString());
                    }
                    try {
                        String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
                        PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
                        pst_bank_deposit.setString(1, (String) session.getAttribute("user_com_id"));
                        pst_bank_deposit.setString(2, (String) session.getAttribute("user_bran_id"));
                        pst_bank_deposit.setString(3, bank_id);
                        pst_bank_deposit.setString(4, account_no);
                        pst_bank_deposit.setString(5, amount);
                        pst_bank_deposit.setString(6, "0");
                        pst_bank_deposit.setString(7, c_date);
                        pst_bank_deposit.setString(8, description);
                        pst_bank_deposit.execute();

                    } catch (SQLException e) {
                        out.println(e.toString());
                    }
                }
            }
        }

        if (bonus != null) {
            double mk_bonus = 0;
            try {
                mk_bonus = Double.parseDouble(bonus);
            } catch (NumberFormatException e) {
                out.println(e.toString());
            }
            if (mk_bonus > 0) {
                try {
                    String sql_customer_payment = "insert into account values(?,?,?,?,?,?,?,?,?,?,?,?)";
                    PreparedStatement pst_customer_payment = DbConnection.getConn(sql_customer_payment);
                    pst_customer_payment.setString(1, null);
                    pst_customer_payment.setString(2, (String) session.getAttribute("user_com_id"));
                    pst_customer_payment.setString(3, (String) session.getAttribute("user_bran_id"));
                    pst_customer_payment.setString(4, user_id);
                    pst_customer_payment.setString(5, "");
                    pst_customer_payment.setString(6, "Bonus for " + maker_id);
                    pst_customer_payment.setString(7, maker_id);
                    pst_customer_payment.setString(8, "0.0");
                    pst_customer_payment.setString(9, mk_bonus + "");
                    pst_customer_payment.setString(10, date);
                    pst_customer_payment.setString(11, "1");
                    pst_customer_payment.setString(12, "3");
                    pst_customer_payment.execute();
                } catch (SQLException e) {
                    out.println(e.toString());
                }

                //maker bonus inventory_details e add hobe 
                try {
                    String sql_maker_cost = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                    PreparedStatement pst_maker_cost = DbConnection.getConn(sql_maker_cost);
                    pst_maker_cost.setString(1, null);
                    pst_maker_cost.setString(2, (String) session.getAttribute("user_com_id"));
                    pst_maker_cost.setString(3, (String) session.getAttribute("user_bran_id"));
                    pst_maker_cost.setString(4, user_id);
                    pst_maker_cost.setString(5, maker_id);
                    pst_maker_cost.setString(6, "0");
                    pst_maker_cost.setString(7, "0");

                    pst_maker_cost.setString(8, "0");
                    pst_maker_cost.setString(9, "0");
                    pst_maker_cost.setString(10, mk_bonus + "");
                    pst_maker_cost.setString(11, "0");
                    pst_maker_cost.setString(12, "0");
                    pst_maker_cost.setString(13, "0");
                    pst_maker_cost.setString(14, "7");
                    pst_maker_cost.setString(15, c_date);
                    pst_maker_cost.setString(16, null);
                    pst_maker_cost.execute();
                } catch (SQLException e) {
                    out.println(e.toString());
                }
                try {
                    String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
                    PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
                    pst_bank_deposit.setString(1, (String) session.getAttribute("user_com_id"));
                    pst_bank_deposit.setString(2, (String) session.getAttribute("user_bran_id"));
                    pst_bank_deposit.setString(3, bank_id);
                    pst_bank_deposit.setString(4, account_no);
                    pst_bank_deposit.setString(5, bonus);
                    pst_bank_deposit.setString(6, "0");
                    pst_bank_deposit.setString(7, c_date);
                    pst_bank_deposit.setString(8, description+" (Bonus)");
                    pst_bank_deposit.execute();

                } catch (SQLException e) {
                    out.println(e.toString());
                }
            }
        }
        if (page.equals("expend")) {
            session.setAttribute("expend_status", page);
            response.sendRedirect("/Tailor/admin/expend.jsp");
        }
        if (page.equals("maker_payment")) {
            session.setAttribute("maker_payment_status", page);
            response.sendRedirect("/Tailor/admin/maker_payment.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
