<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%

    String cus_id = request.getParameter("cus_id");
    //-----------------------------------------------------------customer due------------------------------------------------------------------------
    double total_debit = 0;
    double total_credit = 0;
    double due = 0;    
    double sell_qty = 0;
    //String user_name = null;

    // for debit 
    PreparedStatement pst_debit = null;
    ResultSet rs_debit = null;
    try {
        String sql_debit = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + cus_id + "' and (pro_deal_type = 5 or pro_deal_type = 1 or pro_deal_type = 4 or pro_deal_type = 6)";
        pst_debit = DbConnection.getConn(sql_debit);
        rs_debit = pst_debit.executeQuery();
        while (rs_debit.next()) {
            String debit = rs_debit.getString("pro_sell_price");
            sell_qty= Double.parseDouble(rs_debit.getString("pro_sell_quantity"));
            String credit = rs_debit.getString("pro_sell_paid");
            total_debit += (Double.parseDouble(debit) * sell_qty);
            total_credit += Double.parseDouble(credit);
        }
        due = total_debit - total_credit;
    }catch(Exception e){
        out.println(e.toString());
    }
        //-----------------------------------------------------------//customer due------------------------------------------------------------------------
        out.println(due);
%>