package servlet;

import connection.DbConnection;
import dao.SupplierPayment;
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

public class AddSupplierPyament extends HttpServlet {

    String com_id = null;
    String bran_id = null;
    String user_id = null;

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
        SupplierPayment supplierPayment = new SupplierPayment();
        // current date 
        Date date = new Date();
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
        String c_date = sd.format(date);

        if (session.getAttribute("user_com_id") != null) {
            com_id = (String) session.getAttribute("user_com_id");
        }
        if (session.getAttribute("user_bran_id") != null) {
            bran_id = (String) session.getAttribute("user_bran_id");
        }
        if (session.getAttribute("user_user_id") != null) {
            user_id = (String) session.getAttribute("user_user_id");
        } else {
            user_id = (String) session.getAttribute("user_bran_id");
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

        String company_id = request.getParameter("supplier_id");
        String payment = request.getParameter("amount");
        String discount = request.getParameter("discount");
        String description = request.getParameter("description");
        String bank_id = request.getParameter("bank_id");
        String account_no = request.getParameter("accountno");

        if (payment != null) {
            double dpayment = 0;
            double ddiscountt = 0;
            if (discount != null) {
                ddiscountt = Double.parseDouble(discount);
            }
            try {
                dpayment = Double.parseDouble(payment);
            } catch (NumberFormatException e) {
                out.println(e.toString());
            }
            if (dpayment > 0) {
                //for account     
                supplierPayment.paymentAddInAccount(com_id, bran_id, user_id, description, company_id, dpayment, ddiscountt, c_date);
//                try {
//                    String sql_customer_payment = "insert into account values(?,?,?,?,?,?,?,?,?,?,?,?)";
//                    PreparedStatement pst_customer_payment = DbConnection.getConn(sql_customer_payment);
//                    pst_customer_payment.setString(1, null);
//                    pst_customer_payment.setString(2, com_id);
//                    pst_customer_payment.setString(3, bran_id);
//                    pst_customer_payment.setString(4, user_id);
//                    pst_customer_payment.setString(5, "");
//                    pst_customer_payment.setString(6, description);
//                    pst_customer_payment.setString(7, company_id);
//                    pst_customer_payment.setString(8, "0.0");
//                    pst_customer_payment.setString(9, (dpayment-ddiscountt)+"");
//                    pst_customer_payment.setString(10, c_date);
//                    pst_customer_payment.setString(11, "1");
//                    pst_customer_payment.setString(12, "5");
//                    pst_customer_payment.execute();
//                } catch (SQLException e) {
//                    out.println(e.toString());
//                }

                // for inventory 
                supplierPayment.paymentAddInInventory(com_id, bran_id, user_id, company_id, dpayment, ddiscountt, c_date);
//                try {
//                    String sql_insert_invoice = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
//                    PreparedStatement pst_insert_invoice = DbConnection.getConn(sql_insert_invoice);
//                    pst_insert_invoice.setString(1, null);
//                    pst_insert_invoice.setString(2, (String) session.getAttribute("user_com_id"));
//                    pst_insert_invoice.setString(3, (String) session.getAttribute("user_bran_id"));
//                    pst_insert_invoice.setString(4, user_id);
//                    pst_insert_invoice.setString(5, company_id);
//                    pst_insert_invoice.setString(6, "0");
//                    pst_insert_invoice.setString(7, "0");
//                    pst_insert_invoice.setString(8, "0");
//                    pst_insert_invoice.setString(9, "1");
//                    pst_insert_invoice.setString(10, (dpayment-ddiscountt)+"");
//                    pst_insert_invoice.setString(11, "0");
//                    pst_insert_invoice.setString(12, "0");
//                    pst_insert_invoice.setString(13, "0");
//                    pst_insert_invoice.setString(14, "3");
//                    pst_insert_invoice.setString(15, c_date);
//                    pst_insert_invoice.setString(16, null);
//                    pst_insert_invoice.execute();
//                } catch (SQLException e) {
//                    out.println(e.toString());
//                }
                // add in bank_transaction
                supplierPayment.paymentAddInBankTransaction(com_id, bran_id, bank_id, account_no, dpayment, ddiscountt, c_date, description);
//                try {
//                    String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
//                    PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
//                    pst_bank_deposit.setString(1, com_id);
//                    pst_bank_deposit.setString(2, bran_id);
//                    pst_bank_deposit.setString(3, bank_id);
//                    pst_bank_deposit.setString(4, account_no);
//                    pst_bank_deposit.setString(5, (dpayment - ddiscountt) + "");
//                    pst_bank_deposit.setString(6, "0");
//                    pst_bank_deposit.setString(7, c_date);
//                    pst_bank_deposit.setString(8, description);
//                    pst_bank_deposit.execute();
//                } catch (SQLException e) {
//                    out.println(e.toString());
//                }
            }
        }

        if (discount != null) {
            try {
                double ddiscount = Double.parseDouble(discount);
                if (ddiscount > 0) {
                    // for inventory 
                    try {
                        String sql_insert_invoice = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                        PreparedStatement pst_insert_invoice = DbConnection.getConn(sql_insert_invoice);
                        pst_insert_invoice.setString(1, null);
                        pst_insert_invoice.setString(2, (String) session.getAttribute("user_com_id"));
                        pst_insert_invoice.setString(3, (String) session.getAttribute("user_bran_id"));
                        pst_insert_invoice.setString(4, user_id);
                        pst_insert_invoice.setString(5, company_id);
                        pst_insert_invoice.setString(6, "0");
                        pst_insert_invoice.setString(7, "0");
                        pst_insert_invoice.setString(8, "0");
                        pst_insert_invoice.setString(9, "1");
                        pst_insert_invoice.setString(10, discount);
                        pst_insert_invoice.setString(11, "0");
                        pst_insert_invoice.setString(12, "0");
                        pst_insert_invoice.setString(13, "0");
                        pst_insert_invoice.setString(14, "8");
                        pst_insert_invoice.setString(15, c_date);
                        pst_insert_invoice.setString(16, null);
                        pst_insert_invoice.execute();
                    } catch (SQLException e) {
                        out.println(e.toString());
                    }
                }
            } catch (NumberFormatException e) {
                out.println(e.toString());
            }
        }
        session.setAttribute("supplierpayment", "ok");
        response.sendRedirect("/Tailor/admin/add_supplier_payment.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
