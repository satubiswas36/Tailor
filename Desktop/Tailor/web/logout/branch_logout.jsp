<%-- 
    Document   : branch_logout
    Created on : Apr 22, 2017, 3:59:07 PM
    Author     : Rasel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <%
                    session.removeAttribute("user_com_id");
                    session.removeAttribute("user_bran_id");
                    session.removeAttribute("bran_email");
                    session.removeAttribute("user_user_id"); 
                   // session.invalidate();
                    response.sendRedirect("/Tailor/index.jsp");
            %>
    </body>
</html>
