<%-- 
    Document   : check_bank_acc
    Created on : Nov 19, 2017, 2:56:14 PM
    Author     : Rasel
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String bank_id = request.getParameter("bank_id");
    String account_no = request.getParameter("acc_no");
    try {
        String sql_check = "select * from bank_account where bk_bran_id = '" + session.getAttribute("user_bran_id") + "' and bk_name = '" + bank_id + "' and bk_account_no = '" + account_no + "' ";
        PreparedStatement pst_check = DbConnection.getConn(sql_check);
        ResultSet rs_check = pst_check.executeQuery();
        if (rs_check.next()) {
            out.println("exit");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }
%>

