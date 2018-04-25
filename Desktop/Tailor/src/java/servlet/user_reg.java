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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = -1L)
@WebServlet(name = "user_reg", urlPatterns = {"/user_reg"})
public class user_reg extends HttpServlet {

    int user_id = 2000;
    HttpSession session;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        session = request.getSession(false);

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
        session = request.getSession(false);

        String name = request.getParameter("user_name");
        String email = request.getParameter("user_email");
        String password = request.getParameter("user_password");
        String mobile = request.getParameter("user_mobile");
        String address = request.getParameter("user_address");
        String city = request.getParameter("user_city");
        String zipcode = request.getParameter("user_zipcode");
        String status = request.getParameter("user_status");
        String com_id = (String) session.getAttribute("user_com_id");
        String bran_id = (String) session.getAttribute("user_bran_id");
        String user_id_for_update = request.getParameter("user_id");
        String user_ref_name = request.getParameter("user_ref_name");
        String user_ref_mobile = request.getParameter("user_ref_mobile");
        String user_old_pic = request.getParameter("user_pic_old");
        Part imgPart = request.getPart("user_pic");

        if (user_id_for_update != null) {
            String imgName = null;
            imgName = imgPart.getName();
            if (imgName.length() != 0) {
                File file = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + user_old_pic);
                file.delete();
                imgName = mobile + imgName.substring(imgName.indexOf("."));
                try {
                    InputStream in = null;
                    if (imgPart != null) {
                        in = imgPart.getInputStream();
                        File file2 = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + imgName.toLowerCase());
                        file2.createNewFile();
                        try (FileOutputStream filout = new FileOutputStream(file2)) {
                            int length;
                            byte[] buffer = new byte[1024];
                            while ((length = in.read(buffer)) > 0) {
                                filout.write(buffer, 0, length);
                            }
                        }
                        in.close();
                    }
                } catch (IOException e) {
                    out.println(e.toString());
                }
                try {
                    String sql_user_update = "update user_user set user_name = '" + name + "',user_email = '" + email + "',user_password = '" + password + "',user_mobile = '" + mobile + "',user_address = '" + address + "',user_city = '" + city + "',user_zipcode = '" + zipcode + "',user_status = '" + status + "',user_pic = '" + imgName.toLowerCase() + "',user_ref_name = '" + user_ref_name + "',user_ref_mobile = '" + user_ref_mobile + "' where user_bran_id = '" + session.getAttribute("user_bran_id") + "' and user_id = '" + user_id_for_update + "' ";
                    PreparedStatement pst_user_update = DbConnection.getConn(sql_user_update);
                    pst_user_update.executeUpdate();
                    session.setAttribute("user_updated", "ok");
                    response.sendRedirect("/Tailor/admin/all_users.jsp");
                } catch (SQLException e) {
                    out.println(e.toString());
                }
            }
            if (imgName.length() == 0) {
                String newNameforImage = mobile + user_old_pic.substring(user_old_pic.indexOf("."));
                File renFile = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + user_old_pic);
                File newNameFile = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + newNameforImage + "");
                renFile.renameTo(newNameFile);
                imgName = mobile + user_old_pic.substring(user_old_pic.indexOf("."));
                try {
                    String sql_user_update = "update user_user set user_name = '" + name + "',user_email = '" + email + "',user_password = '" + password + "',user_mobile = '" + mobile + "',user_address = '" + address + "',user_city = '" + city + "',user_zipcode = '" + zipcode + "',user_status = '" + status + "',user_pic = '" + imgName.toLowerCase() + "',user_ref_name = '" + user_ref_name + "',user_ref_mobile = '" + user_ref_mobile + "' where user_bran_id = '" + session.getAttribute("user_bran_id") + "' and user_id = '" + user_id_for_update + "' ";
                    PreparedStatement pst_user_update = DbConnection.getConn(sql_user_update);
                    pst_user_update.executeUpdate();
                    session.setAttribute("user_updated", "ok");
                    response.sendRedirect("/Tailor/admin/all_users.jsp");
                } catch (SQLException e) {
                    out.println(e.toString());
                }
            }
        } else {
            String imgName = null;
            try {
                InputStream in = null;
                if (imgPart != null) {
                    imgName = imgPart.getName();
                    imgName = mobile + imgName.substring(imgName.indexOf("."));

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
                String slq = "select * from user_user ORDER BY user_slno desc limit 1";
                PreparedStatement pst = DbConnection.getConn(slq);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    user_id = Integer.parseInt(rs.getString("user_id"));
                    user_id++;
                } else {
                    user_id = 1;
                }
            } catch (NumberFormatException | SQLException e) {
                out.println(e.toString());
            }
            String sql = "insert into user_user values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = DbConnection.getConn(sql);
            try {
                pst.setString(1, null);
                pst.setString(2, com_id);
                pst.setString(3, bran_id);
                pst.setString(4, user_id + "");
                pst.setString(5, name);
                pst.setString(6, email);
                pst.setString(7, password);
                pst.setString(8, mobile);
                pst.setString(9, address);
                pst.setString(10, city);
                pst.setString(11, zipcode);
                pst.setString(12, null);
                pst.setString(13, "1");
                pst.setString(14, imgName);
                pst.setString(15, user_ref_name);
                pst.setString(16, user_ref_mobile);
                pst.execute();
                session.setAttribute("user_email_check_msg", "inserted");
                response.sendRedirect("/Tailor/admin/user_reg.jsp");
            } catch (SQLException e) {
                out.println(e.toString());
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
