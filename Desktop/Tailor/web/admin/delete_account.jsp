<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String bank_id = request.getParameter("bank_id");
    String account_no = request.getParameter("account_no");
    
    try {
        String sql_delete_acc = "delete from bank_account where bk_bran_id = '" + session.getAttribute("user_bran_id") + "' and bk_name = '" + bank_id + "' and bk_account_no = '" + account_no + "' ";
        PreparedStatement pst_delete_acc = DbConnection.getConn(sql_delete_acc);
        pst_delete_acc.execute();
        session.setAttribute("delete_account","ok");
        response.sendRedirect("/Tailor/admin/bank_list.jsp");
    } catch (Exception e) {
        out.println(e.toString());
    }
%>