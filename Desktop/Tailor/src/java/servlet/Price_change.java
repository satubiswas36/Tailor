package servlet;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Price_change extends HttpServlet {

    HttpSession sess = null;
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
       String id = (String)sess.getAttribute("prlist_user_id");
      

        String shirt_price = request.getParameter("s_price");
        String pant_price = request.getParameter("pnt_price");
        String blazer_price = request.getParameter("blz_price");
        String panjabi_price = request.getParameter("pnjbi_price");
        String payjama_price = request.getParameter("pjama_price");
        String safari_price = request.getParameter("sfri_price");
        String photua_price = request.getParameter("sfri_price");
        out.println(id);
      //  out.println("shirt_price "+shirt_price+ "pant_price "+pant_price+ "blazer_price "+blazer_price+ "panjabi_price "+panjabi_price+ "payjama_price "+payjama_price );

//        try {
//            String sql_up_pric = "update price_list set prlist_shirt = '" + shirt_price + "', prlist_pant = '"
//                    + pant_price + "', prlist_blazer = '" + blazer_price + "', panjabi = '" + panjabi_price + "', payjama = '" + payjama_price + "', safari = '"
//                    + safari_price + "' , photua = '" + photua_price + "' ";
//            PreparedStatement pst_up_price = DbConnection.getConn(sql_up_pric);
//            pst_up_price.execute();
//        } catch (Exception e) {
//        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
