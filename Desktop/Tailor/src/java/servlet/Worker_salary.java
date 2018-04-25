package servlet;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Worker_salary", urlPatterns = {"/Worker_salary"})
public class Worker_salary extends HttpServlet {

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
        HttpSession session = request.getSession(false);
        PrintWriter out = response.getWriter();
        String ws_bran_id = session.getAttribute("user_bran_id").toString();
        String shirt_cost = request.getParameter("s_price");
        String pant_cost = request.getParameter("pnt_price");
        String blazer_cost = request.getParameter("blz_price");
        String panjabi_cost = request.getParameter("pnjbi_price");
        String payjamai_cost = request.getParameter("pjama_price");
        String safari_cost = request.getParameter("sfri_price");
        String photua_cost = request.getParameter("pht_price");
        String mojib_cort_cost = request.getParameter("mjc_price");
        String kable_cost = request.getParameter("kbl_price");
        String koti_cost = request.getParameter("kt_price");

        try {
            String sql_check = "select * from worker_salary where ws_bran_id = '" + ws_bran_id + "' ";
            PreparedStatement pst_check = DbConnection.getConn(sql_check);
            ResultSet rs_check = pst_check.executeQuery();
            if (rs_check.next()) {
                try {
                    String sql_ws_update = "update worker_salary set ws_shirt = '" + shirt_cost + "', ws_pant = '" + pant_cost + "', ws_blazer  = '" + blazer_cost + "',ws_panjabi= '" + panjabi_cost + "', ws_payjama = '" + payjamai_cost + "', ws_safari = '" + safari_cost + "',ws_photua = '" + photua_cost + "',ws_mojib_cort = '"+mojib_cort_cost+"',ws_kable = '"+kable_cost+"',ws_koti = '"+koti_cost+"' where ws_bran_id = '" + ws_bran_id + "'  ";
                    PreparedStatement pst_ws_update = DbConnection.getConn(sql_ws_update);
                    pst_ws_update.execute();
                    session.setAttribute("product_cost", "ok");
                    response.sendRedirect("/Tailor/admin/worker_salary.jsp");
                } catch (IOException | SQLException e) {
                    out.println(e.toString());
                }
            } else {
                try {
                    String product_cost = "insert into worker_salary values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
                    PreparedStatement pst_product_salary = DbConnection.getConn(product_cost);
                    pst_product_salary.setString(1, null);
                    pst_product_salary.setString(2, (String) session.getAttribute("user_com_id"));
                    pst_product_salary.setString(3, (String) session.getAttribute("user_bran_id"));
                    pst_product_salary.setString(4, shirt_cost);
                    pst_product_salary.setString(5, pant_cost);
                    pst_product_salary.setString(6, blazer_cost);
                    pst_product_salary.setString(7, panjabi_cost);
                    pst_product_salary.setString(8, payjamai_cost);
                    pst_product_salary.setString(9, safari_cost);
                    pst_product_salary.setString(10, photua_cost);
                    pst_product_salary.setString(11, mojib_cort_cost);
                    pst_product_salary.setString(12, kable_cost);
                    pst_product_salary.setString(13, koti_cost);
                    pst_product_salary.execute();
                    session.setAttribute("product_cost", "ok");
                    response.sendRedirect("/Tailor/admin/worker_salary.jsp");
                } catch (IOException | SQLException e) {
                    out.println(e.toString());
                }
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
