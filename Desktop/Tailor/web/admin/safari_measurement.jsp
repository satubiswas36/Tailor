
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
<%--<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html lang="bn">
    <jsp:include page="../menu/header.jsp" flush="true"/>
    <body>
        <!---------------------------------------- --- for bangla font ---------------------------------------------->
        <div align="left" id='language'>
            <script type="text/javascript"> google.load("elements", "1", {packages: "transliteration"});
                function onLoad() {
                    var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                    var control = new google.elements.transliteration.TransliterationControl(options);
                    var ids = ["transl1", "output"];
                    control.makeTransliteratable(ids);
                    control.showControl('translControl');
                }
                google.setOnLoadCallback(onLoad);</script>
        </div>
        <style>
            .text{
                font-family:solaimanLipi,arial;
                font-size:36px;
                line-height:15px;
            }
            #contactus input[type="text"],textarea
            {
                color : #000;
                border : 1px solid #990000;
                font-size:36px;
                background-color : #FBFBCA;
            }

            #contactus input:focus,textarea:focus
            {
                color : #000;
                border : 1px solid #990000;
                font-size:36px;
                background-color : #FEF7F8;
                -webkit-box-shadow:  0 0 7px #990000;
                -moz-box-shadow:  0 0 5px #990000;
                box-shadow:  0 0 5px #990000;
            }
        </style>
        <!----------------- for bangla font end ----------------------------------------------------------------------------->
        <div id="wrapper">

            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp" flush="true"/>
            <!-- /. NAV SIDE  -->


            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Shirt Measurements
                                <%
                                    int val = 0;
                                    String order_id_shirt = request.getParameter("order_id_shirt");
                                    if (session.getAttribute("ord_id") != null) {
                                        val = (Integer) session.getAttribute("ord_id");
                                    }

                                    if (order_id_shirt != "" || order_id_shirt != null) {
                                        try {
                                            val = Integer.parseInt(order_id_shirt);
                                            out.println(order_id_shirt);
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    }

                                %>

                            </div>
                            <div class="panel-body">

                                <form action="../Photua_measurment" method="post">
                                    <%                                        String sql_pht = "select * from ser_photua where order_id  = '" + val + "' ";
                                        PreparedStatement pst_pht = DbConnection.getConn(sql_pht);
                                        ResultSet rs_pht = pst_pht.executeQuery();
                                        while (rs_pht.next()) {
                                            String order_id = rs_pht.getString(5);
                                            String pht_long = rs_pht.getString(6);
                                            String pht_body = rs_pht.getString(7);
                                            String pht_pht_body_loose = rs_pht.getString(8);
                                            String pht_bally = rs_pht.getString(9);
                                            String pht_hip = rs_pht.getString(10);
                                            String pht_shoulder = rs_pht.getString(11);
                                            String pht_neck = rs_pht.getString(12);
                                            String pht_hand_long = rs_pht.getString(13);
                                            String pht_hand_moja = rs_pht.getString(14);
                                            String pht_hand_qunu = rs_pht.getString(15);
                                            String pht_hand_cuff = rs_pht.getString(16);
                                            String pht_types = rs_pht.getString(17);
                                            String pht_plet = rs_pht.getString(18);
                                            String pht_collar = rs_pht.getString(19);
                                            String pht_collar_size = rs_pht.getString(20);
                                            String pht_cuff_size = rs_pht.getString(21);
                                            String pht_pocket = rs_pht.getString(22);
                                            String pht_pocket_inner = rs_pht.getString(23);
                                            String qty = rs_pht.getString(24);
                                            String pht_catelog_no = rs_pht.getString(26);
                                            String pht_others = rs_pht.getString(27);
                                    %>
                                    <div class="row">                            
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px">লম্বা  </label>
                                            <input type="text" class="form-control" name="pht_long" id="long" <% if (pht_long != null) {%> value="<%= pht_long%>"<%} %>  style="margin-bottom: 8 px;" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">বডি</label>
                                            <input type="text" class="form-control" name="pht_body" id="body" <input type="text" class="form-control"  <% if (pht_body != null) {%> value="<%= pht_body%>"<%} %>  style="margin-bottom: 8 px;" required=""/>

                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">বডি লুজ</label>
                                            <input type="text" class="form-control" name="pht_body_loose" id="body_loose" <% if (pht_pht_body_loose != null) {%> value="<%= pht_body%>"<%} %>   style="margin-bottom: 8px;" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">হিপ</label>
                                            <input type="text" class="form-control" name="pht_hip" id="hip" <% if (pht_hip != null) {%> value="<%= pht_hip%>"<%} %>  style="margin-bottom: 8px;" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">কাধ</label>
                                            <input type="text" class="form-control" name="pht_shoulder" id="shoulder"<% if (pht_shoulder != null) {%> value="<%= pht_shoulder%>"<%} %>  style="margin-bottom: 8px;" required=""/>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">গলা</label>
                                            <input type="text" class="form-control" name="pht_neck" <% if (pht_neck != null) {%> value="<%= pht_neck%>"<%} %>  style="margin-bottom: 8px;" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">পেট </label>
                                            <input type="text" class="form-control" name="pht_bally" id="pet" <% if (pht_bally != null) {%> value="<%= pht_bally%>"<%} %>  style="margin-bottom: 8px;" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">হাতা কাপ</label>
                                            <input type="text" class="form-control" name="pht_hand_cuff" id="hand_cuff" <% if (pht_hand_cuff != null) {%> value="<%= pht_hand_cuff%>"<%} %>  style="margin-bottom: 8px;"/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">হাতা কুনু</label>
                                            <input type="text" class="form-control" name="pht_hand_kuni" id="hand_konu" <% if (pht_hand_qunu != null) {%> value="<%= pht_hand_qunu%>"<%} %>  style="margin-bottom: 8px;"  required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">হাতা মোজা</label>
                                            <input type="text" class="form-control" name="pht_hand_moja" id="hand_moja" <% if (pht_hand_moja != null) {%> value="<%= pht_hand_moja%>"<%} %>  style="margin-bottom: 8px;" required=""/>
                                        </div>
                                    </div> 
                                    <div class="row">                            
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">হাতা লম্বা  </label>
                                            <input type="text" class="form-control" name="pht_hand_long" id="hand_long"  <% if (pht_hand_long != null) {%> value="<%= pht_hand_long%>"<%}%>  style="margin-bottom: 8px;" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style=" margin: 0px"> ধরন</label>
                                            <select name="pht_type" id="srt_type"  style="width: 100%; height: 30px; text-align: center">
                                                <option></option>
                                                <option value="1" style="text-align: center">চাইনিজ</option>
                                                <option value="2" style="text-align: center">হাওয়াই</option>
                                                <option value="3" style="text-align: center">হাফ</option>

                                            </select>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="padding: 0px; margin: 0px">প্লেট</label>
                                            <select name="pht_plet" class="plet" id="srt_plet" style="width: 100%; height: 30px">
                                                <option></option>
                                                <option value="1">বক্স প্লেট</option>
                                                <option value="2">সেলাই প্লেট</option>
                                                <option value="3">ইনার প্লেট</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px">কলার</label>
                                            <select name="pht_collar" id="srt_collar" style="width: 100%; height: 30px;">
                                                <option></option>
                                                <option value="1">এরো</option>
                                                <option value="2">টাই</option>
                                                <option value="3">বেন</option>
                                                <option value="4">পাঞ্জাবি</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">কলারের মাপ</label>
                                            <select name="pht_collar_size" style="width: 100%; height: 30px;" required="">
                                                <option></option>
                                                <option value="1.5">1.50</option>
                                                <option value="1.75">1.75</option>
                                                <option value="2">2.00</option>
                                                <option value="2.25">2.25</option>
                                                <option value="2.5">2.50</option>
                                                <option value="2.75">2.75</option>
                                                <option value="3">3.00</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">  
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">কাফ সাইজ</label>
                                            <select name="pht_cuff_size" style="width: 100%; height: 30px; text-align: center" required="">
                                                <option></option>
                                                <option value="1.50">1.50</option>
                                                <option value="1.75">1.75</option>
                                                <option value="2">2.00</option>
                                                <option value="2.25">2.25</option>
                                                <option value="2.5">2.50</option>
                                                <option value="2.75">2.75</option>
                                                <option value="3">3.00</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px">পকেট</label>
                                            <select name="pht_pocket" class="pocketdmo" style="width: 100%; height: 30px">
                                                <option></option>
                                                <option value="0">পকেট হবে না</option>
                                                <option value="1">1 টা পকেট</option>
                                                <option value="2">2 টা পকেট</option>
                                                <option value="3">3 টা পকেট</option>
                                                <option value="4">4 টা পকেট</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px">ভিতর পকেট &nbsp;</label>
                                            <select name="pht_pocket_inner" class="innerpocket" style="width: 100%; height: 30px">
                                                <option></option>
                                                <option value="1">পকেট হবে</option>
                                                <option value="0">পকেট হবে না</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">জামার সংখ্যা  </label>
                                            <input type="text" class="form-control" name="pht_number" id="srt_number" value="<%= qty%>" style="margin-bottom: 8px;" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">কেটালগ নং</label>
                                            <input type="text" class="form-control" name="pht_catelog_no" id="srt_catelog_no"  <% if (pht_catelog_no != null) {%> value="<%= pht_catelog_no%>"<%}%>  style="margin-bottom: 8px;" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="" class="control-label" style="margin: 0px;">অনান্য   </label>
                                            <input type='textbox' id="transl1" class="text" style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                            <textarea name="pht_other" id="output" class="text"  style="margin : 5px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"></textarea>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">order no</label>
                                            <input type="text" class="form-control" name="order_no" id="order_no" value="<%= val%>" style="margin-bottom: 8px;"readonly="" />
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                    <div class="row">                            
                                        <div class="col-sm-5">
                                        </div>
                                        <div class="col-sm-5" style="margin-top: 10px">
                                            <input type="submit" class="btn btn-primary" id="btn_submit" value="Submit" />
                                            <input type="reset" class="btn btn-danger" value="Cancel" />
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <p class="error"></p>
                    </div>                                                    <!-- /. PAGE INNER  -->
                </div>                                                    <!-- /. PAGE WRAPPER  -->
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
