package dao.customer.registration;

import connection.DbConnection;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import static java.lang.System.out;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.Part;

public class CustomerRegistration {

    public int lastCustomerID() {
        int cus_customer = 0;
        try {
            String slq = "select * from customer ORDER BY cus_slno desc limit 1";
            PreparedStatement pst = DbConnection.getConn(slq);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                cus_customer = Integer.parseInt(rs.getString("cus_customer_id"));
                cus_customer++;
            } else {
                cus_customer = 1;
            }
            return cus_customer;
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
            return 0;
        }
    }

    public String customerImageUpload(Part imgPart, String cus_phone) {
        String imgName = null;
        imgName = imgPart.getName();
        try {
            InputStream in = null;
            if (imgName.length() != 0) {
                imgName = cus_phone + imgName.substring(imgName.indexOf("."));
                in = imgPart.getInputStream();
                File file = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + imgName);
                file.createNewFile();
                FileOutputStream filout = new FileOutputStream(file);
                int length;
                byte[] buffer = new byte[1024];
                while ((length = in.read(buffer)) > 0) {
                    filout.write(buffer, 0, length);
                }
                filout.close();
                in.close();
            }
            return imgName;
        } catch (IOException e) {
            out.println("");
            return null;
        }
    }

    public int customerRegistration(String cus_com_id, String cus_bran_id, String cus_user_id, int cus_customer, String cus_name,
            String cus_email, String cus_address, String cus_phone, String cus_blood,
            String cus_nid, String cus_birthdate, String cus_reference, String imgName) {
        try {
            String sql = "insert into customer values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = DbConnection.getConn(sql);
            pst.setString(1, null);
            pst.setString(2, cus_com_id);
            pst.setString(3, cus_bran_id);
            pst.setString(4, cus_user_id);
            pst.setString(5, cus_customer + "");
            pst.setString(6, cus_name);
            pst.setString(7, cus_email);
            pst.setString(8, cus_address);
            pst.setString(9, cus_phone);
            pst.setString(10, cus_blood);
            pst.setString(11, cus_nid);
            pst.setString(12, cus_birthdate);
            pst.setString(13, cus_reference);
            pst.setString(14, "1");
            pst.setString(15, null);
            pst.setString(16, imgName);
            return pst.executeUpdate();
        } catch (SQLException e) {
            out.println(e.toString());
            return 0;
        }
    }
}
