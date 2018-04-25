<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
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
    <head>
        <title>Tailor</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta charset="utf-8">
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
            <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2-bootstrap.min.css" />
            <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.css" />
            <script src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.js"></script>        
            <!------------------- select2----------end---------------------->

            <style>
                .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
                    padding: 8px;
                    line-height: 17px;
                    vertical-align: top;
                    border-top: 1px solid #ddd;
                }
                element.style {
                    line-height: 24px;
                    padding-top: 1px;
                }
            </style>
    </head>

    <body>
        <div id="wrapper">            
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp"/>
            <!-- /. NAV SIDE  -->      
            <%
                String supplier_status = null;
                String invoiceid = request.getParameter("invoice_id");
                if (invoiceid != null) {
                    session.setAttribute("invoice_id_for_parchase", invoiceid);
                }
                String supplierid = request.getParameter("supplier_id");
                if (supplierid != null) {
                    session.setAttribute("parchase_supplier_id", supplierid);
                    try {
                        // check supplier local or 
                        String sql_supplier_status = "select * from supplier where suplr_bran_id = '" + session.getAttribute("user_bran_id") + "' and supplier_id = '" + session.getAttribute("parchase_supplier_id") + "' ";
                        PreparedStatement pst_supplier_status = DbConnection.getConn(sql_supplier_status);
                        ResultSet rs_supplier_status = pst_supplier_status.executeQuery();
                        if (rs_supplier_status.next()) {
                            String status = rs_supplier_status.getString("suplr_status");
                            if (status.equals("1")) {
                                supplier_status = "local";
                                session.setAttribute("supplier_status", "local");
                            } else if (status.equals("2")) {
                                supplier_status = "company";
                                session.setAttribute("supplier_status", "company");
                            }
                        }
                    } catch (Exception e) {
                        out.println(e.toString());
                    }
                }
            %>
            <%
                // check invoice id exit or not 
                String exit_status = null;
                String deal_type = "3";
                try {
                    String sql_exit = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_invoice_id = '" + invoiceid + "' and pro_party_id = '" + supplierid + "' and pro_deal_type = '" + deal_type + "' ";
                    PreparedStatement pst_exit = DbConnection.getConn(sql_exit);
                    ResultSet rs_exit = pst_exit.executeQuery();
                    if (rs_exit.next()) {
                        exit_status = "yes";
                    } else {
                        exit_status = "no";
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="">
                                Product Buy <%=session.getAttribute("parchase_supplier_id") + " " + session.getAttribute("supplier_status")%>
                                <span id="product_add">
                                    <%
                                        if (session.getAttribute("addproductparchase") != null) {
                                            if (session.getAttribute("addproductparchase").equals("added")) {
                                    %>
                                    <span style="color: green; margin: 20%;">Successfully Added</span>
                                    <%
                                    } else if (session.getAttribute("addproductparchase").equals("failed")) {
                                    %>
                                    <span style="color: red;">Failed !! Try again</span>
                                    <%
                                    } else if (session.getAttribute("addproductparchase").equals("deleted")) {
                                    %>
                                    <span style="color: red;">Successfully Deleted !!</span>
                                    <%
                                            }
                                        }
                                        if (session.getAttribute("addproductparchase") != null) {
                                            session.removeAttribute("addproductparchase");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="panel-body">
                                <%
                                    if (exit_status.equals("yes")) {
                                        session.removeAttribute("parchase_supplier_id");
                                        session.setAttribute("exit_invoice", "yes");
                                        response.sendRedirect("/Tailor/admin/parchase.jsp");
                                    } else {
                                %>
                                <form action="../ProductParchaseFromSupplier" method="post" id="select2Form" onsubmit="return check_qty_price();">
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Name</label>  
                                            <select name="product_name" id="product_name" class="form-control" required="">
                                                <option value="">--select--</option>
                                                <%
                                                    String pro_name = null;
                                                    String sql_product = null;
                                                    try {
                                                        if (session.getAttribute("supplier_status").equals("local")) {
                                                            sql_product = "select * from inv_product where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        }
                                                        if (session.getAttribute("supplier_status").equals("company")) {
                                                            sql_product = "select * from inv_product where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' and pr_supplier_id = '" + session.getAttribute("parchase_supplier_id") + "' ";
                                                        }

                                                        PreparedStatement pst_product = DbConnection.getConn(sql_product);
                                                        ResultSet rs_product = pst_product.executeQuery();
                                                        while (rs_product.next()) {
                                                            String pro_id = rs_product.getString("pr_product_name"); // product id 
                                                            // product name 
                                                            String sql_pro_name = "select * from inv_product_name where prn_slid = '" + pro_id + "' ";
                                                            PreparedStatement pst_pro_name = DbConnection.getConn(sql_pro_name);
                                                            ResultSet rs_pro_name = pst_pro_name.executeQuery();
                                                            if (rs_pro_name.next()) {
                                                                pro_name = rs_pro_name.getString("prn_product_name");
                                                            }
                                                            // product name
                                                            String buy_price = rs_product.getString("pr_buy_price");
                                                %>
                                                <option value="<%=pro_id%>"><%=pro_name%></option>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="qty" style="margin-bottom:  0px">Quantity</label>  
                                            <input type="text" class="form-control" name="qty" id="pro_qty" placeholder="qty" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="price">Price</label>
                                            <%
                                                if (session.getAttribute("supplier_status").equals("local")) {
                                            %>
                                            <input type="text" class="form-control" name="product_price" id="price" />
                                            <%
                                                } else if (session.getAttribute("supplier_status").equals("company")) {
                                                    %>
                                                    <input type="text" class="form-control" name="product_price" id="price" readonly=""/>
                                                    <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                    <input class="btn btn-primary" type="submit" value="Add" />
                                    <input type="text" value="add" name="status" style="display: none"/>
                                    <a class="btn btn-primary" href="close_invoice.jsp">Close Invoice</a>                                    
                                </form>  
                                <%
                                    }
                                %>
                            </div>
                            <div style="margin-top: 10px;">
                                <%                                    String supplier_name = null;
                                    try {
                                        String sql_supplier = "select * from supplier where supplier_id = '" + session.getAttribute("parchase_supplier_id") + "' ";
                                        PreparedStatement pst_supplier = DbConnection.getConn(sql_supplier);
                                        ResultSet rs_supplier = pst_supplier.executeQuery();
                                        if (rs_supplier.next()) {
                                            supplier_name = rs_supplier.getString("suplr_name");
                                        }
                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                %>
                                <span style="font-size: 24px;">Supplier Name : <%=supplier_name%></span>
                                <h3>Invoice ID : <%= session.getAttribute("invoice_id_for_parchase")%></h3>

                                <table class="table table-bordered">
                                    <thead>
                                        <th style="text-align: center">SL</th>
                                        <th>Product Name</th>
                                        <th style="text-align: center">Buy Quantity</th>
                                        <th style="text-align: right">Buy Price</th>
                                        <th style="text-align: center">Total</th>                                        
                                    </thead>
                                    <tbody>
                                        <%
                                            String Invdeal_type = "3";
                                            String product_name = null;
                                            int qty = 0;
                                            double updated_price = 0;
                                            double price = 0;
                                            double total_price = 0;
                                            int sl = 1;
                                            try {
                                                String sql_invoice_supplier = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + session.getAttribute("parchase_supplier_id") + "' and pro_invoice_id = '" + session.getAttribute("invoice_id_for_parchase") + "' and pro_deal_type = '" + Invdeal_type + "' ";
                                                PreparedStatement pst_invoice_supplier = DbConnection.getConn(sql_invoice_supplier);
                                                ResultSet rs_invoice_supplier = pst_invoice_supplier.executeQuery();
                                                while (rs_invoice_supplier.next()) {
                                                    String product_id = rs_invoice_supplier.getString("pro_product_id");
                                                    // product name 
                                                    String sql_product_name = "select * from inv_product_name where prn_bran_id = '" + session.getAttribute("user_bran_id") + "' and prn_slid = '" + product_id + "' ";
                                                    PreparedStatement pst_product_name = DbConnection.getConn(sql_product_name);
                                                    ResultSet rs_product_name = pst_product_name.executeQuery();
                                                    if (rs_product_name.next()) {
                                                        product_name = rs_product_name.getString("prn_product_name");
                                                    }
                                                    String buy_qty = rs_invoice_supplier.getString("pro_buy_quantity");
                                                    qty = Integer.parseInt(buy_qty);
                                                    String buy_price = rs_invoice_supplier.getString("pro_buy_price");

                                                    price = Double.parseDouble(buy_price);
                                                    total_price += price * qty;
                                        %>
                                        <tr>
                                            <td style="text-align: center"><%=sl++%></td>
                                            <td><%=product_name%></td>
                                            <td style="text-align: center; width: 12%"><input type="text" value="<%=buy_qty%>" id="buy_qty<%=sl%>" onkeyup="change_qty(<%=sl%>)" style="margin: 0; padding: 0; border: none"/></td>
                                            <td style="text-align: right"><span><%=NumberFormat.getNumberInstance(Locale.US).format(price) + ".00"%></span><input type="text" value="<%=price%>" id="buy_price<%=sl%>" style="border: none; display: none" readonly=""/></td>
                                            <td style="text-align: right"><input type="text" value="<%=NumberFormat.getNumberInstance(Locale.US).format(updated_price=qty * price) + ".00"%>"  id="total_price_buy<%=sl%>" style="border: none; text-align: right" readonly=""/></td>                                            
                                            <input type="text" value="<%=product_id%>" id="product_id<%=sl%>" style="display: none"/>
                                        </tr>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            }
                                        %>
                                        <input type="text" value="<%= session.getAttribute("invoice_id_for_parchase")%>" id="invoice_id" style="display: none" />
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right"><b><%=NumberFormat.getNumberInstance(Locale.US).format(total_price) + ".00"%></b></td>
                                        </tr>                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>                                                  
                </div>
            </div>
        </div>
        <script>
            function change_qty(sl) {
                var buy_qty = Number($('#buy_qty' + sl).val());
                var buy_price = Number($('#buy_price' + sl).val());
                var product_id = $("#product_id" + sl).val();
                // alert(buy_price);
                var invoice = $("#invoice_id").val();
                var total_price = buy_qty * buy_price;
                $("#total_price_buy" + sl).val((buy_qty * buy_price) + ".00");

                $.ajax({
                    type: 'POST',
                    url: "buy_product_qty_change.jsp",
                    data: {
                        "total_price": total_price,
                        "buy_qty": buy_qty,
                        "product_id": product_id
                    },
                    success: function () {
                       // $("ss").html(data);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $("#buy_price").html(textStatus);
                    }
                });
            }

            $("#product_name").change(function () {
                var product_id = $("#product_name").val();
                // alert(product_id);

                $.ajax({
                    type: 'POST',
                    url: "product_price.jsp", // group_id ta aaaa servlet e jacce sakhan thaka session set kortaca tarpor product_name_by_group page load kortaca
                    data: {
                        "product_id": product_id,
                        "status": "product_parchase"
                    },
                    success: function (data) {
                        $("#price").val(data.trim());
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("error " + textStatus);
                    }
                });
            });
            
            function check_qty_price(){
                var price_product = $("#price").val();
                var qty_product = $("#pro_qty").val();
                
                if(isNaN(price_product) || isNaN(qty_product)){
                    alert("only digit are allowed");
                    return false;
                }if(qty_product <= 0 || price_product <= 0){
                    alert("0 is not allow");
                    return false;
                }
            }

            $(function () {
                $('#select2Form')
                        .find('[name="product_name"]')
                        .select2();
            });

            $("#product_add").fadeIn().delay(3000).fadeOut("slow");

        </script>
        <!--                <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
