package dao;

import connection.DbConnection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CustomerPayment {

    public void paymentInAccount(String com_id, String bran_id, String user_id, String customer_description, String customer_id, double cus_pay,
            double cus_dis, String customer_payment_date) {
        try {
            String sql_customer_payment = "insert into account(acc_com_id,acc_bran_id,acc_usr_id,acc_description,"
                    + "acc_customer_id,acc_credit,acc_debit,acc_pay_date,acc_deal_type,acc_status) values(?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst_customer_payment = DbConnection.getConn(sql_customer_payment);
            pst_customer_payment.setString(1, com_id);
            pst_customer_payment.setString(2, bran_id);
            pst_customer_payment.setString(3, user_id);
            pst_customer_payment.setString(4, customer_description);
            pst_customer_payment.setString(5, customer_id);
            pst_customer_payment.setString(6, (cus_pay - cus_dis) + "");
            pst_customer_payment.setString(7, "0");
            pst_customer_payment.setString(8, customer_payment_date);
            pst_customer_payment.setString(9, "1");
            pst_customer_payment.setString(10, "1");
            pst_customer_payment.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }

    public void paymentInInventory(String com_id, String bran_id, String user_id, String customer_id, double cus_pay, double cus_dis, String c_date) {
        try {
            // add inventory_details table            
            String sql_insert_invoice = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst_insert_invoice = DbConnection.getConn(sql_insert_invoice);
            pst_insert_invoice.setString(1, null);
            pst_insert_invoice.setString(2, com_id);
            pst_insert_invoice.setString(3, bran_id);
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
            pst_insert_invoice.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }

    public void paymentAddInBank(String com_id, String bran_id, String bank_id, String account_no, double cus_pay, String customer_payment_date,
            String customer_description) {
        try {
            String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
            PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
            pst_bank_deposit.setString(1, com_id);
            pst_bank_deposit.setString(2, bran_id);
            pst_bank_deposit.setString(3, bank_id);
            pst_bank_deposit.setString(4, account_no);
            pst_bank_deposit.setString(5, "0");
            pst_bank_deposit.setString(6, (long) cus_pay + "");
            pst_bank_deposit.setString(7, customer_payment_date);
            pst_bank_deposit.setString(8, customer_description);
            pst_bank_deposit.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }

    public void addDiscountInInventory(String com_id, String bran_id, String user_id, String customer_id, double cus_dis, String c_date) {
        try {
            String sql_insert_invoice = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst_insert_invoice = DbConnection.getConn(sql_insert_invoice);
            pst_insert_invoice.setString(1, null);
            pst_insert_invoice.setString(2, com_id);
            pst_insert_invoice.setString(3, bran_id);
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
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }
}
