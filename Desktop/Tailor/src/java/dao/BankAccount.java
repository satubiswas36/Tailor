package dao;

import connection.DbConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BankAccount {

    public int addBankAccount(String com_id, String bran_id, String bank_name, String branch_name, String account_no, String open_date) {
        try {
            String sql_bank_acc = "insert into bank_account(bk_com_id,bk_bran_id,bk_name,bk_branch_name,bk_account_no,bk_open_date,bk_status) values(?,?,?,?,?,?,?)";
            PreparedStatement pst_bank_acc = DbConnection.getConn(sql_bank_acc);
            pst_bank_acc.setString(1, com_id);
            pst_bank_acc.setString(2, bran_id);
            pst_bank_acc.setString(3, bank_name);
            pst_bank_acc.setString(4, branch_name);
            pst_bank_acc.setString(5, account_no);
            pst_bank_acc.setString(6, open_date);
            pst_bank_acc.setString(7, "1");
            return pst_bank_acc.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
            return 0;
        }
    }

    public String accountslOfAccount(String bran_id, String old_bank_id, String old_account_no) {
        String account_sl = null;
        try {
            // kono bank e account thake. tahole oi acc er bank name ta change korta hole oi accounter sl id ta lagba
            String sql_acc_sl = "select bk_sl from bank_account where bk_bran_id = '" + bran_id + "' and bk_name = '" + old_bank_id + "' and bk_account_no = '" + old_account_no + "' ";
            PreparedStatement pst_acc_sl = DbConnection.getConn(sql_acc_sl);
            ResultSet rs_acc_sl = pst_acc_sl.executeQuery();
            if (rs_acc_sl.next()) {
                account_sl = rs_acc_sl.getString("bk_sl");
            }
            return account_sl;
        } catch (SQLException e) {
            return null;
        }
    }

    public int updateAccount(String bank_name, String branch_name, String account_no, String open_date, String bran_id, String old_bank_id, String old_branch_name, String old_account_no) {
        try {
            // bank account update 
            String sql_update = "update bank_account set bk_name = '" + bank_name + "',bk_branch_name = '" + branch_name + "',"
                    + "bk_account_no = '" + account_no + "',bk_open_date = '" + open_date + "' where bk_bran_id = '" + bran_id + "' and bk_name = '" + old_bank_id + "' and bk_branch_name = '" + old_branch_name + "' and bk_account_no = '" + old_account_no + "' ";
            PreparedStatement pst_update = DbConnection.getConn(sql_update);
            return pst_update.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
            return 0;
        }
    }

    public int updateBankTransaction(String bank_name, String bran_id, String old_bank_id, String account_sl) {
        try {
            // bank_transaction update
            String sql_transaction = "update bank_transaction set bt_bank_id = '" + bank_name + "' where bt_bran_id = '" + bran_id + "' and bt_bank_id = '" + old_bank_id + "' and bt_account_no = '" + account_sl + "' ";
            PreparedStatement pst_bank_transaction = DbConnection.getConn(sql_transaction);
            return pst_bank_transaction.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
            return 0;
        }
    }
}
