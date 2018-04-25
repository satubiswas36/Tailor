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

@WebServlet(name = "AddProductType", urlPatterns = {"/AddProductType"})
public class AddProductType extends HttpServlet {

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
        HttpSession session = request.getSession();

        // current date 
        Date date = new Date();
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
        String c_date = sd.format(date);

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
        String prodcut_type = request.getParameter("product_type_name");

        if (status.equals("add")) {

            try {
                String sql_exit = "select * from inv_product_type where pro_type_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_type_name = '" + prodcut_type + "' ";
                PreparedStatement pst_exit = DbConnection.getConn(sql_exit);
                ResultSet rs_exit = pst_exit.executeQuery();
                if (rs_exit.next()) {
                    session.setAttribute("product_type_msg", "exit");
                    response.sendRedirect("/Tailor/admin/add_product_type.jsp");
                } else {
                    try {
                        String sql_product_type_name = "insert into inv_product_type values(?,?,?,?,?,?)";
                        PreparedStatement pst_product_type_name = DbConnection.getConn(sql_product_type_name);
                        pst_product_type_name.setString(1, null);
                        pst_product_type_name.setString(2, com_id);
                        pst_product_type_name.setString(3, bran_id);
                        pst_product_type_name.setString(4, user_id);
                        pst_product_type_name.setString(5, prodcut_type);
                        pst_product_type_name.setString(6, c_date);
                        pst_product_type_name.execute();
                        session.setAttribute("product_type_msg", "inserted");
                        response.sendRedirect("/Tailor/admin/add_product_type.jsp");
                    } catch (IOException | SQLException e) {
                        out.println(e.toString());
                        session.setAttribute("product_type_msg", "notinserted");
                        response.sendRedirect("/Tailor/admin/add_product_type.jsp");
                    }
                }
            } catch (Exception e) {
            }

        }
        if (status.equals("edit")) {
            String product_type_id = request.getParameter("product_type_id");
            try {
                String sql_product_type_update = "update inv_product_type set pro_type_name = '" + prodcut_type + "' where pro_typ_slno = '" + product_type_id + "' ";
                PreparedStatement pst_product_type_update = DbConnection.getConn(sql_product_type_update);
                pst_product_type_update.execute();
                session.setAttribute("product_type_msg", "updated");
                response.sendRedirect("/Tailor/admin/add_product_type.jsp");
            } catch (IOException | SQLException e) {
                session.setAttribute("product_type_msg", "notupdated");
                response.sendRedirect("/Tailor/admin/add_product_type.jsp");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
