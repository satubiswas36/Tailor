<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String mobile = request.getParameter("mobile");
    String supname = request.getParameter("name");
    try {
            String sqlMobile = "select * from supplier where suplr_bran_id = '"+session.getAttribute("user_bran_id") +"'  and suplr_name = '"+supname+"' and suplr_mobile = '"+mobile+"' ";
            PreparedStatement pstMobile = DbConnection.getConn(sqlMobile);
            ResultSet rsMobile = pstMobile.executeQuery();
            if(rsMobile.next()){
                out.println("exit");
            }
        } catch (Exception e) {
            out.println(e.toString());
        }    
    %>