
<%@page import="connection.DbConnection"%>
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
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

            <jsp:include page="../menu/menu.jsp" flush="true"/>

            <div id="page-wrapper">
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Pant Measurements
                                <%
                                    int val = 0;
                                    String order_id_pant = request.getParameter("order_id_pant");
                                    if (session.getAttribute("ord_id") != null) {
                                        val = (Integer) session.getAttribute("ord_id");
                                    }

                                    if (order_id_pant != "" || order_id_pant != null) {
                                        try {
                                            val = Integer.parseInt(order_id_pant);
                                            out.println(val);
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    }

                                %>
                            </div>
                            <div class="panel-body">
                                <form action="../Pant_Measurements" method="post">
                                    <%                                        String sql = "select * from ser_pant where order_id = " + val;
                                        PreparedStatement pst = DbConnection.getConn(sql);
                                        ResultSet rs = pst.executeQuery();
                                        while (rs.next()) {
                                            String pnt_order_id = rs.getString(5);
                                            String pnt_long = rs.getString(6);
                                            String pnt_komor = rs.getString(7);
                                            String pnt_hip = rs.getString(8);
                                            String pnt_muhuri = rs.getString(9);
                                            String pnt_run = rs.getString(10);
                                            String pnt_high = rs.getString(11);
                                            String pnt_fly = rs.getString(12);
                                            String pnt_kuci = rs.getString(13);
                                            String pnt_pocket_type = rs.getString(14);
                                            String pnt_pocket_backside = rs.getString(15);
                                            String pnt_pocket_inner = rs.getString(16);
                                            String pnt_mohuri_type = rs.getString(17);
                                            String pnt_loop = rs.getString(18);
                                            String pnt_loop_size = rs.getString(19);
                                            String pnt_catelog_no = rs.getString(21);
                                            String pnt_others = rs.getString(22);
                                            String pnt_qty = rs.getString(23);
                                    %>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">লম্বা  <%= val%></label>
                                            <input type="text" class="form-control" name="pnt_long" id="pant_long" <% if (pnt_long != null) {%> value="<%= pnt_long%>" <%} %> placeholder="14 1/8''" style="margin-bottom: 10px"/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label"  style="margin-bottom: 0px">কোমর</label>
                                            <input type="text" class="form-control" name="pant_comor" id="pant_comor" <% if (pnt_komor != null) {%> value="<%= pnt_komor%>" <%} %> placeholder=""/>
                                        </div>
                                        <div class="col-sm-2" style="margin-bottom: 0px;">
                                            <label for="" class="control-label"  style="margin-bottom: 0px">মুহুরি</label>
                                            <input type="text" class="form-control" name="pnt_muhuri" id="pnt_muhuri" <% if (pnt_muhuri != null) {%> value="<%= pnt_muhuri%>" <%} %> placeholder=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label"  style="margin-bottom: 0px">রান</label>
                                            <input type="text" class="form-control" name="pnt_run" id="pnt_run" <% if (pnt_run != null) {%> value="<%= pnt_run%>" <%} %> placeholder=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label"  style="margin-bottom: 0px">হাই</label>
                                            <input type="text" class="form-control" name="pnt_high" id="pnt_high" <% if (pnt_high != null) {%> value="<%= pnt_high%>" <%} %> />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <label for="" class="control-label"  style="margin-bottom: 0px">ফ্লাই</label>
                                            <input type="text" class="form-control" name="pnt_fly" id="pnt_fly" placeholder="" <% if (pnt_fly != null) {%> value="<%= pnt_fly%>" <%} %> style="margin-bottom: 10px"/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label"  style="margin-bottom: 0px">হিপ</label>
                                            <input type="text" class="form-control" name="pnt_hip"  <% if (pnt_hip != null) {%> value="<%= pnt_hip%>" <%} %> />
                                        </div>
                                        <div class="col-sm-2" style="margin:0px">
                                            <label for="" class="control-label" style="margin: 0px">পকেট</label>
                                            <select name="pnt_pocket_type" style="width: 100%; height: 35px">
                                                <option value="0">ক্র্স</option>
                                                <option value="1">সোজা</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2" style="margin:0px">
                                            <label for="" class="control-label" style="margin: 0px">পকেট পিছ্নে</label>
                                            <select name="pnt_pocket_back" style="width: 100%; height: 35px">
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2" style="margin:0px">
                                            <label for="" class="control-label" style="margin: 0px">ইনার পকেট</label>
                                            <select name="pnt_pocket_inner" style="width: 100%; height: 35px">
                                                <option value="1"> হ্যা  </option>
                                                <option value="0">না</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px">মুহুরি</label>                                                                                    
                                            <select name="pnt_muhuri_type" style="width: 100%; height: 35px">
                                                <option value="1">ফ্লাডিং</option>
                                                <option value="2">নর্মাল</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label"style="margin: 0px">লুপ</label>
                                            <select name="pnt_loop" style="width: 100%; height: 35px">
                                                <option value="6">6 টা</option>
                                                <option value="7">7 টা</option>
                                                <option value="8">8 টা</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px">লুপ সাইড</label>
                                            <select name="pnt_loop_side" style="width: 100%; height: 35px">
                                                <option>0.25</option>
                                                <option>0.50</option>
                                                <option>0.75</option>
                                                <option>1.00</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2">   
                                            <label style="margin: 0px">কেটালগ নং</label>
                                            <input type="text" class="form-control" name="pnt_catelog_no" placeholder="" <% if (pnt_catelog_no != null) {%> value="<%= pnt_catelog_no%>" <%}%> style="margin-bottom: 10px">
                                        </div>

                                        <div class="col-sm-2" style="margin-top: 0px">
                                            <label for="" class="control-label" style="margin: 0px">কুচি&nbsp;</label>

                                            <select name="pnt_is_kuci" style="width: 100%; height: 35px" style="margin-bottom: 10px">
                                                <option value="1">হ্যা </option>
                                                <option value="0">না</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="" class="control-label" style="margin-top: 8px;">অনান্য   </label>
                                            <input type='textbox' id="transl1" class="text"  style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                            <textarea name="pnt_other" id="output" class="text"   style="margin : 1px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"></textarea>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">Order id </label>
                                            <input type="text" class="form-control" name="pnt_order_id" value="<%= pnt_order_id%>" id="pant_long" placeholder="" readonly="" style="margin-bottom: 10px"/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">Pnt_number</label>
                                            <input type="text" class="form-control" name="pnt_number" value="<%= pnt_qty%>" id="pant_long" placeholder="" style="margin-bottom: 10px"/>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-12" style="margin-top: 10px">
                                            <center>
                                                <input type="submit" class="btn btn-primary" value="Submit"/>
                                                <input type="reset" class="btn btn-danger" value="Cancel"/>
                                            </center>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
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
