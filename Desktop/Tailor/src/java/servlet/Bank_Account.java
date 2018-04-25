package servlet;

import connection.DbConnection;
import dao.BankAccount;
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

public class Bank_Account extends HttpServlet {

    String com_id;
    String bran_id;

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
        BankAccount bankAccount = new BankAccount();

        if (session != null) {
            if (session.getAttribute("user_com_id") != null) {
                com_id = (String) session.getAttribute("user_com_id");
            }
            if (session.getAttribute("user_bran_id") != null) {
                bran_id = (String) session.getAttribute("user_bran_id");
            }
        }

        String bank_name = request.getParameter("bank_name");
        String branch_name = request.getParameter("branch_name");
        String account_no = request.getParameter("account_no");
        String open_date = request.getParameter("open_date");

        // old name 
        String old_bank_id = request.getParameter("old_bank_id");
        String old_account_no = request.getParameter("old_account_no");
        String old_branch_name = request.getParameter("old_branch_name");

        if (old_bank_id == null) {
            out.println("old bank id null");
            int i = bankAccount.addBankAccount(com_id, bran_id, bank_name, branch_name, account_no, open_date);
            if (i >= 1) {
                session.setAttribute("bank_account_reg_ok", "ok");
                response.sendRedirect("/Tailor/admin/open_bank_account.jsp");
            }
            out.println("i " + i);
//            try {
//                String sql_bank_acc = "insert into bank_account(bk_com_id,bk_bran_id,bk_name,bk_branch_name,bk_account_no,bk_open_date,bk_status) values(?,?,?,?,?,?,?)";
//                PreparedStatement pst_bank_acc = DbConnection.getConn(sql_bank_acc);
//                pst_bank_acc.setString(1, (String) session.getAttribute("user_com_id"));
//                pst_bank_acc.setString(2, (String) session.getAttribute("user_bran_id"));
//                pst_bank_acc.setString(3, bank_name);
//                pst_bank_acc.setString(4, branch_name);
//                pst_bank_acc.setString(5, account_no);
//                pst_bank_acc.setString(6, open_date);
//                pst_bank_acc.setString(7, "1");
//                pst_bank_acc.execute();
//                session.setAttribute("bank_account_reg_ok", "ok");
//                response.sendRedirect("/Tailor/admin/open_bank_account.jsp");
//            } catch (SQLException e) {
//                out.println("bank account create " + e.toString());
//            }
        }
        if (old_bank_id != null) {
            String account_sl = bankAccount.accountslOfAccount(bran_id, old_bank_id, old_account_no);
//            try {
//                // kono bank e account thake. tahole oi acc er bank name ta change korta hole oi accounter sl id ta lagba
//                String sql_acc_sl = "select bk_sl from bank_account where bk_bran_id = '" + session.getAttribute("user_bran_id") + "' and bk_name = '" + old_bank_id + "' and bk_account_no = '" + old_account_no + "' ";
//                PreparedStatement pst_acc_sl = DbConnection.getConn(sql_acc_sl);
//                ResultSet rs_acc_sl = pst_acc_sl.executeQuery();
//                if (rs_acc_sl.next()) {
//                    account_sl = rs_acc_sl.getString("bk_sl");
//                }
//            } catch (SQLException e) {
//                out.println(e.toString());
//            }
            // bank account update 
            bankAccount.updateAccount(bank_name, branch_name, account_no, open_date, bran_id, old_bank_id, old_branch_name, old_account_no);
//            try {
//                // bank account update 
//                String sql_update = "update bank_account set bk_name = '" + bank_name + "',bk_branch_name = '" + branch_name + "',bk_account_no = '" + account_no + "',bk_open_date = '" + open_date + "' where bk_bran_id = '" + session.getAttribute("user_bran_id") + "' and bk_name = '" + old_bank_id + "' and bk_branch_name = '" + old_branch_name + "' and bk_account_no = '" + old_account_no + "' ";
//                PreparedStatement pst_update = DbConnection.getConn(sql_update);
//                pst_update.executeUpdate();
            session.setAttribute("bank_account_update_ok", "ok");
//            } catch (SQLException e) {
//                out.println(e.toString());
//            }
//                  bank transaction update
            bankAccount.updateBankTransaction(bank_name, bran_id, old_bank_id, account_sl);
//            try {
//                // bank_transaction update
//                String sql_transaction = "update bank_transaction set bt_bank_id = '" + bank_name + "' where bt_bran_id = '" + session.getAttribute("user_bran_id") + "' and bt_bank_id = '" + old_bank_id + "' and bt_account_no = '" + account_sl + "' ";
//                PreparedStatement pst_bank_transaction = DbConnection.getConn(sql_transaction);
//                pst_bank_transaction.executeUpdate();
//            } catch (SQLException e) {
//                out.println(e.toString());
//            }
            response.sendRedirect("/Tailor/admin/bank_list.jsp");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
