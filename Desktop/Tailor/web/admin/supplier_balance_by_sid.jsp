<%@page import="connection.DbConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String supplier_id = request.getParameter("sid");
    
    double total_debit = 0;
    double total_credit = 0;
    double due = 0;
    double all_credit = 0;
    double all_debit = 0;
    double all_balance = 0;

    try {
        String sql_debit = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + supplier_id + "' and (pro_deal_type = 3 or pro_deal_type = 8)";
        PreparedStatement pst_debit = DbConnection.getConn(sql_debit);
        ResultSet rs_debit = pst_debit.executeQuery();
        while (rs_debit.next()) {
            String debit = rs_debit.getString("pro_buy_paid"); // debit holo je tk supplier ke daoa hoyaca 
            String credit = rs_debit.getString("pro_buy_price");   // credit holo je tk pabe
            double Qty = Double.parseDouble(rs_debit.getString("pro_buy_quantity"));
            total_debit += Double.parseDouble(debit);
            total_credit += (Double.parseDouble(credit) * Qty);
        }
        due = total_credit - total_debit;
        out.println(due);
        all_balance += due;
        all_debit += total_debit;
        all_credit += total_credit;
    } catch (Exception e) {
        out.println(e.toString());
    }
%>