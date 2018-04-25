

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            session.removeAttribute("user_root");
            session.removeAttribute("user_root_email");
            session.removeAttribute("user_com_id");
            session.removeAttribute("user_bran_id");
            session.removeAttribute("user_user_id");
            //session.invalidate();
            response.sendRedirect("../index.jsp");
        %>
    </body>
</html>
