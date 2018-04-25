<%@page import="java.sql.ResultSet"%>
<%
    String logger = (String) session.getAttribute("logger");
%>

<%
    try {

        if (logger != null) {
            if (logger.equals("user")) {
                String ss_id = (String) session.getAttribute("user_user_id");
                if (ss_id == null) {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            } else if (logger.equals("root")) {
                String user_root = (String) session.getAttribute("user_root");
                if (user_root == null) {
                    response.sendRedirect("../index.jsp");
                }
            } else if (logger.equals("company")) {
                String user_com_id = (String) session.getAttribute("user_com_id");
                if (user_com_id == null) {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            } else if (logger.equals("branch")) {
                String user_bran_id = (String) session.getAttribute("user_bran_id");
                if (user_bran_id == null) {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            }
        } else {
            response.sendRedirect("/Tailor/index.jsp");
        }

    } catch (Exception e) {
        out.println(e.toString());
    }
%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String com_id = (String) session.getAttribute("user_com_id");
    String bran_id = (String) session.getAttribute("user_bran_id");
    String shirt_price = request.getParameter("s_price");
    String pant_price = request.getParameter("pnt_price");
    String blazer_price = request.getParameter("blz_price");
    String panjabi_price = request.getParameter("pnjbi_price");
    String payjama_price = request.getParameter("pjama_price");
    String safari_price = request.getParameter("sfri_price");
    String photua_price = request.getParameter("pht_price");
    String mojibcort_price = request.getParameter("mjc_price");
    String kable_price = request.getParameter("kbl_price");
    String koti_price = request.getParameter("kt_price");
    
    if(shirt_price == ""){
        shirt_price = "0";
    }
    if(pant_price == ""){
        pant_price = "0";
    }
    if(blazer_price == ""){
        blazer_price = "0";
    }
    if(panjabi_price == ""){
        panjabi_price = "0";
    }
    if(payjama_price == ""){
        payjama_price = "0";
    }
    if(safari_price == ""){
        safari_price = "0";
    }    
    if(photua_price == ""){
        photua_price = "0";
    }    
    if(mojibcort_price == ""){
        mojibcort_price = "0";
    }
    if(kable_price == ""){
        kable_price = "0";
    }
    if(koti_price == ""){
        koti_price = "0";
    }
 

    try {
        String sql_check_has_branch_id = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
        PreparedStatement pst_check_has_branch_id = DbConnection.getConn(sql_check_has_branch_id);
        ResultSet rs_check = pst_check_has_branch_id.executeQuery();
        if (rs_check.next()) {
            try {
                String sql_up_pric = "update price_list set prlist_shirt = '" + shirt_price + "', prlist_pant = '"
                        + pant_price + "', prlist_blazer = '" + blazer_price + "', prlist_panjabi = '" + panjabi_price + "', prlist_payjama = '"
                        + payjama_price + "', prlist_safari = '"
                        + safari_price + "' , prlist_photua = '" + photua_price + "',prlist_mojib_cort = '"+mojibcort_price+"',prlist_kable = '"+kable_price+"',prlist_koti = '"+koti_price+"' where prlist_bran_id = '" + bran_id + "' ";
                PreparedStatement pst_up_price = DbConnection.getConn(sql_up_pric);
                int i = pst_up_price.executeUpdate();
                if (i > 0) {
                    session.setAttribute("price_updated", "updated");
                    response.sendRedirect("price_change_by_user.jsp");
                } else {
                    out.println("Something Error");
                }
            } catch (Exception e) {
                out.println(e.toString());
            }
        } else {
            try {
                String sql_inser_price = "insert into price_list values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement pst_insert_price = DbConnection.getConn(sql_inser_price);
                pst_insert_price.setString(1, null);
                pst_insert_price.setString(2, com_id);
                pst_insert_price.setString(3, bran_id);
                pst_insert_price.setString(4, shirt_price);
                pst_insert_price.setString(5, pant_price);
                pst_insert_price.setString(6, blazer_price);
                pst_insert_price.setString(7, panjabi_price);
                pst_insert_price.setString(8, payjama_price);
                pst_insert_price.setString(9, safari_price);
                pst_insert_price.setString(10, photua_price);
                pst_insert_price.setString(11, mojibcort_price);
                pst_insert_price.setString(12, kable_price);
                pst_insert_price.setString(13, koti_price);
                pst_insert_price.execute();
                 session.setAttribute("price_updated", "inserted");
                 response.sendRedirect("price_change_by_user.jsp");
            } catch (Exception e) {
                out.println(e.toString());
            }
        }
    } catch (Exception e) {
        out.println(e.toString());
    }

%>