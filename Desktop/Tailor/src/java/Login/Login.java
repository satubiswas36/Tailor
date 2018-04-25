package Login;

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

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

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
                try {
                    String sql_user = "select * from user_user where user_email = '" + email + "' and user_password = '" + password + "' ";
                    PreparedStatement pst_user = DbConnection.getConn(sql_user);
                    ResultSet rs_user = pst_user.executeQuery();
                    if (rs_user.next()) {
                        String u_com_id = rs_user.getString(2);
                        String u_bran_id = rs_user.getString(3);
                        String u_user_id = rs_user.getString(4);
                        String u_user_email = rs_user.getString(6);
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
                        try {
                            String sql_branch = "select * from user_branch where bran_email = '" + email + "'  and bran_password = '" + password + "' ";
                            PreparedStatement pst_branch = DbConnection.getConn(sql_branch);
                            ResultSet rs_branch = pst_branch.executeQuery();
                            if (rs_branch.next()) {

                                String com_id = rs_branch.getString(3);
                                String bran_id = rs_branch.getString(2);
                                String bran_email = rs_branch.getString(5);
                                session.setAttribute("user_com_id", com_id);
                                session.setAttribute("user_bran_id", bran_id);
                                session.setAttribute("bran_email", bran_email);
                                session.setAttribute("logger", "branch");
                                response.sendRedirect("/Tailor/admin/index.jsp");
                            } else {
                                try {
                                    String sql_company = "select * from user_company where com_email = '" + email + "' and com_password = '" + password + "' ";
                                    PreparedStatement pst_company = DbConnection.getConn(sql_company);
                                    ResultSet rs_company = pst_company.executeQuery();
                                    if (rs_company.next()) {
                                        String u_com_id = rs_company.getString(2);
                                        String u_com_email = rs_company.getString(4);
                                        session.setAttribute("user_com_id", u_com_id);
                                        session.setAttribute("user_com_email", u_com_email);
                                        session.setAttribute("logger", "company");
                                        response.sendRedirect("/Tailor/admin/index.jsp");
                                    } else {
                                        session.setAttribute("root_login_msg", "failed");
                                        response.sendRedirect("/Tailor/index.jsp");
                                    }
                                } catch (SQLException e) {
                                    out.println(e.toString());
                                }
                            }
                        } catch (IOException | SQLException e) {
                            out.println(e.toString());
                        }
                    }
                } catch (IOException | SQLException e) {
                    out.println(e.toString());
                }
            }
        } catch (IOException | SQLException e) {
            out.println(e.toString());
        }
// check is it user or not ??

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
