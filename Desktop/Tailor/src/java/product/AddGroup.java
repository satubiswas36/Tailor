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

@WebServlet(name = "AddGroup", urlPatterns = {"/AddGroup"})
public class AddGroup extends HttpServlet {

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

        if (status.equals("add")) {
            String groupName = request.getParameter("group_name");

            try {
                String sql_group_exit = "select * from inv_product_group where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' and prg_name = '" + groupName + "' ";
                PreparedStatement pst_group_exit = DbConnection.getConn(sql_group_exit);
                ResultSet rs_group_exit = pst_group_exit.executeQuery();
                if (rs_group_exit.next()) {
                    session.setAttribute("add_product_group_msg", "exit");
                    response.sendRedirect("/Tailor/admin/add_group.jsp");
                } else {
                    try {
                        String sql_addgroup = "insert into inv_product_group values(?,?,?,?,?,?)";
                        PreparedStatement pst_addgroup = DbConnection.getConn(sql_addgroup);
                        pst_addgroup.setString(1, null);
                        pst_addgroup.setString(2, com_id);
                        pst_addgroup.setString(3, bran_id);
                        pst_addgroup.setString(4, user_id);
                        pst_addgroup.setString(5, groupName);
                        pst_addgroup.setString(6, c_date);
                        pst_addgroup.execute();
                        session.setAttribute("add_product_group_msg", "inserted");
                        response.sendRedirect("/Tailor/admin/add_group.jsp");
                    } catch (SQLException e) {
                        out.println(e.toString());
                        session.setAttribute("add_product_group_msg", "notinserted");
                        response.sendRedirect("/Tailor/admin/add_group.jsp");
                    }
                }
            } catch (Exception e) {

            }
        }
        if (status.equals("edit")) {
            String group_id = request.getParameter("groupid");
            String group_name = request.getParameter("group_name");
            try {
                String sql_group_update = "update inv_product_group set prg_name = '" + group_name + "' where prg_slid = '" + group_id + "' ";
                PreparedStatement pst_group_id = DbConnection.getConn(sql_group_update);
                pst_group_id.execute();
                session.setAttribute("add_product_group_msg", "update");
                response.sendRedirect("/Tailor/admin/add_group.jsp");
            } catch (IOException | SQLException e) {
                session.setAttribute("add_product_group_msg", "notupdate");
                response.sendRedirect("/Tailor/admin/add_group.jsp");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
