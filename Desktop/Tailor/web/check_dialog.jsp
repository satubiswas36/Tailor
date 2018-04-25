<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>jQuery UI Dialog - Default functionality</title>
        <jsp:include page="menu/header.jsp" flush="true"/>
        
    </head>
    <body>
        <%
            String sub =null;
            String sl = null;
            String sql = "select ws_slno, min(ws_blazer) from worker_salary ";
            PreparedStatement pst = DbConnection.getConn(sql);
            ResultSet rs = pst.executeQuery();
           rs.next();
                 sub = rs.getString(2);
                sl = rs.getString(1);
            
            out.println(sub+ " sl "+ sl);
            %>
    </body>
</html>