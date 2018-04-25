package servlet;

import dao.customer.registration.CustomerRegistration;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = -1L)
public class Customer_Registration extends HttpServlet {

    HttpSession session;
    String cus_com_id = null;
    String cus_bran_id = null;
    String cus_user_id = null;
    int cus_customer = 20;
    CustomerRegistration customerRegistration;

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
        session = request.getSession(false);
        customerRegistration = new CustomerRegistration();
        cus_com_id = (String) session.getAttribute("user_com_id");
        cus_bran_id = (String) session.getAttribute("user_bran_id");
        cus_user_id = (String) session.getAttribute("user_user_id");

        processRequest(request, response);
        PrintWriter out = response.getWriter();

        // last customer id and add 1 on it
        cus_customer = customerRegistration.lastCustomerID();
//        try {
//            String slq = "select * from customer ORDER BY cus_slno desc limit 1";
//            PreparedStatement pst = DbConnection.getConn(slq);
//            ResultSet rs = pst.executeQuery();
//            if (rs.next()) {
//                cus_customer = Integer.parseInt(rs.getString("cus_customer_id"));
//                cus_customer++;
//            } else {
//                cus_customer = 1;
//            }
//        } catch (NumberFormatException | SQLException e) {
//            out.println(e.toString());
//        }

        String cus_name = request.getParameter("cus_name");
        String cus_email = request.getParameter("cus_email");
        String cus_phone = request.getParameter("cus_phone");
        String cus_address = request.getParameter("cus_address");
        String cus_reference = request.getParameter("cus_reference");
        String cus_status = request.getParameter("cus_status");
        String cus_nid = request.getParameter("cus_nid_card");
        String cus_blood = request.getParameter("cus_blood");
        String cus_birthdate = request.getParameter("cus_birthdate");
        Part imgPart = request.getPart("cus_image");

        String imgName = customerRegistration.customerImageUpload(imgPart, cus_phone);
        //                String imgName = null;      
//                imgName = imgPart.getSubmittedFileName();
//                try {
//                    InputStream in = null;
//                    if (imgName.length() != 0) {
//                        
//                        imgName = cus_phone + imgName.substring(imgName.indexOf("."));
//                        
//                        in = imgPart.getInputStream();
//                        File file = new File("F:\\SERVER\\xampp\\htdocs\\Tailor\\web\\images\\" + imgName);
//                        file.createNewFile();
//                        FileOutputStream filout = new FileOutputStream(file);
//                        int length;
//                        byte[] buffer = new byte[1024];
//                        while ((length = in.read(buffer)) > 0) {
//                            filout.write(buffer, 0, length);
//                        }
//                        filout.close();
//                        in.close();
//                    }
//                } catch (IOException e) {
//                    out.println("");
//                }
        int i = customerRegistration.customerRegistration(cus_com_id, cus_bran_id, cus_user_id,
                cus_customer, cus_name, cus_email, cus_address,
                cus_phone, cus_blood, cus_nid, cus_birthdate, cus_reference, imgName);
        if (i >= 1) {
            session.setAttribute("mobile_success", "Successfully inserted !!!");
            response.sendRedirect("/Tailor/admin/customer_registration.jsp");
        }
//                try {
//                    String sql = "insert into customer values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
//                    PreparedStatement pst = DbConnection.getConn(sql);
//                    pst.setString(1, null);
//                    pst.setString(2, cus_com_id);
//                    pst.setString(3, cus_bran_id);
//                    pst.setString(4, cus_user_id);
//                    pst.setString(5, cus_customer + "");
//                    pst.setString(6, cus_name);
//                    pst.setString(7, cus_email);
//                    pst.setString(8, cus_address);
//                    pst.setString(9, cus_phone);
//                    pst.setString(10, cus_blood);
//                    pst.setString(11, cus_nid);
//                    pst.setString(12, cus_birthdate);
//                    pst.setString(13, cus_reference);
//                    pst.setString(14, "1");
//                    pst.setString(15, null);
//                    pst.setString(16, imgName);                   
//                    pst.execute();
//                    session.setAttribute("mobile_success", "Successfully inserted !!!");
//                    response.sendRedirect("/Tailor/admin/customer_registration.jsp");
//                } catch (SQLException e) {
//                    out.println(e.toString());
//                }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
