
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
        <%
            String group_id = null;
            String supplier_id = null;
            if(session.getAttribute("product_name_by_group_product") != null){
                group_id  =(String) session.getAttribute("product_name_by_group_product");
            }
            if(session.getAttribute("supplier_id_product") != null){
                supplier_id = (String)session.getAttribute("supplier_id_product");
            }
            %>

        <select style="width: 100%; height: 32px">
            <option value="">--Select--</option>
            <%
                try {
                    String sql_group_name = "select * from inv_product_name where prn_bran_id = '" + session.getAttribute("user_bran_id") + "' and supplier_id = '"+supplier_id+"' and prn_group_id = '"+group_id+"' order by prn_product_name asc ";
                    PreparedStatement pst_group_name = DbConnection.getConn(sql_group_name);
                    ResultSet rs_group_name = pst_group_name.executeQuery();
                    while (rs_group_name.next()) {
                        String product_name = rs_group_name.getString("prn_product_name");
                        String product_id = rs_group_name.getString("prn_slid");
            %>
            <option value="<%=product_id%>"><%=product_name%></option>
            <%
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
        </select>
    </body>
</html>
