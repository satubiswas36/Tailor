
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URL"%>
<%
    String logger = (String) session.getAttribute("logger");
%>

<%    try {
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

<%
    boolean is_shirt = false;
    boolean is_pant = false;
    boolean is_blazer = false;
    boolean is_panjabi = false;
    boolean is_payjama = false;
    boolean is_safari = false;
    boolean is_photua = false;
    boolean is_mojib_cort = false;
    boolean is_kable = false;
    boolean is_koti = false;

    String shirt_long = "thisisshirt";
    String pant_long = "thisispant";
    String blazer_long = "thisisblazer";
    String panjabi_long = "thisispanjabi";
    String payjama_long = "thisispayjama";
    String safari_long = "thisissafari";
    String photua_long = "thisisphotua";
    String mojib_cort_long = "thisisphotua";
    String kable_long = "thisisphotua";
    String koti_long = "thisisphotua";
    String dilevary_date = null;
%>
<!-- select all product whice are available from temporary table -->


<!--delete all data from temporary table-->
<%    // response.sendRedirect("add_sell_order.jsp");

%>
<%    int val = 0;
    String order_id = null;
    String customer_id_from_ad_order = null;
    String customer_mobile_from_customer = null;
    String bran_name = null;
    String bran_mobile = null;

    if (session.getAttribute("ord_id") != null || session.getAttribute("ord_id") != "") {
        try {
            val = (Integer) session.getAttribute("ord_id");
        } catch (Exception e) {
            out.println(e.toString());
        }
    }
    session.setAttribute("order_id", String.valueOf(val));
    try {
        try {
            // order er modha shirt ace kina ta check korea
            String sql_pro_all = "select * from ser_shirt where bran_id= '"+session.getAttribute("user_bran_id")+"' and order_id = '" + val + "' ";
            PreparedStatement pst_pro_all = DbConnection.getConn(sql_pro_all);
            ResultSet rs_pro_all = pst_pro_all.executeQuery();
            if (rs_pro_all.next()) {
                shirt_long = rs_pro_all.getString(6);
                is_shirt = true;
            }
        } catch (Exception e) {
            out.println(e.toString());
        }

        try {
            // order er modha pant ace kina tai check
            String sql_pro_all = "select * from ser_pant where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + val + "' ";
            PreparedStatement pst_pro_all = DbConnection.getConn(sql_pro_all);
            ResultSet rs_pro_all = pst_pro_all.executeQuery();
            if (rs_pro_all.next()) {
                pant_long = rs_pro_all.getString(6);
                is_pant = true;
            }
        } catch (Exception e) {
            out.println(e.toString());
        }

        try {
            // blazer er modha ai order id ta ace kina tai check 
            String sql_pro_all = "select * from ser_blazer where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + val + "' ";
            PreparedStatement pst_pro_all = DbConnection.getConn(sql_pro_all);
            ResultSet rs_pro_all = pst_pro_all.executeQuery();
            if (rs_pro_all.next()) {
                blazer_long = rs_pro_all.getString(6);
                is_blazer = true;
            }
        } catch (Exception e) {
            out.println(e.toString());
        }

        try {
            // photua  er modha ai order id ta ace kina tai check 
            String sql_pro_all = "select * from ser_photua where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + val + "' ";
            PreparedStatement pst_pro_all = DbConnection.getConn(sql_pro_all);
            ResultSet rs_pro_all = pst_pro_all.executeQuery();
            if (rs_pro_all.next()) {
                photua_long = rs_pro_all.getString(6);
                is_photua = true;
            }
        } catch (Exception e) {
            out.println(e.toString());
        }

        try {
            // panjabi er modha ai order id ta ace kina tai check 
            String sql_pro_all = "select * from ser_panjabi where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + val + "' ";
            PreparedStatement pst_pro_all = DbConnection.getConn(sql_pro_all);
            ResultSet rs_pro_all = pst_pro_all.executeQuery();
            if (rs_pro_all.next()) {
                panjabi_long = rs_pro_all.getString("pnjb_long");
                is_panjabi = true;
            }
        } catch (Exception e) {
            out.println(e.toString());
        }

        try {
            // payjama er modha ai order id ta ace kina tai check 
            String sql_pro_all = "select * from ser_payjama where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + val + "' ";
            PreparedStatement pst_pro_all = DbConnection.getConn(sql_pro_all);
            ResultSet rs_pro_all = pst_pro_all.executeQuery();
            if (rs_pro_all.next()) {
                payjama_long = rs_pro_all.getString("pjma_long");
                is_payjama = true;
            }
        } catch (Exception e) {
            out.println(e.toString());
        }

        try {
            // safari er modha ai order id ta ace kina tai check 
            String sql_pro_all = "select * from ser_safari where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + val + "' ";
            PreparedStatement pst_pro_all = DbConnection.getConn(sql_pro_all);
            ResultSet rs_pro_all = pst_pro_all.executeQuery();
            if (rs_pro_all.next()) {
                safari_long = rs_pro_all.getString("sfr_long");
                is_safari = true;
            }
        } catch (Exception e) {
            out.println(e.toString());
        }

        try {
            // mojib  cort er modha ai order id ta ace kina tai check 
            String sql_pro_all = "select * from ser_mojib_cort where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + val + "' ";
            PreparedStatement pst_pro_all = DbConnection.getConn(sql_pro_all);
            ResultSet rs_pro_all = pst_pro_all.executeQuery();
            if (rs_pro_all.next()) {
                mojib_cort_long = rs_pro_all.getString("mjc_long");
                is_mojib_cort = true;
            }
        } catch (Exception e) {
            out.println(e.toString());
        }

        try {
            // kable er modha ai order id ta ace kina tai check 
            String sql_pro_all = "select * from ser_kable where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + val + "' ";
            PreparedStatement pst_pro_all = DbConnection.getConn(sql_pro_all);
            ResultSet rs_pro_all = pst_pro_all.executeQuery();
            if (rs_pro_all.next()) {
                kable_long = rs_pro_all.getString("kbl_long");
                is_kable = true;
            }
        } catch (Exception e) {
            out.println(e.toString());
        }

        try {
            // Koti er modha ai order id ta ace kina tai check 
            String sql_pro_all = "select * from ser_koti where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + val + "' ";
            PreparedStatement pst_pro_all = DbConnection.getConn(sql_pro_all);
            ResultSet rs_pro_all = pst_pro_all.executeQuery();
            if (rs_pro_all.next()) {
                koti_long = rs_pro_all.getString("kt_long");
                is_koti = true;
            }
        } catch (Exception e) {
            out.println(e.toString());
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>


<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp" flush="true" />

    <body>
        <div align="left" id='language'>
            <!---------------------  for shirt ------------------------------------>
            <script type="text/javascript">
                google.load("elements", "1", {packages: "transliteration"});
                function onLoad() {
                    var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                    var control = new google.elements.transliteration.TransliterationControl(options);
                    var ids = ["transl1", "output"];
                    control.makeTransliteratable(ids);
                    control.showControl('translControl');
                }
                google.setOnLoadCallback(onLoad);
            </script>
            <!---------------------  //for shirt ------------------------------------>
            <!---------------------  for pant ------------------------------------>
            <script type="text/javascript">
                google.load("elements", "1", {packages: "transliteration"});
                function onLoad() {
                    var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                    var control = new google.elements.transliteration.TransliterationControl(options);
                    var idspnt = ["pant", "output_pant"];
                    control.makeTransliteratable(idspnt);
                    control.showControl('translControl');
                }
                google.setOnLoadCallback(onLoad);
            </script>
            <!---------------------  //for pant ------------------------------------>
            <!---------------------  for blazer ------------------------------------>
            <script type="text/javascript">
                google.load("elements", "1", {packages: "transliteration"});
                function onLoad() {
                    var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                    var control = new google.elements.transliteration.TransliterationControl(options);
                    var ids = ["blazer", "output_blazer"];
                    control.makeTransliteratable(ids);
                    control.showControl('translControl');
                }
                google.setOnLoadCallback(onLoad);
            </script>
            <!---------------------  //for blazer ------------------------------------>
            <!---------------------  for photua ------------------------------------>
            <script type="text/javascript">
                google.load("elements", "1", {packages: "transliteration"});
                function onLoad() {
                    var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                    var control = new google.elements.transliteration.TransliterationControl(options);
                    var ids = ["photua", "output_photua"];
                    control.makeTransliteratable(ids);
                    control.showControl('translControl');
                }
                google.setOnLoadCallback(onLoad);
            </script>
            <!---------------------  //for photua ------------------------------------>
            <!---------------------  for panjabi ------------------------------------>
            <script type="text/javascript">
                google.load("elements", "1", {packages: "transliteration"});
                function onLoad() {
                    var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                    var control = new google.elements.transliteration.TransliterationControl(options);
                    var ids = ["panjabi", "output_panjabi"];
                    control.makeTransliteratable(ids);
                    control.showControl('translControl');
                }
                google.setOnLoadCallback(onLoad);
            </script>
            <!---------------------  //for photua ------------------------------------>
            <!---------------------  for payjama ------------------------------------>
            <script type="text/javascript">
                google.load("elements", "1", {packages: "transliteration"});
                function onLoad() {
                    var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                    var control = new google.elements.transliteration.TransliterationControl(options);
                    var ids = ["payjama", "output_payjama"];
                    control.makeTransliteratable(ids);
                    control.showControl('translControl');
                }
                google.setOnLoadCallback(onLoad);
            </script>
            <!---------------------  //for payjama ------------------------------------>
            <!---------------------  for safari ------------------------------------>
            <script type="text/javascript">
                google.load("elements", "1", {packages: "transliteration"});
                function onLoad() {
                    var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                    var control = new google.elements.transliteration.TransliterationControl(options);
                    var ids = ["safari", "output_safari"];
                    control.makeTransliteratable(ids);
                    control.showControl('translControl');
                }
                google.setOnLoadCallback(onLoad);
            </script>
            <!---------------------  //for safari ------------------------------------>
            <!---------------------  for mojib_cort ------------------------------------>
            <script type="text/javascript">
                google.load("elements", "1", {packages: "transliteration"});
                function onLoad() {
                    var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                    var control = new google.elements.transliteration.TransliterationControl(options);
                    var ids = ["mojib_cort", "output_mojib_cort"];
                    control.makeTransliteratable(ids);
                    control.showControl('translControl');
                }
                google.setOnLoadCallback(onLoad);
            </script>
            <!---------------------  //for mojib_cort ------------------------------------>
            <!---------------------  for kable ------------------------------------>
            <script type="text/javascript">
                google.load("elements", "1", {packages: "transliteration"});
                function onLoad() {
                    var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                    var control = new google.elements.transliteration.TransliterationControl(options);
                    var ids = ["kable", "output_kable"];
                    control.makeTransliteratable(ids);
                    control.showControl('translControl');
                }
                google.setOnLoadCallback(onLoad);
            </script>
            <!---------------------  //for kable ------------------------------------>
            <!---------------------  for koti ------------------------------------>
            <script type="text/javascript">
                google.load("elements", "1", {packages: "transliteration"});
                function onLoad() {
                    var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                    var control = new google.elements.transliteration.TransliterationControl(options);
                    var ids = ["koti", "output_koti"];
                    control.makeTransliteratable(ids);
                    control.showControl('translControl');
                }
                google.setOnLoadCallback(onLoad);
            </script>
            <!---------------------  //for koti ------------------------------------>
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
            .modal.fade .modal-dialog {
                -webkit-transform: scale(0.1);
                -moz-transform: scale(0.1);
                -ms-transform: scale(0.1);
                transform: scale(0.1);
                top: 300px;
                opacity: 0;
                -webkit-transition: all 0.3s;
                -moz-transition: all 0.3s;
                transition: all 0.3s;
            }

            .modal.fade.in .modal-dialog {
                -webkit-transform: scale(1);
                -moz-transform: scale(1);
                -ms-transform: scale(1);
                transform: scale(1);
                -webkit-transform: translate3d(0, -300px, 0);
                transform: translate3d(0, -300px, 0);
                opacity: 1;

            }
        </style>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Logger  <% out.println(session.getAttribute("logger"));%>
                            </div>                             
                            <div class="panel-body">
                                <h3>All Measurement of the order is : <%= val%></h3>
                                <%
                                    if (is_shirt) {
                                %>
                                <div class="container">
                                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#modal-1"> শার্ট   পরিমাপ </button><% if (session.getAttribute("srt_msg") != null) {%> <%= session.getAttribute("srt_msg")%><%} %>
                                    <div class="modal fade" id="modal-1">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h3 class="modal-title" >শার্ট  পরিমাপ</h3>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="../Shirt_Measurements" accept-charset="ISO-8859-1" method="post" onsubmit="return shirt_validation()">
                                                        <%
                                                            try {
                                                                // take customer id form ad_order flowing last order_id
                                                                String sql_customer_id = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + val + "' ";
                                                                PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                                                                ResultSet rs_customer_id = pst_customer_id.executeQuery();
                                                                if (rs_customer_id.next()) {
                                                                    customer_id_from_ad_order = rs_customer_id.getString("ord_cutomer_id");
                                                                } else {
                                                                    out.println("Customer id not found");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            // take customer mobile from customer by matching customer id                                                                
                                                            try {
                                                                String sql_customer_mobile = "select * from customer where cus_customer_id = '" + customer_id_from_ad_order + "' ";
                                                                PreparedStatement pst_customer_mobile = DbConnection.getConn(sql_customer_mobile);
                                                                ResultSet rs_customer_mobile = pst_customer_mobile.executeQuery();
                                                                if (rs_customer_mobile.next()) {
                                                                    customer_mobile_from_customer = rs_customer_mobile.getString("cus_mobile");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            // out.println(customer_mobile_from_customer);
                                                            try {
                                                                String sql_shirt = "select * from msr_shirt where customer_mobile = '" + customer_mobile_from_customer + "'and bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                                PreparedStatement pst_shirt = DbConnection.getConn(sql_shirt);
                                                                ResultSet rs = pst_shirt.executeQuery();
                                                                while (rs.next()) {
                                                                    String srt_long_d = rs.getString("srt_long");
                                                                    String srt_body_d = rs.getString("srt_body");
                                                                    String srt_body_lose_d = rs.getString("srt_body_loose");
                                                                    String srt_bally_loose_d = rs.getString("srt_bally_loose");
                                                                    String srt_hip_loose_d = rs.getString("srt_hip_loose");
                                                                    String srt_hip_d = rs.getString("srt_hip");
                                                                    String srt_shoulder_d = rs.getString("srt_shoulder");
                                                                    String srt_neck_d = rs.getString("srt_neck");
                                                                    String srt_bally_d = rs.getString("srt_bally");
                                                                    String srt_hand_cuff_d = rs.getString("srt_hand_cuff");
                                                                    String srt_hnd_qunu_d = rs.getString("srt_hand_qunu");
                                                                    String srt_hnd_moja_d = rs.getString("srt_hand_moja");
                                                                    String srt_hnd_long_d = rs.getString("srt_hand_long");
                                                                    String srt_types = rs.getString("srt_types");
                                                                    String srt_plet = rs.getString("srt_plet");
                                                                    String srt_collar = rs.getString("srt_collar");
                                                                    String srt_collar_size = rs.getString("srt_collar_size");
                                                                    String srt_cuff_size = rs.getString("srt_cuff_size");
                                                                    String srt_pocket = rs.getString("srt_pocket");
                                                                    String srt_pocket_inner = rs.getString("srt_pocket_inner");
                                                                    String srt_shirt_cate_num_d = rs.getString("srt_catelog_no");
                                                                    String srt_others = rs.getString("srt_others");
                                                        %>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">লম্বা  </label>
                                                                <input type="text" class="form-control" name="srt_long" id="srt_long" placeholder="14 1/8"  <% if (srt_long_d != null) {%> value="<%= srt_long_d%>" <%} %> style="margin-bottom: 8px;" maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">বডি</label>
                                                                <input type="text" class="form-control" name="srt_body" id="srt_body" placeholder=""  <% if (srt_body_d != null) {%> value="<%= srt_body_d%>" <%} %> style="margin-bottom: 8px;" maxlength="5"  required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">পেট </label>
                                                                <input type="text" class="form-control" name="srt_bally" id="srt_bally" placeholder="" <% if (srt_bally_d != null) {%> value="<%= srt_bally_d%>" <%} %> style="margin-bottom: 8px;" maxlength="5" required=""/>
                                                            </div>                                                            
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">হিপ</label>
                                                                <input type="text" class="form-control" name="srt_hip" id="srt_hip" placeholder=""  <% if (srt_hip_d != null) {%> value="<%= srt_hip_d%>" <%} %>  style="margin-bottom: 8px;"  maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">কাধ</label>
                                                                <input type="text" class="form-control" name="srt_shoulder" id="srt_shoulder" placeholder="" <% if (srt_shoulder_d != null) {%> value="<%= srt_shoulder_d%>" <%} %> style="margin-bottom: 8px;" maxlength="5"  required=""/>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">হাতা লম্বা  </label>
                                                                <input type="text" class="form-control" name="srt_hand_long" id="srt_hand_long" <% if (srt_hnd_long_d != null) {%> value="<%= srt_hnd_long_d%>" <%}%>  style="margin-bottom: 8px;"  maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">হাতা কাপ</label>
                                                                <input type="text" class="form-control" name="srt_hand_cuff" id="srt_hand_cuff" <% if (srt_hand_cuff_d != null) {%> value="<%= srt_hand_cuff_d%>" <%} %>  style="margin-bottom: 8px;    " maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">গলা</label>
                                                                <input type="text" class="form-control" name="srt_neck" id="srt_neck" <% if (srt_neck_d != null) {%> value="<%= srt_neck_d%>" <%} %> style="margin-bottom: 8px;" maxlength="5"  required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">হাতা মোজা</label>
                                                                <input type="text" class="form-control" name="srt_hand_moja" id="srt_hand_moja" <% if (srt_hnd_moja_d != null) {%> value="<%= srt_hnd_moja_d%>" <%} %>  style="margin-bottom: 8px;"  maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">হাতা কুনু</label>
                                                                <input type="text" class="form-control" name="srt_hand_kuni" id="srt_hand_kuni" <% if (srt_hnd_qunu_d != null) {%> value="<%= srt_hnd_qunu_d%>" <%} %> style="margin-bottom: 8px;"  maxlength="5"  required=""/>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">বডি লুজ</label>
                                                                <input type="text" class="form-control" name="srt_body_loose" id="srt_body_loose" <% if (srt_body_lose_d != null) {%> value="<%= srt_body_lose_d%>" <%} %>  style="margin-bottom: 8px;" maxlength="5"/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">পেট লুজ</label>
                                                                <input type="text" class="form-control" name="srt_bally_loose" id="srt_bally" placeholder="" <% if (srt_bally_loose_d != null) {%> value="<%= srt_bally_loose_d%>" <%} %> style="margin-bottom: 8px;" maxlength="5"/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">হিপ লুজ</label>
                                                                <input type="text" class="form-control" name="srt_hip_loose" id="srt_hip" placeholder=""  <% if (srt_hip_loose_d != null) {%> value="<%= srt_hip_loose_d%>" <%} %>  style="margin-bottom: 8px;"  maxlength="5"/>
                                                            </div>                                                                                                            
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style=" margin: 0px"> ধরন</label>
                                                                <select name="srt_type" id="srt_type"  style="width: 100%; height: 30px; text-align: center" required="">
                                                                    <%
                                                                        String types_srt = null;
                                                                        if (srt_types != null) {
                                                                            if (srt_types.equals("1")) {
                                                                                types_srt = "চাইনিজ";
                                                                            } else if (srt_types.equals("2")) {
                                                                                types_srt = "হাওয়াই";
                                                                            } else if (srt_types.equals("3")) {
                                                                                types_srt = "হাফ";
                                                                            }
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (srt_types != null) {
                                                                    %>
                                                                    <option value="<%= srt_types%>"><%= types_srt%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                   
                                                                    <option value="1" style="text-align: center">চাইনিজ</option>
                                                                    <option value="2" style="text-align: center">হাওয়াই</option>
                                                                    <option value="3" style="text-align: center">হাফ</option>

                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="padding: 0px; margin: 0px">প্লেট</label>
                                                                <select name="srt_plet" class="srt_plet" id="srt_plet" style="width: 100%; height: 30px" required="">
                                                                    <%
                                                                        String plet = null;
                                                                        if (srt_plet != null) {
                                                                            if (srt_plet.equals("1")) {
                                                                                plet = "বক্স প্লেট";
                                                                            } else if (srt_plet.equals("2")) {
                                                                                plet = "সেলাই প্লেট";
                                                                            } else if (srt_plet.equals("3")) {
                                                                                plet = "ইনার প্লেট";
                                                                            }
                                                                        }%>

                                                                    <%
                                                                        if (srt_plet != null) {
                                                                    %>
                                                                    <option value="<%= srt_plet%>"><%= plet%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1">বক্স প্লেট</option>
                                                                    <option value="2">সেলাই প্লেট</option>
                                                                    <option value="3">ইনার প্লেট</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row">        
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px">কলার</label>
                                                                <select name="srt_collar" id="srt_collar" style="width: 100%; height: 30px;" required="">
                                                                    <%
                                                                        String collar = null;
                                                                        if (srt_collar != null) {
                                                                            if (srt_collar.equals("1")) {
                                                                                collar = "এরো";
                                                                            } else if (srt_collar.equals("2")) {
                                                                                collar = "টাই";
                                                                            } else if (srt_collar.equals("3")) {
                                                                                collar = "বেন";
                                                                            } else if (srt_collar.equals("4")) {
                                                                                collar = "পাঞ্জাবি";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (srt_collar != null) {
                                                                    %>
                                                                    <option value="<%= srt_collar%>"><%= collar%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1">এরো</option>
                                                                    <option value="2">টাই</option>
                                                                    <option value="3">বেন</option>
                                                                    <option value="4">পাঞ্জাবি</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">কলারের মাপ</label>
                                                                <select name="srt_collar_size" id="srt_collar_size" style="width: 100%; height: 30px;" required="">
                                                                    <%
                                                                        String collar_size = null;
                                                                        if (srt_collar_size != null) {
                                                                            if (srt_collar_size.equals("1.5")) {
                                                                                collar_size = "1.5";
                                                                            } else if (srt_collar_size.equals("1.75")) {
                                                                                collar_size = "1.75";
                                                                            } else if (srt_collar_size.equals("2")) {
                                                                                collar_size = "2";
                                                                            } else if (srt_collar_size.equals("2.25")) {
                                                                                collar_size = "2.25";
                                                                            } else if (srt_collar_size.equals("2.5")) {
                                                                                collar_size = "2.5";
                                                                            } else if (srt_collar_size.equals("2.75")) {
                                                                                collar_size = "2.75";
                                                                            } else if (srt_collar_size.equals("3")) {
                                                                                collar_size = "3";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (srt_collar_size != null) {
                                                                    %>
                                                                    <option value="<%= srt_collar_size%>"><%= collar_size%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1.5">1.50</option>
                                                                    <option value="1.75">1.75</option>
                                                                    <option value="2">2.00</option>
                                                                    <option value="2.25">2.25</option>
                                                                    <option value="2.5">2.50</option>
                                                                    <option value="2.75">2.75</option>
                                                                    <option value="3">3.00</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">কাফ সাইজ</label>
                                                                <select name="srt_cuff_size" id="srt_cuff_size" style="width: 100%; height: 30px; text-align: center" required="">
                                                                    <%
                                                                        String cuff_size = null;
                                                                        if (srt_cuff_size != null) {
                                                                            if (srt_cuff_size.equals("1.50")) {
                                                                                cuff_size = "1.50";
                                                                            } else if (srt_cuff_size.equals("1.75")) {
                                                                                cuff_size = "1.75";
                                                                            } else if (srt_cuff_size.equals("2")) {
                                                                                cuff_size = "2.00";
                                                                            } else if (srt_cuff_size.equals("2.25")) {
                                                                                cuff_size = "2.25";
                                                                            } else if (srt_cuff_size.equals("2.5")) {
                                                                                cuff_size = "2.50";
                                                                            } else if (srt_cuff_size.equals("2.75")) {
                                                                                cuff_size = "2.75";
                                                                            } else if (srt_cuff_size.equals("3")) {
                                                                                cuff_size = "3.00";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (srt_cuff_size != null) {
                                                                    %>
                                                                    <option value="<%= srt_cuff_size%>"><%= cuff_size%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
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
                                                                <select name="pocket" class="pocketdmo" id="pocket" style="width: 100%; height: 30px" required="">
                                                                    <%
                                                                        String pocket = null;
                                                                        if (srt_pocket != null) {
                                                                            if (srt_pocket.equals("0")) {
                                                                                pocket = "পকেট হবে না";
                                                                            } else if (srt_pocket.equals("1")) {
                                                                                pocket = "1 টা পকেট";
                                                                            } else if (srt_pocket.equals("2")) {
                                                                                pocket = "2 টা পকেট";
                                                                            } else if (srt_pocket.equals("3")) {
                                                                                pocket = "3 টা পকেট";
                                                                            } else if (srt_pocket.equals("4")) {
                                                                                pocket = "4 টা পকেট";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (srt_pocket != null) {
                                                                    %>
                                                                    <option value="<%= srt_pocket%>"><%= pocket%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="0">পকেট হবে না</option>
                                                                    <option value="1">1 টা পকেট</option>
                                                                    <option value="2">2 টা পকেট</option>
                                                                    <option value="3">3 টা পকেট</option>
                                                                    <option value="4">4 টা পকেট</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px">ভিতর পকেট &nbsp;</label>
                                                                <select name="pocket_inner" id="pocket_inner" class="innerpocket" style="width: 100%; height: 30px; margin-bottom: 8px;" required="">
                                                                    <%
                                                                        String pocket_iner = null;
                                                                        if (srt_pocket_inner != null) {
                                                                            if (srt_pocket_inner.equals("0")) {
                                                                                pocket_iner = "পকেট হবে না";
                                                                            } else if (srt_pocket_inner.equals("1")) {
                                                                                pocket_iner = "পকেট হবে";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (srt_pocket_inner != null) {
                                                                    %>
                                                                    <option value="<%= srt_pocket_inner%>"><%= pocket_iner%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1">পকেট হবে</option>
                                                                    <option value="0">পকেট হবে না</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row">                                                            
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">order no</label>
                                                                <input type="text" class="form-control" name="order_no" id="order_no" value="<%= val%>" style="margin-bottom: 8px; text-align: center" readonly="" />
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">জামার সংখ্যা  </label>
                                                                <%
                                                                    String s_qty = null;
                                                                    try {
                                                                        String sql_s_qty = "select * from ser_shirt where order_id = '" + val + "' ";
                                                                        PreparedStatement pst_s_qty = DbConnection.getConn(sql_s_qty);
                                                                        ResultSet rs_s_qty = pst_s_qty.executeQuery();
                                                                        if (rs_s_qty.next()) {
                                                                            s_qty = rs_s_qty.getString("qty");
                                                                        }
                                                                    } catch (Exception e) {
                                                                        out.println(e.toString());
                                                                    }
                                                                %>
                                                                <input type="text" class="form-control" name="srt_number" id="srt_number" value="<%= s_qty%>" style="margin-bottom: 8px;"  maxlength="3" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">কেটালগ নং</label>
                                                                <input type="text" class="form-control" name="srt_catelog_no" id="srt_catelog_no" placeholder="" <% if (srt_shirt_cate_num_d != null) {%> value="<%= srt_shirt_cate_num_d%>" <%}%> style="margin-bottom: 8px;" />
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <label for="" class="control-label" style="margin: 0px;">অনান্য   </label>
                                                                <input type='textbox' id="transl1" class="text" style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                                                <textarea name="srt_other" id="output" class="text"  style="margin : 1px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px; padding-top: 5px; font-family: SolaimanLipi; background-color:#FFFFFF; resize: none;z-index: 1000"> <% if (srt_others != null) {%> <%= srt_others.trim()%><% }%></textarea>
                                                            </div>
                                                            <input type="text" name="customer_mobile" value="<%= customer_mobile_from_customer%>" style="display: none"/>
                                                        </div>                                                
                                                        <%
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                        %>
                                                        <div class="row">
                                                            <div class="col-sm-5">

                                                            </div>
                                                            <div class="col-sm-5" style="margin-top: 10px">
                                                                <input type="submit" class="btn btn-primary" id="btn_submit" value="Submit" />

                                                                <input type="reset" class="btn btn-danger" data-dismiss="modal" value="Cancel" />
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                    if (is_pant) {
                                %>
                                <div class="container" style="margin-top: 5px;">
                                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#modal-2">প্যান্ট পরিমাপ</button><% if (session.getAttribute("pnt_msg") != null) {%> <%= session.getAttribute("pnt_msg")%><%} %>
                                    <div class="modal fade" id="modal-2">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h3 class="modal-title" >প্যান্ট পরিমাপ </h3>
                                                </div>                        
                                                <div class="modal-body">
                                                    <form action="../Pant_Measurements" accept-charset="ISO-8859-1" onsubmit="return pant_validation();" method="post">
                                                        <%
                                                            try {
                                                                // take customer id form ad_order flowing last order_id
                                                                String sql_customer_id = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + val + "' ";
                                                                PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                                                                ResultSet rs_customer_id = pst_customer_id.executeQuery();
                                                                if (rs_customer_id.next()) {
                                                                    customer_id_from_ad_order = rs_customer_id.getString("ord_cutomer_id");
                                                                } else {
                                                                    out.println("Customer id not found");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            // take customer mobile from customer by matching customer id                                                                
                                                            try {
                                                                String sql_customer_mobile = "select * from customer where cus_bran_id = '"+session.getAttribute("user_bran_id")+"' and cus_customer_id = '" + customer_id_from_ad_order + "' ";
                                                                PreparedStatement pst_customer_mobile = DbConnection.getConn(sql_customer_mobile);
                                                                ResultSet rs_customer_mobile = pst_customer_mobile.executeQuery();
                                                                if (rs_customer_mobile.next()) {
                                                                    customer_mobile_from_customer = rs_customer_mobile.getString("cus_mobile");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }

                                                            try {
                                                                String sql_ = "select * from msr_pant where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '" + customer_mobile_from_customer + "' ";
                                                                PreparedStatement pst = DbConnection.getConn(sql_);
                                                                ResultSet rs = pst.executeQuery();
                                                                while (rs.next()) {
                                                                    //String pnt_order_id = rs.getString(5);
                                                                    String pnt_long = rs.getString("pnt_long");
                                                                    String pnt_komor = rs.getString("pnt_comor");
                                                                    String pnt_hip = rs.getString("pnt_hip");
                                                                    String pnt_muhuri = rs.getString("pnt_mohuri");
                                                                    String pnt_run = rs.getString("pnt_run");
                                                                    String pnt_high = rs.getString("pnt_high");
                                                                    String pnt_fly = rs.getString("pnt_fly");
                                                                    String pnt_kuci = rs.getString("pnt_kuci");
                                                                    String pnt_pocket_type = rs.getString("pnt_pocket_type");
                                                                    String pnt_pocket_backside = rs.getString("pnt_pocket_backside");
                                                                    String pnt_pocket_inner = rs.getString("pnt_pocket_inner");
                                                                    String pnt_mohuri_type = rs.getString("pnt_mohuri_type");
                                                                    String pnt_loop = rs.getString("pnt_loop");
                                                                    String pnt_loop_size = rs.getString("pnt_loop_size");
                                                                    String pnt_catelog_no = rs.getString("pnt_catelog_no");
                                                                    String pnt_others = rs.getString("pnt_others");
                                                                    // String pnt_qty = rs.getString("pnt_others");

                                                        %>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">লম্বা </label>
                                                                <input type="text" class="form-control" name="pnt_long" id="pant_long" <% if (pnt_long != null) {%> value="<%= pnt_long%>" <%} %>  placeholder="14 1/8''" style="margin-bottom: 10px" maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label"  style="margin-bottom: 0px">কোমর</label>
                                                                <input type="text" class="form-control" name="pant_comor" id="pant_comor" <% if (pnt_komor != null) {%> value="<%= pnt_komor%>" <%} %>  maxlength="5"  required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label"  style="margin-bottom: 0px">হিপ</label>
                                                                <input type="text" class="form-control" name="pnt_hip" id="pnt_hip"  <% if (pnt_hip != null) {%> value="<%= pnt_hip%>" <%} %> maxlength="5"  required="" />
                                                            </div>
                                                            <div class="col-sm-2" style="margin-bottom: 0px;">
                                                                <label for="" class="control-label"  style="margin-bottom: 0px">মুহুরি</label>
                                                                <input type="text" class="form-control" name="pnt_muhuri" id="pnt_muhuri" <% if (pnt_muhuri != null) {%> value="<%= pnt_muhuri%>" <%} %>  maxlength="5"  required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label"  style="margin-bottom: 0px">রান</label>
                                                                <input type="text" class="form-control" name="pnt_run" id="pnt_run" <% if (pnt_run != null) {%> value="<%= pnt_run%>" <%} %> maxlength="5"  required=""/>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label"  style="margin-bottom: 0px">হাই</label>
                                                                <input type="text" class="form-control" name="pnt_high" id="pnt_high" <% if (pnt_high != null) {%> value="<%= pnt_high%>" <%} %>  maxlength="5" required="" />
                                                            </div>                                                            
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label"  style="margin-bottom: 0px">ফ্লাই</label>
                                                                <input type="text" class="form-control" name="pnt_fly" id="pnt_fly" placeholder="" <% if (pnt_fly != null) {%> value="<%= pnt_fly%>" <%} %> style="margin-bottom: 10px" maxlength="5" required=""/>
                                                            </div>                                                           
                                                            <div class="col-sm-2" style="margin:0px">
                                                                <label for="" class="control-label" style="margin: 0px">পকেট</label>
                                                                <select name="pnt_pocket_type" style="width: 100%; height: 35px" required="">
                                                                    <%
                                                                        String pant_pocket = "";
                                                                        if (pnt_pocket_type != null) {
                                                                            if (pnt_pocket_type.equals("0")) {
                                                                                pant_pocket = "ক্র্স";
                                                                            }
                                                                            if (pnt_pocket_type.equals("1")) {
                                                                                pant_pocket = "সোজা";
                                                                            }
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (pnt_pocket_type != null) {
                                                                    %>
                                                                    <option value="<%= pnt_pocket_type%>"><%= pant_pocket%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="0">ক্র্স</option>
                                                                    <option value="1">সোজা</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2" style="margin:0px">
                                                                <label for="" class="control-label" style="margin: 0px">পকেট পিছ্নে</label>
                                                                <select name="pnt_pocket_back" style="width: 100%; height: 35px" required="">
                                                                    <%
                                                                        String pant_back_pock = "";
                                                                        if (pnt_pocket_backside != null) {
                                                                            if (pnt_pocket_backside.equals("1")) {
                                                                                pant_back_pock = "1 টা";
                                                                            }
                                                                            if (pnt_pocket_backside.equals("2")) {
                                                                                pant_back_pock = "2 টা";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pnt_pocket_backside != null) {
                                                                    %>
                                                                    <option value="<%= pnt_pocket_backside%>"><%= pant_back_pock%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1">1</option>
                                                                    <option value="2">2</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2" style="margin:0px">
                                                                <label for="" class="control-label" style="margin: 0px">ইনার পকেট</label>
                                                                <select name="pnt_pocket_inner" style="width: 100%; height: 35px" required="">
                                                                    <%
                                                                        String pant_inner_pock = "";
                                                                        if (pnt_pocket_inner != null) {
                                                                            if (pnt_pocket_inner.equals("1")) {
                                                                                pant_inner_pock = "হ্যা ";
                                                                            }
                                                                            if (pnt_pocket_inner.equals("0")) {
                                                                                pant_inner_pock = "না";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pnt_pocket_inner != null) {
                                                                    %>
                                                                    <option value="<%= pnt_pocket_inner%>"><%= pant_inner_pock%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1"> হ্যা  </option>
                                                                    <option value="0">না</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px">মুহুরি</label>                                                                                    
                                                                <select name="pnt_muhuri_type" style="width: 100%; height: 35px" required="">
                                                                    <%
                                                                        String pant_m_type = "";
                                                                        if (pnt_mohuri_type != null) {
                                                                            if (pnt_mohuri_type.equals("1")) {
                                                                                pant_m_type = "ফ্লাডিং";
                                                                            }
                                                                            if (pnt_mohuri_type.equals("2")) {
                                                                                pant_m_type = "নর্মাল";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pnt_mohuri_type != null) {
                                                                    %>
                                                                    <option value="<%= pnt_mohuri_type%>"><%= pant_m_type%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1">ফ্লাডিং</option>
                                                                    <option value="2">নর্মাল</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label"style="margin: 0px">লুপ</label>
                                                                <select name="pnt_loop" style="width: 100%; height: 35px" required="">
                                                                    <%
                                                                        String pant_lop = "";
                                                                        if (pnt_loop != null) {
                                                                            if (pnt_loop.equals("6")) {
                                                                                pant_lop = "6 টা";
                                                                            }
                                                                            if (pnt_loop.equals("7")) {
                                                                                pant_lop = "7 টা";
                                                                            }
                                                                            if (pnt_loop.equals("8")) {
                                                                                pant_lop = "8 টা";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pnt_loop != null) {
                                                                    %>
                                                                    <option value="<%= pnt_loop%>"><%= pant_lop%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="6">6 টা</option>
                                                                    <option value="7">7 টা</option>
                                                                    <option value="8">8 টা</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px">লুপ সাইড</label>
                                                                <select name="pnt_loop_side" style="width: 100%; height: 35px" required="">
                                                                    <%
                                                                        String pant_lop_size = "";
                                                                        if (pnt_loop_size != null) {
                                                                            if (pnt_loop_size.equals("0.25")) {
                                                                                pant_lop_size = "0.25";
                                                                            }
                                                                            if (pnt_loop_size.equals("0.50")) {
                                                                                pant_lop_size = "0.50";
                                                                            }
                                                                            if (pnt_loop_size.equals("0.75")) {
                                                                                pant_lop_size = "0.75";
                                                                            }
                                                                            if (pnt_loop_size.equals("1")) {
                                                                                pant_lop_size = "1.00";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pnt_loop_size != null) {
                                                                    %>
                                                                    <option value="<%= pnt_loop_size%>"><%= pant_lop_size%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="0.25">0.25</option>
                                                                    <option value="0.50">0.50</option>
                                                                    <option value="0.75">0.75</option>
                                                                    <option value="1">1.00</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2" style="margin-top: 0px">
                                                                <label for="" class="control-label" style="margin: 0px">কুচি&nbsp;</label>
                                                                <select name="pnt_is_kuci" style="width: 100%; height: 35px" style="margin-bottom: 10px" required="">
                                                                    <%
                                                                        String pant_kuci = "";
                                                                        if (pnt_kuci != null) {
                                                                            if (pnt_kuci.equals("1")) {
                                                                                pant_kuci = "হ্যা ";
                                                                            }
                                                                            if (pnt_kuci.equals("0")) {
                                                                                pant_kuci = "না";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pnt_kuci != null) {
                                                                    %>
                                                                    <option value="<%= pnt_kuci%>"><%= pant_kuci%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1">হ্যা </option>
                                                                    <option value="0">না</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">প্যান্টের সংখ্যা  </label>
                                                                <%
                                                                    String pant_qty = null;
                                                                    try {
                                                                        String sql_pant = "select * from ser_pant where order_id = '" + val + "' ";
                                                                        PreparedStatement pst_pant = DbConnection.getConn(sql_pant);
                                                                        ResultSet rs_pant = pst_pant.executeQuery();
                                                                        if (rs_pant.next()) {
                                                                            pant_qty = rs_pant.getString("qty");
                                                                        }
                                                                    } catch (Exception e) {
                                                                        out.println(e.toString());
                                                                    }
                                                                %>
                                                                <input type="text" class="form-control" name="pnt_number" id="pnt_number" value="<%= pant_qty%>" id="pant_long" placeholder="" style="margin-bottom: 10px"  maxlength="3" required=""/>
                                                            </div>
                                                        </div>
                                                        <div class="row">                                                                   
                                                            <div class="col-sm-2">   
                                                                <label style="margin: 0px">কেটালগ নং</label>
                                                                <input type="text" class="form-control" name="pnt_catelog_no" placeholder="" <% if (pnt_catelog_no != null) {%> value="<%= pnt_catelog_no%>" <%}%> style="margin-bottom: 10px"/>
                                                            </div>    
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">Order id </label>
                                                                <input type="text" class="form-control" name="pnt_order_id" value="<%= val%>" id="pant_long" readonly="" style="margin-bottom: 10px"/>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <label for="" class="control-label" style="margin: 0px;">অনান্য   </label>
                                                                <input type='textbox' id="pant" class="text"  style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                                                <textarea name="pnt_other" id="output_pant" class="text"   style="margin : 5px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"><% if (pnt_others != null) {%><%= pnt_others.trim()%><%}%></textarea>
                                                            </div>
                                                            <input type="text" name="customer_mobile" value="<%= customer_mobile_from_customer%>" style="display: none" />
                                                        </div>
                                                        <%
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                        %>
                                                        <div class="row">
                                                            <div class="col-sm-12 col-md-12" style="margin-top: 10px">
                                                                <center>
                                                                    <input type="submit" class="btn btn-primary" value="Submit"/>
                                                                    <input type="reset" class="btn btn-danger" data-dismiss="modal" value="Cancel"/>
                                                                </center>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                    if (is_blazer) {
                                %>
                                <div class="container" style="margin-top: 5px;">
                                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#modal-blazer">ব্লেজার পরিমাপ </button> <% if (session.getAttribute("blz_msg") != null) {%> <%= session.getAttribute("blz_msg")%><%} %>
                                    <div class="modal fade" id="modal-blazer">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h3 class="modal-title" >ব্লেজার পরিমাপ</h3>
                                                </div>

                                                <div class="modal-body">
                                                    <form action="../Blazers_Measurement" accept-charset="ISO-8859-1" onsubmit="return blazer_validation();" method="post">
                                                        <%
                                                            try {
                                                                // take customer id form ad_order flowing last order_id
                                                                String sql_customer_id = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + val + "' ";
                                                                PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                                                                ResultSet rs_customer_id = pst_customer_id.executeQuery();
                                                                if (rs_customer_id.next()) {
                                                                    customer_id_from_ad_order = rs_customer_id.getString("ord_cutomer_id");
                                                                } else {
                                                                    out.println("Customer id not found");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            // take customer mobile from customer by matching customer id                                                                
                                                            try {
                                                                String sql_customer_mobile = "select * from customer where cus_bran_id = '"+session.getAttribute("user_bran_id")+"' and cus_customer_id = '" + customer_id_from_ad_order + "' ";
                                                                PreparedStatement pst_customer_mobile = DbConnection.getConn(sql_customer_mobile);
                                                                ResultSet rs_customer_mobile = pst_customer_mobile.executeQuery();
                                                                if (rs_customer_mobile.next()) {
                                                                    customer_mobile_from_customer = rs_customer_mobile.getString("cus_mobile");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }

                                                            try {
                                                                String sql = "select * from msr_blazer where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '" + customer_mobile_from_customer + "' ";
                                                                PreparedStatement pst = DbConnection.getConn(sql);
                                                                ResultSet rs_blazer = pst.executeQuery();
                                                                while (rs_blazer.next()) {
                                                                    String blz_long = rs_blazer.getString("blz_long");
                                                                    String blz_body = rs_blazer.getString("blz_body");
                                                                    String blz_bally = rs_blazer.getString("blz_bally");
                                                                    String blz_hip = rs_blazer.getString("blz_hip");
                                                                    String blz_shoulder = rs_blazer.getString("blz_shoulder");
                                                                    String blz_hand_long = rs_blazer.getString("blz_hand_long");
                                                                    String blz_hand_mohuri = rs_blazer.getString("blz_hand_mohuri");
                                                                    String blz_cross_back = rs_blazer.getString("blz_cross_back");
                                                                    String blz_button_num = rs_blazer.getString("blz_button_num");
                                                                    String blz_nepel = rs_blazer.getString("blz_nepel");
                                                                    String blz_side = rs_blazer.getString("blz_side");
                                                                    String blz_catelog_no = rs_blazer.getString("blz_catelog_no");
                                                                    String blz_other = rs_blazer.getString("blz_others");
                                                                    //String blz_qty = rs_blazer.getString(20);
                                                                    String blz_best = rs_blazer.getString("best");
                                                                    String blz_under = rs_blazer.getString("under");
                                                        %>
                                                        <div class="row">
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label" style="margin: 0px;">লম্বা</label>
                                                                <input type="text" class="form-control" name="blz_long" id="blz_long" <% if (blz_long != null) {%> value="<%= blz_long%>" <%}%> style="margin-bottom: 8px" maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label" style="margin: 0px;">বডি</label>
                                                                <input type="text" class="form-control" name="blz_body" id="blz_body" <% if (blz_body != null) {%> value="<%= blz_body%>" <%}%>  style="margin-bottom: 8px"  maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label" style="margin: 0px;">পেট </label>
                                                                <input type="text" class="form-control" name="blz_bally" id="blz_bally" <% if (blz_bally != null) {%> value="<%= blz_bally%>" <%}%>  style="margin-bottom: 8px" maxlength="5" required=""/>
                                                            </div>                                        
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label" style="margin: 0px;">হিপঃ</label>
                                                                <input type="text" class="form-control" name="blz_hip" id="blz_hip" <% if (blz_hip != null) {%> value="<%= blz_hip%>" <%}%> style="margin-bottom: 8px" maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label" style="margin: 0px;">কাধ</label>
                                                                <input type="text" class="form-control" name="blz_shoulder" id="blz_shoulder" <% if (blz_shoulder != null) {%> value="<%= blz_shoulder%>" <%}%> style="margin-bottom: 8px" maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label" style="margin: 0px;">হাতা-লম্বাঃ</label>
                                                                <input type="text" class="form-control" name="blz_hand_long" id="blz_hand_long" <% if (blz_hand_long != null) {%> value="<%= blz_hand_long%>" <%}%> style="margin-bottom: 8px" maxlength="5" required=""/>
                                                            </div>                                        
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label" style="margin: 0px;">হাতা-মহরিঃ</label>
                                                                <input type="text" class="form-control" name="blz_mohuri" id="blz_mohuri" <% if (blz_hand_mohuri != null) {%> value="<%= blz_hand_mohuri%>" <%}%> style="margin-bottom: 8px" maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label" style="margin: 0px;">ক্রস ব্যাকঃ </label>
                                                                <input type="text" class="form-control" name="blz_crass_back" id="blz_crass_back" <% if (blz_cross_back != null) {%> value="<%= blz_cross_back%>" <%}%> style="margin-bottom: 8px" maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-3" style="margin: 0px">
                                                                <label for="" class="control-label">বুতাম &nbsp;</label>
                                                                <select name="button" style="width: 100%; height: 35px;" required="">
                                                                    <%
                                                                        String blazer_btton = "";
                                                                        if (blz_button_num != null) {
                                                                            if (blz_button_num.equals("1")) {
                                                                                blazer_btton = "1 টা";
                                                                            }
                                                                            if (blz_button_num.equals("2")) {
                                                                                blazer_btton = "2 টা";
                                                                            }
                                                                            if (blz_button_num.equals("3")) {
                                                                                blazer_btton = "3 টা";
                                                                            }
                                                                            if (blz_button_num.equals("4")) {
                                                                                blazer_btton = "4 টা";
                                                                            }
                                                                            if (blz_button_num.equals("5")) {
                                                                                blazer_btton = "5 টা";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (blz_button_num != null) {
                                                                    %>
                                                                    <option value="<%= blz_button_num%>"><%= blazer_btton%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1">1 টা</option>
                                                                    <option value="2">2 টা</option>
                                                                    <option value="3">3 টা</option>
                                                                    <option value="4">4 টা</option>
                                                                    <option value="5">5 টা</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-3" style="margin: 0px">
                                                                <label for="" class="control-label">নেপেল</label>
                                                                <select name="nepel" style="width: 100%; height: 35px; margin-bottom: 8px" required="">
                                                                    <%
                                                                        String blazer_nepel = "";
                                                                        if (blz_nepel != null) {
                                                                            if (blz_nepel.equals("2")) {
                                                                                blazer_nepel = "2.00";
                                                                            }
                                                                            if (blz_nepel.equals("2.25")) {
                                                                                blazer_nepel = "2.25";
                                                                            }
                                                                            if (blz_nepel.equals("2.50")) {
                                                                                blazer_nepel = "2.50";
                                                                            }
                                                                            if (blz_nepel.equals("2.75")) {
                                                                                blazer_nepel = "2.75";
                                                                            }
                                                                            if (blz_nepel.equals("3.00")) {
                                                                                blazer_nepel = "3.00";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (blz_nepel != null) {
                                                                    %>
                                                                    <option value="<%= blz_nepel%>"><%= blazer_nepel%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="2">2.00</option>
                                                                    <option value="2.25">2.25</option>
                                                                    <option value="2.50">2.50</option>
                                                                    <option value="2.75">2.75</option>
                                                                    <option value="3.00">3.00</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-3" style="margin: 0px">
                                                                <label for="" class="control-label">ওপেন</label>
                                                                <select name="blz_side" style="width: 100%; height: 35px;" required="">
                                                                    <%
                                                                        String blazer_open = "";
                                                                        if (blz_side != null) {
                                                                            if (blz_side.equals("1")) {
                                                                                blazer_open = "ব্যাক ওপেন ";
                                                                            }
                                                                            if (blz_side.equals("2")) {
                                                                                blazer_open = " সাইড ওপেন";
                                                                            }
                                                                            if (blz_side.equals("3")) {
                                                                                blazer_open = "নো ওপেন ";
                                                                            }
                                                                            if (blz_side.equals("4")) {
                                                                                blazer_open = " ব্যাক/সাইড ওপেন ";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (blz_side != null) {
                                                                    %>
                                                                    <option value="<%= blz_side%>"><%= blazer_open%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1"> ব্যাক ওপেন</option>
                                                                    <option value="2"> সাইড ওপেন </option>
                                                                    <option value="3">নো ওপেন </option>
                                                                    <option value="4">ব্যাক/সাইড ওপেন </option>
                                                                </select>                                           
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label"  style="margin: 0px">বেস্ট </label>
                                                                <select name="best" style="width: 100%; height: 35px;" required="">
                                                                    <%
                                                                        String blazer_best = "";
                                                                        if (blz_best != null) {
                                                                            if (blz_best.equals("2")) {
                                                                                blazer_best = "ডাবল";
                                                                            }
                                                                            if (blz_best.equals("1")) {
                                                                                blazer_best = "সিংগেল";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (blz_best != null) {
                                                                    %>
                                                                    <option value="<%= blz_best%>"><%= blazer_best%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="2">ডাবল</option>
                                                                    <option value="1">সিংগেল</option>
                                                                </select>                                           
                                                            </div>
                                                        </div>
                                                        <div class="row">                                                                                                                                                
                                                            <div class="col-sm-3" >
                                                                <label for="" class="control-label" style="margin: 0px">নিচে</label>
                                                                <select name="neca" style="width: 100%; height: 35px;" required="">
                                                                    <%
                                                                        String blazer_under = "";
                                                                        if (blz_under != null) {
                                                                            if (blz_under.equals("0")) {
                                                                                blazer_under = "রাউন্ড";
                                                                            }
                                                                            if (blz_under.equals("1")) {
                                                                                blazer_under = "স্ক্য়ার";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (blz_under != null) {
                                                                    %>
                                                                    <option value="<%= blz_under%>"><%= blazer_under%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="0">রাউন্ড</option>
                                                                    <option value="1">স্ক্য়ার</option>
                                                                </select>                                           
                                                            </div>                                                                                                                                                
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label" style="margin: 0px;"> ব্লেজারের সংখ্যা </label>
                                                                <%
                                                                    String blzqty = null;
                                                                    try {
                                                                        String sql_blz = "select * from ser_blazer where order_id = '" + val + "' ";
                                                                        PreparedStatement pst_blz = DbConnection.getConn(sql_blz);
                                                                        ResultSet rs_blz = pst_blz.executeQuery();
                                                                        if (rs_blz.next()) {
                                                                            blzqty = rs_blz.getString("qty");
                                                                        }
                                                                    } catch (Exception e) {
                                                                        out.println(e.toString());
                                                                    }
                                                                %>
                                                                <input type="text" class="form-control" name="blz_qty" id="blz_qty" value="<%= blzqty%>" maxlength="3" style="margin-bottom: 8px" required=""/>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label" style="margin: 0px;">কেটালগ নং</label>
                                                                <input type="text" class="form-control" name="blz_catelog" id="blz_catelog" placeholder="" style="margin-bottom: 8px"/>
                                                            </div>
                                                        </div>
                                                        <div class="row">                                                            
                                                            <div class="col-sm-3">
                                                                <label for="" class="control-label" style="margin: 0px;">order no</label>
                                                                <input type="text" class="form-control" name="blz_order_id" id="blz_body"  value="<%= val%>"placeholder="" readonly="" style="margin-bottom: 8px"/>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <label for="" class="control-label" style="margin: 0px;">অনান্য</label>
                                                                <input type='textbox' id="blazer" class="text"  style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                                                <textarea name="blz_other" id="output_blazer" class="text"   style="margin : 1px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"><% if (blz_other != null) {%><%= blz_other%><%}%></textarea>
                                                            </div>
                                                            <input type="text" name="customer_mobile" value="<%= customer_mobile_from_customer%>" style="display: none" />
                                                        </div>
                                                        <%
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                        %>


                                                        <div class="row">
                                                            <div class="col-sm-12 col-md-12" style="margin-top: 10px; margin-bottom: 10px;">
                                                                <center>
                                                                    <input type="submit" class="btn btn-primary" value="Submit"/>
                                                                    <input type="reset" class="btn btn-danger" data-dismiss="modal" value="Cancel"/>
                                                                </center>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                    if (is_photua) {
                                %>
                                <!-------------------------------------------------------------------------------------------------------------------------------------------photua ------------------------------------------------------------------------------------------------------------------------>
                                <div class="container" style="margin-top:5px">
                                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#modal-photua">ফতুয়া পরিমাপ </button> <% if (session.getAttribute("pht_msg") != null) {%> <%= session.getAttribute("pht_msg")%><%} %>
                                    <div class="modal fade" id="modal-photua">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h3 class="modal-title" >ফতুয়া পরিমাপ</h3>
                                                </div>
                                                <div class="modal-body">
                                                    <form  action="../Photua_measurment" accept-charset="ISO-8859-1" onsubmit="return photua_validation();" method="post">
                                                        <%
                                                            try {
                                                                // take customer id form ad_order flowing last order_id
                                                                String sql_customer_id = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + val + "' ";
                                                                PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                                                                ResultSet rs_customer_id = pst_customer_id.executeQuery();
                                                                if (rs_customer_id.next()) {
                                                                    customer_id_from_ad_order = rs_customer_id.getString("ord_cutomer_id");
                                                                } else {
                                                                    out.println("Customer id not found");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            // take customer mobile from customer by matching customer id                                                                
                                                            try {
                                                                String sql_customer_mobile = "select * from customer where cus_bran_id = '"+session.getAttribute("user_bran_id")+"' and cus_customer_id = '" + customer_id_from_ad_order + "' ";
                                                                PreparedStatement pst_customer_mobile = DbConnection.getConn(sql_customer_mobile);
                                                                ResultSet rs_customer_mobile = pst_customer_mobile.executeQuery();
                                                                if (rs_customer_mobile.next()) {
                                                                    customer_mobile_from_customer = rs_customer_mobile.getString("cus_mobile");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            try {
                                                                String sql_pht = "select * from msr_photua where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '" + customer_mobile_from_customer + "' ";
                                                                PreparedStatement pst = DbConnection.getConn(sql_pht);
                                                                ResultSet rs_pht = pst.executeQuery();
                                                                while (rs_pht.next()) {
                                                                    String pht_order_id = rs_pht.getString(5);
                                                                    String pht_long = rs_pht.getString("pht_long");
                                                                    String pht_body = rs_pht.getString("pht_body");
                                                                    String pht_pht_body_loose = rs_pht.getString("pht_body_loose");
                                                                    String pht_bally = rs_pht.getString("pht_bally");
                                                                    String pht_hip = rs_pht.getString("pht_hip");
                                                                    String pht_shoulder = rs_pht.getString("pht_shoulder");
                                                                    String pht_neck = rs_pht.getString("pht_neck");
                                                                    String pht_hand_long = rs_pht.getString("pht_hand_long");
                                                                    String pht_hand_moja = rs_pht.getString("pht_hand_moja");
                                                                    String pht_hand_qunu = rs_pht.getString("pht_hand_qunu");
                                                                    String pht_hand_cuff = rs_pht.getString("pht_hand_cuff");
                                                                    String pht_types = rs_pht.getString("pht_types");
                                                                    String pht_plet = rs_pht.getString("pht_plet");
                                                                    String pht_collar = rs_pht.getString("pht_collar");
                                                                    String pht_collar_size = rs_pht.getString("pht_collar_size");
                                                                    String pht_cuff_size = rs_pht.getString("pht_cuff_size");
                                                                    String pht_pocket = rs_pht.getString("pht_pocket");
                                                                    String pht_pocket_inner = rs_pht.getString("pht_pocket_inner");
                                                                    // String qty = rs_pht.getString(24);
                                                                    String pht_open = rs_pht.getString("pht_open");
                                                                    String pht_catelog_no = rs_pht.getString("pht_catelog_no");
                                                                    String pht_others = rs_pht.getString("pht_others");
                                                        %>
                                                        <div class="row">                          
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">লম্বা  </label>
                                                                <input type="text" class="form-control" name="pht_long" id="pht_long" <% if (pht_long != null) {%> value="<%= pht_long%>"<%} %> maxlength="5" style="margin-bottom: 8 px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">বডি</label>
                                                                <input type="text" class="form-control" name="pht_body" id="pht_body" <input type="text" class="form-control"  <% if (pht_body != null) {%> value="<%= pht_body%>"<%} %>  style="margin-bottom: 8 px;" maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">পেট </label>
                                                                <input type="text" class="form-control" name="pht_bally" id="pht_bally" <% if (pht_bally != null) {%> value="<%= pht_bally%>"<%} %>  style="margin-bottom: 8px;" maxlength="5" required=""/>
                                                            </div>                                                           
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">হিপ</label>
                                                                <input type="text" class="form-control" name="pht_hip" id="pht_hip" <% if (pht_hip != null) {%> value="<%= pht_hip%>"<%} %>  style="margin-bottom: 8px;" maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">কাধ</label>
                                                                <input type="text" class="form-control" name="pht_shoulder" id="pht_shoulder"<% if (pht_shoulder != null) {%> value="<%= pht_shoulder%>"<%} %>  style="margin-bottom: 8px;" maxlength="5" required=""/>
                                                            </div>
                                                        </div>
                                                        <div class="row">                            
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">হাতা লম্বা  </label>
                                                                <input type="text" class="form-control" name="pht_hand_long" id="pht_hand_long"  <% if (pht_hand_long != null) {%> value="<%= pht_hand_long%>"<%}%>  style="margin-bottom: 8px;" maxlength="5" required=""/>
                                                            </div>                                                           
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">হাতা কাপ</label>
                                                                <input type="text" class="form-control" name="pht_hand_cuff" id="pht_hand_cuff" <% if (pht_hand_cuff != null) {%> value="<%= pht_hand_cuff%>"<%} %>  style="margin-bottom: 8px;" maxlength="5" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">গলা</label>
                                                                <input type="text" class="form-control" name="pht_neck" id="pht_neck" <% if (pht_neck != null) {%> value="<%= pht_neck%>"<%} %>  style="margin-bottom: 8px;" maxlength="5" required=""/>
                                                            </div> 
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">হাতা কুনু</label>
                                                                <input type="text" class="form-control" name="pht_hand_kuni" id="pht_hand_konu" <% if (pht_hand_qunu != null) {%> value="<%= pht_hand_qunu%>"<%} %>  style="margin-bottom: 8px;" maxlength="5"  required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">হাতা মোজা</label>
                                                                <input type="text" class="form-control" name="pht_hand_moja" id="pht_hand_moja" <% if (pht_hand_moja != null) {%> value="<%= pht_hand_moja%>"<%} %>  style="margin-bottom: 8px;" maxlength="5" required=""/>
                                                            </div>
                                                        </div> 
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px;">বডি লুজ</label>
                                                                <input type="text" class="form-control" name="pht_body_loose" id="pht_body_loose" <% if (pht_pht_body_loose != null) {%> value="<%= pht_body%>"<%} %>   style="margin-bottom: 8px;" maxlength="5"/>
                                                            </div>                                                           
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style=" margin: 0px"> ধরন</label>
                                                                <select name="pht_type" id="srt_type"  style="width: 100%; height: 30px; text-align: center" required="">
                                                                    <%
                                                                        String pht_type = null;
                                                                        if (pht_types != null) {
                                                                            if (pht_types.equals("1")) {
                                                                                pht_type = "চাইনিজ";
                                                                            } else if (pht_types.equals("2")) {
                                                                                pht_type = "হাওয়াই";
                                                                            } else if (pht_types.equals("3")) {
                                                                                pht_type = "হাফ";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pht_types != null) {
                                                                    %>
                                                                    <option value="<%= pht_types%>"><%= pht_type%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1" style="text-align: center">চাইনিজ</option>
                                                                    <option value="2" style="text-align: center">হাওয়াই</option>
                                                                    <option value="3" style="text-align: center">হাফ</option>

                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="padding: 0px; margin: 0px">প্লেট</label>
                                                                <select name="pht_plet" class="plet" id="srt_plet" style="width: 100%; height: 30px" required="">
                                                                    <%
                                                                        String pht_plets = null;
                                                                        if (pht_plet != null) {
                                                                            if (pht_plet.equals("1")) {
                                                                                pht_plets = "বক্স প্লেট";
                                                                            } else if (pht_plet.equals("2")) {
                                                                                pht_plets = "সেলাই প্লেট";
                                                                            } else if (pht_plet.equals("3")) {
                                                                                pht_plets = "ইনার প্লেট";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pht_plet != null) {
                                                                    %>
                                                                    <option value="<%= pht_plet%>"><%= pht_plets%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="2">সেলাই প্লেট</option>
                                                                    <option value="3">ইনার প্লেট</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px">কলার</label>
                                                                <select name="pht_collar" id="srt_collar" style="width: 100%; height: 30px;" required="">
                                                                    <%
                                                                        String pht_collars = null;
                                                                        if (pht_collar != null) {
                                                                            if (pht_collar.equals("1")) {
                                                                                pht_collars = "এরো";
                                                                            } else if (pht_collar.equals("2")) {
                                                                                pht_collars = "টাই";
                                                                            } else if (pht_collar.equals("3")) {
                                                                                pht_collars = "বেন";
                                                                            } else if (pht_collar.equals("4")) {
                                                                                pht_collars = "পাঞ্জাবি";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pht_collar != null) {
                                                                    %>
                                                                    <option value="<%= pht_collar%>"><%= pht_collars%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1">এরো</option>
                                                                    <option value="2">টাই</option>
                                                                    <option value="3">বেন</option>
                                                                    <option value="4">পাঞ্জাবি</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">কলারের মাপ</label>
                                                                <select name="pht_collar_size" style="width: 100%; height: 30px;" required="">
                                                                    <%
                                                                        String pht_coll_size = null;
                                                                        if (pht_collar_size != null) {
                                                                            if (pht_collar_size.equals("1.5")) {
                                                                                pht_coll_size = "1.50";
                                                                            } else if (pht_collar_size.equals("1.75")) {
                                                                                pht_coll_size = "1.50";
                                                                            } else if (pht_collar_size.equals("2")) {
                                                                                pht_coll_size = "1.75";
                                                                            } else if (pht_collar_size.equals("2.25")) {
                                                                                pht_coll_size = "2.00";
                                                                            } else if (pht_collar_size.equals("2.5")) {
                                                                                pht_coll_size = "2.50";
                                                                            } else if (pht_collar_size.equals("2.75")) {
                                                                                pht_coll_size = "2.75";
                                                                            } else if (pht_collar_size.equals("3")) {
                                                                                pht_coll_size = "3.00";
                                                                            } else if (pht_collar_size.equals("0.5")) {
                                                                                pht_coll_size = "0.50";
                                                                            } else if (pht_collar_size.equals("0.75")) {
                                                                                pht_coll_size = "0.75";
                                                                            } else if (pht_collar_size.equals("1")) {
                                                                                pht_coll_size = "1.00";
                                                                            }
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (pht_collar_size != null) {
                                                                    %>
                                                                    <option value="<%= pht_collar_size%>"><%= pht_coll_size%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="0.5">0.50</option>
                                                                    <option value="0.75">0.75</option>
                                                                    <option value="1">1.00</option>
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
                                                                    <%
                                                                        String pht_cuffs_size = null;
                                                                        if (pht_cuff_size != null) {
                                                                            if (pht_cuff_size.equals("1.5")) {
                                                                                pht_cuffs_size = "1.50";
                                                                            } else if (pht_cuff_size.equals("1.75")) {
                                                                                pht_cuffs_size = "1.50";
                                                                            } else if (pht_cuff_size.equals("2")) {
                                                                                pht_cuffs_size = "1.75";
                                                                            } else if (pht_cuff_size.equals("2.25")) {
                                                                                pht_cuffs_size = "2.00";
                                                                            } else if (pht_cuff_size.equals("2.5")) {
                                                                                pht_cuffs_size = "2.50";
                                                                            } else if (pht_cuff_size.equals("2.75")) {
                                                                                pht_cuffs_size = "2.75";
                                                                            } else if (pht_cuff_size.equals("3")) {
                                                                                pht_cuffs_size = "3.00";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pht_cuff_size != null) {
                                                                    %>
                                                                    <option value="<%= pht_cuff_size%>"><%= pht_cuffs_size%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1.5">1.50</option>
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
                                                                <select name="pht_pocket" class="pocketdmo" style="width: 100%; height: 30px" required="">
                                                                    <%
                                                                        String pockets = null;
                                                                        if (pht_pocket != null) {
                                                                            if (pht_pocket.equals("0")) {
                                                                                pockets = "পকেট হবে না";
                                                                            } else if (pht_pocket.equals("1")) {
                                                                                pockets = "1 টা পকেট";
                                                                            } else if (pht_pocket.equals("2")) {
                                                                                pockets = "2 টা পকেট";
                                                                            } else if (pht_pocket.equals("3")) {
                                                                                pockets = "3 টা পকেট";
                                                                            } else if (pht_pocket.equals("4")) {
                                                                                pockets = "4 টা পকেট";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pht_pocket != null) {
                                                                    %>
                                                                    <option value="<%= pht_pocket%>"><%= pockets%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="0">পকেট হবে না</option>
                                                                    <option value="1">1 টা পকেট</option>
                                                                    <option value="2">2 টা পকেট</option>
                                                                    <option value="3">3 টা পকেট</option>
                                                                    <option value="4">4 টা পকেট</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px">ভিতর পকেট &nbsp;</label>
                                                                <select name="pht_pocket_inner" class="innerpocket" style="width: 100%; height: 30px" required="">
                                                                    <%
                                                                        String pht_inr_pocket = "";
                                                                        if (pht_pocket_inner != null) {
                                                                            if (pht_pocket_inner.equals("1")) {
                                                                                pht_inr_pocket = "পকেট হবে";
                                                                            }
                                                                            if (pht_pocket_inner.equals("0")) {
                                                                                pht_inr_pocket = "পকেট হবে না";
                                                                            }
                                                                        }
                                                                    %>

                                                                    <%
                                                                        if (pht_pocket_inner != null) {
                                                                    %>
                                                                    <option value="<%= pht_pocket_inner%>"><%= pht_inr_pocket%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select One</option>
                                                                    <%
                                                                        }
                                                                    %>   
                                                                    <option value="1">পকেট হবে</option>
                                                                    <option value="0">পকেট হবে না</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">ওপেন</label>
                                                                <select name="pht_open" class="form-control" required="">
                                                                    <%
                                                                        String pht_open_status = null;
                                                                        if (pht_open != null) {
                                                                            if (pht_open.equals("1")) {
                                                                                pht_open_status = "ওপেন";
                                                                            } else if (pht_open.equals("2")) {
                                                                                pht_open_status = "নো ওপেন";
                                                                            }
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (pht_open != null) {
                                                                    %>
                                                                    <option value="<%=pht_open%>"><%=pht_open_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">ওপেন</option>
                                                                    <option value="2">নো ওপেন</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">কেটালগ নং</label>
                                                                <input type="text" class="form-control" name="pht_catelog_no" id="srt_catelog_no"  <% if (pht_catelog_no != null) {%> value="<%= pht_catelog_no%>"<%}%>  style="margin-bottom: 8px;" />
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">ফতুয়া সংখ্যা  </label>
                                                                <%
                                                                    String ser_pht_qty = null;
                                                                    try {
                                                                        String sql_ser_photua = "select * from ser_photua where order_id = '" + val + "' ";
                                                                        PreparedStatement pst_ser_pht = DbConnection.getConn(sql_ser_photua);
                                                                        ResultSet rs_ser_pht = pst_ser_pht.executeQuery();
                                                                        if (rs_ser_pht.next()) {
                                                                            ser_pht_qty = rs_ser_pht.getString("qty");
                                                                        }
                                                                    } catch (Exception e) {
                                                                        out.println(e.toString());
                                                                    }
                                                                %>
                                                                <input type="text" class="form-control" name="pht_number" id="pht_number" value="<%= ser_pht_qty%>"  maxlength="3" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin: 0px;">order no</label>
                                                                <input type="text" class="form-control" name="order_no" id="order_no" value="<%= val%>" style="margin-bottom: 8px;"readonly="" />
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <label for="" class="control-label" style="margin: 0px;">অনান্য   </label>
                                                                <input type='textbox' id="photua" class="text" style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                                                <textarea name="pht_other" id="output_photua" class="text"  style="margin : 1px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"><% if (pht_others != null) {%><%= pht_others%><%}%></textarea>
                                                            </div>
                                                            <input type="text" name="customer_mobile" value="<%= customer_mobile_from_customer%>" style="display: none" />
                                                        </div>
                                                        <%
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                        %>
                                                        <div class="row">                            
                                                            <div class="col-sm-5">
                                                            </div>
                                                            <div class="col-sm-5" style="margin-top: 10px">
                                                                <input type="submit" class="btn btn-primary" id="btn_submit" value="Submit" />
                                                                <input type="reset" class="btn btn-danger" data-dismiss="modal"  value="Cancel" />
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>                                                             
                                <!-------------------------------------------------------------------------------------------------------------------------------------------////photua ------------------------------------------------------------------------------------------------------------------------>
                                <%
                                    }
                                    if (is_panjabi) {
                                %>                                
                                <div class="container" style="margin-top: 5px;">                                   
                                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#panjabi">পাঞ্জাবি পরিমাপ</button><% if (session.getAttribute("pnjb_msg") != null) {%> <%= session.getAttribute("pnjb_msg")%><%} %>
                                    <!-- Modal      pnjb_msg -->
                                    <div class="modal fade" id="panjabi" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title">পাঞ্জাবি পরিমাপ</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="../Panjabi_Measurement" accept-charset="ISO-8859-1" method="post" onsubmit="return panjabi_validation()">
                                                        <%
                                                            try {
                                                                // take customer id form ad_order flowing last order_id
                                                                String sql_customer_id = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + val + "' ";
                                                                PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                                                                ResultSet rs_customer_id = pst_customer_id.executeQuery();
                                                                if (rs_customer_id.next()) {
                                                                    customer_id_from_ad_order = rs_customer_id.getString("ord_cutomer_id");
                                                                } else {
                                                                    out.println("Customer id not found");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            // take customer mobile from customer by matching customer id                                                                
                                                            try {
                                                                String sql_customer_mobile = "select * from customer where cus_bran_id = '"+session.getAttribute("user_bran_id")+"' and cus_customer_id = '" + customer_id_from_ad_order + "' ";
                                                                PreparedStatement pst_customer_mobile = DbConnection.getConn(sql_customer_mobile);
                                                                ResultSet rs_customer_mobile = pst_customer_mobile.executeQuery();
                                                                if (rs_customer_mobile.next()) {
                                                                    customer_mobile_from_customer = rs_customer_mobile.getString("cus_mobile");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            try {
                                                                String sql_panjabi = "select * from msr_panjabi where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '" + customer_mobile_from_customer + "' ";
                                                                PreparedStatement pst_panjabi = DbConnection.getConn(sql_panjabi);
                                                                ResultSet rs_panjabi = pst_panjabi.executeQuery();
                                                                while (rs_panjabi.next()) {
                                                                    String pnjb_long = rs_panjabi.getString("pnjb_long");
                                                                    String pnjb_body = rs_panjabi.getString("pnjb_body");
                                                                    String pnjb_body_loose = rs_panjabi.getString("pnjb_body_loose");
                                                                    String pnjb_belly = rs_panjabi.getString("pnjb_belly");
                                                                    String pnjb_belly_loose = rs_panjabi.getString("pnjb_belly_loose");
                                                                    String pnjb_hip = rs_panjabi.getString("pnjb_hip");
                                                                    String pnjb_hip_loose = rs_panjabi.getString("pnjb_hip_loose");
                                                                    String pnjb_shoulder = rs_panjabi.getString("pnjb_shoulder");
                                                                    String pnjb_neck = rs_panjabi.getString("pnjb_neck");
                                                                    String pnjb_hand_long = rs_panjabi.getString("pnjb_hand_long");
                                                                    String pnjb_muhuri = rs_panjabi.getString("pnjb_muhuri");
                                                                    String pnjb_plet = rs_panjabi.getString("pnjb_plet");
                                                                    String pnjb_collar_type = rs_panjabi.getString("pnjb_collar_type");
                                                                    String pnjb_collar_size = rs_panjabi.getString("pnjb_collar_size");
                                                                    String pnjb_pocket = rs_panjabi.getString("pnjb_pocket");
                                                                    String pnjb_inner_pocket = rs_panjabi.getString("pnjb_inner_pocket");
                                                                    // String qty = rs_panjabi.getString("qty");
                                                                    String pnjb_catelog_no = rs_panjabi.getString("pnjb_catelog_no");
                                                                    String pnjb_others = rs_panjabi.getString("pnjb_others");
                                                        %>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">লম্বা  </label>
                                                                <input type="text" class="form-control" name="pnjb_long" id="pnjb_long" <% if (pnjb_long != null) {%> value="<%= pnjb_long%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">বডি </label>
                                                                <input type="text" class="form-control" name="pnjb_body" id="pnjb_body" <% if (pnjb_body != null) {%> value="<%= pnjb_body%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পেট</label>
                                                                <input type="text" class="form-control" name="pnjb_belly" id="pnjb_belly" <% if (pnjb_belly != null) {%> value="<%= pnjb_belly%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ</label>
                                                                <input type="text" class="form-control" name="pnjb_hip" id="pnjb_hip" <% if (pnjb_hip != null) {%> value="<%= pnjb_hip%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কাঁধ</label>
                                                                <input type="text" class="form-control" name="pnjb_shoulder" id="pnjb_shoulder" <% if (pnjb_shoulder != null) {%> value="<%= pnjb_shoulder%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হাতা লম্বা</label>
                                                                <input type="text" class="form-control" name="pnjb_hand_long" id="pnjb_hand_long" <% if (pnjb_hand_long != null) {%> value="<%= pnjb_hand_long%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">মুহুরী</label>
                                                                <input type="text" class="form-control" name="pnjb_muhuri" id="pnjb_muhuri" <% if (pnjb_muhuri != null) {%> value="<%= pnjb_muhuri%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">গলা</label>
                                                                <input type="text" class="form-control" name="pnjb_neck" id="pnjb_neck" <% if (pnjb_neck != null) {%> value="<%= pnjb_neck%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">বডি লুজ</label>
                                                                <input type="text" class="form-control" name="pnjb_body_loose" id="pnjb_body_loose" <% if (pnjb_body_loose != null) {%> value="<%= pnjb_body_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;" />
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পেট লুজ</label>
                                                                <input type="text" class="form-control" name="pnjb_belly_loose" id="pnjb_belly_loose" <% if (pnjb_belly_loose != null) {%> value="<%= pnjb_belly_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>                                                 
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ লুজ</label>
                                                                <input type="text" class="form-control" name="pnjb_hip_loose" id="pnjb_hip_loose" <% if (pnjb_hip_loose != null) {%> value="<%= pnjb_hip_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>                                                           
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কলার সাইজ</label>
                                                                <select name="pnjb_collar_size" class="form-control" required="">
                                                                    <%
                                                                        if (pnjb_collar_size != null) {
                                                                    %>
                                                                    <option><%=pnjb_collar_size%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option>0.50</option>
                                                                    <option>1.00</option>
                                                                    <option>1.25</option>
                                                                    <option>1.50</option>
                                                                    <option>1.75</option>
                                                                    <option>2.00</option>
                                                                    <option>2.25</option>
                                                                    <option>2.50</option>
                                                                    <option>2.75</option>
                                                                    <option>3.00</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কলার টাইপ</label>
                                                                <select class="form-control" name="pnjb_collar_type" style="width: 100%;">
                                                                    <option value="1">ব্যান্ড কলার</option>                                                                    
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পকেট</label>
                                                                <select class="form-control" name="pnjb_pocket" style="width: 100%;" required="">
                                                                    <%
                                                                        if (pnjb_pocket != null) {
                                                                    %>
                                                                    <option value="<%=pnjb_pocket%>"><%=pnjb_pocket + " টি"%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                   
                                                                    <option value="1">1 টি</option>
                                                                    <option value="2">2 টি</option>
                                                                    <option value="3">3 টি</option>
                                                                    <option value="4">4 টি</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">প্লেট</label>
                                                                <select class="form-control" name="pnjb_plet" style="width: 100%;" required="">
                                                                    <%
                                                                        String pnjb_plet_status = null;
                                                                        if (pnjb_plet != null) {
                                                                            if (pnjb_plet.equals("1")) {
                                                                                pnjb_plet_status = "ইনার প্লেট";
                                                                            } else if (pnjb_plet.equals("2")) {
                                                                                pnjb_plet_status = "নরমাল প্লেট";
                                                                            }
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (pnjb_plet != null) {
                                                                    %>
                                                                    <option value="<%=pnjb_plet%>"><%=pnjb_plet_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">ইনার প্লেট</option>
                                                                    <option value="2">নরমাল প্লেট</option>                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ইনার পকেট</label>
                                                                <select name="pnjb_inner_pocket" class="form-control" id="pnjb_inner_pocket" required="">
                                                                    <%
                                                                        String pnjb_inner_pocket_status = null;
                                                                        if (pnjb_inner_pocket != null) {
                                                                            if (pnjb_inner_pocket.equals("1")) {
                                                                                pnjb_inner_pocket_status = "হবে";
                                                                            } else if (pnjb_inner_pocket.equals("0")) {
                                                                                pnjb_inner_pocket_status = "হবে না";
                                                                            }
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (pnjb_inner_pocket != null) {
                                                                    %>
                                                                    <option value="<%=pnjb_inner_pocket%>"><%=pnjb_inner_pocket_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">হবে</option>
                                                                    <option value="0">হবে না</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পাঞ্জাবি সংখ্যা</label>
                                                                <%
                                                                    String pnjb_qty = null;
                                                                    try {
                                                                        String sql_pnjb_qty = "select * from ser_panjabi where order_id = '" + val + "' ";
                                                                        PreparedStatement pst_pnjb_qty = DbConnection.getConn(sql_pnjb_qty);
                                                                        ResultSet rs_pnjb_qty = pst_pnjb_qty.executeQuery();
                                                                        if (rs_pnjb_qty.next()) {
                                                                            pnjb_qty = rs_pnjb_qty.getString("qty");
                                                                        }
                                                                    } catch (Exception e) {
                                                                        out.println("panjabi qty from ser_panjabi");
                                                                    }
                                                                %>
                                                                <input type="text" class="form-control" name="pnjb_qty" id="pnjb_qty" <% if (pnjb_qty != null) {%> value="<%= pnjb_qty%>"<%}%> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">অর্ডার নং</label>
                                                                <input type="text" class="form-control" name="pnjb_order_no" id="pnjb_order_no" value="<%=val%>" maxlength="5" style="margin-bottom: 8px;" required="" readonly=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ক্যাটালগ নং</label>
                                                                <input type="text" class="form-control" name="pnjb_catelog_no" id="pnjb_catelog_no" <% if (pnjb_catelog_no != null) {%> value="<%= pnjb_catelog_no%>"<%}%> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>                                                           
                                                            <input type="text" name="customer_mobile" value="<%=customer_mobile_from_customer%>" style="display: none"/>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-4">
                                                                <label for="" class="control-label" style="margin: 0px;">অনান্য   </label>
                                                                <input type='textbox' id="panjabi" class="text" style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                                                <textarea name="pnjb_other" id="output_panjabi" class="text"  style="margin : 1px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"><% if (pnjb_others != null) {%><%= pnjb_others%><%}%></textarea>
                                                            </div>
                                                        </div>
                                                        <%
                                                                }
                                                            } catch (Exception e) {
                                                                out.println("Panjabi measurement " + e.toString());
                                                            }
                                                        %>
                                                        <div class="row">                            
                                                            <div class="col-sm-5">
                                                            </div>
                                                            <div class="col-sm-5" style="margin-top: 10px">
                                                                <input type="submit" class="btn btn-primary" id="btn_submit" value="Submit" />
                                                                <input type="reset" class="btn btn-danger" data-dismiss="modal"  value="Cancel" />
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                    if (is_payjama) {
                                %>                                
                                <div class="container" style="margin-top: 5px;">                                   
                                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#payjama">পাজামা পরিমাপ</button><% if (session.getAttribute("pjma_msg") != null) {%> <%= session.getAttribute("pjma_msg")%><%} %>
                                    <!-- Modal -->
                                    <div class="modal fade" id="payjama" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title">পাজামা পরিমাপ</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="../Payjama_Measurement" accept-charset="iso-8859-1" method="post" onsubmit="return payjama_validation()">
                                                        <%
                                                            try {
                                                                // take customer id form ad_order flowing last order_id
                                                                String sql_customer_id = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + val + "' ";
                                                                PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                                                                ResultSet rs_customer_id = pst_customer_id.executeQuery();
                                                                if (rs_customer_id.next()) {
                                                                    customer_id_from_ad_order = rs_customer_id.getString("ord_cutomer_id");
                                                                } else {
                                                                    out.println("Customer id not found");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            // take customer mobile from customer by matching customer id                                                                
                                                            try {
                                                                String sql_customer_mobile = "select * from customer where cus_bran_id = '"+session.getAttribute("user_bran_id")+"' and cus_customer_id = '" + customer_id_from_ad_order + "' ";
                                                                PreparedStatement pst_customer_mobile = DbConnection.getConn(sql_customer_mobile);
                                                                ResultSet rs_customer_mobile = pst_customer_mobile.executeQuery();
                                                                if (rs_customer_mobile.next()) {
                                                                    customer_mobile_from_customer = rs_customer_mobile.getString("cus_mobile");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            try {
                                                                String sql_pajama = "select * from msr_payjama where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '" + customer_mobile_from_customer + "'";
                                                                PreparedStatement pst_pajama = DbConnection.getConn(sql_pajama);
                                                                ResultSet rs_pajama = pst_pajama.executeQuery();
                                                                while (rs_pajama.next()) {
                                                                    String pjma_long = rs_pajama.getString("pjma_long");
                                                                    String pjma_comor = rs_pajama.getString("pjma_comor");
                                                                    String pjma_hip = rs_pajama.getString("pjma_hip");
                                                                    String pjma_hip_loose = rs_pajama.getString("pjma_hip_loose");
                                                                    String pjma_mohuri = rs_pajama.getString("pjma_mohuri");
                                                                    String pjma_thai = rs_pajama.getString("pjma_thai");
                                                                    String pjma_fly = rs_pajama.getString("pjma_fly");
                                                                    String pjma_high = rs_pajama.getString("pjma_high");
                                                                    String pjma_pocket = rs_pajama.getString("pjma_pocket");
                                                                    String pjma_catelog_no = rs_pajama.getString("pjma_catelog_no");
                                                                    String pjma_others = rs_pajama.getString("pjma_others");
                                                        %>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">লম্বা  </label>
                                                                <input type="text" class="form-control" name="pjma_long" id="pjma_long" <% if (pjma_long != null) {%> value="<%= pjma_long%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কোমর</label>
                                                                <input type="text" class="form-control" name="pjma_comor" id="pjma_comor" <% if (pjma_comor != null) {%> value="<%= pjma_comor%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ</label>
                                                                <input type="text" class="form-control" name="pjma_hip" id="pjma_hip" <% if (pjma_hip != null) {%> value="<%= pjma_hip%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">মুহুরী</label>
                                                                <input type="text" class="form-control" name="pjma_muhuri" id="pjma_muhuri" <% if (pjma_mohuri != null) {%> value="<%= pjma_mohuri%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">থাই</label>
                                                                <input type="text" class="form-control" name="pjma_thai" id="pjma_thai" <% if (pjma_thai != null) {%> value="<%= pjma_thai%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ফ্লাই</label>
                                                                <input type="text" class="form-control" name="pjma_fly" id="pjma_fly" <% if (pjma_fly != null) {%> value="<%= pjma_fly%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হাই</label>
                                                                <input type="text" class="form-control" name="pjma_high" id="pjma_high" <% if (pjma_high != null) {%> value="<%= pjma_high%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ লুস</label>
                                                                <input type="text" class="form-control" name="pjma_hip_loose" id="pjma_hip_loose" <% if (pjma_hip_loose != null) {%> value="<%= pjma_hip_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পকেট</label>
                                                                <select name="pjma_pocket" class="form-control" required="">
                                                                    <%
                                                                        if (pjma_pocket != null) {
                                                                    %>
                                                                    <option value="<%=pjma_pocket%>"><%=pjma_pocket + " টি"%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">1টি</option>
                                                                    <option value="2">2টি</option>
                                                                    <option value="3">3টি</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পাজামা সংখ্যা </label>
                                                                <%
                                                                    String pjma_qty = null;
                                                                    try {
                                                                        String sql_pajama_qty = "select * from ser_payjama where order_id = '" + val + "' ";
                                                                        PreparedStatement pst_payjama_qty = DbConnection.getConn(sql_pajama_qty);
                                                                        ResultSet rs_payjama_qty = pst_payjama_qty.executeQuery();
                                                                        if (rs_payjama_qty.next()) {
                                                                            pjma_qty = rs_payjama_qty.getString("qty");
                                                                        }
                                                                    } catch (Exception e) {
                                                                        out.println("payjama qty " + e.toString());
                                                                    }
                                                                %>  
                                                                <input type="text" class="form-control" name="pjma_qty" id="pjma_qty" <% if (pjma_qty != null) {%> value="<%= pjma_qty%>"<%}%> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>                                                            
                                                        </div>
                                                        <div class="row">                                                           
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">অর্ডার নং</label>
                                                                <input type="text" class="form-control" name="pjma_order_no" id="pht_long" value="<%=val%>" maxlength="5" style="margin-bottom: 8px;" readonly=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ক্যাটালগ নং</label>
                                                                <input type="text" class="form-control" name="pjma_catelog_no" id="pjma_catelog_no" <% if (pjma_catelog_no != null) {%> value="<%= pjma_catelog_no%>"<%}%> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <label for="" class="control-label" style="margin: 0px;">অনান্য   </label>
                                                                <input type='textbox' id="payjama" class="text" style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                                                <textarea name="pjma_other" id="output_payjama" class="text"  style="margin : 1px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"><% if (pjma_others != null) {%><%= pjma_others%><%}%></textarea>
                                                            </div>
                                                            <input type="text" name="customer_mobile" value="<%=customer_mobile_from_customer%>" style="display: none" />
                                                        </div>
                                                        <div class="row">                            
                                                            <div class="col-sm-5">
                                                            </div>
                                                            <div class="col-sm-5" style="margin-top: 10px">
                                                                <input type="submit" class="btn btn-primary" id="btn_submit" value="Submit" />
                                                                <input type="reset" class="btn btn-danger" data-dismiss="modal"  value="Cancel" />
                                                            </div>
                                                        </div>
                                                        <%
                                                                }
                                                            } catch (Exception e) {
                                                                out.println("payjama measurement " + e.toString());
                                                            }
                                                        %>
                                                    </form>
                                                </div>                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                    if (is_safari) {
                                %>                                
                                <div class="container" style="margin-top: 5px;">                                    
                                    <!-- Trigger the modal with a button -->
                                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#safari">সাফারি পরিমাপ</button><% if (session.getAttribute("safari_msg") != null) {%> <%= session.getAttribute("safari_msg")%><%} %>
                                    <!-- Modal -->
                                    <div class="modal fade" id="safari" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title">সাফারি পরিমাপ</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="../Safari_Measurement" accept-charset="ISO-8859-1" method="post" onsubmit="return safari_validation()">
                                                        <%
                                                            try {
                                                                // take customer id form ad_order flowing last order_id
                                                                String sql_customer_id = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + val + "' ";
                                                                PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                                                                ResultSet rs_customer_id = pst_customer_id.executeQuery();
                                                                if (rs_customer_id.next()) {
                                                                    customer_id_from_ad_order = rs_customer_id.getString("ord_cutomer_id");
                                                                } else {
                                                                    out.println("Customer id not found");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            // take customer mobile from customer by matching customer id                                                                
                                                            try {
                                                                String sql_customer_mobile = "select * from customer where cus_bran_id = '"+session.getAttribute("user_bran_id")+"' and cus_customer_id = '" + customer_id_from_ad_order + "' ";
                                                                PreparedStatement pst_customer_mobile = DbConnection.getConn(sql_customer_mobile);
                                                                ResultSet rs_customer_mobile = pst_customer_mobile.executeQuery();
                                                                if (rs_customer_mobile.next()) {
                                                                    customer_mobile_from_customer = rs_customer_mobile.getString("cus_mobile");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            try {
                                                                String sql_safari = "select * from msr_safari where bran_id = '" + session.getAttribute("user_bran_id") + "' and customer_mobile = '" + customer_mobile_from_customer + "' ";
                                                                PreparedStatement pst_safari = DbConnection.getConn(sql_safari);
                                                                ResultSet rs_safari = pst_safari.executeQuery();
                                                                while (rs_safari.next()) {
                                                                    String sfr_long = rs_safari.getString("sfr_long");
                                                                    String sfr_body = rs_safari.getString("sfr_body");
                                                                    String sfr_body_loose = rs_safari.getString("sfr_body_loose");
                                                                    String sfr_belly = rs_safari.getString("sfr_belly");
                                                                    String sfr_belly_loose = rs_safari.getString("sfr_belly_loose");
                                                                    String sfr_hip = rs_safari.getString("sfr_hip");
                                                                    String sfr_hip_loose = rs_safari.getString("sfr_hip_loose");
                                                                    String sfr_shoulder = rs_safari.getString("sfr_shoulder");
                                                                    String sfr_cross_back = rs_safari.getString("sfr_cross_back");
                                                                    String sfr_neck = rs_safari.getString("sfr_neck");
                                                                    String sfr_hand_long = rs_safari.getString("sfr_hand_long");
                                                                    String sfr_hand_cuff = rs_safari.getString("sfr_hand_cuff");
                                                                    String sfr_plet = rs_safari.getString("sfr_plet");
                                                                    String sfr_collar = rs_safari.getString("sfr_collar");
                                                                    String sfr_collar_size = rs_safari.getString("sfr_collar_size");
                                                                    // String sfr_cuff_size = rs_safari.getString("sfr_cuff_size");
                                                                    String sfr_inner_pocket = rs_safari.getString("sfr_inner_pocket");
                                                                    String sfr_type = rs_safari.getString("sfr_type");
                                                                    String sfr_pocket = rs_safari.getString("sfr_pocket");
                                                                    String sfr_back_side = rs_safari.getString("sfr_back_side");
                                                                    String sfr_catelog_no = rs_safari.getString("sfr_catelog_no");
                                                                    String sfr_others = rs_safari.getString("sfr_others");
                                                        %>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">লম্বা  </label>
                                                                <input type="text" class="form-control" name="sfr_long" id="sfr_long" <% if (sfr_long != null) {%> value="<%= sfr_long%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">বডি </label>
                                                                <input type="text" class="form-control" name="sfr_body" id="sfr_body" <% if (sfr_body != null) {%> value="<%= sfr_body%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পেট</label>
                                                                <input type="text" class="form-control" name="sfr_belly" id="sfr_belly" <% if (sfr_belly != null) {%> value="<%= sfr_belly%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ</label>
                                                                <input type="text" class="form-control" name="sfr_hip" id="sfr_hip" <% if (sfr_hip != null) {%> value="<%= sfr_hip%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কাঁধ</label>
                                                                <input type="text" class="form-control" name="sfr_shoulder" id="sfr_shoulder" <% if (sfr_shoulder != null) {%> value="<%= sfr_shoulder%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ক্রস ব্যাক</label>
                                                                <input type="text" class="form-control" name="sfr_crossback" id="sfr_crossback" <% if (sfr_cross_back != null) {%> value="<%= sfr_cross_back%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হাতা লম্বা </label>
                                                                <input type="text" class="form-control" name="sfr_hand_long" id="sfr_hand_long" <% if (sfr_hand_long != null) {%> value="<%= sfr_hand_long%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কাপ</label>
                                                                <input type="text" class="form-control" name="sfr_hand_cup" id="sfr_cup" <% if (sfr_hand_cuff != null) {%> value="<%= sfr_hand_cuff%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">গলা </label>
                                                                <input type="text" class="form-control" name="sfr_neck" id="sfr_neck" <% if (sfr_neck != null) {%> value="<%= sfr_neck%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">বডি লুজ</label>
                                                                <input type="text" class="form-control" name="sfr_body_loose" id="sfr_body_loose" <% if (sfr_body_loose != null) {%> value="<%= sfr_body_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পেট লুজ</label>
                                                                <input type="text" class="form-control" name="sfr_belly_loose" id="sfr_belly_loose" <% if (sfr_belly_loose != null) {%> value="<%= sfr_belly_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ  লুজ</label>
                                                                <input type="text" class="form-control" name="sfr_hip_loose" id="sfr_hip_loose" <% if (sfr_hip_loose != null) {%> value="<%= sfr_hip_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কলার সাইজ</label>
                                                                <select name="sfr_collar_size" class="form-control" required="">
                                                                    <%
                                                                        if (sfr_collar_size != null) {
                                                                    %>
                                                                    <option><%=sfr_collar_size%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option>Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option>0.50</option>
                                                                    <option>0.75</option>
                                                                    <option>1.00</option>
                                                                    <option>1.25</option>
                                                                    <option>1.50</option>
                                                                    <option>1.75</option>
                                                                    <option>2.00</option>
                                                                    <option>2.25</option>
                                                                    <option>2.50</option>
                                                                    <option>2.75</option>
                                                                    <option>3.00</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">প্লেট </label>
                                                                <select name="sfr_plet" class="form-control" required="">
                                                                    <%
                                                                        String sfr_plet_status = null;
                                                                        if (sfr_plet != null) {
                                                                            if (sfr_plet.equals("1")) {
                                                                                sfr_plet_status = "বক্স প্লেট";
                                                                            } else if (sfr_plet.equals("2")) {
                                                                                sfr_plet_status = " সেলাই প্লেট";
                                                                            } else if (sfr_plet.equals("3")) {
                                                                                sfr_plet_status = " সেলাই প্লেট";
                                                                            }
                                                                        }
                                                                        if (sfr_plet != null) {
                                                                    %>
                                                                    <option value="<%=sfr_plet%>"><%=sfr_plet_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">বক্স প্লেট</option>
                                                                    <option value="2"> সেলাই প্লেট</option>
                                                                    <option value="3">সেলাই ছাড়া</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পকেট</label>
                                                                <select name="sfr_pocket" class="form-control" required="">
                                                                    <%
                                                                        if (sfr_pocket != null) {
                                                                    %>
                                                                    <option value="<%=sfr_pocket%>"><%=sfr_pocket + " টা"%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">1 টা</option>
                                                                    <option value="2">2 টা</option>
                                                                    <option value="3">3 টা</option>
                                                                    <option value="4">4 টা</option>
                                                                    <option value="5">5 টা</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ব্যাক সাইড</label>
                                                                <select name="sfr_back_side" class="form-control" required="">
                                                                    <%
                                                                        String sfr_back_side_status = null;
                                                                        if (sfr_back_side != null) {
                                                                            if (sfr_back_side.equals("1")) {
                                                                                sfr_back_side_status = "ওপেন";
                                                                            } else if (sfr_back_side.equals("2")) {
                                                                                sfr_back_side_status = "নো ওপেন";
                                                                            }
                                                                        }
                                                                        if (sfr_back_side != null) {
                                                                    %>
                                                                    <option value="<%=sfr_back_side%>"><%=sfr_back_side_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                   
                                                                    <option value="1">ওপেন</option>
                                                                    <option value="2">নো ওপেন</option>                                                                    
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কলার</label>
                                                                <select name="sfr_collar_type" class="form-control" required="">
                                                                    <%
                                                                        String sfr_collar_status = null;
                                                                        if (sfr_collar != null) {
                                                                            if (sfr_collar.equals("1")) {
                                                                                sfr_collar_status = "শার্ট   কলার";
                                                                            } else if (sfr_collar.equals("2")) {
                                                                                sfr_collar_status = "ব্যান্ড কলার";
                                                                            } else if (sfr_collar.equals("3")) {
                                                                                sfr_collar_status = "ওপেন কলার";
                                                                            }
                                                                        }
                                                                        if (sfr_collar != null) {
                                                                    %>
                                                                    <option value="<%=sfr_collar%>"><%=sfr_collar_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">শার্ট   কলার</option>
                                                                    <option value="2">ব্যান্ড কলার</option>
                                                                    <option value="3">ওপেন কলার</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">সাফারি সংখ্যা </label>
                                                                <%
                                                                    String safari_qty = null;
                                                                    try {
                                                                        String sql_safari_qty = "select * from ser_safari where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + val + "' ";
                                                                        PreparedStatement pst_safari_qty = DbConnection.getConn(sql_safari_qty);
                                                                        ResultSet rs_safari_qty = pst_safari_qty.executeQuery();
                                                                        if (rs_safari_qty.next()) {
                                                                            safari_qty = rs_safari_qty.getString("qty");
                                                                        }
                                                                    } catch (Exception e) {
                                                                        out.println("safari qty " + e.toString());
                                                                    }
                                                                %>
                                                                <input type="text" class="form-control" name="sfr_qty" id="sfr_qty" value="<%= safari_qty%>" maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ইনার পকেট</label>
                                                                <select name="sfr_inner_pocket" class="form-control" required="">
                                                                    <%
                                                                        String sfr_inner_pocket_status = null;
                                                                        if (sfr_inner_pocket != null) {
                                                                            if (sfr_inner_pocket.equals("1")) {
                                                                                sfr_inner_pocket_status = "হ্যাঁ";
                                                                            } else if (sfr_inner_pocket.equals("0")) {
                                                                                sfr_inner_pocket_status = "না";
                                                                            }
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (sfr_inner_pocket != null) {
                                                                    %>
                                                                    <option value="<%=sfr_inner_pocket%>"><%=sfr_inner_pocket_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">হ্যাঁ</option>
                                                                    <option value="0">না</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">সাফারি ধরণ</label>
                                                                <select name="sfr_type" class="form-control" required="">
                                                                    <%
                                                                        String sfr_type_status = null;
                                                                        if (sfr_type != null) {
                                                                            if (sfr_type.equals("1")) {
                                                                                sfr_type_status = "ফুল হাতা";
                                                                            } else if (sfr_type.equals("0")) {
                                                                                sfr_type_status = "হাফ হাতা";
                                                                            }
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (sfr_type != null) {
                                                                    %>
                                                                    <option value="<%=sfr_type%>"><%=sfr_type_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">ফুল হাতা</option>
                                                                    <option value="0">হাফ হাতা</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ক্যাটালগ নং</label>
                                                                <input type="text" class="form-control" name="sfr_catelog_no" id="sfr_catelog_no" <%if (sfr_catelog_no != null) {%>value="<%=sfr_catelog_no%>"<% }%> maxlength="5" style="margin-bottom: 8px;" />
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">অর্ডার নং</label>
                                                                <input type="text" class="form-control" name="sfr_order_no" id="sfr_order_no" value="<%= val%>" maxlength="5" style="margin-bottom: 8px;" readonly=""/>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <label for="" class="control-label" style="margin: 0px;">অনান্য   </label>
                                                                <input type='textbox' id="safari" class="text" style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                                                <textarea name="sfr_other" id="output_safari" class="text"  style="margin : 1px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"><% if (sfr_others != null) {%><%=sfr_others%><%}%></textarea>
                                                            </div>
                                                            <input type="text" name="customer_mobile" value="<%=customer_mobile_from_customer%>" style="display: none" />
                                                        </div>
                                                        <div class="row">                            
                                                            <div class="col-sm-5">
                                                            </div>
                                                            <div class="col-sm-5" style="margin-top: 10px">
                                                                <input type="submit" class="btn btn-primary" id="btn_submit" value="Submit" />
                                                                <input type="reset" class="btn btn-danger" data-dismiss="modal"  value="Cancel" />
                                                            </div>
                                                        </div>
                                                        <%
                                                                }
                                                            } catch (Exception e) {
                                                                out.println("safari " + e.toString());
                                                            }
                                                        %>
                                                    </form>
                                                </div>                                              
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                    if (is_mojib_cort) {
                                %>                                
                                <div class="container" style="margin-top: 5px">                                    
                                    <!-- Trigger the modal with a button -->
                                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#mojib_cort">মুজিব কোর্ট </button><% if (session.getAttribute("mojib_cort_msg") != null) {%> <%= session.getAttribute("mojib_cort_msg")%><%} %>
                                    <!-- Modal -->
                                    <div class="modal fade" id="mojib_cort" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title">মুজিব কোর্ট পরিমাপ</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="../Mojib_Cort_Measurement" accept-charset="ISO-8859-1" method="post" onsubmit="return mojib_cort_validation()">
                                                        <%
                                                            try {
                                                                // take customer id form ad_order flowing last order_id
                                                                String sql_customer_id = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + val + "' ";
                                                                PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                                                                ResultSet rs_customer_id = pst_customer_id.executeQuery();
                                                                if (rs_customer_id.next()) {
                                                                    customer_id_from_ad_order = rs_customer_id.getString("ord_cutomer_id");
                                                                } else {
                                                                    out.println("Customer id not found");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            // take customer mobile from customer by matching customer id                                                                
                                                            try {
                                                                String sql_customer_mobile = "select * from customer where cus_bran_id = '"+session.getAttribute("user_bran_id")+"' and cus_customer_id = '" + customer_id_from_ad_order + "' ";
                                                                PreparedStatement pst_customer_mobile = DbConnection.getConn(sql_customer_mobile);
                                                                ResultSet rs_customer_mobile = pst_customer_mobile.executeQuery();
                                                                if (rs_customer_mobile.next()) {
                                                                    customer_mobile_from_customer = rs_customer_mobile.getString("cus_mobile");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            try {
                                                                String sql_mojib_cort = "select * from msr_mojib_cort  where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '" + customer_mobile_from_customer + "'";
                                                                PreparedStatement pst_mojib_cort = DbConnection.getConn(sql_mojib_cort);
                                                                ResultSet rs_mojib_cort = pst_mojib_cort.executeQuery();
                                                                while (rs_mojib_cort.next()) {
                                                                    String mjc_long = rs_mojib_cort.getString("mjc_long");
                                                                    String mjc_body = rs_mojib_cort.getString("mjc_body");
                                                                    String mjc_body_loose = rs_mojib_cort.getString("mjc_body_loose");
                                                                    String mjc_belly = rs_mojib_cort.getString("mjc_belly");
                                                                    String mjc_belly_loose = rs_mojib_cort.getString("mjc_belly_loose");
                                                                    String mjc_hip = rs_mojib_cort.getString("mjc_hip");
                                                                    String mjc_hip_loose = rs_mojib_cort.getString("mjc_hip_loose");

                                                                    String mjc_shoulder = rs_mojib_cort.getString("mjc_shoulder");
                                                                    String mjc_neck = rs_mojib_cort.getString("mjc_neck");
                                                                    String mjc_collar = rs_mojib_cort.getString("mjc_collar");
                                                                    String mjc_pocket = rs_mojib_cort.getString("mjc_pocket");
                                                                    String mjc_inner_pocket = rs_mojib_cort.getString("mjc_inner_pocket");
                                                                    String mjc_open = rs_mojib_cort.getString("mjc_open");
                                                                    String mjc_catelog_no = rs_mojib_cort.getString("mjc_catelog_no");
                                                                    String mjc_others = rs_mojib_cort.getString("mjc_others");
                                                        %>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">লম্বা  </label>
                                                                <input type="text" class="form-control" name="mjc_long" id="mjc_long" <% if (mjc_long != null) {%> value="<%= mjc_long%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">বডি </label>
                                                                <input type="text" class="form-control" name="mjc_body" id="mjc_body" <% if (mjc_body != null) {%> value="<%= mjc_body%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পেট</label>
                                                                <input type="text" class="form-control" name="mjc_belly" id="mjc_belly" <% if (mjc_belly != null) {%> value="<%= mjc_belly%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ</label>
                                                                <input type="text" class="form-control" name="mjc_hip" id="mjc_hip" <% if (mjc_hip != null) {%> value="<%= mjc_hip%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কাঁধ</label>
                                                                <input type="text" class="form-control" name="mjc_shoulder" id="mjc_shoulder" <% if (mjc_shoulder != null) {%> value="<%= mjc_shoulder%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">গলা</label>
                                                                <input type="text" class="form-control" name="mjc_neck" id="mjc_nect" <% if (mjc_neck != null) {%> value="<%= mjc_neck%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">বডি লুজ</label>
                                                                <input type="text" class="form-control" name="mjc_body_loose" id="mjc_body_loose" <% if (mjc_body_loose != null) {%> value="<%= mjc_body_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;" />
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পেট লুজ</label>
                                                                <input type="text" class="form-control" name="mjc_belly_loose" id="mjc_belly_loose" <% if (mjc_belly_loose != null) {%> value="<%= mjc_belly_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ লুজ</label>
                                                                <input type="text" class="form-control" name="mjc_hip_loose" id="mjc_hip_loose" <% if (mjc_hip_loose != null) {%> value="<%= mjc_hip_loose%>"<%}%> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কলার</label>
                                                                <select name="mjc_collar" class="form-control" required="">                                                                    
                                                                    <option value="1">ব্যান্ড কলার</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পকেট</label>
                                                                <select name="mjc_pocket" class="form-control" required="">
                                                                    <%
                                                                        if (mjc_pocket != null) {
                                                                    %>
                                                                    <option value="<%=mjc_pocket%>"><%=mjc_pocket + " টি"%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">1টি</option>
                                                                    <option value="2">2টি</option>
                                                                    <option value="3">3টি</option>
                                                                    <option value="4">4টি</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ইনার পকেট</label>
                                                                <select name="mjc_inner_pocket" class="form-control" required="">
                                                                    <%
                                                                        String mjc_inner_pocket_status = null;
                                                                        if (mjc_inner_pocket != null) {
                                                                            if (mjc_inner_pocket.equals("1")) {
                                                                                mjc_inner_pocket_status = "হবে";
                                                                            } else {
                                                                                mjc_inner_pocket_status = "হবে না";
                                                                            }
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (mjc_inner_pocket_status != null) {
                                                                    %>
                                                                    <option value="<%=mjc_inner_pocket%>"><%=mjc_inner_pocket_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">হবে</option>
                                                                    <option value="2">হবে না</option>                                                                    
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ওপেন</label>
                                                                <select name="mjc_open" class="form-control" required="">
                                                                    <%
                                                                        String mjc_open_status = null;
                                                                        if (mjc_open != null) {
                                                                            if (mjc_open.equals("1")) {
                                                                                mjc_open_status = "ব্যাক ওপেন";
                                                                            } else if (mjc_open.equals("2")) {
                                                                                mjc_open_status = "সাইড ওপেন";
                                                                            }
                                                                        }
                                                                        if (mjc_open != null) {
                                                                    %>
                                                                    <option value="<%=mjc_open%>"><%= mjc_open_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">ব্যাক ওপেন</option>
                                                                    <option value="2">সাইড ওপেন</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">অর্ডার</label>
                                                                <input type="text" class="form-control" name="mjc_order_no" id="pht_long" value="<%=val%>" maxlength="5" style="margin-bottom: 8px;" readonly=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">সংখ্যা</label>
                                                                <%
                                                                    String mjc_qty = null;
                                                                    try {
                                                                        String sql_mjc_qty = "select * from ser_mojib_cort where order_id = '" + val + "' ";
                                                                        PreparedStatement pst_mjc_qty = DbConnection.getConn(sql_mjc_qty);
                                                                        ResultSet rs_mjc_qty = pst_mjc_qty.executeQuery();
                                                                        if (rs_mjc_qty.next()) {
                                                                            mjc_qty = rs_mjc_qty.getString("qty");
                                                                        }
                                                                    } catch (Exception e) {
                                                                        out.println("mjc qty " + e.toString());
                                                                    }
                                                                %>
                                                                <input type="text" class="form-control" name="mjc_qty" id="mjc_qty"  value="<%= mjc_qty%>" maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ক্যাটালগ নং</label>
                                                                <input type="text" class="form-control" name="mjc_catelog_no" id="pht_long" <% if (mjc_catelog_no != null) {%> value="<%= mjc_catelog_no%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <label for="" class="control-label" style="margin: 0px;">অনান্য   </label>
                                                                <input type='textbox' id="mojib_cort" class="text" style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                                                <textarea name="mjc_others" id="output_mojib_cort" class="text"  style="margin : 1px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"><% if (mjc_others != null) {%><%= mjc_others%><%}%></textarea>
                                                            </div>
                                                            <input type="text" name="customer_mobile" value="<%=customer_mobile_from_customer%>" style="display: none" />
                                                        </div>
                                                        <div class="row">                            
                                                            <div class="col-sm-5">
                                                            </div>
                                                            <div class="col-sm-5" style="margin-top: 10px">
                                                                <input type="submit" class="btn btn-primary" id="btn_submit" value="Submit" />
                                                                <input type="reset" class="btn btn-danger" data-dismiss="modal"  value="Cancel" />
                                                            </div>
                                                        </div>
                                                        <%                                                                            }
                                                            } catch (Exception e) {
                                                                out.println("mojib cort measurement " + e.toString());
                                                            }
                                                        %>
                                                    </form>
                                                </div>                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                    if (is_kable) {
                                %>                                
                                <div class="container" style="margin-top:5px;">                                   
                                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#kable">কাবলি পরিমাপ</button><% if (session.getAttribute("kable_msg") != null) {%> <%= session.getAttribute("kable_msg")%><%} %>
                                    <!-- Modal -->
                                    <div class="modal fade" id="kable" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title">কাবলি পরিমাপ</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="../Kable_Measurement" accept-charset="ISO-8859-1" method="post" onsubmit="return kable_validation()">
                                                        <%
                                                            try {
                                                                // take customer id form ad_order flowing last order_id
                                                                String sql_customer_id = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + val + "' ";
                                                                PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                                                                ResultSet rs_customer_id = pst_customer_id.executeQuery();
                                                                if (rs_customer_id.next()) {
                                                                    customer_id_from_ad_order = rs_customer_id.getString("ord_cutomer_id");
                                                                } else {
                                                                    out.println("Customer id not found");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            // take customer mobile from customer by matching customer id                                                                
                                                            try {
                                                                String sql_customer_mobile = "select * from customer where cus_bran_id = '"+session.getAttribute("user_bran_id")+"' and cus_customer_id = '" + customer_id_from_ad_order + "' ";
                                                                PreparedStatement pst_customer_mobile = DbConnection.getConn(sql_customer_mobile);
                                                                ResultSet rs_customer_mobile = pst_customer_mobile.executeQuery();
                                                                if (rs_customer_mobile.next()) {
                                                                    customer_mobile_from_customer = rs_customer_mobile.getString("cus_mobile");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            try {
                                                                String sql_panjabi = "select * from msr_kable where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '" + customer_mobile_from_customer + "' ";
                                                                PreparedStatement pst_panjabi = DbConnection.getConn(sql_panjabi);
                                                                ResultSet rs_panjabi = pst_panjabi.executeQuery();
                                                                while (rs_panjabi.next()) {
                                                                    String kbl_long = rs_panjabi.getString("kbl_long");
                                                                    String kbl_body = rs_panjabi.getString("kbl_body");
                                                                    String kbl_body_loose = rs_panjabi.getString("kbl_body_loose");
                                                                    String kbl_belly = rs_panjabi.getString("kbl_belly");
                                                                    String kbl_belly_loose = rs_panjabi.getString("kbl_belly_loose");
                                                                    String kbl_hip = rs_panjabi.getString("kbl_hip");
                                                                    String kbl_hip_loose = rs_panjabi.getString("kbl_hip_loose");
                                                                    String kbl_shoulder = rs_panjabi.getString("kbl_shoulder");
                                                                    String kbl_neck = rs_panjabi.getString("kbl_neck");
                                                                    String kbl_hand_long = rs_panjabi.getString("kbl_hand_long");
                                                                    String kbl_muhuri = rs_panjabi.getString("kbl_muhuri");
                                                                    String kbl_plet = rs_panjabi.getString("kbl_plet");
                                                                    String kbl_collar_type = rs_panjabi.getString("kbl_collar_type");                                                                    
                                                                    String kbl_collar_size = rs_panjabi.getString("kbl_collar_size");
                                                                    String kbl_pocket = rs_panjabi.getString("kbl_pocket");
                                                                    // String qty = rs_panjabi.getString("qty");
                                                                    String kbl_catelog_no = rs_panjabi.getString("kbl_catelog_no");
                                                                    String kbl_others = rs_panjabi.getString("kbl_others");
                                                        %>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">লম্বা  </label>
                                                                <input type="text" class="form-control" name="kbl_long" id="kbl_long" <% if (kbl_long != null) {%> value="<%= kbl_long%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">বডি </label>
                                                                <input type="text" class="form-control" name="kbl_body" id="kbl_body" <% if (kbl_body != null) {%> value="<%= kbl_body%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পেট</label>
                                                                <input type="text" class="form-control" name="kbl_belly" id="kbl_belly" <% if (kbl_belly != null) {%> value="<%= kbl_belly%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ</label>
                                                                <input type="text" class="form-control" name="kbl_hip" id="kbl_hip" <% if (kbl_hip != null) {%> value="<%= kbl_hip%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কাঁধ</label>
                                                                <input type="text" class="form-control" name="kbl_shoulder" id="kbl_shoulder" <% if (kbl_shoulder != null) {%> value="<%= kbl_shoulder%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হাতা লম্বা</label>
                                                                <input type="text" class="form-control" name="kbl_hand_long" id="kbl_hand_long" <% if (kbl_hand_long != null) {%> value="<%= kbl_hand_long%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">মুহুরী</label>
                                                                <input type="text" class="form-control" name="kbl_muhuri" id="kbl_muhuri" <% if (kbl_muhuri != null) {%> value="<%= kbl_muhuri%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">গলা</label>
                                                                <input type="text" class="form-control" name="kbl_neck" id="kbl_neck" <% if (kbl_neck != null) {%> value="<%= kbl_neck%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">বডি লুজ</label>
                                                                <input type="text" class="form-control" name="kbl_body_loose" id="kbl_body_loose" <% if (kbl_body_loose != null) {%> value="<%= kbl_body_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;" />
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পেট লুজ</label>
                                                                <input type="text" class="form-control" name="kbl_belly_loose" id="kbl_belly_loose" <% if (kbl_belly_loose != null) {%> value="<%= kbl_belly_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;" />
                                                            </div>                                                 
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ লুজ</label>
                                                                <input type="text" class="form-control" name="kbl_hip_loose" id="kbl_hip_loose" <% if (kbl_hip_loose != null) {%> value="<%= kbl_hip_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>                                                           
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কলার সাইজ</label>
                                                                <input type="text" class="form-control" name="kbl_collar_size" id="kbl_collar_size" <% if (kbl_collar_size != null) {%> value="<%= kbl_collar_size%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কলার টাইপ</label>
                                                                <select class="form-control" name="kbl_collar_type" style="width: 100%;">
                                                                    <%
                                                                        String kbl_collar_status = null;
                                                                        if (kbl_collar_type != null) {
                                                                            if (kbl_collar_type.equals("1")) {
                                                                                kbl_collar_status = "শার্ট   কলার";
                                                                            } else if (kbl_collar_type.equals("2")) {
                                                                                kbl_collar_status = "ব্যান্ড কলার";
                                                                            }
                                                                        }
                                                                        if (kbl_collar_type != null) {
                                                                    %>
                                                                    <option value="<%=kbl_collar_type%>"><%=kbl_collar_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <option value="1">শার্ট   কলার</option>
                                                                    <option value="2">ব্যান্ড কলার</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পকেট</label>
                                                                <select class="form-control" name="kbl_pocket" style="width: 100%;" required="">
                                                                    <%
                                                                        if (kbl_pocket != null) {
                                                                    %>
                                                                    <option value="<%=kbl_pocket%>"><%=kbl_pocket + " টি"%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                   
                                                                    <option value="1">1 টি</option>
                                                                    <option value="2">2 টি</option>
                                                                    <option value="3">3 টি</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">প্লেট</label>
                                                                <select class="form-control" name="kbl_plet" style="width: 100%;" required="">
                                                                    <%
                                                                        String kbl_plet_status = null;
                                                                        if (kbl_plet != null) {
                                                                            if (kbl_plet.equals("1")) {
                                                                                kbl_plet_status = "ইনার প্লেট";
                                                                            } else if (kbl_plet.equals("2")) {
                                                                                kbl_plet_status = "নরমাল প্লেট";
                                                                            }
                                                                        }
                                                                        if (kbl_plet != null) {
                                                                    %>
                                                                    <option value="<%=kbl_plet%>"><%=kbl_plet_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">ইনার প্লেট</option>
                                                                    <option value="2">নরমাল প্লেট</option>                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row">                                                            
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">অর্ডার নং</label>
                                                                <input type="text" class="form-control" name="kbl_order_no" id="pht_long" value="<%=val%>" maxlength="5" style="margin-bottom: 8px;" readonly=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কাবলি সংখ্যা</label>
                                                                <%
                                                                    String kbl_qty = null;
                                                                    try {
                                                                        String sql_pnjb_qty = "select * from ser_kable where order_id = '" + val + "' ";
                                                                        PreparedStatement pst_pnjb_qty = DbConnection.getConn(sql_pnjb_qty);
                                                                        ResultSet rs_pnjb_qty = pst_pnjb_qty.executeQuery();
                                                                        if (rs_pnjb_qty.next()) {
                                                                            kbl_qty = rs_pnjb_qty.getString("qty");
                                                                        }
                                                                    } catch (Exception e) {
                                                                        out.println("panjabi qty from ser_panjabi");
                                                                    }
                                                                %>
                                                                <input type="text" class="form-control" name="kbl_qty" id="kbl_qty" <% if (kbl_qty != null) {%> value="<%= kbl_qty%>"<%}%> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>                                                           
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ক্যাটালগ নং</label>
                                                                <input type="text" class="form-control" name="kbl_catelog_no" id="pht_long" <% if (kbl_catelog_no != null) {%> value="<%= kbl_catelog_no%>"<%}%> maxlength="5" style="margin-bottom: 8px;" />
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <label for="" class="control-label" style="margin: 0px;">অনান্য   </label>
                                                                <input type='textbox' id="kable" class="text" style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                                                <textarea name="kbl_other" id="output_kable" class="text"  style="margin : 1px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"><% if (kbl_others != null) {%><%= kbl_others%><%}%></textarea>
                                                            </div>
                                                            <input type="text" value="<%=customer_mobile_from_customer%>" name="customer_mobile" style="display: none"/>
                                                        </div>
                                                        <%
                                                                }
                                                            } catch (Exception e) {
                                                                out.println("Panjabi measurement " + e.toString());
                                                            }
                                                        %>
                                                        <div class="row">                            
                                                            <div class="col-sm-5">
                                                            </div>
                                                            <div class="col-sm-5" style="margin-top: 10px">
                                                                <input type="submit" class="btn btn-primary" id="btn_submit" value="Submit" />
                                                                <input type="reset" class="btn btn-danger" data-dismiss="modal"  value="Cancel" />
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>                                            
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                    if (is_koti) {
                                %>                                
                                <div class="container" style="margin-top: 5px;">                                    
                                    <!-- Trigger the modal with a button -->
                                    <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#koti">কটি পরিমাপ</button><% if (session.getAttribute("koti_msg") != null) {%> <%= session.getAttribute("koti_msg")%><%} %>
                                    <!-- Modal -->
                                    <div class="modal fade" id="koti" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title">কটি পরিমাপ</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="../Koti_Measurement" accept-charset="iso-8859-1" method="post" onsubmit="return koti_validation()">
                                                        <%
                                                            try {
                                                                // take customer id form ad_order flowing last order_id
                                                                String sql_customer_id = "select * from ad_order where ord_bran_id = '"+session.getAttribute("user_bran_id")+"' and ord_bran_order = '" + val + "' ";
                                                                PreparedStatement pst_customer_id = DbConnection.getConn(sql_customer_id);
                                                                ResultSet rs_customer_id = pst_customer_id.executeQuery();
                                                                if (rs_customer_id.next()) {
                                                                    customer_id_from_ad_order = rs_customer_id.getString("ord_cutomer_id");
                                                                } else {
                                                                    out.println("Customer id not found");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            // take customer mobile from customer by matching customer id                                                                
                                                            try {
                                                                String sql_customer_mobile = "select * from customer where cus_bran_id = '"+session.getAttribute("user_bran_id")+"' and cus_customer_id = '" + customer_id_from_ad_order + "' ";
                                                                PreparedStatement pst_customer_mobile = DbConnection.getConn(sql_customer_mobile);
                                                                ResultSet rs_customer_mobile = pst_customer_mobile.executeQuery();
                                                                if (rs_customer_mobile.next()) {
                                                                    customer_mobile_from_customer = rs_customer_mobile.getString("cus_mobile");
                                                                }
                                                            } catch (Exception e) {
                                                                out.println(e.toString());
                                                            }
                                                            try {
                                                                String sql_koti = "select * from msr_koti  where bran_id = '"+session.getAttribute("user_bran_id")+"' and customer_mobile = '" + customer_mobile_from_customer + "'";
                                                                PreparedStatement pst_koti = DbConnection.getConn(sql_koti);
                                                                ResultSet rs_koti = pst_koti.executeQuery();
                                                                while (rs_koti.next()) {
                                                                    String kt_long = rs_koti.getString("kt_long");
                                                                    String kt_body = rs_koti.getString("kt_body");
                                                                    String kt_body_loose = rs_koti.getString("kt_body_loose");
                                                                    String kt_belly = rs_koti.getString("kt_belly");
                                                                    String kt_belly_loose = rs_koti.getString("kt_belly_loose");
                                                                    String kt_hip = rs_koti.getString("kt_hip");
                                                                    String kt_hip_loose = rs_koti.getString("kt_hip_loose");
                                                                    String kt_shoulder = rs_koti.getString("kt_shoulder");
                                                                    //String kt_collar = rs_koti.getString("kt_collar");
                                                                    String kt_pocket = rs_koti.getString("kt_pocket");
                                                                    String kt_belt = rs_koti.getString("kt_belt");
                                                                    String kt_catelog_no = rs_koti.getString("kt_catelog_no");
                                                                    String kt_others = rs_koti.getString("kt_others");
                                                        %>
                                                        <div class="row">
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">লম্বা  </label>
                                                                <input type="text" class="form-control" name="kt_long" id="kt_long" <% if (kt_long != null) {%> value="<%= kt_long%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">বডি </label>
                                                                <input type="text" class="form-control" name="kt_body" id="kt_body" <% if (kt_body != null) {%> value="<%= kt_body%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পেট</label>
                                                                <input type="text" class="form-control" name="kt_belly" id="kt_belly" <% if (kt_belly != null) {%> value="<%= kt_belly%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ</label>
                                                                <input type="text" class="form-control" name="kt_hip" id="kt_hip" <% if (kt_hip != null) {%> value="<%= kt_hip%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">কাঁধ</label>
                                                                <input type="text" class="form-control" name="kt_shoulder" id="kt_shoulder" <% if (kt_shoulder != null) {%> value="<%= kt_shoulder%>"<%} %> maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                        </div>
                                                        <div class="row">                                                            
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">বডি লুজ</label>
                                                                <input type="text" class="form-control" name="kt_body_loose" id="kt_body_loose" <% if (kt_body_loose != null) {%> value="<%= kt_body_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পেট লুজ</label>
                                                                <input type="text" class="form-control" name="kt_belly_loose" id="kt_belly_loose" <% if (kt_belly_loose != null) {%> value="<%= kt_belly_loose%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">হিপ লুজ</label>
                                                                <input type="text" class="form-control" name="kt_hip_loose" id="kt_hip_loose" <% if (kt_hip_loose != null) {%> value="<%= kt_hip_loose%>"<%}%> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">পকেট</label>
                                                                <select name="kt_pocket" class="form-control" required="">
                                                                    <%
                                                                        if (kt_pocket != null) {
                                                                    %>
                                                                    <option value="<%=kt_pocket%>"><%=kt_pocket + " টি"%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                    
                                                                    <option value="1">1 টি</option>
                                                                    <option value="2">2 টি</option>
                                                                    <option value="3">3 টি</option>
                                                                    <option value="4">4 টি</option>                                                                    
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">বেল্ট</label>
                                                                <select name="kt_belt" class="form-control" required="">
                                                                    <%
                                                                        String kt_belt_status = null;
                                                                        if (kt_belt != null) {
                                                                            if (kt_belt.equals("1")) {
                                                                                kt_belt_status = "বেল্ট";
                                                                            } else if (kt_belt.equals("0")) {
                                                                                kt_belt_status = "নো বেল্ট";
                                                                            }
                                                                        }
                                                                        if (kt_belt != null) {
                                                                    %>
                                                                    <option value="<%=kt_belt%>"><%=kt_belt_status%></option>
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                    <option value="">Select</option>
                                                                    <%
                                                                        }
                                                                    %>                                                                   
                                                                    <option value="1">বেল্ট</option>
                                                                    <option value="0">নো বেল্ট</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="row">                                                            
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">অর্ডার</label>
                                                                <input type="text" class="form-control" name="kt_order_no" id="pht_long" value="<%=val%>" maxlength="5" style="margin-bottom: 8px;" readonly=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">সংখ্যা</label>
                                                                <%
                                                                    String kt_qty = null;
                                                                    try {
                                                                        String sql_koti_qty = "select * from ser_koti where order_id = '" + val + "' ";
                                                                        PreparedStatement pst_koti_qty = DbConnection.getConn(sql_koti_qty);
                                                                        ResultSet rs__koti_qty = pst_koti_qty.executeQuery();
                                                                        if (rs__koti_qty.next()) {
                                                                            kt_qty = rs__koti_qty.getString("qty");
                                                                        }
                                                                    } catch (Exception e) {
                                                                        out.println("kt qty " + e.toString());
                                                                    }
                                                                %>
                                                                <input type="text" class="form-control" name="kt_qty" id="kt_qty"  value="<%= kt_qty%>" maxlength="5" style="margin-bottom: 8px;" required=""/>
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label for="" class="control-label" style="margin-bottom: 0px">ক্যাটালগ নং</label>
                                                                <input type="text" class="form-control" name="kt_catelog_no" id="kt_catelog_no" <% if (kt_catelog_no != null) {%> value="<%=kt_catelog_no%>"<%} %> maxlength="5" style="margin-bottom: 8px;"/>
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <label for="" class="control-label" style="margin: 0px;">অনান্য   </label>
                                                                <input type='textbox' id="koti" class="text" style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                                                <textarea name="kt_other" id="output_koti" class="text"  style="margin : 1px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"><% if (kt_others != null) {%><%= kt_others%><%}%></textarea>
                                                            </div>
                                                            <input type="text" value="<%=customer_mobile_from_customer%>" name="customer_mobile" style="display: none" />
                                                        </div>                                                       
                                                        <div class="row">                            
                                                            <div class="col-sm-5">
                                                            </div>
                                                            <div class="col-sm-5" style="margin-top: 10px">
                                                                <input type="submit" class="btn btn-primary" id="btn_submit" value="Submit" />
                                                                <input type="reset" class="btn btn-danger" data-dismiss="modal"  value="Cancel" />
                                                            </div>
                                                        </div>
                                                        <%                                                                            }
                                                            } catch (Exception e) {
                                                                out.println("koti measurement " + e.toString());
                                                            }
                                                        %>
                                                    </form>
                                                </div>                                              
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                                <div class="para" style="width: 16%; margin-top: 8px; margin-left: 1.30%; display: none">
                                    <input type="text" class="form-control" name="delivary_date" id="delivary_date"  required=""/>  <span class="" id="dd" style="color: red; display: none">Required Delivery Date</span>                           
                                </div>

                                <div style="margin-top: 8px; margin-left: 15px">
                                    <a href="javascript:void(0)" class="btn btn-danger btn-sm link" onclick="openback();">Finish Order and Print</a>
                                </div>
                            </div>
                        </div>                                                    <!-- /. PAGE INNER  -->
                    </div>                                                    <!-- /. PAGE WRAPPER  -->
                </div>
            </div>
        </div>        
        <script  type="text/javascript">
            $(function () {
                $("#delivary_date").datepicker({
                    dateFormat: "yy-mm-dd",
                    minDate: 0
                });
            });

            function openback() {
            <%
                if (shirt_long == null) {
            %>
                alert("Please Take Shirt Measurement");
            <%
            } else if (pant_long == null) {
            %>
                alert("Please Take Pant Measurement");
            <%
            } else if (blazer_long == null) {
            %>
                alert("Please Take Blazer Measurement");
            <%
            } else if (photua_long == null) {
            %>
                alert("Please Take Photua Measurement");
            <%
            } else if (panjabi_long == null) {
            %>
                alert("Please Take Panjabi Measurement");
            <%
            } else if (payjama_long == null) {
            %>
                alert("Please Take Payjama Measurement");
            <%
            } else if (safari_long == null) {
            %>
                alert("Please Take Safari Measurement");
            <%
            } else if (mojib_cort_long == null) {
            %>
                alert("Please Take Mojib Cort Measurement");
            <%
            } else if (kable_long == null) {
            %>
                alert("Please Take Kable Measurement");
            <%
            } else if (koti_long == null) {
            %>
                alert("Please Take Koti Measurement");
            <%
            } else {
            %>
                $(".para").fadeIn("slow", function () {
                    var d_date = $("#delivary_date").val();
                    if (d_date === null || d_date === "") {
                        $("#dd").show("slow");
                        return false;
                    } else {
                        window.open('finish_order_print.jsp?ddate=' + d_date, '_blank', 'location=yes,height=570,width=720,scrollbars=yes,status=yes');
                    }
                });
            <%
                }
            %>
            }
            $(function () {
                var ddate = $("#delivary_date").val();
                if (ddate.length > 0) {
                    $("#dd").hide();
                }
            });

            function shirt_validation() {
                var srt_long = $("#srt_long").val();
                var srt_body = $("#srt_body").val();
                var srt_body_loose = $("#srt_body_loose").val();
                var srt_hip = $("#srt_hip").val();
                var srt_shoulder = $("#srt_shoulder").val();
                var srt_neck = $("#srt_neck").val();
                var srt_bally = $("#srt_bally").val();
                var srt_hand_cuff = $("#srt_hand_cuff").val();
                var srt_hand_kuni = $("#srt_hand_kuni").val();
                var srt_hand_moja = $("#srt_hand_moja").val();
                var srt_hand_long = $("#srt_hand_long").val();
                var srt_type = $("#srt_type").val();
                var srt_plet = $("#srt_plet").val();
                var srt_collar = $("#srt_collar").val();
                var srt_collar_size = $("#srt_collar_size").val();
                var srt_cuff_size = $("#srt_cuff_size").val();
                var pocket = $("#pocket").val();
                var pocket_inner = $("#pocket_inner").val();
                //  var srt_hip = $("#pocket_inner").val();
                var srt_number = $("#srt_number").val();
                var srt_catelog_no = $("#srt_catelog_no").val();

                if (isNaN(srt_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_long').focus();                    
                    return false;
                }
                if (isNaN(srt_body)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_body').focus();                    
                    return false;
                }
                if (isNaN(srt_body_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_body_loose').focus();                    
                    return false;
                }
                if (isNaN(srt_hip)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_hip').focus();                    
                    return false;
                }
                if (isNaN(srt_shoulder)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_shoulder').focus();                    
                    return false;
                }
                if (isNaN(srt_neck)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_neck').focus();                    
                    return false;
                }
                if (isNaN(srt_bally)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_bally').focus();                    
                    return false;
                }
                if (isNaN(srt_hand_cuff)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_hand_cuff').focus();                    
                    return false;
                }
                if (isNaN(srt_hand_kuni)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_hand_kuni').focus();                    
                    return false;
                }
                if (isNaN(srt_hand_moja)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_hand_moja').focus();                    
                    return false;
                }
                if (isNaN(srt_hand_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_hand_long').focus();                    
                    return false;
                }
                if (isNaN(srt_plet)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_plet').focus();                    
                    return false;
                }
                if (isNaN(srt_collar)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_collar').focus();                    
                    return false;
                }
                if (isNaN(srt_collar_size)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_collar_size').focus();                    
                    return false;
                }
                if (isNaN(srt_cuff_size)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_cuff_size').focus();                    
                    return false;
                }
                if (isNaN(pocket)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pocket').focus();                    
                    return false;
                }
                if (isNaN(pocket_inner)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pocket_inner').focus();                    
                    return false;
                }
                if (isNaN(srt_number)) {
                    alert("Please Enter Number Only");
                    document.getElementById('srt_number').focus();                    
                    return false;
                }
            }
            function pant_validation() {
                var pnt_long = $("#pant_long").val();
                var pant_comor = $("#pant_comor").val();
                var pnt_muhuri = $("#pnt_muhuri").val();
                var pnt_run = $("#pnt_run").val();
                var pnt_high = $("#pnt_high").val();
                var pnt_hip = $("#pnt_hip").val();
                var pnt_fly = $("#pnt_fly").val();
                var pnt_number = $("#pnt_number").val();

                if (isNaN(pnt_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pant_long').focus();
                    return false;
                }
                if (isNaN(pant_comor)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pant_comor').focus();
                    return false;
                }
                if (isNaN(pnt_muhuri)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnt_muhuri').focus();
                    return false;
                }
                if (isNaN(pnt_run)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnt_run').focus();
                    return false;
                }
                if (isNaN(pnt_high)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnt_high').focus();
                    return false;
                }
                if (isNaN(pnt_hip)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnt_hip').focus();
                    return false;
                }
                if (isNaN(pnt_fly)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnt_fly').focus();
                    return false;
                }
                if (isNaN(pnt_number)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnt_number').focus();
                    return false;
                }

//                if (isNaN(pnt_long) || isNaN(pant_comor) || isNaN(pnt_muhuri) || isNaN(pnt_run) || isNaN(pnt_high) || isNaN(pnt_hip) || isNaN(pnt_fly) || isNaN(pnt_number)) {
//                    alert("Please Enter Number Only");
//                    return false;
//                }
            }
            function blazer_validation() {
                var blz_long = $("#blz_long").val();
                var blz_body = $("#blz_body").val();
                var blz_bally = $("#blz_bally").val();
                var blz_hip = $("#blz_hip").val();
                var blz_shoulder = $("#blz_shoulder").val();
                var blz_hand_long = $("#blz_hand_long").val();
                var blz_mohuri = $("#blz_mohuri").val();
                var blz_crass_back = $("#blz_crass_back").val();
                var blz_qty = $("#blz_qty").val();

                if (isNaN(blz_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('blz_long').focus();
                    return false;
                }
                if (isNaN(blz_body)) {
                    alert("Please Enter Number Only");
                    document.getElementById('blz_body').focus();
                    return false;
                }
                if (isNaN(blz_bally)) {
                    alert("Please Enter Number Only");
                    document.getElementById('blz_bally').focus();
                    return false;
                }
                if (isNaN(blz_hip)) {
                    alert("Please Enter Number Only");
                    document.getElementById('blz_hip').focus();
                    return false;
                }
                if (isNaN(blz_shoulder)) {
                    alert("Please Enter Number Only");
                    document.getElementById('blz_shoulder').focus();
                    return false;
                }
                if (isNaN(blz_hand_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('blz_hand_long').focus();
                    return false;
                }
                if (isNaN(blz_mohuri)) {
                    alert("Please Enter Number Only");
                    document.getElementById('blz_mohuri').focus();
                    return false;
                }
                if (isNaN(blz_crass_back)) {
                    alert("Please Enter Number Only");
                    document.getElementById('blz_crass_back').focus();
                    return false;
                }
                if (isNaN(blz_qty)) {
                    alert("Please Enter Number Only");
                    document.getElementById('blz_qty').focus();
                    return false;
                }

//                if (isNaN(blz_long) || isNaN(blz_bally) || isNaN(blz_body) || isNaN(blz_hip) || isNaN(blz_shoulder) || isNaN(blz_hand_long) || isNaN(blz_mohuri) || isNaN(blz_crass_back) || isNaN(blz_qty)) {
//                    alert("Please Enter Number Only");
//                    return  false;
//                }
            }

            function photua_validation() {
                var pht_long = $("#pht_long").val();
                var pht_body = $("#pht_body").val();
                var pht_body_loose = $("#pht_body_loose").val();
                var pht_hip = $("#pht_hip").val();
                var pht_shoulder = $("#pht_shoulder").val();
                var pht_neck = $("#pht_neck").val();
                var pht_bally = $("#pht_bally").val();
                var pht_hand_cuff = $("#pht_hand_cuff").val();
                var pht_hand_konu = $("#pht_hand_konu").val();
                var pht_hand_moja = $("#pht_hand_moja").val();
                var pht_hand_long = $("#pht_hand_long").val();
                var pht_number = $("#pht_number").val();

                if (isNaN(pht_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_long').focus();
                    return false;
                }
                if (isNaN(pht_body)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_body').focus();
                    return false;
                }
                if (isNaN(pht_body_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_body_loose').focus();
                    return false;
                }
                if (isNaN(pht_hip)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_hip').focus();
                    return false;
                }
                if (isNaN(pht_shoulder)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_shoulder').focus();
                    return false;
                }
                if (isNaN(pht_neck)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_neck').focus();
                    return false;
                }
                if (isNaN(pht_bally)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_bally').focus();
                    return false;
                }
                if (isNaN(pht_hand_cuff)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_hand_cuff').focus();
                    return false;
                }
                if (isNaN(pht_hand_konu)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_hand_konu').focus();
                    return false;
                }
                if (isNaN(pht_hand_moja)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_hand_moja').focus();
                    return false;
                }
                if (isNaN(pht_hand_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_hand_long').focus();
                    return false;
                }
                if (isNaN(pht_number)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pht_number').focus();
                    return false;
                }
//                if (isNaN(pht_long) || isNaN(pht_body) || isNaN(pht_body_loose) || isNaN(pht_hip) || isNaN(pht_shoulder) || isNaN(pht_neck)
//                        || isNaN(pht_bally) || isNaN(pht_hand_cuff) || isNaN(pht_hand_konu) || isNaN(pht_hand_moja) || isNaN(pht_hand_long) || isNaN(pht_number)) {
//                    alert("Please Enter Number Only");                    
//                    return false;
//                }
            }
            function koti_validation() {
                var kt_long = $("#kt_long").val();
                var kt_body = $("#kt_body").val();
                var kt_belly = $("#kt_belly").val();
                var kt_hip = $("#kt_hip").val();
                var kt_shoulder = $("#kt_shoulder").val();
               // var kt_neck = $("#kt_neck").val();
                var kt_body_loose = $("#kt_body_loose").val();
                var kt_belly_loose = $("#kt_belly_loose").val();
                var kt_hip_loose = $("#kt_hip_loose").val();
                var kt_qty = $("#kt_qty").val();
                if (isNaN(kt_qty)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kt_qty').focus();
                    return false;
                }
                if (isNaN(kt_hip_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kt_hip_loose').focus();
                    return false;
                }
                if (isNaN(kt_belly_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kt_belly_loose').focus();
                    return false;
                }
                if (isNaN(kt_body_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kt_body_loose').focus();
                    return false;
                }
               
                if (isNaN(kt_shoulder)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kt_shoulder').focus();
                    return false;
                }
                if (isNaN(kt_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kt_long').focus();
                    return false;
                }
                if (isNaN(kt_body)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kt_body').focus();
                    return false;
                }
                if (isNaN(kt_belly)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kt_belly').focus();
                    return false;
                }
                if (isNaN(kt_hip)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kt_hip').focus();
                    return false;
                }
            }

            function mojib_cort_validation() {
                var mjc_long = $("#mjc_long").val();
                var mjc_body = $("#mjc_body").val();
                var mjc_belly = $("#mjc_belly").val();
                var mjc_hip = $("#mjc_hip").val();
                var mjc_shoulder = $("#mjc_shoulder").val();
                var mjc_nect = $("#mjc_nect").val();
                var mjc_body_loose = $("#mjc_body_loose").val();
                var mjc_belly_loose = $("#mjc_belly_loose").val();
                var mjc_hip_loose = $("#mjc_hip_loose").val();
                var mjc_qty = $("#mjc_qty").val();

                if (isNaN(mjc_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('mjc_long').focus();
                    return false;
                }
                if (isNaN(mjc_body)) {
                    alert("Please Enter Number Only");
                    document.getElementById('mjc_body').focus();
                    return false;
                }
                if (isNaN(mjc_belly)) {
                    alert("Please Enter Number Only");
                    document.getElementById('mjc_belly').focus();
                    return false;
                }
                if (isNaN(mjc_hip)) {
                    alert("Please Enter Number Only");
                    document.getElementById('mjc_hip').focus();
                    return false;
                }
                if (isNaN(mjc_shoulder)) {
                    alert("Please Enter Number Only");
                    document.getElementById('mjc_shoulder').focus();
                    return false;
                }
                if (isNaN(mjc_nect)) {
                    alert("Please Enter Number Only");
                    document.getElementById('mjc_nect').focus();
                    return false;
                }
                if (isNaN(mjc_body_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('mjc_body_loose').focus();
                    return false;
                }
                if (isNaN(mjc_belly_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('mjc_belly_loose').focus();
                    return false;
                }
                if (isNaN(mjc_hip_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('mjc_hip_loose').focus();
                    return false;
                }
                if (isNaN(mjc_qty)) {
                    alert("Please Enter Number Only");
                    document.getElementById('mjc_qty').focus();
                    return false;
                }
            }

            function kable_validation() {
                var kbl_long = $("#kbl_long").val();
                var kbl_body = $("#kbl_body").val();
                var kbl_belly = $("#kbl_belly").val();
                var kbl_hip = $("#kbl_hip").val();
                var kbl_shoulder = $("#kbl_shoulder").val();
                var kbl_hand_long = $("#kbl_hand_long").val();
                var kbl_muhuri = $("#kbl_muhuri").val();
                var kbl_neck = $("#kbl_neck").val();
                var kbl_body_loose = $("#kbl_body_loose").val();
                var kbl_belly_loose = $("#kbl_belly_loose").val();
                var kbl_hip_loose = $("#kbl_hip_loose").val();
                var kbl_collar_size = $("#kbl_collar_size").val();
                var kbl_qty = $("#kbl_qty").val();

                if (isNaN(kbl_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_long').focus();
                    return false;
                }
                if (isNaN(kbl_body)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_body').focus();
                    return false;
                }
                if (isNaN(kbl_belly)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_belly').focus();
                    return false;
                }
                if (isNaN(kbl_hip)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_hip').focus();
                    return false;
                }
                if (isNaN(kbl_shoulder)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_shoulder').focus();
                    return false;
                }
                if (isNaN(kbl_hand_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_hand_long').focus();
                    return false;
                }
                if (isNaN(kbl_muhuri)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_muhuri').focus();
                    return false;
                }
                if (isNaN(kbl_neck)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_neck').focus();
                    return false;
                }
                if (isNaN(kbl_body_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_body_loose').focus();
                    return false;
                }
                if (isNaN(kbl_belly_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_belly_loose').focus();
                    return false;
                }
                if (isNaN(kbl_hip_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_hip_loose').focus();
                    return false;
                }
                if (isNaN(kbl_collar_size)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_collar_size').focus();
                    return false;
                }
                if (isNaN(kbl_qty)) {
                    alert("Please Enter Number Only");
                    document.getElementById('kbl_qty').focus();
                    return false;
                }
            }

            function safari_validation() {
                var sfr_long = $("#sfr_long").val();
                var sfr_body = $("#sfr_body").val();
                var sfr_belly = $("#sfr_belly").val();
                var sfr_hip = $("#sfr_hip").val();
                var sfr_shoulder = $("#sfr_shoulder").val();
                var sfr_crossback = $("#sfr_crossback").val();
                var sfr_hand_long = $("#sfr_hand_long").val();
                var sfr_cup = $("#sfr_cup").val();
                var sfr_neck = $("#sfr_neck").val();
                var sfr_body_loose = $("#sfr_body_loose").val();
                var sfr_belly_loose = $("#sfr_belly_loose").val();
                var sfr_hip_loose = $("#sfr_hip_loose").val();
                
                var sfr_catelog_no = $("#sfr_catelog_no").val();

                if (isNaN(sfr_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_long').focus();
                    return false;
                }
                if (isNaN(sfr_body)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_body').focus();
                    return false;
                }
                if (isNaN(sfr_belly)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_belly').focus();
                    return false;
                }
                if (isNaN(sfr_hip)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_hip').focus();
                    return false;
                }
                if (isNaN(sfr_shoulder)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_shoulder').focus();
                    return false;
                }
                if (isNaN(sfr_crossback)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_crossback').focus();
                    return false;
                }
                if (isNaN(sfr_hand_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_hand_long').focus();
                    return false;
                }
                if (isNaN(sfr_cup)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_cup').focus();
                    return false;
                }
                if (isNaN(sfr_neck)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_neck').focus();
                    return false;
                }
                if (isNaN(sfr_body_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_body_loose').focus();
                    return false;
                }
                if (isNaN(sfr_belly_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_belly_loose').focus();
                    return false;
                }
                if (isNaN(sfr_hip_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('sfr_hip_loose').focus();
                    return false;
                }
            }

            function payjama_validation() {
                var pjma_long = $("#pjma_long").val();
                var pjma_comor = $("#pjma_comor").val();
                var pjma_hip = $("#pjma_hip").val();
                var pjma_muhuri = $("#pjma_muhuri").val();
                var pjma_thai = $("#pjma_thai").val();
                var pjma_fly = $("#pjma_fly").val();
                var pjma_high = $("#pjma_high").val();
                var pjma_hip_loose = $("#pjma_hip_loose").val();
                var pjma_qty = $("#pjma_qty").val();

                if (isNaN(pjma_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pjma_long').focus();
                    return false;
                }
                if (isNaN(pjma_comor)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pjma_comor').focus();
                    return false;
                }
                if (isNaN(pjma_hip)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pjma_hip').focus();
                    return false;
                }
                if (isNaN(pjma_muhuri)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pjma_muhuri').focus();
                    return false;
                }
                if (isNaN(pjma_thai)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pjma_thai').focus();
                    return false;
                }
                if (isNaN(pjma_fly)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pjma_fly').focus();
                    return false;
                }
                if (isNaN(pjma_high)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pjma_high').focus();
                    return false;
                }
                if (isNaN(pjma_hip_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pjma_hip_loose').focus();
                    return false;
                }
                if (isNaN(pjma_qty)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pjma_qty').focus();
                    return false;
                }
            }

            function panjabi_validation() {
                var pnjb_long = $("#pnjb_long").val();
                var pnjb_body = $("#pnjb_body").val();
                var pnjb_belly = $("#pnjb_belly").val();
                var pnjb_hip = $("#pnjb_hip").val();
                var pnjb_shoulder = $("#pnjb_shoulder").val();
                var pnjb_hand_long = $("#pnjb_hand_long").val();
                var pnjb_muhuri = $("#pnjb_muhuri").val();
                var pnjb_neck = $("#pnjb_neck").val();
                var pnjb_body_loose = $("#pnjb_body_loose").val();
                var pnjb_belly_loose = $("#pnjb_belly_loose").val();
                var pnjb_hip_loose = $("#pnjb_hip_loose").val();
                var pnjb_collar_size = $("#pnjb_collar_size").val();
                var pnjb_qty = $("#pnjb_qty").val();

                if (isNaN(pnjb_qty)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_qty').focus();
                    return false;
                }
                if (isNaN(pnjb_hip_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_hip_loose').focus();
                    return false;
                }
                if (isNaN(pnjb_belly_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_belly_loose').focus();
                    return false;
                }
                if (isNaN(pnjb_body_loose)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_body_loose').focus();
                    return false;
                }
                if (isNaN(pnjb_neck)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_neck').focus();
                    return false;
                }
                if (isNaN(pnjb_muhuri)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_muhuri').focus();
                    return false;
                }
                if (isNaN(pnjb_hand_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_hand_long').focus();
                    return false;
                }
                if (isNaN(pnjb_shoulder)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_shoulder').focus();
                    return false;
                }
                if (isNaN(pnjb_hip)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_hip').focus();
                    return false;
                }
                if (isNaN(pnjb_belly)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_belly').focus();
                    return false;
                }
                if (isNaN(pnjb_body)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_body').focus();
                    return false;
                }
                if (isNaN(pnjb_long)) {
                    alert("Please Enter Number Only");
                    document.getElementById('pnjb_long').focus();
                    return false;
                }
            }


        </script>
        <!--        <script src="assets/js/bootstrap.min.js"></script>   
                <script src="assets/js/jquery-1.10.2.js"></script>   
                <script src="assets/js/jquery.metisMenu.js"></script>     
                <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
                <script src="assets/js/morris/morris.js"></script>   
                <script src="assets/js/custom.js"></script>      -->
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script> 
        <script src="/Tailor/admin/assets/js/custom.js"></script>   
    </body>
</html>
