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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProductParchaseFromSupplier extends HttpServlet {

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

        String product_id = request.getParameter("product_name");
        String product_qty = request.getParameter("qty");
        String product_price = request.getParameter("product_price");

        out.println(product_id + " " + product_price + " " + product_qty);
        out.println(session.getAttribute("parchase_supplier_id"));
        out.println(session.getAttribute("invoice_id_for_parchase"));

        try {
            String sql_check_exit_product = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + session.getAttribute("parchase_supplier_id") + "' and pro_product_id = '" + product_id + "' and pro_invoice_id = '" + session.getAttribute("invoice_id_for_parchase") + "' and pro_deal_type = 3 ";
            PreparedStatement pst_check_product_delete = DbConnection.getConn(sql_check_exit_product);
            ResultSet rs_check_product_delete = pst_check_product_delete.executeQuery();
            if (rs_check_product_delete.next()) {
                try {
                    String sql_update_product = "update inventory_details set pro_buy_quantity= '" + product_qty + "' where  pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + session.getAttribute("parchase_supplier_id") + "' and pro_product_id = '" + product_id + "' and pro_invoice_id = '" + session.getAttribute("invoice_id_for_parchase") + "' and pro_deal_type = 3 ";
                    PreparedStatement pst_update_product = DbConnection.getConn(sql_update_product);
                    pst_update_product.execute();
                    session.setAttribute("addproductparchase", "added");
                    response.sendRedirect("/Tailor/admin/product_parchase.jsp");
                } catch (IOException | SQLException e) {
                    out.println(e.toString());
                }
            } else {
                try {
                    String sql_parchase_product = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                    PreparedStatement pst_parchase_product = DbConnection.getConn(sql_parchase_product);
                    pst_parchase_product.setString(1, null);
                    pst_parchase_product.setString(2, com_id);
                    pst_parchase_product.setString(3, bran_id);
                    pst_parchase_product.setString(4, user_id);
                    pst_parchase_product.setString(5, (String) session.getAttribute("parchase_supplier_id"));
                    pst_parchase_product.setString(6, product_id);
                    pst_parchase_product.setString(7, (String) session.getAttribute("invoice_id_for_parchase"));
                    pst_parchase_product.setString(8, product_qty);
                    pst_parchase_product.setString(9, "0");
                    pst_parchase_product.setString(10, "0");
                    pst_parchase_product.setString(11, "0");
                    pst_parchase_product.setString(12, product_price);
                    pst_parchase_product.setString(13, "0");
                    pst_parchase_product.setString(14, "3");
                    pst_parchase_product.setString(15, c_date);
                    pst_parchase_product.setString(16, null);
                    pst_parchase_product.execute();
                    session.setAttribute("addproductparchase", "added");
                    response.sendRedirect("/Tailor/admin/product_parchase.jsp");
                } catch (SQLException e) {
                    session.setAttribute("addproductparchase", "failed");
                    response.sendRedirect("/Tailor/admin/product_parchase.jsp");
                }
            }
        } catch (IOException | SQLException e) {
            out.println(e.toString());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
