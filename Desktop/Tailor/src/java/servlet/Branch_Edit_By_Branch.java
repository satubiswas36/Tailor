
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
@WebServlet(name = "Branch_Edit_By_Branch", urlPatterns = {"/Branch_Edit_By_Branch"})
public class Branch_Edit_By_Branch extends HttpServlet {

  
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
        HttpSession session = request.getSession(false);
        String bran_image_name = null;
        String mobile = null;
        
        try {
            String sql_bran_image_name = "select * from user_branch where bran_id= '"+session.getAttribute("user_bran_id")+"' ";
            PreparedStatement pst_bran_image_name = DbConnection.getConn(sql_bran_image_name);
            ResultSet rs_bran_image_name = pst_bran_image_name.executeQuery();
            if(rs_bran_image_name.next()){
                bran_image_name = rs_bran_image_name.getString("bran_com_logo");
                mobile = rs_bran_image_name.getString("bran_mobile");
            }
        } catch (SQLException e) {
            out.println(e.toString());
        }
        
        String address = request.getParameter("address");
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

                String sql_bran_update = "update user_branch set bran_address = '"+address+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' ";
                PreparedStatement pst_bran_update = DbConnection.getConn(sql_bran_update);
                pst_bran_update.executeUpdate();
                session.setAttribute("bran_list_update", "ok");
                if (!response.isCommitted()) {
                    response.sendRedirect("/Tailor/admin/bran_edit_by_bran.jsp");
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
                String sql_bran_update = "update user_branch set bran_address = '"+address+"' where bran_id = '"+session.getAttribute("user_bran_id")+"' ";
                PreparedStatement pst_bran_update = DbConnection.getConn(sql_bran_update);
                pst_bran_update.executeUpdate();
                session.setAttribute("bran_edit_by_bran", "ok");
                if (!response.isCommitted()) {
                    response.sendRedirect("/Tailor/admin/bran_edit_by_bran.jsp");
                }
            } catch (SQLException e) {
                out.println(e.toString());
            }
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
