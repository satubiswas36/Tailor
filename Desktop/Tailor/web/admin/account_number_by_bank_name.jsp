
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>       

        <select style="width: 100%; height: 32px">
            <option value="">--Select--</option>
            <%
                try {
                    String sql_group_name = "select * from bank_account where bk_bran_id = '" + session.getAttribute("user_bran_id") + "' and bk_name = '" + session.getAttribute("bank_id") + "' ";
                    PreparedStatement pst_group_name = DbConnection.getConn(sql_group_name);
                    ResultSet rs_group_name = pst_group_name.executeQuery();
                    while (rs_group_name.next()) {
                        String account_no = rs_group_name.getString("bk_account_no");
                        String sl = rs_group_name.getString("bk_sl");
                        String branch_name = rs_group_name.getString("bk_branch_name");
            %>
            <option value="<%=sl%>"><%=account_no+" ("+ branch_name +")"%></option>
            <%
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
        </select>
    </body>
</html>
