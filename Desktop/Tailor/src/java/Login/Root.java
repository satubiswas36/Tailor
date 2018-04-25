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

public class Root extends HttpServlet {

    RequestDispatcher dispatcher;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            String sql = "select * from user_root where root_email = '" + email + "' and root_password = '" + password + "' ";
            PreparedStatement pst = DbConnection.getConn(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {                
                String user_root = rs.getString(2);
                String user_root_email = rs.getString(7);
                session.setAttribute("logger", "root");
                session.setAttribute("user_root", user_root);
                session.setAttribute("user_root_email", user_root_email);
                response.sendRedirect("/Tailor/admin/index.jsp");
            } else {
                session.setAttribute("root_login_msg", "failed");
                response.sendRedirect("/Tailor/index.jsp");
            }
        } catch (IOException | SQLException e) {
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
