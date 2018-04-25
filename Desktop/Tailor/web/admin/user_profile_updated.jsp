
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String user_id = request.getParameter("user_id");
    String user_name = request.getParameter("user_name");
    String user_email = request.getParameter("user_email");
    String user_old_password = request.getParameter("user_old_password");
    String user_new_password = request.getParameter("user_new_password");
    String user_mobile = request.getParameter("user_mobile");
    String user_address = request.getParameter("user_address");
%>
<%
    try {
        String sql_update_profile_user = "select * from user_user where user_id = '" + user_id + "' and user_password = '" + user_old_password + "' ";
        PreparedStatement pst = DbConnection.getConn(sql_update_profile_user);
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            try {
                String sql_user_update = "update user_user set user_name = '" + user_name + "', user_email = '" + user_email + "', "
                        + "user_password = '" + user_new_password + "', user_mobile = '" + user_mobile + "', user_address = '" + user_address + "' where user_id = '" + user_id + "' ";
                PreparedStatement pst_user_update = DbConnection.getConn(sql_user_update);
                pst_user_update.executeUpdate();
                session.setAttribute("user_profile_update", "Successfully Updated !!!");
                response.sendRedirect("/Tailor/admin/user_profile_update.jsp");
            } catch (Exception e) {
                out.println(e.toString());
            }
        } else {
            session.setAttribute("user_profile_not_update", "Successfully Updated !!!");
            response.sendRedirect("/Tailor/admin/user_profile_update.jsp");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }
%>