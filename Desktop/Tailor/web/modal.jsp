<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.Blob"%>

<%
    String order= request.getParameter("ord_id");
    String cus_id= request.getParameter("customer_id");
    out.println(order + " "+cus_id);
%>