<%-- 
    Document   : delete_temp_product_sell
    Created on : Aug 24, 2017, 12:07:35 PM
    Author     : Rasel
--%>

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
            String invoice = request.getParameter("invoice");
            String product_id = request.getParameter("product_id");
            try {
                String sql = "delete from temporary_product_sell where invoice_id = '" + invoice + "' and product_id = '" + product_id + "' ";
                PreparedStatement pst = DbConnection.getConn(sql);
                pst.execute();
            } catch (Exception e) {
                out.println(e.toString());
            }
        %>
        <table style="margin-left: -20px;">
            <%                int sl = 1;
                String product_name = null;
                double t_qty = 0;
                double t_price = 0;
                double all_price = 0;
                try {
                    String sql_display = "select * from temporary_product_sell where invoice_id = '" + invoice + "' ";
                    PreparedStatement pst_display = DbConnection.getConn(sql_display);
                    ResultSet rs_display = pst_display.executeQuery();
                    while (rs_display.next()) {
                        String product_id_for_name = rs_display.getString("product_id");
                        String Qty = rs_display.getString("qty");
                        t_qty = Double.parseDouble(Qty);
                        String Price = rs_display.getString("price");
                        t_price = Double.parseDouble(Price);
                        all_price += (t_qty * t_price);
                        // product name by product id 
                        String sql_product_name = "select * from inv_product_name where prn_slid = '" + product_id_for_name + "' ";
                        PreparedStatement pst_product_name = DbConnection.getConn(sql_product_name);
                        ResultSet rs_product_name = pst_product_name.executeQuery();
                        if (rs_product_name.next()) {
                            product_name = rs_product_name.getString("prn_product_name");
                        }
                        // product name 
                        //  double t_qty = Double.parseDouble(rs_product_name.getString("qty"));
            %>
            <tr>
                <td><%=sl++%></td>
                <td style="text-align: left"><%=product_name%></td>
                <td><%=Qty%></td>
                <td style="text-align: right"><%=t_price + "0"%></td>
                <td style="text-align: right"><%=(t_qty * t_price) + "0"%></td>

            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><b><%=all_price + "0"%></b></td>
            </tr>
        </table>

    </body>
</html>
