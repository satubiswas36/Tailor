package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DbConnection {

    private static Connection conn = null;

    private DbConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/tailor", "root", "");
        } catch (Exception e) {

        }
    }

    public static PreparedStatement getConn(String sql) {
        PreparedStatement pst = null;
        if (conn != null) {
            try {
                pst = conn.prepareStatement(sql);
                return pst;
            } catch (SQLException ex) {
                return null;
            }
        } else {
            try {
                new DbConnection();
                pst = conn.prepareStatement(sql);
                return pst;
            } catch (SQLException ex) {
                return null;
            }
        }
    }

    public static void main(String[] args) {
        getConn("");
    }
}
