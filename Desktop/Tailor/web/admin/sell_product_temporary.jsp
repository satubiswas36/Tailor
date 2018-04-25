<%-- 
    Document   : sell_product_temporary
    Created on : Aug 23, 2017, 10:42:52 AM
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
            String com_id = null;
            String bran_id = null;
            String usr_id = null;
            if (session.getAttribute("user_com_id") != null) {
                com_id = (String) session.getAttribute("user_com_id");
            }
            if (session.getAttribute("user_bran_id") != null) {
                bran_id = (String) session.getAttribute("user_bran_id");
            }
            if (session.getAttribute("user_com_id") != null) {
                usr_id = (String) session.getAttribute("user_com_id");
            } else {
                usr_id = bran_id;
            }

            String product_id = request.getParameter("product_id");
            String invoice = request.getParameter("invoice");
            String price = request.getParameter("price");
            String qty = request.getParameter("qty");

            try {
                String sql_exit_or_not = "select * from temporary_product_sell where bran_id = '" + session.getAttribute("user_bran_id") + "' and invoice_id = '" + invoice + "' and product_id = '" + product_id + "' ";
                PreparedStatement pst_exit_or_not = DbConnection.getConn(sql_exit_or_not);
                ResultSet rs_exit_or_not = pst_exit_or_not.executeQuery();
                if (rs_exit_or_not.next()) {
                    try {
                        String sql_update = "update temporary_product_sell set qty = '" + qty + "' where bran_id = '" + session.getAttribute("user_bran_id") + "' and invoice_id = '" + invoice + "' and product_id = '" + product_id + "' ";
                        PreparedStatement pst_update = DbConnection.getConn(sql_update);
                        pst_update.execute();
                    } catch (Exception e) {
                        out.println(e.toString());
                    }
                } else {
                    try {
                        String sql = "insert into temporary_product_sell values(?,?,?,?,?,?,?,?)";
                        PreparedStatement pst = DbConnection.getConn(sql);
                        pst.setString(1, null);
                        pst.setString(2, com_id);
                        pst.setString(3, bran_id);
                        pst.setString(4, usr_id);
                        pst.setString(5, invoice);
                        pst.setString(6, product_id);
                        pst.setString(7, price);
                        pst.setString(8, qty);
                        pst.execute();
                    } catch (Exception e) {
                        out.println(e.toString());
                    }
                }
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
                <td style="text-align: right"><%=(t_qty * t_price)+"0"%></td>        
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
                <td><b><%=all_price+"0"%></b></td>
            </tr>
        </table>
    </body>
</html>
