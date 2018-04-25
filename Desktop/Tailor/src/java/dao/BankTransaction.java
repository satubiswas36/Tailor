package dao;

import connection.DbConnection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BankTransaction {

    public int addDeposit(String com_id,String bran_id, String bank_id, String account_no, String amount, String payment_date, String reference) {
        try {
            String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
            PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
            pst_bank_deposit.setString(1, com_id);
            pst_bank_deposit.setString(2, bran_id);
            pst_bank_deposit.setString(3, bank_id);
            pst_bank_deposit.setString(4, account_no);
            pst_bank_deposit.setString(5, "0");
            pst_bank_deposit.setString(6, amount);
            pst_bank_deposit.setString(7, payment_date);
            pst_bank_deposit.setString(8, reference);
            return pst_bank_deposit.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
            return 0;
        }
    }

    public int addWithDraw(String com_id,String bran_id, String bank_id, String account_no, String amount, String payment_date, String reference) {
        try {
            String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
            PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
            pst_bank_deposit.setString(1, com_id);
            pst_bank_deposit.setString(2, bran_id);
            pst_bank_deposit.setString(3, bank_id);
            pst_bank_deposit.setString(4, account_no);
            pst_bank_deposit.setString(5, amount);
            pst_bank_deposit.setString(6, "0");
            pst_bank_deposit.setString(7, payment_date);
            pst_bank_deposit.setString(8, reference);
            return pst_bank_deposit.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
            return 0;
        }
    }
}
