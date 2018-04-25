<%-- 
    Document   : logout
    Created on : Apr 20, 2017, 6:32:11 PM
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
        <div>

            <%
                    session.removeAttribute("user_com_id");
                    session.removeAttribute("user_bran_id");
                    session.removeAttribute("user_user_id"); 
                    session.removeAttribute("user_user_email");
                  //  session.invalidate();
                    response.sendRedirect("/Tailor/index.jsp");
            %>
        </div>
    </body>
</html>
