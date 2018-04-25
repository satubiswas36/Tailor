package Login;

import connection.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Company_login extends HttpServlet {

    RequestDispatcher dispatcher;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session  = request.getSession(false);

        String email = request.getParameter("c_email");
        String password = request.getParameter("c_password");

        try {
            String sql = "select * from user_company where com_email = '" + email + "' and com_password = '" + password + "' ";
            PreparedStatement pst = DbConnection.getConn(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                
                String u_com_id = rs.getString(2);
                String u_com_email = rs.getString(4);
                session.setAttribute("user_com_id", u_com_id);
                session.setAttribute("user_com_email", u_com_email);
                session.setAttribute("logger", "company");
                  response.sendRedirect("/Tailor/admin/index.jsp");
            } else {
                 session.setAttribute("company_login_msg", "failed");
                  response.sendRedirect("/Tailor/company/index.jsp");
            }
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
