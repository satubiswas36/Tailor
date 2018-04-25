<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String amount = request.getParameter("amount");
    String bank_id = request.getParameter("bank_id");
    String account_no = request.getParameter("account_no");


    double balance = 0;  
    
    try {
        // total balance by account
        double debit = 0;
        double credit = 0;
        String sql_de_cedit = "select * from bank_transaction where bt_bran_id = '" + session.getAttribute("user_bran_id") + "' and bt_bank_id = '"+bank_id+"' and bt_account_no = '" + account_no+ "' ";
        PreparedStatement pst_de_cedit = DbConnection.getConn(sql_de_cedit);
        ResultSet rs_de_cedit = pst_de_cedit.executeQuery();
        while (rs_de_cedit.next()) {
            String Debit = rs_de_cedit.getString("bt_debit");
            debit += Double.parseDouble(Debit);
            String Credit = rs_de_cedit.getString("bt_credit");
            credit += Double.parseDouble(Credit);
        }
        balance = credit - debit;
        
        if(Double.parseDouble(amount) > balance){
            out.println("insufficient");
        }else {
            out.println("sufficient");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }    
%>