package dao;

import connection.DbConnection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SupplierPayment {

    public void paymentAddInAccount(String com_id, String bran_id, String user_id, String description, String company_id, double dpayment, double ddiscountt, String c_date) {
        try {
            String sql_customer_payment = "insert into account values(?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst_customer_payment = DbConnection.getConn(sql_customer_payment);
            pst_customer_payment.setString(1, null);
            pst_customer_payment.setString(2, com_id);
            pst_customer_payment.setString(3, bran_id);
            pst_customer_payment.setString(4, user_id);
            pst_customer_payment.setString(5, "");
            pst_customer_payment.setString(6, description);
            pst_customer_payment.setString(7, company_id);
            pst_customer_payment.setString(8, "0.0");
            pst_customer_payment.setString(9, (dpayment - ddiscountt) + "");
            pst_customer_payment.setString(10, c_date);
            pst_customer_payment.setString(11, "1");
            pst_customer_payment.setString(12, "5");
            pst_customer_payment.execute();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }

    public void paymentAddInInventory(String com_id, String bran_id, String user_id, String company_id, double dpayment, double ddiscountt, String c_date) {
        try {
            String sql_insert_invoice = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst_insert_invoice = DbConnection.getConn(sql_insert_invoice);
            pst_insert_invoice.setString(1, null);
            pst_insert_invoice.setString(2, com_id);
            pst_insert_invoice.setString(3, bran_id);
            pst_insert_invoice.setString(4, user_id);
            pst_insert_invoice.setString(5, company_id);
            pst_insert_invoice.setString(6, "0");
            pst_insert_invoice.setString(7, "0");
            pst_insert_invoice.setString(8, "0");
            pst_insert_invoice.setString(9, "1");
            pst_insert_invoice.setString(10, (dpayment - ddiscountt) + "");
            pst_insert_invoice.setString(11, "0");
            pst_insert_invoice.setString(12, "0");
            pst_insert_invoice.setString(13, "0");
            pst_insert_invoice.setString(14, "3");
            pst_insert_invoice.setString(15, c_date);
            pst_insert_invoice.setString(16, null);
            pst_insert_invoice.execute();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }

    public void paymentAddInBankTransaction(String com_id, String bran_id, String bank_id, String account_no, double dpayment, double ddiscountt, String c_date, String description) {
        try {
            String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
            PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
            pst_bank_deposit.setString(1, com_id);
            pst_bank_deposit.setString(2, bran_id);
            pst_bank_deposit.setString(3, bank_id);
            pst_bank_deposit.setString(4, account_no);
            pst_bank_deposit.setString(5, (dpayment - ddiscountt) + "");
            pst_bank_deposit.setString(6, "0");
            pst_bank_deposit.setString(7, c_date);
            pst_bank_deposit.setString(8, description);
            pst_bank_deposit.execute();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }
}
