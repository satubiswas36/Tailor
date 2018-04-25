package servlet;

import connection.DbConnection;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = -1L)
public class Makder_registration extends HttpServlet {

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

        String mk_name = request.getParameter("mk_name");
        String mk_mobile = request.getParameter("mk_mobile");
        String mk_email = request.getParameter("mk_email");
        String mk_address = request.getParameter("mk_address");
        String mk_birthdate = request.getParameter("mk_birthdate");
        String mk_nid = request.getParameter("mk_nid");
        String mk_password = request.getParameter("mk_password");
        String mk_ref_name = request.getParameter("mk_ref_name");
        String mk_ref_mobile = request.getParameter("mk_ref_mobile");
        Part imgPart = request.getPart("mk_image");       

        try {
            String sql_check_isAvailable = "select * from maker where mk_name = '" + mk_name + "' and mk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
            PreparedStatement pst_isAvailable = DbConnection.getConn(sql_check_isAvailable);
            ResultSet rs_isAvailable = pst_isAvailable.executeQuery();
            if (rs_isAvailable.next()) {
                session.setAttribute("maker_reg_msg", "isavailable");
                response.sendRedirect("/Tailor/admin/maker_reg.jsp");
            } else {
                 String imgName = null;
                  try {
                    InputStream in = null;
                    if (imgPart != null) {
                        imgName = imgPart.getName();
                        imgName = mk_mobile + imgName.substring(imgName.indexOf("."));
                        
                        in = imgPart.getInputStream();
                        File file = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + imgName);
                        file.createNewFile();
                        FileOutputStream filout = new FileOutputStream(file);
                        int length;
                        byte[] buffer = new byte[1024];
                        while ((length = in.read(buffer)) > 0) {
                            filout.write(buffer, 0, length);
                        }
                        filout.close();
                        in.close();
                    }
                } catch (IOException e) {
                    out.println("");
                }
                try {
                    String sql_check = "select * from maker where mk_bran_id = '"+session.getAttribute("user_bran_id")+"' and mk_name = '" + mk_name + "' and mk_mobile = '" + mk_mobile + "' ";
                    PreparedStatement pst_check = DbConnection.getConn(sql_check);
                    ResultSet rs_check = pst_check.executeQuery();
                    if (rs_check.next()) {
                        session.setAttribute("maker_reg_msg", "has");
                        response.sendRedirect("/Tailor/admin/maker_reg.jsp");
                    } else {
                        try {
                            String sql_maker = "insert into maker values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                            PreparedStatement pst_maker = DbConnection.getConn(sql_maker);
                            pst_maker.setString(1, null);
                            pst_maker.setString(2, (String) session.getAttribute("user_com_id"));
                            pst_maker.setString(3, (String) session.getAttribute("user_bran_id"));
                            pst_maker.setString(4, null);
                            pst_maker.setString(5, mk_name);
                            pst_maker.setString(6, mk_mobile);
                            pst_maker.setString(7, mk_email);
                            pst_maker.setString(8, mk_address);
                            pst_maker.setString(9, mk_birthdate);
                            pst_maker.setString(10, mk_nid);
                            pst_maker.setString(11, imgName);
                            pst_maker.setString(12, null);
                            pst_maker.setString(13, "active");
                            pst_maker.setString(14, mk_password);
                            pst_maker.setString(15, mk_ref_name);
                            pst_maker.setString(16, mk_ref_mobile);
                            pst_maker.execute();
                            session.setAttribute("maker_reg_msg", "ok");
                            response.sendRedirect("/Tailor/admin/maker_reg.jsp");

                        } catch (SQLException e) {
                            out.println(e.toString());
                        }
                    }
                } catch (SQLException e) {
                    out.println(e.toString());
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
