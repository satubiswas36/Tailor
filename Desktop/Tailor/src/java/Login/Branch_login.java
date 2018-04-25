package Login;

import baseurl.BaseUrl;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Branch_login extends HttpServlet {

    RequestDispatcher dispatcher;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

//        String b_email = request.getParameter("email");
//        String b_password = request.getParameter("password");
//
//        try {
//            String sql = "select * from user_branch where bran_email = '" + b_email + "'  and bran_password = '" + b_password + "' ";
//            PreparedStatement pst = DbConnection.getConn(sql);
//            ResultSet rs = pst.executeQuery();
//            if (rs.next()) {
//                
//                String com_id = rs.getString(3);
//                String bran_id = rs.getString(2);
//                String bran_email = rs.getString(5);
//                session.setAttribute("user_com_id", com_id);
//                session.setAttribute("user_bran_id", bran_id);
//                session.setAttribute("bran_email", bran_email);
//                session.setAttribute("logger", "branch");
//                response.sendRedirect("/Tailor/admin/index.jsp");
//            } else {
//                session.setAttribute("branch_login_msg", "failed");
//                response.sendRedirect("/Tailor/Branch/index.jsp");
//            }
//        } catch (IOException | SQLException e) {
//            out.println(e.toString());
//        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        PrintWriter out = response.getWriter();
        String baseUrl = BaseUrl.getBaseUrl(request, "admin/customer_payment");
        out.println(baseUrl);
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
