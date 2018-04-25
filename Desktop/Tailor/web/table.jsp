<%-- 
    Document   : table
    Created on : Sep 11, 2017, 10:35:23 PM
    Author     : SATU
--%>

<%@page import="com.satu.service.NumberConvertToWord"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://rawgit.com/wenzhixin/bootstrap-table/master/src/bootstrap-table.css" rel="stylesheet"/>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

        <script src="https://rawgit.com/wenzhixin/bootstrap-table/master/src/bootstrap-table.js"></script>
        <style>
            .table {
                border-bottom:0px !important;
            }
            .table th, .table td {
                border: 1px !important;
            }
            .fixed-table-container {
                border:0px !important;
            }
        </style>
    </head>
    <body>
        <table>
            
        <%
            
                 String wrd = new NumberConvertToWord().convert(15420);
               
            %>
            <tr>
                <td><%=wrd%></td>
            </tr>
        </table>
    </body>
</html>
