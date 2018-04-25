package product;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AddProductName", urlPatterns = {"/AddProductName"})
public class AddProductName extends HttpServlet {

    String com_id = null;
    String bran_id = null;
    String user_id = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

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

        // current date 
        Date date = new Date();
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
        String c_date = sd.format(date);

        HttpSession session = request.getSession();

        if (session.getAttribute("user_com_id") != null) {
            com_id = (String) session.getAttribute("user_com_id");
        }
        if (session.getAttribute("user_bran_id") != null) {
            bran_id = (String) session.getAttribute("user_bran_id");
        }
        if (session.getAttribute("user_user_id") != null) {
            user_id = (String) session.getAttribute("user_user_id");
        } else {
            user_id = bran_id;
        }
        String status = request.getParameter("status");

        String supplier_id = request.getParameter("supplier_id");
        String group_id = request.getParameter("group_id");
        String product_name = request.getParameter("product_name");
        String prodct_desc = request.getParameter("product_desc");
        String product_id = request.getParameter("product_id");

        if (status.equals("add")) {

            try {
                String sql_exit = "select * from inv_product_name where prn_bran_id = '" + session.getAttribute("user_bran_id") + "' and prn_product_name = '" + product_name + "' ";
                PreparedStatement pst_exit = DbConnection.getConn(sql_exit);
                ResultSet rs_exit = pst_exit.executeQuery();
                if (rs_exit.next()) {
                    session.setAttribute("product_name_msg", "exit");
                    response.sendRedirect("/Tailor/admin/add_product_name.jsp");
                } else {
                    try {
                        String sql_product_name = "insert into inv_product_name values(?,?,?,?,?,?,?,?,?)";
                        PreparedStatement pst_product_name = DbConnection.getConn(sql_product_name);
                        pst_product_name.setString(1, null);
                        pst_product_name.setString(2, com_id);
                        pst_product_name.setString(3, bran_id);
                        pst_product_name.setString(4, user_id);
                        pst_product_name.setString(5, supplier_id);
                        pst_product_name.setString(6, group_id);
                        pst_product_name.setString(7, product_name);
                        pst_product_name.setString(8, prodct_desc);
                        pst_product_name.setString(9, c_date);
                        pst_product_name.execute();
                        session.setAttribute("product_name_msg", "inserted");
                        response.sendRedirect("/Tailor/admin/add_product_name.jsp");
                    } catch (SQLException e) {
                        out.println(e.toString());
                        session.setAttribute("product_name_msg", "notinserted");
                        response.sendRedirect("/Tailor/admin/add_product_name.jsp");
                    }
                }
            } catch (Exception e) {
            }
        }
        if (status.equals("edit")) {
            try {
                String sql_product_name_update = "update inv_product_name set supplier_id = '" + supplier_id + "', prn_group_id = '" + group_id + "', prn_product_name = '" + product_name + "', prn_product_desc = '" + prodct_desc + "' where prn_slid = '" + product_id + "' ";
                PreparedStatement pst_product_name_update = DbConnection.getConn(sql_product_name_update);
                pst_product_name_update.execute();
                session.setAttribute("product_name_msg", "updated");
                response.sendRedirect("/Tailor/admin/add_product_name.jsp");
            } catch (SQLException e) {
                session.setAttribute("product_name_msg", "notupdated");
                response.sendRedirect("/Tailor/admin/add_product_name.jsp");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
