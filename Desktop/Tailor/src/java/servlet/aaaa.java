package servlet;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "aaaa", urlPatterns = {"/aaaa"})
public class aaaa extends HttpServlet {

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
        HttpSession session = request.getSession();

        String name = request.getParameter("group_id");
        String group_id_product = request.getParameter("group_id_product");
        String product_id_for_price = request.getParameter("product_id");
        String bank_id = request.getParameter("bank_id");
        String status = request.getParameter("status");
        String supplier_id_product = request.getParameter("supplier_id_product");
        String product_id = request.getParameter("product_id");

        if(supplier_id_product != null){
            session.setAttribute("supplier_id_product", supplier_id_product);
        }
        if(product_id != null){
            session.setAttribute("product_id_desc", product_id);
        }
        
        if (status.equals("location")) {
            session.setAttribute("product_name_by_group_location", name);
        }
        if (status.equals("product")) {
            if (group_id_product != null || group_id_product != "") {
                session.setAttribute("product_name_by_group_product", group_id_product);
            }
        }
        if(status.equals("account_no_by_bank_id_deposit")){
            if(bank_id != null){
                session.setAttribute("bank_id", bank_id);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
