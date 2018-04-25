
package servlet;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Branch_Login extends HttpServlet {

    PreparedStatement pst ;
    ResultSet rs;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
          
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
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
//        out.println(email +" "+password);
    
        try {
            String sql = "select * from user_branch where bran_email = ? and bran_password = ? ";
            pst = DbConnection.getConn(sql);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();
            if(rs.next()){
                String bran_com_id = rs.getString("bran_com_id");
                String bran_id = rs.getString("bran_id");
                out.println(bran_com_id + " "+bran_id);
            }else {
                out.println("Failed");
            }
        } catch (SQLException e) {
            e.toString();
        }
        
        
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
