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

@WebServlet(name = "Product", urlPatterns = {"/Product"})
public class Product extends HttpServlet {

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

        // product description by product id
        String product_description = null;
        try {
            String sql_product_description = "select * from inv_product_name where prn_bran_id = '" + session.getAttribute("user_bran_id") + "' and supplier_id = '" + session.getAttribute("supplier_id_product") + "' and prn_group_id = '" + session.getAttribute("product_name_by_group_product") + "' and prn_slid = '" + session.getAttribute("product_id_desc") + "' ";
            PreparedStatement pst_product_description = DbConnection.getConn(sql_product_description);
            ResultSet rs_product_description = pst_product_description.executeQuery();
            if (rs_product_description.next()) {
                product_description = rs_product_description.getString("prn_product_desc");
            }
        } catch (SQLException e) {
            out.println("product description " + e.toString());
        }

        String status = request.getParameter("status");
        String supplier_id = request.getParameter("supplier_id");
        String group_id = request.getParameter("group_id");
        String product_id = request.getParameter("product_id");
        String product_type_id = request.getParameter("type_name");
        //String product_description = request.getParameter("product_desc");
        String product_buy_price = request.getParameter("product_buy_price");
        String product_sell_price = request.getParameter("product_sell_price");
        String product_shr_quantity = request.getParameter("shr_quantity");

        // current date 
        Date date = new Date();
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
        String c_date = sd.format(date);

        if (status.equals("add")) {

            try {
                String sql_exit = "select * from inv_product where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' and pr_product_name = '" + product_id + "' ";
                PreparedStatement pst_exit = DbConnection.getConn(sql_exit);
                ResultSet rs_exit = pst_exit.executeQuery();
                if (rs_exit.next()) {
                    session.setAttribute("addproductmsg", "exit");
                    response.sendRedirect("/Tailor/admin/add_product.jsp");
                } else {
                    try {
                        String sql_product = "insert into inv_product values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
                        PreparedStatement pst_product = DbConnection.getConn(sql_product);
                        pst_product.setString(1, null);
                        pst_product.setString(2, com_id);
                        pst_product.setString(3, bran_id);
                        pst_product.setString(4, user_id);
                        pst_product.setString(5, supplier_id);
                        pst_product.setString(6, group_id);
                        pst_product.setString(7, product_type_id);
                        pst_product.setString(8, product_id);
                        pst_product.setString(9, product_description);
                        pst_product.setString(10, product_buy_price);
                        pst_product.setString(11, product_sell_price);
                        pst_product.setString(12, product_shr_quantity);
                        pst_product.setString(13, c_date);
                        pst_product.execute();
                        session.setAttribute("addproductmsg", "inserted");
                        response.sendRedirect("/Tailor/admin/add_product.jsp");
                    } catch (SQLException e) {
                        session.setAttribute("addproductmsg", "notinserted");
                        response.sendRedirect("/Tailor/admin/add_product.jsp");
                    }
                }
            } catch (IOException | SQLException e) {
            }
        }
        if (status.equals("edit")) {
            try {
                String sql_product_update = "update inv_product set pr_supplier_id = '" + supplier_id + "', pr_group = '" + group_id + "', pr_type = '" + product_type_id + "', pr_buy_price = '" + product_buy_price + "', pr_sell_price = '" + product_sell_price + "' where pr_product_name = '" + product_id + "' ";
                PreparedStatement pst_product_update = DbConnection.getConn(sql_product_update);
                pst_product_update.execute();
                session.setAttribute("addproductmsg", "updated");
                response.sendRedirect("/Tailor/admin/add_product.jsp");
            } catch (IOException | SQLException e) {
                session.setAttribute("addproductmsg", "notupdated");
                response.sendRedirect("/Tailor/admin/add_product.jsp");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
