
<%
    String order_id = null;
    String cus_id = null;
    String logger = (String) session.getAttribute("logger");
%>


<%
    try {

        if (logger != null) {
            if (logger.equals("user")) {
                String ss_id = (String) session.getAttribute("user_user_id");
                if (ss_id == null) {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            } else if (logger.equals("root")) {
                String user_root = (String) session.getAttribute("user_root");
                if (user_root == null) {
                    response.sendRedirect("../index.jsp");
                }
            } else if (logger.equals("company")) {
                String user_com_id = (String) session.getAttribute("user_com_id");
                if (user_com_id == null) {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            } else if (logger.equals("branch")) {
                String user_bran_id = (String) session.getAttribute("user_bran_id");
                if (user_bran_id == null) {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            }
        } else {
            response.sendRedirect("/Tailor/index.jsp");
        }

    } catch (Exception e) {
        out.println(e.toString());
    }
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Calendar"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <!--   delete all data from temporary-->
        <div id="wrapper">
            <jsp:include page="../menu/menu.jsp?page_name=customer"/>  
            <div id="page-wrapper" >
                <div id="page-inner">
                    <aside class="right-side">
                        <section class="content">
                            <div class="row">
                                <div class="col-xs-10">
                                    <div class="box">
                                        <%
                                            order_id = request.getParameter("takeorderid");

                                            cus_id = request.getParameter("customer_id");
                                        %>
                                        <div class="box-header">
                                            <h3 class="box-title"></h3>
                                        </div>        
                                        <div class="box-body table-responsive">                                            
                                            <table id="DataTable" class="table table-bordered table-hover" style="width: 45%">
                                                <thead>
                                                    <tr>                                                        
                                                        <th style="text-align: center">SL</th>
                                                        <th style="text-align: center">Product Name</th>                                                                                                  
                                                        <th style="text-align: center">Qty</th>
                                                        <th style="text-align: center">Action</th>                                                        
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- ---------------------------------------------------- order id------------------------------------------------------------------->

                                                    <!-- ---------------------------------------------------- order id end-------------------------------------------------------------->
                                                    <!----------------------------------------------------------shir qty ----------------------------------------------------------------------------------------->
                                                    <%
                                                        int id = 1;
                                                        String sql_s = "select * from ser_shirt where order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_s = DbConnection.getConn(sql_s);
                                                        ResultSet rs_s = pst_s.executeQuery();
                                                        if (rs_s.next()) {
                                                            String sql_shirt = "select * from ser_shirt where order_id = " + order_id;
                                                            PreparedStatement pst_shirt = DbConnection.getConn(sql_shirt);
                                                            ResultSet rs_shirt = pst_shirt.executeQuery();
                                                            while (rs_shirt.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center; width: 6%;"><%= id++%></td>
                                                        <td style="text-align: center; width: 25%;"><%= "Shirt"%> </td>
                                                        <td style="text-align: center; width: 6%;"><%= rs_shirt.getString("qty")%></td>
                                                        <td style="text-align: center; width: 8%;"><button class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button></td>
                                                    </tr>
                                                    <%
                                                            }
                                                        } else {

                                                        }
                                                    %>                                                    
                                                    <!---------------------------------------------------------------////shirt qty---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------pant qty---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_p = "select * from ser_pant where order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_p = DbConnection.getConn(sql_p);
                                                        ResultSet rs_p = pst_p.executeQuery();
                                                        if (rs_p.next()) {
                                                            String sql_pant = "select * from ser_pant where order_id = " + order_id;
                                                            PreparedStatement pst_pant = DbConnection.getConn(sql_pant);
                                                            ResultSet rs_pant = pst_pant.executeQuery();
                                                            while (rs_pant.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Pant"%></td>
                                                        <td style="text-align: center"><%= rs_pant.getString("qty")%></td>
                                                        <td style="text-align: center"><button class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button></td>
                                                    </tr>
                                                    <%
                                                        }
                                                    } else {
                                                    %>

                                                    <%
                                                        }
                                                    %>                                                    
                                                    <!---------------------------------------------------------------pant qty end---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------blazer qty ---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_bl = "select * from ser_blazer where order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_bl = DbConnection.getConn(sql_bl);
                                                        ResultSet rs_bl = pst_bl.executeQuery();
                                                        if (rs_bl.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=  id++%></td>
                                                        <td style="text-align: center"><%= "Blazer"%></td>
                                                        <td style="text-align: center"><%= rs_bl.getString("qty")%> </td>
                                                        <td style="text-align: center"><button class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button></td>
                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>

                                                    <%
                                                        }
                                                    %>
                                                    <!---------------------------------------------------------------///blazer qty ---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------photua qty ---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_pht = "select * from ser_photua where order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_pht = DbConnection.getConn(sql_pht);
                                                        ResultSet rs_pht = pst_pht.executeQuery();
                                                        if (rs_pht.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Photua"%></td>
                                                        <td style="text-align: center"><%= rs_pht.getString("qty")%></td>
                                                        <td style="text-align: center"><button class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button></td>
                                                    </tr>
                                                    <%

                                                        }
                                                    %>
                                                    <!---------------------------------------------------------------///blazer qty ---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------safari qty ---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_safari = "select * from ser_safari where order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_safari = DbConnection.getConn(sql_safari);
                                                        ResultSet rs_safari = pst_safari.executeQuery();
                                                        if (rs_safari.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Safari"%></td>
                                                        <td style="text-align: center"><%= rs_pht.getString("qty")%></td>
                                                        <td style="text-align: center"><button class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button></td>
                                                    </tr>
                                                    <%

                                                        } else {

                                                        }
                                                    %>
                                                    <!---------------------------------------------------------------///safari qty ---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------panjabi qty ---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_panjabi = "select * from ser_panjabi where order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_panjabi = DbConnection.getConn(sql_panjabi);
                                                        ResultSet rs_panjabi = pst_panjabi.executeQuery();
                                                        if (rs_panjabi.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Panjabi"%></td>
                                                        <td style="text-align: center"><%= rs_panjabi.getString("qty")%></td>
                                                        <td style="text-align: center"><button class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button></td>
                                                    </tr>
                                                    <%

                                                        } else {

                                                        }
                                                    %>
                                                    <!---------------------------------------------------------------///safari qty ---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------payjama qty ---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_payjama = "select * from ser_payjama where order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_payjama = DbConnection.getConn(sql_payjama);
                                                        ResultSet rs_payjama = pst_payjama.executeQuery();
                                                        if (rs_payjama.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Payjama"%></td>
                                                        <td style="text-align: center"><%= rs_payjama.getString("qty")%></td>
                                                        <td style="text-align: center"><button class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button></td>
                                                    </tr>
                                                    <%

                                                        } else {

                                                        }
                                                    %>
                                                    <!---------------------------------------------------------------///safari qty ---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------mojib cort qty ---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_mojibcort = "select * from ser_mojib_cort where order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_mojibcort = DbConnection.getConn(sql_mojibcort);
                                                        ResultSet rs_mojibcort = pst_mojibcort.executeQuery();
                                                        if (rs_mojibcort.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Mojib Cort"%></td>
                                                        <td style="text-align: center"><%= rs_mojibcort.getString("qty")%></td>
                                                        <td style="text-align: center"><button class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button></td>
                                                    </tr>
                                                    <%

                                                        } else {

                                                        }
                                                    %>
                                                    <!---------------------------------------------------------------///safari qty ---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------Kable qty ---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_kable = "select * from ser_kable where order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_kable = DbConnection.getConn(sql_kable);
                                                        ResultSet rs_kable = pst_kable.executeQuery();
                                                        if (rs_kable.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Kable"%></td>
                                                        <td style="text-align: center"><%= rs_kable.getString("qty")%></td>
                                                        <td style="text-align: center"><button class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button></td>
                                                    </tr>
                                                    <%

                                                        } else {

                                                        }
                                                    %>
                                                    <!---------------------------------------------------------------///safari qty ---------------------------------------------------------------------------->
                                                    <!---------------------------------------------------------------Kable qty ---------------------------------------------------------------------------->
                                                    <%
                                                        String sql_koti = "select * from ser_kable where order_id = '" + order_id + "' ";
                                                        PreparedStatement pst_koti = DbConnection.getConn(sql_koti);
                                                        ResultSet rs_koti = pst_koti.executeQuery();
                                                        if (rs_koti.next()) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%= id++%></td>
                                                        <td style="text-align: center"><%= "Koti"%></td>
                                                        <td style="text-align: center"><%= rs_koti.getString("qty")%></td>
                                                        <td style="text-align: center"><button class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button></td>
                                                    </tr>
                                                    <%

                                                        } else {

                                                        }
                                                    %>
                                                    <!---------------------------------------------------------------///safari qty ---------------------------------------------------------------------------->
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>                           

                            </div>
                        </section>
                    </aside>                                         
                </div>
            </div>
        </div>
            <script src="assets/js/jquery-1.10.2.js"></script>   
            <script src="assets/js/bootstrap.min.js"></script>    
            <script src="assets/js/jquery.metisMenu.js"></script>     
            <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
            <script src="assets/js/morris/morris.js"></script>   
            <script src="assets/js/custom.js"></script>      
    </body>
</html>
