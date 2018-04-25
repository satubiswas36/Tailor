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

@WebServlet(name = "com_reg", urlPatterns = {"/com_reg"})
public class com_reg extends HttpServlet {

    int company_id = 445000;
    HttpSession session;
    boolean i = false;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        session = request.getSession(false);

        String com_name = request.getParameter("com_name");
        String Email = request.getParameter("com_email");
        String Password = request.getParameter("com_password");
        String Mobile = request.getParameter("com_mobile");
        String Phone = request.getParameter("com_phone");
        String Fax = request.getParameter("com_fax");
        String Address = request.getParameter("com_address");
        String City = request.getParameter("com_city");
        String Zipcode = request.getParameter("com_zipcode");
        String BusinessType = request.getParameter("com_bus_type");
        String openTime = request.getParameter("com_open_time");
        String closeTime = request.getParameter("com_close_time");
        String webSite = request.getParameter("com_website");
        String companyType = request.getParameter("com_type");
        String taxable = request.getParameter("com_taxable");
        String sender_id = request.getParameter("com_sender_id");
        //String status=request.getParameter("com_status");
        String expireDate = request.getParameter("com_expiredate");
        session.setAttribute("com_name", com_name);
        session.setAttribute("com_email", Email);
        session.setAttribute("com_password", Password);
        session.setAttribute("com_mobile", Mobile);
        session.setAttribute("com_phone", Phone);
        session.setAttribute("com_fax", Fax);
        session.setAttribute("com_address", Address);
        session.setAttribute("com_city", City);
        session.setAttribute("com_zipcode", Zipcode);
        session.setAttribute("com_bus_type", BusinessType);
        session.setAttribute("com_website", webSite);
        session.setAttribute("com_type", companyType);
        session.setAttribute("com_taxable", taxable);
        session.setAttribute("com_expiredate", expireDate);

        //       update company id from ser_com table 
        try {
            String slq_com_id = "select * from user_company ORDER BY com_slno desc limit 1";
            PreparedStatement pst = DbConnection.getConn(slq_com_id);
            ResultSet rs_com_id = pst.executeQuery();
            if (rs_com_id.next()) {
                company_id = Integer.parseInt(rs_com_id.getString(2));
                company_id++;
            } else {
                company_id = 445000;
            }
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
//       update company id from ser_com table 
        try {
            String sql = "insert into user_company values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = DbConnection.getConn(sql);
            pst.setString(1, null);
            pst.setString(2, company_id + "");
            pst.setString(3, com_name);
            pst.setString(4, Email);
            pst.setString(5, Password);
            pst.setString(6, Mobile);
            pst.setString(7, Phone);
            pst.setString(8, Fax);
            pst.setString(9, Address);
            pst.setString(10, City);
            pst.setString(11, Zipcode);
            pst.setString(12, BusinessType);
            pst.setString(13, webSite);
            pst.setString(14, openTime);
            pst.setString(15, closeTime);
            pst.setString(16, companyType);
            pst.setString(17, taxable);
            pst.setString(18, null);
            pst.setString(19, "1");
            pst.setString(20, expireDate);
            pst.setString(21, sender_id);
            pst.execute();
            session.removeAttribute("com_name");
            session.removeAttribute("com_email");
            session.removeAttribute("com_password");
            session.removeAttribute("com_mobile");
            session.removeAttribute("com_phone");
            session.removeAttribute("com_fax");
            session.removeAttribute("com_address");
            session.removeAttribute("com_city");
            session.removeAttribute("com_zipcode");
            session.removeAttribute("com_bus_type");
            session.removeAttribute("com_website");
            session.removeAttribute("com_type");
            session.removeAttribute("com_taxable");
            session.removeAttribute("com_expiredate");
            session.setAttribute("com_email_check_msg", "inserted");
            response.sendRedirect("/Tailor/admin/com_reg.jsp");
        } catch (SQLException e) {
            out.println(e.toString());
        }

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

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
