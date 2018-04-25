<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String mobile = request.getParameter("mobile");
    String status = request.getParameter("status");

    try {
        String sql_root_mail = "select * from user_root where root_mobile = '" + mobile + "' ";
        PreparedStatement pst_root_mail = DbConnection.getConn(sql_root_mail);
        ResultSet rs_root_mail = pst_root_mail.executeQuery();
        if (rs_root_mail.next()) {
            out.println("exit");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }
    try {
        // mail check in user_ccompany exit or not
        String sql_com_email = "select * from user_company where com_mobile = '" + mobile + "' ";
        PreparedStatement pst_com_mail = DbConnection.getConn(sql_com_email);
        ResultSet rs_com_mail = pst_com_mail.executeQuery();
        if (rs_com_mail.next()) {
            out.println("exit");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }
    try {
        // mail check in user_branch exit or not
        String sql_bran_emil = "select  * from user_branch where bran_mobile = '" + mobile + "' ";
        PreparedStatement pst_bran_email = DbConnection.getConn(sql_bran_emil);
        ResultSet rs_bran_email = pst_bran_email.executeQuery();
        if (rs_bran_email.next()) {
            out.print("exit");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }
    try {
        String sql_user_mail = "select * from user_user where user_mobile = '" + mobile + "' ";
        PreparedStatement pst_user_mail = DbConnection.getConn(sql_user_mail);
        ResultSet rs_user_mail = pst_user_mail.executeQuery();
        if (rs_user_mail.next()) {
            out.println("exit");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }

    try {
        String sql_cus_mobile = null;
        if (status != null) {
            if (status.equals("user")) {
                sql_cus_mobile = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_mobile = '" + mobile + "' ";
            }
        } else {
            sql_cus_mobile = "select * from customer where cus_mobile = '" + mobile + "' ";
        }
        PreparedStatement pst_cus_mobile = DbConnection.getConn(sql_cus_mobile);
        ResultSet rs_cus_mobile = pst_cus_mobile.executeQuery();
        if (rs_cus_mobile.next()) {
            out.println("exit");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }
%>