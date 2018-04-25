<%@page import="connection.DbConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String logger = (String) session.getAttribute("logger");
%>

<%
    try {

        if (logger != null) {
            if (logger.equals("user")) {
                String ss_id = (String) session.getAttribute("user_user_id");
                if (ss_id == null) {
                    response.sendRedirect("../index.jsp");
                }
            } else if (logger.equals("root")) {
                String user_root = (String) session.getAttribute("user_root");
                if (user_root == null) {
                    response.sendRedirect("../index.jsp");
                }
            } else if (logger.equals("company")) {
                String user_com_id = (String) session.getAttribute("user_com_id");
                if (user_com_id == null) {
                    response.sendRedirect("../index.jsp");
                }
            } else if (logger.equals("branch")) {
                String user_bran_id = (String) session.getAttribute("user_bran_id");
                if (user_bran_id == null) {
                    response.sendRedirect("../index.jsp");
                }
            }
        } else {
            response.sendRedirect("../index.jsp");
        }

    } catch (Exception e) {
        out.println(e.toString());
    }
%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=cost"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                <span>Working Cost</span>
                                <%
                                    if (session.getAttribute("product_cost") != null) {
                                        if (session.getAttribute("product_cost").equals("ok")) {
                                %>
                                <center> <span class="product_cost" style="color: green; font-size: 18px">Successfully inserted !!</span></center>
                                    <%
                                    } else {
                                    %>
                                <span style="color: red; font-size: 18px;">Failed !!</span>
                                <%
                                        }
                                    }
                                    session.removeAttribute("product_cost");
                                %>
                            </div>
                            <div class="panel-body">
                                <form action="../Worker_salary" method="post" onsubmit="return price_validation()">
                                    <table id="" class="table table-bordered table-hover table-responsive" style="width: 50%;">
                                        <%
                                            String shirt_price = null;
                                            String pant_price = null;
                                            String blazer_price = null;
                                            String photua_price = null;
                                            String panjabi_price = null;
                                            String payjama_price = null;
                                            String safari_price = null;
                                            String mojib_cort_price = null;
                                            String kable_price = null;
                                            String koti_price = null; 
                                            String bran_id = (String) session.getAttribute("user_bran_id");
                                            try {
                                                String sql = "select * from worker_salary where ws_bran_id = '" + bran_id + "' ";
                                                session.setAttribute("satu", "1");
                                                PreparedStatement pst = DbConnection.getConn(sql);
                                                ResultSet rs = pst.executeQuery();
                                                while (rs.next()) {
                                                    shirt_price = rs.getString("ws_shirt");
                                                    pant_price = rs.getString("ws_pant");
                                                    blazer_price = rs.getString("ws_blazer");
                                                    panjabi_price = rs.getString("ws_panjabi");
                                                    payjama_price = rs.getString("ws_payjama");
                                                    safari_price = rs.getString("ws_safari");
                                                    photua_price = rs.getString("ws_photua");
                                                    mojib_cort_price = rs.getString("ws_mojib_cort");
                                                    kable_price = rs.getString("ws_kable");
                                                    koti_price = rs.getString("ws_koti");
                                                }
                                        %>
                                        <tr>
                                            <td>Shirt Price</td>
                                            <td style="width: 50%;"><input text="text" class="form-control" id="shirt_price" <%if (shirt_price != null) {%> value="<%= shirt_price%>"<%} %> name="s_price" maxlength="4"  required=""></td>
                                        </tr>
                                        <tr>
                                            <td>Pant Price</td>
                                            <td><input text="text" class="form-control"  name="pnt_price" id="pant_price"  <%if (pant_price != null) {%>value="<%= pant_price%>"<%} %> maxlength="4" required=""> </td>
                                        </tr>
                                        <tr>
                                            <td>Blazer Price</td>
                                            <td><input text="text" class="form-control" name="blz_price" id="blazer_price" <%if (blazer_price != null) {%>value="<%= blazer_price%>"<%} %> maxlength="4" required=""> </td>
                                        </tr>
                                        <tr>
                                            <td>Panjabi Price</td>
                                            <td><input text="text" class="form-control" name="pnjbi_price" id="panjabi_price" <%if (panjabi_price != null) {%>value="<%= panjabi_price%>"<%} %> maxlength="4" required=""> </td>
                                        </tr>
                                        <tr>
                                            <td>Payjama Price</td>
                                            <td><input text="text" class="form-control" name="pjama_price" id="payjama_price" <%if (payjama_price != null) {%>value="<%= payjama_price%>"<%} %> maxlength="4" required=""> </td>
                                        </tr>
                                        <tr>
                                            <td>Safari Price</td>
                                            <td><input text="text" class="form-control" name="sfri_price" id="safari_price" <%if (safari_price != null) {%> value="<%= safari_price%>"<%} %> maxlength="4" required=""> </td>
                                        </tr>
                                        <tr>
                                            <td>Photua Price</td>
                                            <td><input text="text" class="form-control"  name="pht_price" id="photua_price" <%if (photua_price != null) {%>value="<%= photua_price%>"<%} %> maxlength="4" required=""> </td>
                                        </tr>
                                        <tr>
                                            <td>Mojib Cort Price</td>
                                            <td><input text="text" class="form-control"  name="mjc_price" id="mjc_price" <%if (mojib_cort_price != null) {%>value="<%= mojib_cort_price%>"<%} %> maxlength="4" required=""> </td>
                                        </tr>
                                        <tr>
                                            <td>Kable Price</td>
                                            <td><input text="text" class="form-control"  name="kbl_price" id="kbl_price" <%if (kable_price != null) {%>value="<%= kable_price%>"<%} %> maxlength="4" required=""> </td>
                                        </tr>
                                        <tr>
                                            <td>Koti Price</td>
                                            <td><input text="text" class="form-control"  name="kt_price" id="kt_price" <%if (koti_price != null) {%>value="<%= koti_price%>"<%} %> maxlength="4" required=""> </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <%
                                                    if (shirt_price != null) {
                                                %>
                                                <input type="submit" value="Update"/>
                                                <%
                                                } else {
                                                %>
                                                <input type="submit" value="Submit"/>
                                                <%
                                                    }
                                                %>
                                            </td>
                                        </tr>
                                        <%
                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            }
                                        %>
                                    </table>
                                </form>
                            </div>                          
                        </div>                                               
                    </div>                                                    
                </div>
            </div>
        </div>
        <script>
            function price_validation() {
                var shirt_price = $("#shirt_price").val();
                var pant_price = $("#pant_price").val();
                var blazer_price = $("#blazer_price").val();
                var payjama_price = $("#payjama_price").val();
                var panjabi_price = $("#panjabi_price").val();
                var safari_price = $("#safari_price").val();
                var photua_price = $("#photua_price").val();
                var mojibcort_price = $("#mjc_price").val();
                var kbl_price = $("#kbl_price").val();
                var kt_price = $("#kt_price").val();

                if (isNaN(shirt_price) || isNaN(pant_price) || isNaN(blazer_price) || isNaN(payjama_price) || isNaN(panjabi_price) || isNaN(safari_price) || isNaN(photua_price)||isNaN(mojibcort_price)||isNaN(kbl_price)||isNaN(kt_price)) {
                    alert("Only Digit allowed");
                    //window.location.reload();
                    return false;
                }
            }
            $(function () {
                $(".product_cost").fadeIn(1500).delay(3000).fadeOut(1000);
            });
        </script>
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   
                <script src="assets/js/bootstrap.min.js"></script>    
                <script src="assets/js/jquery.metisMenu.js"></script>     
                <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
                <script src="assets/js/morris/morris.js"></script>   
                <script src="assets/js/custom.js"></script>    -->
    </body>
</html>
