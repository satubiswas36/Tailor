<%-- 
    Document   : order_delete
    Created on : Jun 6, 2017, 2:14:21 PM
    Author     : Rasel
--%>

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
    String sess_id = null;
    sess_id = request.getParameter("sid");
    try {
            String sql = "delete from temporary where session_id = '"+sess_id+"' ";
            PreparedStatement pst = DbConnection.getConn(sql);
            pst.execute();
        } catch (Exception e) {
            out.println(e.toString());
        }
    %>
    </body>
</html>
