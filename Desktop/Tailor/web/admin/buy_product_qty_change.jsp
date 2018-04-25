
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
            String total_price = request.getParameter("total_price");
            String buy_qty = request.getParameter("buy_qty");
            String product_id = request.getParameter("product_id");
            
            try {
                String sql_update = "update inventory_details set pro_buy_quantity = '"+buy_qty+"' where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_invoice_id = '"+session.getAttribute("invoice_id_for_parchase")+"' and pro_product_id = '"+product_id+"' and pro_deal_type = 3";
                PreparedStatement pst_update = DbConnection.getConn(sql_update);
                pst_update.execute();
            } catch (Exception e) {
            }
            out.println(total_price);
        %>
    </body>
</html>
