package dao.supplier.registration;

import connection.DbConnection;
import static java.lang.System.out;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SupplierRegistration {

    public int lastSupplierID() {
        int supid = 0;
        try {
            String sql_last_supid = "select * from supplier order by supplier_slno desc limit 1";
            PreparedStatement pst_last_supid = DbConnection.getConn(sql_last_supid);
            ResultSet rs_last_supid = pst_last_supid.executeQuery();
            if (rs_last_supid.next()) {
                supid = Integer.parseInt(rs_last_supid.getString("supplier_slno"));
                supid++;
            } else {
                supid = 1;
            }
            return supid;
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
            return 0;
        }
    }

    public int registrationOfSupplier(String com_id, String bran_id, String user_id, int supid,
            String supplierName, String supplierAddress, String supplierPerson, String supplierMobile,
            String supplierPhone, String supplierEmail, String supplierWebSite, String supplierComplainNumber,
            String supplierDueBalance, String supplier_status, String c_date) {
        try {
            String sql_addsupplier = "insert into supplier values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst_addsupplier = DbConnection.getConn(sql_addsupplier);
            pst_addsupplier.setString(1, null);
            pst_addsupplier.setString(2, com_id);
            pst_addsupplier.setString(3, bran_id);
            pst_addsupplier.setString(4, user_id);
            pst_addsupplier.setString(5, supid + "");
            pst_addsupplier.setString(6, supplierName);
            pst_addsupplier.setString(7, supplierAddress);
            pst_addsupplier.setString(8, supplierPerson);
            pst_addsupplier.setString(9, supplierMobile);
            pst_addsupplier.setString(10, supplierPhone);
            pst_addsupplier.setString(11, supplierEmail);
            pst_addsupplier.setString(12, supplierWebSite);
            pst_addsupplier.setString(13, supplierComplainNumber);
            pst_addsupplier.setString(14, supplierDueBalance);
            pst_addsupplier.setString(15, supplier_status);
            pst_addsupplier.setString(16, c_date);
            return pst_addsupplier.executeUpdate();
            //response.sendRedirect("/Tailor/admin/add_supplier.jsp");
        } catch (SQLException e) {
            out.println(e.toString());
            return 0;
        }
    }
}
