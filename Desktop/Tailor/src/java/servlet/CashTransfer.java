package servlet;

import dao.Account_For_CashTransfer;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CashTransfer extends HttpServlet {

    private String bran_id;
    private String com_id;
    private String user_id;

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
        Account_For_CashTransfer cashTransfer = new Account_For_CashTransfer();
        if (session != null) {
            if (session.getAttribute("user_bran_id") != null) {
                bran_id = (String) session.getAttribute("user_bran_id");
            }
            if (session.getAttribute("user_com_id") != null) {
                com_id = (String) session.getAttribute("user_com_id");
            }
        }

        String from_bank_id = request.getParameter("from_bank_name");
        String to_bank_id = request.getParameter("to_bank_name");
        String from_account_sl = request.getParameter("from_account_no");
        String to_account_sl = request.getParameter("to_account_no");
        String amount = request.getParameter("amount");
        String description = request.getParameter("description");

        // from bank name 
        String from_bank_name = cashTransfer.fromBankName(from_bank_id);
//        try {
//            String sql_from_bank_name = "select bank_name from bank where sl = '" + from_bank_id + "' ";
//            PreparedStatement pst_from_bank_name = DbConnection.getConn(sql_from_bank_name);
//            ResultSet rs_from_bank_name = pst_from_bank_name.executeQuery();
//            if (rs_from_bank_name.next()) {
//                from_bank_name = rs_from_bank_name.getString("bank_name");
//            }
//        } catch (SQLException e) {
//            out.println(e.toString());
//        }

        // to  bank name 
        String to_bank_name = cashTransfer.toBankName(to_bank_id);
//        try {
//            String sql_to_bank_name = "select bank_name from bank where sl = '" + to_bank_id + "' ";
//            PreparedStatement pst_to_bank_name = DbConnection.getConn(sql_to_bank_name);
//            ResultSet rs_to_bank_name = pst_to_bank_name.executeQuery();
//            if (rs_to_bank_name.next()) {
//                to_bank_name = rs_to_bank_name.getString("bank_name");
//            }
//        } catch (SQLException e) {
//            out.println(e.toString());
//        }

        //from account no 
        String from_account_no = cashTransfer.fromAccount(bran_id, from_account_sl);
//        try {
//            String sql_from_acc_no = "select bk_account_no from bank_account where bk_bran_id = '" + session.getAttribute("user_bran_id") + "' and bk_sl = '" + from_account_sl + "' ";
//            PreparedStatement pst_from_acc_no = DbConnection.getConn(sql_from_acc_no);
//            ResultSet rs_from_acc_no = pst_from_acc_no.executeQuery();
//            if (rs_from_acc_no.next()) {
//                from_account_no = rs_from_acc_no.getString("bk_account_no");
//            }
//        } catch (SQLException e) {
//            out.println(e.toString());
//        }

        //to account no 
        String to_account_no = cashTransfer.to_Account_No(bran_id, to_account_sl);
//        try {
//            String sql_to_acc_no = "select bk_account_no from bank_account where bk_bran_id = '" + session.getAttribute("user_bran_id") + "' and bk_sl = '" + to_account_sl + "' ";
//            PreparedStatement pst_to_acc_no = DbConnection.getConn(sql_to_acc_no);
//            ResultSet rs_to_acc_no = pst_to_acc_no.executeQuery();
//            if (rs_to_acc_no.next()) {
//                to_account_no = rs_to_acc_no.getString("bk_account_no");
//            }
//        } catch (SQLException e) {
//            out.println(e.toString());
//        }

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String date_f = dateFormat.format(date);

        // cash withdraw(debit)
        int withdraw = cashTransfer.cashWithDrawForTransfer(bran_id, com_id, from_bank_id, from_account_sl, amount, date_f, description, to_bank_name, to_account_no);
        if (withdraw >= 1) {
            session.setAttribute("cash_withdraw", "ok");
        }
//        try {
//            String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
//            PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
//            pst_bank_deposit.setString(1, (String) session.getAttribute("user_com_id"));
//            pst_bank_deposit.setString(2, (String) session.getAttribute("user_bran_id"));
//            pst_bank_deposit.setString(3, from_bank_id);
//            pst_bank_deposit.setString(4, from_account_sl);
//            pst_bank_deposit.setString(5, amount);
//            pst_bank_deposit.setString(6, "0");
//            pst_bank_deposit.setString(7, date_f);
//            pst_bank_deposit.setString(8, description + " Cash Transfer to Bank: " + to_bank_name + " and Account No: " + to_account_no);
//            pst_bank_deposit.execute();
//            session.setAttribute("cash_withdraw", "ok");
//        } catch (SQLException e) {
//            out.println(e.toString());
//        }

        // cash deposit (credit)
        int deposit = cashTransfer.cashDepositForTransfer(bran_id, com_id, to_bank_id, to_account_sl, amount, date_f, description, from_bank_name, from_account_no);
        if (deposit >= 1) {
            session.setAttribute("cash_deposit", "ok");
        }
//        try {
//            String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
//            PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
//            pst_bank_deposit.setString(1, (String) session.getAttribute("user_com_id"));
//            pst_bank_deposit.setString(2, (String) session.getAttribute("user_bran_id"));
//            pst_bank_deposit.setString(3, to_bank_id);
//            pst_bank_deposit.setString(4, to_account_sl);
//            pst_bank_deposit.setString(5, "0");
//            pst_bank_deposit.setString(6, amount);
//            pst_bank_deposit.setString(7, date_f);
//            pst_bank_deposit.setString(8, description + " Cash Transfer from Bank " + from_bank_name + " and Account No " + from_account_no);
//            pst_bank_deposit.execute();
//            session.setAttribute("cash_deposit", "ok");
//        } catch (SQLException e) {
//            out.println(e.toString());
//        }
        response.sendRedirect("/Tailor/admin/cash_transfer.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
