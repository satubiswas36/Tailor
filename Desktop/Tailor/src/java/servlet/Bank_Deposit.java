package servlet;

import connection.DbConnection;
import dao.BankTransaction;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Bank_Deposit extends HttpServlet {
    String com_id = null;
    String bran_id = null;

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
        BankTransaction bankTransaction = new BankTransaction();
        if(session != null){
          if(session.getAttribute("user_com_id") != null){
              com_id  = (String)session.getAttribute("user_com_id");
          }
          if(session.getAttribute("user_bran_id") != null){
              bran_id  = (String)session.getAttribute("user_bran_id");
          }
        }

        String bank_id = request.getParameter("bank_name");
        String account_no = request.getParameter("account_no");
        String amount = request.getParameter("payment_amount");
        String reference = request.getParameter("reference");
        String payment_date = request.getParameter("to_date");
        String status = request.getParameter("p_status");

        if (status != null) {
            if (status.equals("deposit")) {
                int deposit = bankTransaction.addDeposit(com_id, bran_id, bank_id, account_no, amount, payment_date, reference);
                if (deposit >= 1) {
                    session.setAttribute("deposit_status", "ok");
                    response.sendRedirect("/Tailor/admin/add_bank_deposit.jsp");
                }
//                try {
//                    String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
//                    PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
//                    pst_bank_deposit.setString(1, (String) session.getAttribute("user_com_id"));
//                    pst_bank_deposit.setString(2, (String) session.getAttribute("user_bran_id"));
//                    pst_bank_deposit.setString(3, bank_id);
//                    pst_bank_deposit.setString(4, account_no);
//                    pst_bank_deposit.setString(5, "0");
//                    pst_bank_deposit.setString(6, amount);
//                    pst_bank_deposit.setString(7, payment_date);
//                    pst_bank_deposit.setString(8, reference);
//                    pst_bank_deposit.execute();
//                    session.setAttribute("deposit_status", "ok");
//                    response.sendRedirect("/Tailor/admin/add_bank_deposit.jsp");
//                } catch (SQLException e) {
//                    out.println(e.toString());
//                }
            }
            if (status.equals("withdraw")) {
                int withdraw = bankTransaction.addWithDraw(com_id, bran_id, bank_id, account_no, amount, payment_date, reference);
                if (withdraw >= 1) {
                    session.setAttribute("withdraw_status", "ok");
                    response.sendRedirect("/Tailor/admin/add_bank_withdraw.jsp");
                }
//                try {
//                    String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
//                    PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
//                    pst_bank_deposit.setString(1, (String) session.getAttribute("user_com_id"));
//                    pst_bank_deposit.setString(2, (String) session.getAttribute("user_bran_id"));
//                    pst_bank_deposit.setString(3, bank_id);
//                    pst_bank_deposit.setString(4, account_no);
//                    pst_bank_deposit.setString(5, amount);
//                    pst_bank_deposit.setString(6, "0");
//                    pst_bank_deposit.setString(7, payment_date);
//                    pst_bank_deposit.setString(8, reference);
//                    pst_bank_deposit.execute();
//                    session.setAttribute("withdraw_status", "ok");
//                    response.sendRedirect("/Tailor/admin/add_bank_withdraw.jsp");
//                } catch (SQLException e) {
//                    out.println(e.toString());
//                }
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
