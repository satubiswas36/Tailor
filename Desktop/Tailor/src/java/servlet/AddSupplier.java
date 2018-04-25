package servlet;

import connection.DbConnection;
import dao.supplier.registration.SupplierRegistration;
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

public class AddSupplier extends HttpServlet {

    String com_id = null;
    String bran_id = null;
    String user_id = null;
    int supid = 0;

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
        SupplierRegistration supplierRegistration = new SupplierRegistration();
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
            user_id = (String) session.getAttribute("user_bran_id");
        }

        String supplierName = request.getParameter("sup_name");
        String supplierAddress = request.getParameter("sup_address");
        String supplierPerson = request.getParameter("sup_person");
        String supplierMobile = request.getParameter("sup_mobile");
        String supplierPhone = request.getParameter("sup_phone");
        String supplierEmail = request.getParameter("sup_email");
        String supplierWebSite = request.getParameter("sup_website");
        String supplierComplainNumber = request.getParameter("sup_com_num");
        String supplierDueBalance = request.getParameter("open_du_balance");
        String supplier_status = request.getParameter("supplier_status");

//        try {
//            String sql_check_account = "select * from supplier where suplr_bran_id = '" + session.getAttribute("user_bran_id") + "' and suplr_name = '" + supplierName + "' and suplr_mobile = '" + supplierMobile + "' ";
//            PreparedStatement pst_check_account = DbConnection.getConn(sql_check_account);
//            ResultSet rs_check_account = pst_check_account.executeQuery();
//            if (rs_check_account.next()) {
//                session.setAttribute("add_supplier_msg", "exit");
//                response.sendRedirect("/Tailor/admin/add_supplier.jsp");
//            }
//        } catch (IOException | SQLException e) {
//            out.println(e.toString());
//        }

        if (supplierDueBalance != null) {
            double sup_due_balance = 0;
            try {
                sup_due_balance = Double.parseDouble(supplierDueBalance);
            } catch (NumberFormatException e) {
                out.println(e.toString());
            }
            if (sup_due_balance <= 0) {
                supplierDueBalance = "0";
            }
        } else {
            supplierDueBalance = "0";
        }

        // get last supplier id 
        supid = supplierRegistration.lastSupplierID();
//        try {
//            String sql_last_supid = "select * from supplier order by supplier_slno desc limit 1";
//            PreparedStatement pst_last_supid = DbConnection.getConn(sql_last_supid);
//            ResultSet rs_last_supid = pst_last_supid.executeQuery();
//            if (rs_last_supid.next()) {
//                supid = Integer.parseInt(rs_last_supid.getString("supplier_slno"));
//                supid++;
//            } else {
//                supid = 1;
//            }
//        } catch (NumberFormatException | SQLException e) {
//            out.println(e.toString());
//        }
// supplier registration
        int i = supplierRegistration.registrationOfSupplier(com_id, bran_id, user_id, supid, supplierName,
                supplierAddress, supplierPerson, supplierMobile, supplierPhone, supplierEmail,
                supplierWebSite, supplierComplainNumber, supplierDueBalance, supplier_status, c_date);
        if (i >= 1) {
            session.setAttribute("add_supplier_msg", "inserted");
            response.sendRedirect("/Tailor/admin/add_supplier.jsp");
        } else {
            session.setAttribute("add_supplier_msg", "noinserted");
            response.sendRedirect("/Tailor/admin/add_supplier.jsp");
        }
//        try {
//            String sql_addsupplier = "insert into supplier values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
//            PreparedStatement pst_addsupplier = DbConnection.getConn(sql_addsupplier);
//            pst_addsupplier.setString(1, null);
//            pst_addsupplier.setString(2, com_id);
//            pst_addsupplier.setString(3, bran_id);
//            pst_addsupplier.setString(4, user_id);
//            pst_addsupplier.setString(5, supid + "");
//            pst_addsupplier.setString(6, supplierName);
//            pst_addsupplier.setString(7, supplierAddress);
//            pst_addsupplier.setString(8, supplierPerson);
//            pst_addsupplier.setString(9, supplierMobile);
//            pst_addsupplier.setString(10, supplierPhone);
//            pst_addsupplier.setString(11, supplierEmail);
//            pst_addsupplier.setString(12, supplierWebSite);
//            pst_addsupplier.setString(13, supplierComplainNumber);
//            pst_addsupplier.setString(14, supplierDueBalance);
//            pst_addsupplier.setString(15, supplier_status);
//            pst_addsupplier.setString(16, c_date);
//            pst_addsupplier.execute();
//            session.setAttribute("add_supplier_msg", "inserted");
//            response.sendRedirect("/Tailor/admin/add_supplier.jsp");
//            //response.sendRedirect("/Tailor/admin/add_supplier.jsp");
//        } catch (SQLException e) {
//            session.setAttribute("add_supplier_msg", "noinserted");
//            response.sendRedirect("/Tailor/admin/add_supplier.jsp");
//        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
