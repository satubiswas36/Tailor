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

@WebServlet(name = "branch_reg", urlPatterns = {"/branch_reg"})
@MultipartConfig(maxFileSize = -1L)
public class branch_reg extends HttpServlet {

    HttpSession session;
    int branch_id = 1;
    int bran_sender_id = 1;

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
        PrintWriter out = response.getWriter();
        session = request.getSession(false);
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
        String bran_person_name = request.getParameter("bran_person_name");
        String bran_order_no = request.getParameter("order_no");

        String message_times = "";
        if (message_time != null) {
            for (int i = 0; i < message_time.length; i++) {
                message_times += message_time[i] + " ";
            }
        }

        try {
            String slq = "select * from user_branch ORDER BY bran_slno desc limit 1";
            PreparedStatement pst = DbConnection.getConn(slq);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                branch_id = Integer.parseInt(rs.getString(2));
                branch_id++;
            } else {
                branch_id = 1;
            }
        } catch (NumberFormatException | SQLException e) {
            out.println(e.toString());
        }
        String fileName = null;
        Part imgPart = request.getPart("logo");
        try {
            fileName = imgPart.getName();
            fileName = mobile + fileName.substring(fileName.indexOf("."));
            out.println(fileName);
            try {
                InputStream in = null;
                if (imgPart != null || fileName.length() > 0) {
                    in = imgPart.getInputStream();
                    File file = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + fileName.toLowerCase());
                    file.createNewFile();
                    try (FileOutputStream filout = new FileOutputStream(file)) {
                        int length;
                        byte[] buffer = new byte[1024];
                        while ((length = in.read(buffer)) > 0) {
                            filout.write(buffer, 0, length);
                        }
                    }
                    in.close();
                }
            } catch (IOException e) {
                out.println("");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String sql = "insert into user_branch values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement pst = DbConnection.getConn(sql);
        try {
            pst.setString(1, null);
            pst.setString(2, branch_id + "");
            pst.setString(3, com_id);
            pst.setString(4, name);
            pst.setString(5, email);
            pst.setString(6, password);
            pst.setString(7, mobile);
            pst.setString(8, phone);
            pst.setString(9, fax);
            pst.setString(10, address);
            pst.setString(11, city);
            pst.setString(12, zipcode);
            pst.setString(13, fileName.toLowerCase());
            pst.setString(14, taxable);
            pst.setString(15, businessType);
            pst.setString(16, website);
            pst.setString(17, opentime);
            pst.setString(18, closetime);
            pst.setString(19, null);
            pst.setString(20, "1");
            pst.setString(21, expiredate);
            pst.setString(22, sender_id);
            pst.setString(23, message_times);
            pst.setString(24, bran_person_name);
            pst.setString(25, bran_order_no);
            boolean i = pst.execute();
            session.setAttribute("bran_email_check_msg", "inserted");
            if (!response.isCommitted()) {
                response.sendRedirect("/Tailor/admin/branch_regis.jsp");
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
