
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
        <%
            String product_name = request.getParameter("pname");
            String ses_id = request.getParameter("sessionid");
            
            try {
                    String sql = "delete from temporary where session_id = '"+ses_id+"' and pName = '"+product_name+"' ";
                    PreparedStatement pst = DbConnection.getConn(sql);
                    pst.execute();
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
    </body>
</html>
