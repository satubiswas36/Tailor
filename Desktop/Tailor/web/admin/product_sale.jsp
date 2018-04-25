<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String logger = (String) session.getAttribute("logger");

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
        <meta charset="utf-8"/>
        <meta contenteditable="utf8_general_ci"/>
        <!--        <meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="shortcut icon" type="image/x-icon" href="../admin/assets/img/t_mechin.jpg"/>
        <link href="/Tailor/admin/assets/css/bootstrap.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/css/font-awesome.css" rel="stylesheet" />    
        <link href="/Tailor/admin/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />       
        <link href="/Tailor/admin/assets/css/custom.css" rel="stylesheet" />      
        <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/dataTables.jqueryui.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/dataTables.uikit.min.css" rel="stylesheet" type="text/css"/>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />        
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <!--        <link href="assets/css/bootstrap.css" rel="stylesheet" type="text/css"/>
                <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>-->


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

        <!------------------- select2-------------------------------->
        <!--        <script src="/Tailor/admin/assets/js/jquery.js" type="text/javascript"></script>-->
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.css" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.js"></script>
        <!------------------- select2----------end---------------------->
        <style>
            .big-col {
                width: 50px !important;
            }
            .one{
                width: 3px !important;
            }
            .cs{
                width: 3px !important;
            }
            .price{
                width: 40px !important;
            }

            table#mydata{
                table-layout:fixed;
            }
        </style>
    </head>
    <body>
        <div id="wrapper">
            <jsp:include page="../menu/menu.jsp"/>
            <div id="page-wrapper" >
                <div class="">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="height: 50px">
                            <span style="font-size: 18px;">Product Sales</span>
                        </div>
                        <div class="panel-body" style="min-height: 600px;">
                            <div class="col-md-8" id="product_show" style="margin-left: -10px;">
                                <table class="table table-striped table-bordered table-hover" id="mydata">
                                    <thead>
                                        <tr>
                                            <th class="one">SL</th>
                                            <th class="big-col">Name</th>
                                            <th class="big-col">Details</th>
                                            <th class="big-col">Group</th>
                                            <th class="cs">CS</th>
                                            <th class="price">Price</th>
                                            <th class="big-col">Add</th>                
                                        </tr>
                                    </thead>           
                                    <tbody>
                                        <%                                                int sl = 1;
                                            String product_name = null;
                                            String group_name = null;
                                            int total_sell_qty = 0;
                                            int total_buy_qty = 0;
                                            int stock = 0;

                                            PreparedStatement pst_product_id = null;
                                            ResultSet rs_product_id = null;
                                            try {
                                                String sql_product_id = "select * from inv_product where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                pst_product_id = DbConnection.getConn(sql_product_id);
                                                rs_product_id = pst_product_id.executeQuery();
                                                while (rs_product_id.next()) {
                                                    String product_id = rs_product_id.getString("pr_product_name");
                                                    // product name 
                                                    PreparedStatement pst_product_name = null;
                                                    ResultSet rs_product_name = null;
                                                    try {
                                                        String sql_product_name = "select * from inv_product_name where prn_slid = '" + product_id + "' ";
                                                        pst_product_name = DbConnection.getConn(sql_product_name);
                                                        rs_product_name = pst_product_name.executeQuery();
                                                        if (rs_product_name.next()) {
                                                            product_name = rs_product_name.getString("prn_product_name");
                                                        }
                                                    } catch (Exception e) {
                                                        out.println("product name " + e.toString());
                                                    } finally {
                                                        pst_product_name.close();
                                                        rs_product_name.close();
                                                    }

                                                    String product_detail = rs_product_id.getString("pr_product_detail");
                                                    String group_id = rs_product_id.getString("pr_group");
                                                    // group name
                                                    PreparedStatement pst_group_name = null;
                                                    ResultSet rs_group_name = null;
                                                    try {
                                                        String sql_group_name = "select * from inv_product_group where prg_slid = '" + group_id + "' ";
                                                        pst_group_name = DbConnection.getConn(sql_group_name);
                                                        rs_group_name = pst_group_name.executeQuery();
                                                        if (rs_group_name.next()) {
                                                            group_name = rs_group_name.getString("prg_name");
                                                        }
                                                    } catch (Exception e) {
                                                        out.println("group name " + e.toString());
                                                    } finally {
                                                        pst_group_name.close();
                                                        rs_group_name.close();
                                                    }

                                                    String sale_price = rs_product_id.getString("pr_sell_price");
                                                    String buy_price = rs_product_id.getString("pr_buy_price");
                                                    // product stock 
                                                    PreparedStatement pst_product_stock = null;
                                                    ResultSet rs_product_stock = null;
                                                    try {
                                                        String sql_product_stock = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_product_id = '" + product_id + "' and (pro_deal_type = 3 or pro_deal_type = 4) ";
                                                        pst_product_stock = DbConnection.getConn(sql_product_stock);
                                                        rs_product_stock = pst_product_stock.executeQuery();
                                                        while (rs_product_stock.next()) {
                                                            int sell_qty = Integer.parseInt(rs_product_stock.getString("pro_sell_quantity"));
                                                            total_sell_qty += sell_qty;
                                                            int buy_qty = Integer.parseInt(rs_product_stock.getString("pro_buy_quantity"));
                                                            total_buy_qty += buy_qty;
                                                        }
                                                        stock = total_buy_qty - total_sell_qty;
                                                        total_buy_qty = 0;
                                                        total_sell_qty = 0;
                                                    } catch (Exception e) {
                                                        out.println("product stock " + e.toString());
                                                    } finally {
                                                        pst_product_stock.close();
                                                        rs_product_stock.close();
                                                    }
                                        %>
                                        <tr>
                                            <td style="text-align: center; width: 3%"><%=sl++%></td>
                                            <td><input type="text" value="<%=product_id%>" id="product_id<%=sl%>" style="display: none" /><span title="<%=buy_price%>"><%=product_name%></span></td>
                                            <td><%=product_detail%></td>
                                            <td><%=group_name%></td>
                                            <td style="text-align: center"><input type="text" id="stock<%=sl%>" value="<%=stock%>" style="display: none" /><%=stock%></span></td>
                                            <td style="text-align: right; width: 10%"><input type="text" value="<%=sale_price%>" id="price<%=sl%>" style="width: 80%; border: none; text-align: center"/></td>
                                            <td style="">
                                                <input type="text" name="qty" id="qty<%=sl%>" onkeypress="doSomething(this, event,<%=sl%>)" size="1" /><a class="btn btn-primary" href="#" onclick="sell(<%=sl%>,<%=sale_price%>)" style="height: 1%;">+</a>
                                            </td>
                                        </tr>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                out.println("Product id " + e.toString());
                                            } finally {
                                                pst_product_id.close();
                                                rs_product_id.close();
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <%
                                String sessionID = null;
                                String last_inv = null;

                                Calendar cl = Calendar.getInstance();
                                int year = cl.get(Calendar.YEAR);
                                int month = cl.get(Calendar.MONTH) + 1;
                                int day = cl.get(Calendar.DATE);
                                int hour = cl.get(Calendar.HOUR);
                                int minute = cl.get(Calendar.MINUTE);
                                int second = cl.get(Calendar.SECOND);
                                //int milisecond = cl.get(Calendar.MILLISECOND);
                                sessionID = year + month + "" + day + "" + hour + "" + minute + "" + second;
                                if (session.getAttribute("invoice_for_product_sell") == null) {
                                    session.setAttribute("invoice_for_product_sell", sessionID);
                                }

                                // take last invoice id for product sell (4)
                                PreparedStatement pst_last_inv = null;
                                ResultSet rs_last_inv = null;
                                try {
                                    String sql_last_inv = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and (pro_sell_quantity != 0 and pro_sell_paid = 0) and pro_deal_type = 4 order by pro_slno desc limit 1";
                                    pst_last_inv = DbConnection.getConn(sql_last_inv);
                                    rs_last_inv = pst_last_inv.executeQuery();
                                    while (rs_last_inv.next()) {
                                        last_inv = rs_last_inv.getString("pro_invoice_id");
                                    }
                                } catch (Exception e) {
                                    out.println("last inventory " + e.toString());
                                } finally {
                                    pst_last_inv.close();
                                    rs_last_inv.close();
                                }
                            %>
                            <div class="col-md-4">
                                previous invoice <span><%=last_inv%></span> <a class="btn btn-info" onclick="window.open('show_last_invoice.jsp?last_inv=<%=last_inv%>', '_blank', 'location=yes,height=570,width=720,scrollbars=yes,status=yes');"><span class="glyphicon glyphicon-zoom-in">View</span></a>
                                <form id="select2Formcus">
                                    Current  Invoice ID : <input type="text" name="invoiceid" id="invoiceid" value="<%=sessionID%>" readonly="" style="border: none"/>
                                    Select Customer
                                    <select name="cus_name" id="cus_name"  class="form-control select2-select"
                                            data-placeholder="Choose 2-4 colors" style="height: 40px;" required="">
                                        <option value="">Select customer</option>
                                        <%

                                            PreparedStatement pst_customer = null;
                                            ResultSet rs_customer = null;
                                            try {
                                                String sql_customer = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' order by cus_name";
                                                pst_customer = DbConnection.getConn(sql_customer);
                                                rs_customer = pst_customer.executeQuery();
                                                while (rs_customer.next()) {
                                        %>                                                    
                                        <option value="<%=rs_customer.getString("cus_customer_id")%>"><%= rs_customer.getString("cus_name")%><%=" (" + rs_customer.getString("cus_mobile") + ")"%></option>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                out.println("customer name with mobile" + e.toString());
                                            } finally {
                                                pst_customer.close();
                                                rs_customer.close();
                                            }
                                        %>

                                    </select>
                                </form>
                                <%                                                     String data_id = null;
                                    String display_style = null;
                                    if (session.getAttribute("invoice_for_product_sell") != null) {
                                        data_id = "show_data";
                                        display_style = "block";
                                    } else {
                                        data_id = "data_show";
                                        display_style = "none";
                                    }
                                %>
                                <div id="dataShow" style="display: none; margin-left: 5%;">
                                    <table class="table table-bordered" style="margin-left: -20px;">
                                        <thead>
                                            <th>SL</th>
                                            <th>P.Name</th>
                                            <th>Qty</th>
                                            <th>Price</th>
                                            <th>Total</th>
                                        </thead>
                                        <tbody id="data_show" style="height: 50px; overflow: scroll">

                                        </tbody>
                                    </table>
                                    <button class="btn btn-danger" onclick="openback()" style="margin-left: 50%">Finish And Print</button>
                                </div>
                            </div>
                        </div>                        
                    </div>
                </div>              
            </div>            
        </div>
        <script>

            $(document).ready(function () {
                $('#select2Formcus')
                        .find('[name="cus_name"]')
                        .select2();
            });
            $(document).ready(function () {
                $('#select2Formgpname')
                        .find('[name="group_name"]')
                        .select2();
            });

            function doSomething(element, e, id) {
                var charCode;
                var p_qty = Number($('#qty' + id).val());
                if (e && e.which) {
                    charCode = e.which;
                } else if (window.event) {
                    e = window.event;
                    charCode = e.keyCode;
                }

                if (charCode == 13) {
                    var sale_price = Number($('#price' + id).val());
                    var p_qty = Number($('#qty' + id).val());
                    var has_Qty = Number($('#stock' + id).val());
                    var product_id = $('#product_id' + id).val();
                    var invoice = $("#invoiceid").val();

                    if (p_qty == null || p_qty == "") {
                        alert("Please Enter Qty..");
                        return false;
                    } else if (p_qty === 0) {
                        // alert("for delete");
                        $.ajax({
                            type: 'POST',
                            url: "delete_temp_product_sell.jsp",
                            data: {
                                "product_id": product_id,
                                "invoice": invoice,
                                "price": sale_price,
                                "qty": p_qty
                            },
                            success: function (data, textStatus, jqXHR) {
                                $("#data_show").html(data);
                            }
                        });
                    } else if (isNaN(p_qty)) {
                        alert("Select Number Only ");
                        
                        document.getElementById('#qty'+id).focus();
                        return false;
                    } else if (sale_price <= 0) {
                        alert("Price never be 0. Please consider again !");
                        return false;
                    } else if (p_qty > has_Qty) {
                        alert("Stock is not available");
                    } else {
                        $("#dataShow").fadeIn("slow");
                        $.ajax({
                            type: 'POST',
                            url: "sell_product_temporary.jsp",
                            data: {
                                "product_id": product_id,
                                "invoice": invoice,
                                "price": sale_price,
                                "qty": p_qty
                            },
                            success: function (data) {
                                $("#data_show").html(data);
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                $("#data_show").html(textStatus);
                            }
                        });
                    }
                }
            }

            function sell(id, price) {
                var sale_price = Number($('#price' + id).val());
                var p_qty = Number($('#qty' + id).val());
                var has_Qty = Number($('#stock' + id).val());
                var product_id = $('#product_id' + id).val();
                var invoice = $("#invoiceid").val();

                if (p_qty == null || p_qty == "") {
                    alert("Please Enter Qty..");
                    return false;
                } else if (p_qty === 0) {
                    // alert("for delete");
                    $.ajax({
                        type: 'POST',
                        url: "delete_temp_product_sell.jsp",
                        data: {
                            "product_id": product_id,
                            "invoice": invoice,
                            "price": sale_price,
                            "qty": p_qty
                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#data_show").html(data);
                        }
                    });
                } else if (isNaN(p_qty)) {
                    alert("Select Number Only ");
                    return false;
                } else if (sale_price <= 0) {
                    alert("Price never be 0. Please consider again !");
                    return false;
                } else if (p_qty > has_Qty) {
                    alert("Stock is not available");
                } else {
                    $("#dataShow").fadeIn("slow");
                    $.ajax({
                        type: 'POST',
                        url: "sell_product_temporary.jsp",
                        data: {
                            "product_id": product_id,
                            "invoice": invoice,
                            "price": sale_price,
                            "qty": p_qty
                        },
                        success: function (data) {
                            $("#data_show").html(data);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $("#data_show").html(textStatus);
                        }
                    });
                }
            }

            function openback() {
                //alert("Hi");
                var invoice = $("#invoiceid").val();
                var customer_id = $("#cus_name").val();
                if (customer_id == null || customer_id == "") {
                    alert("Please select Customer");
                    return false;
                } else {
                    location.reload();
                    window.open("finish_sale_product_invoice.jsp?invoice=" + invoice + "&customer_id=" + customer_id, '_blank', 'location=yes,height=570,width=720,scrollbars=yes,status=yes');

                }
            }
        </script>
        <!--        <script src="assets/js/jquery.js" type="text/javascript"></script>-->
        <script src="assets/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/js/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>
        <script>
            $("#mydata").dataTable({
                "pagingType": "simple_numbers",
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search..."
                }
            });
        </script>
    </body>
</html>
