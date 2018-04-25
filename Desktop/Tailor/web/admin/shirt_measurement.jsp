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
            <jsp:include page="../menu/menu.jsp"/>
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

                                <form accept-charset="language="java contentType="text/html; charset=utf-8" pageEncoding="UTF-8" action="../Shirt_Measurements" method="post">
                                    <%                                     try {

                                            String sql = "select * from ser_shirt where order_id = " + val;
                                            PreparedStatement pst = DbConnection.getConn(sql);
                                            ResultSet rs = pst.executeQuery();
                                            while (rs.next()) {
                                                String srt_long_d = rs.getString(6);
                                                String srt_body_d = rs.getString(7);
                                                String srt_body_lose_d = rs.getString(8);
                                                String srt_hip_d = rs.getString(10);
                                                String srt_shoulder_d = rs.getString(11);
                                                String srt_neck_d = rs.getString(12);
                                                String srt_bally_d = rs.getString(9);
                                                String srt_hand_cuff_d = rs.getString(16);
                                                String srt_hnd_qunu_d = rs.getString(15);
                                                String srt_hnd_moja_d = rs.getString(14);
                                                String srt_hnd_long_d = rs.getString(13);
                                                String srt_types = rs.getString(17);
                                                String srt_plet = rs.getString(18);
                                                String srt_collar = rs.getString(19);
                                                String srt_collar_size = rs.getString(20);
                                                String srt_cuff_size = rs.getString(21);
                                                String srt_pocket = rs.getString(22);
                                                String srt_pocket_inner = rs.getString(23);
                                                String srt_shirt_cate_num_d = rs.getString(26);
                                                String srt_others = rs.getString(27);
                                    %>
                                    <div class="row">                            
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px">লম্বা  </label>
                                            <input type="text" class="form-control" name="srt_long" id="long" placeholder="14 1/8"  <% if (srt_long_d != null) {%> value="<%= srt_long_d%>" <%} %> style="margin-bottom: 8px; text-align: center" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">বডি</label>
                                            <input type="text" class="form-control" name="srt_body" id="body" placeholder=""  <% if (srt_body_d != null) {%> value="<%= srt_body_d%>" <%} %> style="margin-bottom: 8px; text-align: center" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">বডি লুজ</label>
                                            <input type="text" class="form-control" name="srt_body_loose" id="body_loose" <% if (srt_body_lose_d != null) {%> value="<%= srt_body_lose_d%>" <%} %>  style="margin-bottom: 8px; text-align: center" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">হিপ</label>
                                            <input type="text" class="form-control" name="srt_hip" id="hip" placeholder=""  <% if (srt_hip_d != null) {%> value="<%= srt_hip_d%>" <%} %>  style="margin-bottom: 8px; text-align: center" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">কাধ</label>
                                            <input type="text" class="form-control" name="srt_shoulder" id="shoulder" placeholder="" <% if (srt_shoulder_d != null) {%> value="<%= srt_shoulder_d%>" <%} %> style="margin-bottom: 8px; text-align: center" required=""/>
                                        </div>
                                    </div>
                                    <div class="row">                            
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">গলা</label>
                                            <input type="text" class="form-control" name="srt_neck" id="neck" <% if (srt_neck_d != null) {%> value="<%= srt_neck_d%>" <%} %> style="margin-bottom: 8px; text-align: center" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">পেট </label>
                                            <input type="text" class="form-control" name="srt_bally" id="pet" placeholder="" <% if (srt_bally_d != null) {%> value="<%= srt_bally_d%>" <%} %> style="margin-bottom: 8px; text-align: center" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">হাতা কাপ</label>
                                            <input type="text" class="form-control" name="srt_hand_cuff" id="hand_cuff" <% if (srt_hand_cuff_d != null) {%> value="<%= srt_hand_cuff_d%>" <%} %>  style="margin-bottom: 8px; text-align: center" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">হাতা কুনু</label>
                                            <input type="text" class="form-control" name="srt_hand_kuni" id="hand_konu" <% if (srt_hnd_qunu_d != null) {%> value="<%= srt_hnd_qunu_d%>" <%} %> style="margin-bottom: 8px; text-align: center"  required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin-bottom: 0px;">হাতা মোজা</label>
                                            <input type="text" class="form-control" name="srt_hand_moja" id="hand_moja" <% if (srt_hnd_moja_d != null) {%> value="<%= srt_hnd_moja_d%>" <%} %>  style="margin-bottom: 8px; text-align: center" required=""/>
                                        </div>
                                    </div> 
                                    <div class="row">                            
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">হাতা লম্বা  </label>
                                            <input type="text" class="form-control" name="srt_hand_long" id="hand_long" <% if (srt_hnd_long_d != null) {%> value="<%= srt_hnd_long_d%>" <%}%>  style="margin-bottom: 8px; text-align: center" required=""/>
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
                                            <select name="srt_plet" class="plet" id="srt_plet" style="width: 100%; height: 30px" required="">
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
                                            <select name="srt_collar_size" style="width: 100%; height: 30px;" required="">
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
                                    </div>
                                    <div class="row">  
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">কাফ সাইজ</label>
                                            <select name="srt_cuff_size" style="width: 100%; height: 30px; text-align: center" required="">
                                                <%
                                                    String cuff_size = null;
                                                    if (srt_cuff_size != null) {
                                                        if (srt_cuff_size.equals("1.5")) {
                                                            cuff_size = "1.5";
                                                        } else if (srt_cuff_size.equals("1.75")) {
                                                            cuff_size = "1.75";
                                                        } else if (srt_cuff_size.equals("2")) {
                                                            cuff_size = "2.00";
                                                        } else if (srt_cuff_size.equals("2.25")) {
                                                            cuff_size = "2.25";
                                                        } else if (srt_cuff_size.equals("2.5")) {
                                                            cuff_size = "2.5";
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
                                            <select name="pocket" class="pocketdmo" style="width: 100%; height: 30px" required="">
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
                                            <select name="pocket_inner" class="innerpocket" style="width: 100%; height: 30px" required="">
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
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">জামার সংখ্যা  </label>
                                            <input type="text" class="form-control" name="srt_number" id="srt_number" value="<%= rs.getString("qty")%>" style="margin-bottom: 8px; text-align: center" required=""/>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">কেটালগ নং</label>
                                            <input type="text" class="form-control" name="srt_catelog_no" id="srt_catelog_no" placeholder="" <% if (srt_shirt_cate_num_d != null) {%> value="<%= srt_shirt_cate_num_d%>" <%}%> style="margin-bottom: 8px; text-align: center" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="" class="control-label" style="margin: 0px;">অনান্য   </label>
                                            <input type='textbox' id="transl1" class="text" style="font-size: 36px; display: none; font-family: SolaimanLipi;" />
                                            <textarea name="srt_other" id="output" class="text"  style="margin : 1px 1px 0 0; color:black; width: 100%; height: 70px; font-size:24px; padding:6px; padding-top: 0px; font-family: SolaimanLipi; background-color:#FFFFFF; resize: none"> <% if (srt_others != null) {%> <%= srt_others%><% }%></textarea>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">order no</label>
                                            <input type="text" class="form-control" name="order_no" id="order_no" value="<%= rs.getString(5)%>" style="margin-bottom: 8px; text-align: center"readonly="" />
                                        </div>
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
