

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
            String pName;
            String Price ;
            String Total;
            String Qty;
            String SessionID;
            String com_id = (String)session.getAttribute("user_com_id");
            %>

        <%
             pName = request.getParameter("pname");
             Price = request.getParameter("price");
             Total = request.getParameter("total");
             Qty = request.getParameter("qty");
             SessionID = request.getParameter("sessionid");
             if(SessionID != null){
                 session.setAttribute("saveSessionid", SessionID);
             }
        %>

        <%
            
            String sql_produc = "select * from temporary where pName = '" + pName + "' and session_id = '"+SessionID+"' ";
            PreparedStatement pst_produc = DbConnection.getConn(sql_produc);
            ResultSet rs_produc = pst_produc.executeQuery();
            if (rs_produc.next()) {
                String sql_up_shirt = "update temporary set price = '" + Price + "' , total_price = '" + Total + "', qty = '" + Qty + "' where pName =  '" + pName + "' ";
                PreparedStatement pst_up_shirt = DbConnection.getConn(sql_up_shirt);
                pst_up_shirt.execute();
            } else {
                String sql = "insert into temporary(com_id,pName,price,total_price,qty,session_id) values('"+com_id+"','"+pName+"','"+Price+"','"+Total+"','"+Qty+"','"+SessionID+"')";
                PreparedStatement pst = DbConnection.getConn(sql);
                pst.execute();
               
            }
        %>



    </body>
</html>
