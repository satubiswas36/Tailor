<%-- 
    Document   : includepaged
    Created on : Apr 9, 2017, 1:31:47 PM
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
    <%
        String save_session_id = null;
        if (session.getAttribute("saveSessionid") != null) {
            save_session_id = (String) session.getAttribute("saveSessionid");
        }

    %>
    <body>
        <div class="col-xs-5">
            <div class="box">             
                <div class="box-body table-responsive" id="cart_anchor" style="">
                    <table id="DataTable" class="table table-bordered table-hover">

                        <tbody>
                            <%     
                                double total_price = 0;
                                int id = 1;
                                String sql = "select * from temporary where session_id = '"+save_session_id+"' ";
                                PreparedStatement pst = DbConnection.getConn(sql);
                                ResultSet rs = pst.executeQuery();
                                while (rs.next()) {
                                    total_price += Double.parseDouble(rs.getString(5));
                            %>
                            <tr>
                                <td style="text-align: center"><%= id++ %></td>
                                <td><%= rs.getString(3)%></td>
                                <td id="qty" style="text-align: center"><%= rs.getString(6)%></td>
                                <td id="price" style="text-align: right"><%= rs.getString(4)+".00"%></td>
                                <td id="total_price" style="text-align: right"><%=  rs.getString(5)+".00"%></td>                                
                            </tr>
                            <%
                                }
                            %>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td style="text-align: right"><b>Total Price : </b></td>
                                <td style="text-align: right"><b><%=total_price+"0"%></b></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
