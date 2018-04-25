package servlet;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class com_login extends HttpServlet {
    PreparedStatement pst;
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
        HttpSession session=request.getSession();
        
        processRequest(request, response);
        PrintWriter out = response.getWriter();
        String email = request.getParameter("email");
        String password = request.getParameter("password"); 
        
        try {
            String sql = "select * from user_company where com_email = '"+email+"' and com_password = '"+password+"' ";
             pst = DbConnection.getConn(sql);
          
             rs = pst.executeQuery();
            if(rs.next()){
                //get value from database 
                String com_company_id = rs.getString("com_company_id");
                String com_slno = rs.getString("com_slno");
                
                // set session 
                session.setAttribute("com_company_id", com_company_id);
                session.setAttribute("com_slno", com_slno);
                
                out.println("Successfull and id is : "+com_company_id);
            }else {
                out.println("Failed");
            }
        } catch (SQLException e) {
            out.println();
        }finally{
            try {
                pst.close();
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(com_login.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
