
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>

        <%
            String product_id = request.getParameter("product_id");
//            if (session.getAttribute("produc_id_for_price") != null) {
//                product_id = (String) session.getAttribute("produc_id_for_price");
//                // product_id = "2";
//            }
                String sql_product_price = "select * from inv_product where pr_product_name = '" + product_id + "' ";
                PreparedStatement pst_product_price = DbConnection.getConn(sql_product_price);
                ResultSet rs_product_price = pst_product_price.executeQuery();
                if (rs_product_price.next()) {
                    String pro_price = rs_product_price.getString("pr_buy_price");
                    
        %>
        <%= pro_price%>
    <%
            }

    %>        

