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

public class User_Login extends HttpServlet {

    RequestDispatcher dispatcher;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
          HttpSession session = request.getSession(false);
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        try {
            String sql = "select * from user_user where user_email = '" + email + "' and user_password = '" + password + "' ";
            PreparedStatement pst = DbConnection.getConn(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {              
                String u_com_id = rs.getString(2);
                String u_bran_id = rs.getString(3);
                String u_user_id = rs.getString(4);
                String u_user_email = rs.getString(6);
                // out.println("com id " + u_com_id + "<br>" + "bran id " + u_bran_id + "<br>" + "user id " + u_user_id + "<br>");
                session.setAttribute("user_com_id", u_com_id);
                session.setAttribute("user_bran_id", u_bran_id);
                session.setAttribute("user_user_id", u_user_id);
                session.setAttribute("user_user_email", u_user_email);
                session.setAttribute("logger", "user");
                 //dispatcher = getServletContext().getRequestDispatcher("/admin/index.jsp");
               // dispatcher.forward(request, response);
               response.sendRedirect("/Tailor/admin/index.jsp");
            } else {             
                session.setAttribute("user_msg_login", "failed");
                response.sendRedirect("/Tailor/user/index.jsp");                 
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
