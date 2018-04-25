package dao;

import connection.DbConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Account_For_CashTransfer {

    public String fromBankName(String from_bank_id) {
        String from_bank_name = null;
        try {
            String sql_from_bank_name = "select bank_name from bank where sl = '" + from_bank_id + "' ";
            PreparedStatement pst_from_bank_name = DbConnection.getConn(sql_from_bank_name);
            ResultSet rs_from_bank_name = pst_from_bank_name.executeQuery();
            if (rs_from_bank_name.next()) {
                from_bank_name = rs_from_bank_name.getString("bank_name");
            }
            return from_bank_name;
        } catch (SQLException e) {
            System.out.println(e.toString());
            return null;
        }
    }

    public String toBankName(String to_bank_id) {
        String to_bank_name = null;
        try {
            String sql_to_bank_name = "select bank_name from bank where sl = '" + to_bank_id + "' ";
            PreparedStatement pst_to_bank_name = DbConnection.getConn(sql_to_bank_name);
            ResultSet rs_to_bank_name = pst_to_bank_name.executeQuery();
            if (rs_to_bank_name.next()) {
                to_bank_name = rs_to_bank_name.getString("bank_name");
            }
            return to_bank_name;
        } catch (SQLException e) {
            System.out.println(e.toString());
            return null;
        }
    }

    public String fromAccount(String bran_id, String from_account_sl) {
        String from_account_no = null;
        try {
            String sql_from_acc_no = "select bk_account_no from bank_account where bk_bran_id = '" + bran_id + "' and bk_sl = '" + from_account_sl + "' ";
            PreparedStatement pst_from_acc_no = DbConnection.getConn(sql_from_acc_no);
            ResultSet rs_from_acc_no = pst_from_acc_no.executeQuery();
            if (rs_from_acc_no.next()) {
                from_account_no = rs_from_acc_no.getString("bk_account_no");
            }
            return from_account_no;
        } catch (SQLException e) {
            System.out.println(e.toString());
            return null;
        }
    }

    public String to_Account_No(String bran_id, String to_account_sl) {
        //to account no 
        String to_account_no = null;
        try {
            String sql_to_acc_no = "select bk_account_no from bank_account where bk_bran_id = '" + bran_id + "' and bk_sl = '" + to_account_sl + "' ";
            PreparedStatement pst_to_acc_no = DbConnection.getConn(sql_to_acc_no);
            ResultSet rs_to_acc_no = pst_to_acc_no.executeQuery();
            if (rs_to_acc_no.next()) {
                to_account_no = rs_to_acc_no.getString("bk_account_no");
            }
            return to_account_no;
        } catch (SQLException e) {
            return null;
        }
    }

    public int cashWithDrawForTransfer(String bran_id, String com_id, String from_bank_id, String from_account_sl, String amount, String date_f, String description, String to_bank_name, String to_account_no) {
        try {
            String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
            PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
            pst_bank_deposit.setString(1, com_id);
            pst_bank_deposit.setString(2, bran_id);
            pst_bank_deposit.setString(3, from_bank_id);
            pst_bank_deposit.setString(4, from_account_sl);
            pst_bank_deposit.setString(5, amount);
            pst_bank_deposit.setString(6, "0");
            pst_bank_deposit.setString(7, date_f);
            pst_bank_deposit.setString(8, description + " Cash Transfer to Bank: " + to_bank_name + " and Account No: " + to_account_no);
            return pst_bank_deposit.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.toString());
            return 0;
        }
    }

    public int cashDepositForTransfer(String bran_id, String com_id, String to_bank_id, String to_account_sl, String amount, String date_f, String description, String from_bank_name, String from_account_no) {
        try {
            String sql_bank_deposit = "insert into bank_transaction(bt_com_id,bt_bran_id,bt_bank_id,bt_account_no,bt_debit,bt_credit,bt_tdate,bt_ref) values(?,?,?,?,?,?,?,?)";
            PreparedStatement pst_bank_deposit = DbConnection.getConn(sql_bank_deposit);
            pst_bank_deposit.setString(1, com_id);
            pst_bank_deposit.setString(2, bran_id);
            pst_bank_deposit.setString(3, to_bank_id);
            pst_bank_deposit.setString(4, to_account_sl);
            pst_bank_deposit.setString(5, "0");
            pst_bank_deposit.setString(6, amount);
            pst_bank_deposit.setString(7, date_f);
            pst_bank_deposit.setString(8, description + " Cash Transfer from Bank " + from_bank_name + " and Account No " + from_account_no);
            return pst_bank_deposit.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.toString());
            return 0;
        }
    }
}
