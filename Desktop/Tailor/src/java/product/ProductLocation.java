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

@WebServlet(name = "ProductLocation", urlPatterns = {"/ProductLocation"})
public class ProductLocation extends HttpServlet {

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
        HttpSession session = request.getSession(false);

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

        String productName = request.getParameter("product_id");
        String productBlock = request.getParameter("product_block");
        String productSelf = request.getParameter("product_self");

        if (status.equals("add")) {

            try {
                // location add kora ace naki tai check kora 
                String sql_exit_location = "select * from inv_product_location where pl_bran_id = '" + session.getAttribute("user_bran_id") + "' and pl_product_id = '" + productName + "' ";
                PreparedStatement pst_exit_location = DbConnection.getConn(sql_exit_location);
                ResultSet rs_exit_location = pst_exit_location.executeQuery();
                if (rs_exit_location.next()) {
                    session.setAttribute("productlocationmsg", "exit");
                    response.sendRedirect("/Tailor/admin/location.jsp");
                } else {
                    // jodi location add kora na thake tahole add korba 
                    try {
                        String sqlProductLocation = "insert into inv_product_location values(?,?,?,?,?,?,?,?)";
                        PreparedStatement pstproductLocation = DbConnection.getConn(sqlProductLocation);
                        pstproductLocation.setString(1, null);
                        pstproductLocation.setString(2, com_id);
                        pstproductLocation.setString(3, bran_id);
                        pstproductLocation.setString(4, user_id);
                        pstproductLocation.setString(5, productName);
                        pstproductLocation.setString(6, productBlock);
                        pstproductLocation.setString(7, productSelf);
                        pstproductLocation.setString(8, c_date);
                        pstproductLocation.execute();
                        session.setAttribute("productlocationmsg", "inserted");
                        response.sendRedirect("/Tailor/admin/location.jsp");
                    } catch (SQLException e) {
                        session.setAttribute("productlocationmsg", "notinserted");
                        response.sendRedirect("/Tailor/admin/location.jsp");
                    }
                }
            } catch (IOException | SQLException e) {
                session.setAttribute("productlocationmsg", "notinserted");
                response.sendRedirect("/Tailor/admin/location.jsp");
            }
        }
        if (status.equals("edit")) {
            try {
                String sql_location_update = "update inv_product_location set pl_block = '" + productBlock + "', pl_self = '" + productSelf + "' where pl_product_id = '" + productName + "' ";
                PreparedStatement pst_location_update = DbConnection.getConn(sql_location_update);
                pst_location_update.execute();
                session.setAttribute("productlocationmsg", "updated");
                response.sendRedirect("/Tailor/admin/location.jsp");
            } catch (IOException | SQLException e) {
                session.setAttribute("productlocationmsg", "notupdated");
                response.sendRedirect("/Tailor/admin/location.jsp");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
