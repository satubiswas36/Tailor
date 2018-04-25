package servlet;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AddPrice extends HttpServlet {


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
        int ap_com_id = 1;
        int ap_bran_id =15;
        int ap_user_id = 3;
        int ap_prod_id = 1010;
        
        
        String shirt_price = request.getParameter("shirt_price");
        String pant_price = request.getParameter("pant_price");
        String blazer_price = request.getParameter("blazer_price");
        String payjama_price = request.getParameter("payjama_price");
        String photua_price = request.getParameter("photua_price");
        String panjabi_price = request.getParameter("panjabi_price");
        String safari_price = request.getParameter("safari_price");
        ap_prod_id++;
        try {
            String sql = "insert into price_list values(?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = DbConnection.getConn(sql);
            pst.setString(1, null);
            pst.setString(2, ap_com_id+"");
            pst.setString(3, ap_bran_id+"");
            pst.setString(4, ap_user_id+"");
            pst.setString(5, ap_prod_id+"");
            pst.setString(6, shirt_price);
            pst.setString(7, pant_price);
            pst.setString(8, blazer_price);
            pst.setString(9, panjabi_price);
            pst.setString(10, payjama_price);
            pst.setString(11, safari_price);
            pst.setString(12, photua_price);
            pst.execute();
        } catch (SQLException e) {
            out.println(e.toString());
        }
        
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
