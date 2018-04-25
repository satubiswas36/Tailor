
<%
    String logger = (String) session.getAttribute("logger");
    String branch_id = (String) session.getAttribute("user_bran_id");
    String last_status = null;
    String sl_no = null;
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
                response.sendRedirect("../index.jsp");
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
    <head>
        <title>Tailor</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta charset="utf-8"/>
        <meta contenteditable="utf8_general_ci"/>
        <!--        <meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="shortcut icon" type="image/x-icon" href="../admin/assets/img/t_mechin.jpg"/>
        <link href="/Tailor/admin/assets/css/bootstrap.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/css/font-awesome.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />       
        <link href="/Tailor/admin/assets/css/custom.css" rel="stylesheet" />      
        <link href="/Tailor/admin/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />        
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script src="http://mymaplist.com/js/vendor/TweenLite.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
        <link rel="stylesheet" href="/resources/demos/style.css"/>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <!--      for time picker-->
        <link href="../admin/assets/css/timedropper.css" rel="stylesheet" type="text/css"/>
        <script src="../admin/assets/js/timedropper.js" type="text/javascript"></script>
        <!--    <script src="../admin/assets/js/jquery.js" type="text/javascript"></script>-->

        <!------------------- select2-------------------------------->
        <script src="/Tailor/admin/assets/js/jquery.js" type="text/javascript"></script>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.css" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.js"></script>
        <!------------------- select2----------end---------------------->
    </head>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp" flush="true"/> 
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <aside class="right-side">
                        <section class="content">
                            <div class="row">
                                <div class="col-xs-6">
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title"> </h3>
                                            <%
                                                String bran_id = (String) session.getAttribute("user_bran_id");
                                                String user_id = (String) session.getAttribute("user_user_id");
                                                if (user_id == null) {
                                                    user_id = bran_id;
                                                }
                                                String sessionID = null;
                                            %>
                                        </div>
                                        <%
                                            // --------------------------------------user er id er sate match kore last status check --------------------------------------------------------------------
                                            String sql_check_last_statuse_user = "select * from ad_order where ord_user_id = '" + user_id + "' and ord_status = 1";
                                            PreparedStatement pst_check_last_statuse_user = DbConnection.getConn(sql_check_last_statuse_user);
                                            ResultSet rs_check_last_statuse_user = pst_check_last_statuse_user.executeQuery();
                                            if (rs_check_last_statuse_user.next()) {
                                                String incomplete_order = rs_check_last_statuse_user.getString("ord_bran_order");
                                                session.setAttribute("ord_id", Integer.parseInt(incomplete_order));
                                        %>
                                        <h2>Already <%= incomplete_order%> Pending a Order<a href="take_measure_for_order.jsp" style="text-decoration: none">Click</a> to complete Pending One</h2>
                                        <%
                                        } else {
                                        %>
                                        <div class="box-body table-responsive">
                                            <%
                                                Calendar cl = Calendar.getInstance();
                                                int year = cl.get(Calendar.YEAR);
                                                int month = cl.get(Calendar.MONTH) + 1;
                                                int day = cl.get(Calendar.DATE);
                                                int hour = cl.get(Calendar.HOUR);
                                                int minute = cl.get(Calendar.MINUTE);
                                                int second = cl.get(Calendar.SECOND);
                                                int milisecond = cl.get(Calendar.MILLISECOND);
                                                sessionID = month + "" + day + "" + hour + "" + minute + "" + second + "" + milisecond;

                                            %>

                                            <%                                                        PreparedStatement pst = null;
                                                ResultSet rs = null;
                                            %>
                                            <%
                                                try {
                                                    String sql_check = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                                    PreparedStatement pst_check = DbConnection.getConn(sql_check);
                                                    ResultSet rs_check = pst_check.executeQuery();
                                                    if (rs_check.next()) {
                                            %>
                                            <table id="DataTable" class="table table-bordered table-hover table-responsive" >
                                                <thead>
                                                    <tr>
                                                        <th style="text-align: center" id="Sl">Sl</th>
                                                        <th style="text-align: center" id="Name">Name</th>
                                                        <th style="text-align: center" id="Price">Price</th>                                                                                                  
                                                        <th style="text-align: center">Qty</th>
                                                        <th style="text-align: center">Add</th>
                                                    </tr>
                                                </thead>                                                                        
                                                <tbody>
                                                    <%
                                                        int id = 1;
                                                        String sql = "select * from price_list where prlist_bran_id = '" + bran_id + "' ";
                                                        pst = DbConnection.getConn(sql);
                                                        rs = pst.executeQuery();
                                                        while (rs.next()) {
                                                            // String com_id = rs.getString(2);
                                                            String shirt_price = rs.getString("prlist_shirt");
                                                            int shirt_p = Integer.parseInt(shirt_price);
                                                            String pant_price = rs.getString("prlist_pant");
                                                            int pant_p = Integer.parseInt(pant_price);
                                                            String blazer_price = rs.getString("prlist_blazer");
                                                            int blazer_p = Integer.parseInt(blazer_price);
                                                            String panjabi_price = rs.getString("prlist_panjabi");
                                                            int panjabi_p = Integer.parseInt(panjabi_price);
                                                            String payjama_price = rs.getString("prlist_payjama");
                                                            int payjama_p = Integer.parseInt(payjama_price);
                                                            String safari_price = rs.getString("prlist_safari");
                                                            int safari_p = Integer.parseInt(safari_price);
                                                            String photua_price = rs.getString("prlist_photua");
                                                            int photua_p = Integer.parseInt(photua_price);
                                                            String mjcort_price = rs.getString("prlist_mojib_cort");
                                                            int mjcort_p = Integer.parseInt(mjcort_price);
                                                            String kable_price = rs.getString("prlist_kable");
                                                            int kable_p = Integer.parseInt(kable_price);
                                                            String koti_price = rs.getString("prlist_koti");
                                                            int koti_p = Integer.parseInt(koti_price);
                                                    %>
                                                    <%
                                                        if (shirt_p > 0) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=id++%></td>
                                                        <td style="text-align: center">Shirt<input type="text" name="productname" id="productname<%=1%>" value="shirt" style="display: none"></td>
                                                        <td style="text-align: center"><input type="text" name="sellprice1" id="sellprice<%=1%>" value="<%=shirt_price%>" style="width:60px; text-align:center; border: none" readonly=""></td>
                                                        <td style="text-align: center">    
                                                            <input type="text" name="Qty" id="Qty<%=1%>" placeholder="Qty" style="width: 50px; text-align: center"/>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <a href="javascript:void(0)" class="btn btn-success add-to-cart" onClick="addtocart(1,<%= sessionID%>);" id="addtocart" >+</a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                    <%
                                                        if (pant_p > 0) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=id++%></td>
                                                        <td style="text-align: center">Pants<input type="text" id="productname<%=2%>" value="pant" style="display: none;"></td>
                                                        <td style="text-align: center"><input type="text" name="sellprice1" 
                                                                                              id="sellprice<%=2%>" value="<%= pant_price%>" style="width:60px; text-align:center; border: none" readonly=""></td>
                                                        <td  style="text-align: center">    
                                                            <input type="text" name="Qty" id="Qty<%=2%>" 
                                                                   placeholder="Qty" style="width: 50px; text-align:center;" required=""/>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <a href="javascript:void(0)" class="btn btn-success add-to-cart" onClick="addtocart
                                                                            (2,<%= sessionID%>);" id="addtocart" >+</a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                    <%
                                                        if (blazer_p > 0) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=id++%></td>
                                                        <td style="text-align: center">Blazers<input type="text" 
                                                                                                     id="productname<%=3%>" value="blazer" style="display: none;"></td>
                                                        <td style="text-align: center"><input type="text" name="sellprice1" 
                                                                                              id="sellprice<%=3%>" value="<%= blazer_price%>" style="width:60px; text-align:center; border: none" readonly=""></td>
                                                        <td style="text-align: center">    
                                                            <input type="text" name="Qty1" id="Qty<%=3%>" 
                                                                   placeholder="Qty" style="width: 50px; text-align:center;" required=""/>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <a href="javascript:void(0)" class="btn btn-success add-to-cart" onClick="addtocart
                                                                            (3,<%= sessionID%>);" id="addtocart" >+</a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                    <%
                                                        if (panjabi_p > 0) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=id++%></td>
                                                        <td style="text-align: center">Punjabi<input type="text" 
                                                                                                     id="productname<%=4%>" value="panjabi" style="display: none;"></td>
                                                        <td style="text-align: center"><input type="text" name="sellprice1" 
                                                                                              id="sellprice<%=4%>" value="<%= panjabi_price%>" style="width:60px; text-align:center; border: none" readonly=""></td>
                                                        <td style="text-align: center">    
                                                            <input type="text" name="Qty1" id="Qty<%=4%>" 
                                                                   placeholder="Qty" style="width: 50px; text-align:center;" required=""/>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <a href="javascript:void(0)" class="btn btn-success add-to-cart" onClick="addtocart
                                                                            (4,<%= sessionID%>);" id="addtocart" >+</a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                    <%
                                                        if (payjama_p > 0) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=id++%></td>
                                                        <td style="text-align: center">Pajama<input type="text" 
                                                                                                    id="productname<%=5%>" value="payjama" style="display: none;"></td>
                                                        <td style="text-align: center"><input type="text" name="sellprice1" 
                                                                                              id="sellprice<%=5%>" value="<%= payjama_price%>" style="width:60px; text-align:center; border: none" readonly=""></td>
                                                        <td style="text-align: center">    
                                                            <input type="text" name="Qty1" id="Qty<%=5%>" 
                                                                   placeholder="Qty" style="width: 50px; text-align:center;" required=""/>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <a href="javascript:void(0)" class="btn btn-success add-to-cart" onClick="addtocart
                                                                            (5,<%= sessionID%>);" id="addtocart" >+</a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                    <%
                                                        if (safari_p > 0) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=id++%></td>
                                                        <td style="text-align: center">safaris<input type="text" 
                                                                                                     id="productname<%=6%>" value="safari" style="display: none;"></td>
                                                        <td style="text-align: center"><input type="text" name="sellprice1" 
                                                                                              id="sellprice<%=6%>" value="<%= safari_price%>" style="width:60px; text-align:center; border: none" readonly=""></td>
                                                        <td style="text-align: center">    
                                                            <input type="text" name="Qty1" id="Qty<%=6%>" 
                                                                   placeholder="Qty" style= "width: 50px; text-align:center;" required=""/>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <a href="javascript:void(0)" class="btn btn-success add-to-cart" onClick="addtocart
                                                                            (6,<%= sessionID%>);" id="addtocart" >+</a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                    <%
                                                        if (photua_p > 0) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=id++%></td>
                                                        <td style="text-align: center">Fatua<input type="text" 
                                                                                                   id="productname<%=7%>" value="photua" style="display: none;"></td>
                                                        <td style="text-align: center"><input type="text" name="sellprice1" 
                                                                                              id="sellprice<%=7%>" value="<%= photua_price%>" style="width:60px; text-align:center; border: none" readonly=""></td>
                                                        <td style="text-align: center">    
                                                            <input type="text" name="Qty1" id="Qty<%=7%>" 
                                                                   placeholder="Qty" style="width: 50px;text-align:center;" required=""/>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <a href="javascript:void(0)" class="btn btn-success add-to-cart" onClick="addtocart
                                                                            (7,<%= sessionID%>);" id="addtocart" >+</a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                    <%
                                                        if (mjcort_p > 0) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=id++%></td>
                                                        <td style="text-align: center">Mojib Cort<input type="text" 
                                                                                                        id="productname<%=8%>" value="mojib_cort" style="display: none;"></td>
                                                        <td style="text-align: center"><input type="text" name="sellprice1" 
                                                                                              id="sellprice<%=8%>" value="<%=mjcort_price%>" style="width:60px; text-align:center; border: none" readonly=""></td>
                                                        <td style="text-align: center">    
                                                            <input type="text" name="Qty1" id="Qty<%=8%>" 
                                                                   placeholder="Qty" style="width: 50px;text-align:center;" required=""/>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <a href="javascript:void(0)" class="btn btn-success add-to-cart" onClick="addtocart
                                                                            (8,<%= sessionID%>);" id="addtocart" >+</a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                    <%
                                                        if (koti_p > 0) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=id++%></td>
                                                        <td style="text-align: center">Koti<input type="text" name="productname" id="productname<%=9%>" value="koti" style="display: none"></td>
                                                        <td style="text-align: center"><input type="text" name="sellprice1" id="sellprice<%=9%>" value="<%=koti_price%>" style="width:60px; text-align:center; border: none" readonly=""></td>
                                                        <td style="text-align: center">
                                                            <input type="text" name="Qty" id="Qty<%=9%>" placeholder="Qty" style="width: 50px; text-align: center"/>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <a href="javascript:void(0)" class="btn btn-success add-to-cart" onClick="addtocart(9,<%= sessionID%>);" id="addtocart" >+</a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                    <%
                                                        if (kable_p > 0) {
                                                    %>
                                                    <tr>
                                                        <td style="text-align: center"><%=id++%></td>
                                                        <td style="text-align: center">Kable<input type="text" name="productname" id="productname<%=10%>" value="kable" style="display: none"></td>
                                                        <td style="text-align: center"><input type="text" name="sellprice1" id="sellprice<%=10%>" value="<%=kable_price%>" style="width:60px; text-align:center; border: none" readonly=""></td>
                                                        <td style="text-align: center">    
                                                            <input type="text" name="Qty" id="Qty<%=10%>" placeholder="Qty" style="width: 50px; text-align: center"/>
                                                        </td>
                                                        <td style="text-align: center">
                                                            <a href="javascript:void(0)" class="btn btn-success add-to-cart" onClick="addtocart(10,<%= sessionID%>);" id="addtocart" >+</a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    } else {
                                                    %>
                                                    <center>  <span class="" style="color: red; font-size: 18px;">Please add product price first !!</span></center>
                                                        <%
                                                                }
                                                            } catch (Exception e) {
                                                                e.printStackTrace();
                                                            }
                                                        %>
                                                </tbody>
                                            </table>
                                        </div>  
                                        <%                                                                    }
                                            // --------------------------------------//user er id er sate match kore last status check --------------------------------------------------------------------
                                        %>
                                    </div>
                                </div>
                                <div class="col-xs-5">
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title">Cart</h3>
                                        </div>

                                        <form id="select2Form">
                                            <h4> Select Customer
                                                <select name="cus_name" id="cus_name"  class="form-control select2-select"
                                                        data-placeholder="Choose 2-4 colors" style="height: 40px;" required="">
                                                    <option value="">Select customer</option>
                                                    <%                                                        try {
                                                            String sql_customer = "select * from customer where cus_bran_id = '" + branch_id + "' order by cus_name";
                                                            PreparedStatement pst_customer = DbConnection.getConn(sql_customer);
                                                            ResultSet rs_customer = pst_customer.executeQuery();
                                                            while (rs_customer.next()) {
                                                    %>                                                    
                                                    <option value="<%=rs_customer.getString("cus_customer_id")%>"><%= rs_customer.getString("cus_name")%><%=" (" + rs_customer.getString("cus_mobile") + ")"%></option>
                                                    <%
                                                            }
                                                        } catch (Exception e) {
                                                            e.printStackTrace();
                                                        } finally {

                                                        }

                                                    %>
                                                </select></h4>
                                        </form>

                                        <div id="dataShow" style="display: none">                                             

                                            <table id="DataTable" class="table table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Sl</th>
                                                        <th>P.Name</th>
                                                        <th style="text-align: center">Qty</th>
                                                        <th style="text-align:center">Price</th>
                                                        <th style="text-align:center">Total</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="data_show">

                                                </tbody>
                                            </table>
                                            <button class="btn btn-primary" id="ordered" onClick="order_product(<%= sessionID%>)">Create Order</button><a href="take_measure_for_order.jsp"><button type="button" id="take_measurement" class="btn btn-success" style="display: none">Take measurement</button></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </aside>                                         
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $('#select2Form')
                        .find('[name="cus_name"]')
                        .select2();
            });

            function addtocart(slno, sid) {
                var s_qty = parseInt($('#Qty' + slno).val());
                var product = $('#productname' + slno).val();
                var price = parseFloat($("#sellprice" + slno).val());
                var sessionid = sid;
                var totalprice = price * s_qty;

                if (price === 0 || s_qty === 0) {

                    $.ajax({
                        type: 'POST',
                        url: "produc_delete_from_order.jsp",
                        data: {
                            "pname": product,
                            "sessionid": sessionid
                        },
                        success: function () {
                            $("#data_show").load("includepaged.jsp");
                        }
                    });
                } else if (isNaN(s_qty)) {
                    alert("Please fillup qty accurately or price");
                    $('#Qty' + slno).val("");
                } else {
                    $("#dataShow").show("slow");

                    $.ajax({
                        type: 'POST',
                        url: "aa.jsp",
                        data: {
                            "pname": product,
                            "price": price,
                            "total": totalprice,
                            "qty": s_qty,
                            "sessionid": sessionid
                        },
                        success: function () {
                            $("#data_show").load("includepaged.jsp");
                        }
                    });
                }
            }

            function order_product(s_id) {
                $("#cus_name").attr("disabled", "disabled");
                $("#ordered").attr("disabled", "disabled");
                var cutomer = $("#cus_name").val();
                if (cutomer == null || cutomer == "") {
                    alert("please select customer");
                    $("#cus_name").removeAttr("disabled");
                    $("#ordered").removeAttr("disabled");
                    return false;
                }

                $.ajax({
                    type: 'POST',
                    url: "/Tailor/ordered",
                    data: {
                        "sid": s_id,
                        "cutomer_id": cutomer
                    },
                    success: function (data) {
                        $("#ordered").hide();
                        $("#take_measurement").slideDown("slow");
                    }
                });
            }
        </script>
        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <script type="text/javascript">
            function googleTranslateElementInit() {
                new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
            }
        </script>
        <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
        <script src="assets/js/bootstrap.min.js"></script>   
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
