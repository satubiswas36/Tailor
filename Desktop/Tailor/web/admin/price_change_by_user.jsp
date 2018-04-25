<%
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
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html lang="bn">
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp" flush="true"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">                    
                    <div class="panel panel-default">
                        <div class="panel-heading" style="height: 50px;">
                            <span class="price_udpdate" style="margin-left: 34%; color: green; font-size: 18px; display: none">
                                <%
                                    if (session.getAttribute("price_updated") != null) {
                                        if (session.getAttribute("price_updated").equals("updated")) {
                                %>
                                <%="successfully updated"%>
                                <%
                                    }
                                    if (session.getAttribute("price_updated").equals("inserted")) {
                                %>
                                <%="successfully inserted"%>
                                <%
                                        }

                                    }
                                    session.removeAttribute("price_updated");
                                %>
                            </span>
                        </div>
                        <div class="panel-body">
                            <form action="price_list_update.jsp" onsubmit="return price_validation()">
                                <table id="" class="table table-bordered table-hover table-responsive" style="width: 50%;">
                                    <%
                                        String shirt_price = null;
                                        String pant_price = null;
                                        String blazer_price = null;
                                        String photua_price = null;
                                        String panjabi_price = null;
                                        String payjama_price = null;
                                        String safari_price = null;
                                        String mojibcort_price = null;
                                        String kable_price = null;
                                        String koti_price = null; 
                                        String bran_id = (String) session.getAttribute("user_bran_id");
                                        try {
                                            String sql = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                            session.setAttribute("satu", "1");
                                            PreparedStatement pst = DbConnection.getConn(sql);
                                            ResultSet rs = pst.executeQuery();
                                            while (rs.next()) {
                                                shirt_price = rs.getString("prlist_shirt");
                                                pant_price = rs.getString("prlist_pant");
                                                blazer_price = rs.getString("prlist_blazer");
                                                panjabi_price = rs.getString("prlist_panjabi");
                                                payjama_price = rs.getString("prlist_payjama");
                                                safari_price = rs.getString("prlist_safari");
                                                photua_price = rs.getString("prlist_photua");
                                                mojibcort_price = rs.getString("prlist_mojib_cort");
                                                kable_price = rs.getString("prlist_kable");
                                                koti_price = rs.getString("prlist_koti");
                                            }
                                    %>
                                    <tr>
                                        <td>Shirt Price</td>
                                        <td style="width: 50%;"><input text="text" class="form-control" id="shirt_price" <%if (shirt_price != null) {%> value="<%= shirt_price%>"<%} %> name="s_price" maxlength="4"></td>
                                    </tr>
                                    <tr>
                                        <td>Pant Price</td>
                                        <td><input text="text" class="form-control"  name="pnt_price" id="pant_price"  <%if (pant_price != null) {%>value="<%= pant_price%>"<%} %> maxlength="4" > </td>
                                    </tr>
                                    <tr>
                                        <td>Blazer Price</td>
                                        <td><input text="text" class="form-control" name="blz_price" id="blazer_price" <%if (blazer_price != null) {%>value="<%= blazer_price%>"<%} %> maxlength="4"> </td>
                                    </tr>
                                    <tr>
                                        <td>Panjabi Price</td>
                                        <td><input text="text" class="form-control" name="pnjbi_price" id="panjabi_price" <%if (panjabi_price != null) {%>value="<%= panjabi_price%>"<%} %> maxlength="4"> </td>
                                    </tr>
                                    <tr>
                                        <td>Payjama Price</td>
                                        <td><input text="text" class="form-control" name="pjama_price" id="payjama_price" <%if (payjama_price != null) {%>value="<%= payjama_price%>"<%} %> maxlength="4"> </td>
                                    </tr>
                                    <tr>
                                        <td>Safari Price</td>
                                        <td><input text="text" class="form-control" name="sfri_price" id="safari_price" <%if (safari_price != null) {%> value="<%= safari_price%>"<%} %> maxlength="4" > </td>
                                    </tr>
                                    <tr>
                                        <td>Photua Price</td>
                                        <td><input text="text" class="form-control"  name="pht_price" id="photua_price" <%if (photua_price != null) {%>value="<%= photua_price%>"<%} %> maxlength="4" > </td>
                                    </tr>
                                    <tr>
                                        <td>Mojib Cort Price</td>
                                        <td><input text="text" class="form-control"  name="mjc_price" id="mojib_cort_price" <%if (mojibcort_price != null) {%>value="<%= mojibcort_price%>"<%} %> maxlength="4"> </td>
                                    </tr>
                                    <tr>
                                        <td>Kable Price</td>
                                        <td><input text="text" class="form-control"  name="kbl_price" id="kable_price" <%if (kable_price != null) {%>value="<%= kable_price%>"<%} %> maxlength="4" > </td>
                                    </tr>
                                    <tr>
                                        <td>Koti Price</td>
                                        <td><input text="text" class="form-control"  name="kt_price" id="koti_price" <%if (koti_price != null) {%>value="<%= koti_price%>"<%} %> maxlength="4" > </td>
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
        <script>
            function price_validation() {
                var shirt_price = $("#shirt_price").val();
                var pant_price = $("#pant_price").val();
                var blazer_price = $("#blazer_price").val();
                var payjama_price = $("#payjama_price").val();
                var panjabi_price = $("#panjabi_price").val();
                var safari_price = $("#safari_price").val();
                var photua_price = $("#photua_price").val();
                var mojibcort_price = $("#mojib_cort_price").val();
                var kable_price = $("#kable_price").val();
                var koti_price = $("#koti_price").val();

                if (isNaN(shirt_price) || isNaN(pant_price) || isNaN(blazer_price) || isNaN(payjama_price) || isNaN(panjabi_price) || isNaN(safari_price) || isNaN(photua_price)||isNaN(mojibcort_price)||isNaN(kable_price)||isNaN(koti_price)) {
                    alert("Only Digit allowed");
                   // window.location.reload();
                    return false;
                }
            }
            $(function () {
                $(".price_udpdate").fadeIn(1500).delay(3000).fadeOut(1000);
            });
        </script>
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
