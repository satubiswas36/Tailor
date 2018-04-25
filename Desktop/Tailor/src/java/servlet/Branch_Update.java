package servlet;

import connection.DbConnection;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
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
@WebServlet(name = "Branch_Update", urlPatterns = {"/Branch_Update"})
public class Branch_Update extends HttpServlet {

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
        HttpSession session = request.getSession();

        String name = request.getParameter("bran_name");
        String email = request.getParameter("bran_email");
        String password = request.getParameter("bran_password");
        String mobile = request.getParameter("bran_mobile");
        String phone = request.getParameter("bran_phone");
        String fax = request.getParameter("bran_fax");
        String address = request.getParameter("bran_address");
        String city = request.getParameter("bran_city");
        String zipcode = request.getParameter("bran_zipcode");
        String businessType = request.getParameter("bran_bus_type");
        String opentime = request.getParameter("bran_open_time");
        String closetime = request.getParameter("bran_close_time");
        String website = request.getParameter("bran_website");
        String taxable = request.getParameter("taxable");
        String expiredate = request.getParameter("bran_expire_date");
        String com_id = (String) session.getAttribute("user_com_id");
        String sender_id = request.getParameter("bran_sender_id");
        String[] message_time = request.getParameterValues("chk");
        String bran_idd = request.getParameter("bran_id");
        String bran_statu = request.getParameter("active_status");
        String bran_image_name = request.getParameter("bran_image_name");
        String bran_order_no = request.getParameter("order_no");
        String person_name = request.getParameter("bran_person_name");

        String message_times = "";
        if (message_time != null) {
            for (int i = 0; i < message_time.length; i++) {
                message_times += message_time[i] + " ";
            }
        }
        String fileName = null;
        Part imgPart = request.getPart("logo");
        fileName = imgPart.getName();
        out.println(fileName.length());

        if (fileName.length() != 0) {
            File file = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + bran_image_name);
            file.delete();
            fileName = mobile + fileName.substring(fileName.indexOf("."));
            out.println(fileName);
            try {
                InputStream in = null;
                if (imgPart != null) {
                    in = imgPart.getInputStream();
                    File file2 = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + fileName.toLowerCase());
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

                String sql_bran_update = "update user_branch set bran_name = '" + name + "',bran_email = '" + email + "',bran_password = '" + password + "',"
                        + "bran_mobile= '" + mobile + "',bran_phone = '" + phone + "',bran_fax_no = '" + fax + "',bran_address = '" + address + "',bran_city = '" + city + "',"
                        + "bran_zipcode = '" + zipcode + "',bran_com_logo = '" + fileName.toLowerCase() + "', bran_is_taxable = '" + taxable + "',bran_business_type = '" + businessType + "',bran_website = '" + website + "',"
                        + "bran_open_time = '" + opentime + "',bran__close_time = '" + closetime + "',bran_status = '" + bran_statu + "',bran_expire_date = '" + expiredate + "',"
                        + "bran_sender_id = '" + sender_id + "', bran_message_time = '" + message_times + "',bran_order_no = '"+bran_order_no+"',bran_person_name = '"+person_name+"' where bran_id = '" + bran_idd + "' ";
                PreparedStatement pst_bran_update = DbConnection.getConn(sql_bran_update);
                pst_bran_update.executeUpdate();
                session.setAttribute("bran_list_update", "ok");
                if (!response.isCommitted()) {
                    response.sendRedirect("/Tailor/admin/branch_regis.jsp");
                }
            } catch (SQLException e) {
                out.println(e.toString());
            }
        }
        if (fileName.length() == 0) {
            String newNameforImage = mobile + bran_image_name.substring(bran_image_name.indexOf("."));
            File renFile = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + bran_image_name);
            File newNameFile = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + newNameforImage + "");
            renFile.renameTo(newNameFile);
            fileName = mobile + bran_image_name.substring(bran_image_name.indexOf("."));

            try {

                String sql_bran_update = "update user_branch set bran_name = '" + name + "',bran_email = '" + email + "',bran_password = '" + password + "',"
                        + "bran_mobile= '" + mobile + "',bran_phone = '" + phone + "',bran_fax_no = '" + fax + "',bran_address = '" + address + "',bran_city = '" + city + "',"
                        + "bran_zipcode = '" + zipcode + "',bran_com_logo = '" + fileName.toLowerCase() + "', bran_is_taxable = '" + taxable + "',bran_business_type = '" + businessType + "',bran_website = '" + website + "',"
                        + "bran_open_time = '" + opentime + "',bran__close_time = '" + closetime + "',bran_status = '" + bran_statu + "',bran_expire_date = '" + expiredate + "',"
                        + "bran_sender_id = '" + sender_id + "', bran_message_time = '" + message_times + "',bran_order_no = '"+bran_order_no+"',bran_person_name = '"+person_name+"' where bran_id = '" + bran_idd + "' ";
                PreparedStatement pst_bran_update = DbConnection.getConn(sql_bran_update);
                pst_bran_update.executeUpdate();
                session.setAttribute("bran_list_update", "ok");
                if (!response.isCommitted()) {
                    response.sendRedirect("/Tailor/admin/branch_list.jsp");
                }
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
