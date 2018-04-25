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
        <meta charset="utf-8" />
        <meta contenteditable="utf8_general_ci" />
        <!--        <meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <meta name="viewport" content="width=device-width, initial-scale=1" />
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

        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
        <link rel="stylesheet" href="/resources/demos/style.css" />
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <!--      for time picker-->
        <link href="../admin/assets/css/timedropper.css" rel="stylesheet" type="text/css" />
        <script src="../admin/assets/js/timedropper.js" type="text/javascript"></script>
        <!--    <script src="../admin/assets/js/jquery.js" type="text/javascript"></script>-->

        <!------------------- select2-------------------------------->
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2-bootstrap.min.css" />
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.css" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/select2/3.5.0/select2.min.js"></script>        
        <!------------------- select2----------end---------------------->
    </head>
    <body>
        <div id="wrapper">              
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=product_information"/>
            <!-- /. NAV SIDE  -->
            <%
                String status = request.getParameter("status");
            %>
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Add Product
                                <span id="addproductmsg">
                                    <%                                        if (session.getAttribute("addproductmsg") != null) {
                                            if (session.getAttribute("addproductmsg").equals("inserted")) {
                                    %>
                                    <span style="color: green; margin-left: 20%;">Successfully Inserted !!</span>
                                    <%
                                    } else if (session.getAttribute("addproductmsg").equals("notinserted")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Not Inserted !! try again</span>
                                    <%
                                    } else if (session.getAttribute("addproductmsg").equals("updated")) {
                                    %>
                                    <span style="color: green; margin-left: 20%;">Successfully Updated !!</span>
                                    <%
                                    } else if (session.getAttribute("addproductmsg").equals("notupdated")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Not Updated !! try again</span>
                                    <%
                                    } else if (session.getAttribute("addproductmsg").equals("exit")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Exit !! try again</span>
                                    <%
                                            }
                                        }
                                        if (session.getAttribute("addproductmsg") != null) {
                                            session.removeAttribute("addproductmsg");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="panel-body">
                                <%
                                    if (status == null) {
                                %>
                                <form action="../Product" id="select2Form" method="post" >
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Supplier Name</label>  
                                            <select name="supplier_id" id="supplier_id" class="form-control select2-select"
                                                    data-placeholder="Please Select Supplier" style="width: 100%; height: 32px" required="">
                                                <option></option>
                                                <%
                                                    try {
                                                        String sql_supplier_name = "select * from supplier where suplr_bran_id = '" + session.getAttribute("user_bran_id") + "' and suplr_status = 2 order by suplr_name asc ";
                                                        PreparedStatement pst_supplier_name = DbConnection.getConn(sql_supplier_name);
                                                        ResultSet rs_supplier_name = pst_supplier_name.executeQuery();
                                                        while (rs_supplier_name.next()) {
                                                            String supplier_name = rs_supplier_name.getString("suplr_name");
                                                            String supplier_id = rs_supplier_name.getString("supplier_id");
                                                %>
                                                <option value="<%=supplier_id%>"><%=supplier_name%></option>
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
                                            <label for="name" style="margin-bottom:  0px">Group Name</label>  
                                            <select name="group_id" id="group_id" style="width: 100%; height: 32px" required="">
                                                <option></option>
                                                <%
                                                    try {
                                                        String sql_group_name = "select * from inv_product_group where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' order by prg_name asc ";
                                                        PreparedStatement pst_group_name = DbConnection.getConn(sql_group_name);
                                                        ResultSet rs_group_name = pst_group_name.executeQuery();
                                                        while (rs_group_name.next()) {
                                                            String group_name = rs_group_name.getString("prg_name");
                                                            String group_id = rs_group_name.getString("prg_slid");
                                                %>
                                                <option value="<%=group_id%>"><%=group_name%></option>
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
                                            <label for="name" style="margin-bottom:  0px">Product Name</label>  
                                            <select name="product_id" id="product_id" style="width: 100%; height: 32px" required="">

                                            </select>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Type Name</label>  
                                            <select name="type_name" style="width: 100%; height: 32px" required="">
                                                <option></option>
                                                <%
                                                    try {
                                                        String sql_product_type = "select * from inv_product_type where pro_type_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                        PreparedStatement pst_product_type = DbConnection.getConn(sql_product_type);
                                                        ResultSet rs_product_type = pst_product_type.executeQuery();
                                                        while (rs_product_type.next()) {
                                                            String product_type = rs_product_type.getString("pro_type_name");
                                                            String product_type_id = rs_product_type.getString("pro_typ_slno");
                                                %>
                                                <option value="<%=product_type_id%>"><%=product_type%></option>
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
                                            <label for="name" style="margin-bottom:  0px">Product Buy Price</label>  
                                            <input type="text" class="form-control" name="product_buy_price" id="product_buy_price" maxlength="8" placeholder="Enter Product Buy Price" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Sell Price</label>  
                                            <input type="text" class="form-control" name="product_sell_price" id="product_buy_price" maxlength="8" placeholder="Enter Product Sell Price" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Short Quantity</label>  
                                            <input type="text" class="form-control" name="shr_quantity" maxlength="2" id="product_buy_price" placeholder="Enter Short Quantity" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <input type="submit" class="btn btn-primary" value="Add" />
                                            <input type="text" value="add" name="status" style="display: none"/>
                                        </div>                                    
                                    </div>
                                </form>
                                <%
                                    }
                                %>
                                <%
                                    if (status != null) {
                                        String supplier_id_show = request.getParameter("supplier_id");
                                        String supplier_name_show = request.getParameter("supplier_name");
                                        String group_id_show = request.getParameter("group_id");
                                        String group_name_show = request.getParameter("group_name");
                                        String product_id_show = request.getParameter("product_id");
                                        String product_name_show = request.getParameter("product_name");
                                        String type_id_show = request.getParameter("product_type_id");
                                        String type_name_show = request.getParameter("product_type_name");                                        
                                        String buy_price_show = request.getParameter("buy_price");
                                        String sell_price_show = request.getParameter("sell_price");
                                %>
                                <form action="../Product" method="post" >
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Supplier Name</label>  
                                            <select name="supplier_id" style="width: 100%; height: 32px" required=""  readonly="">
                                                <option value="<%=supplier_id_show%>"><%=supplier_name_show%></option>

                                            </select>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Group Name</label>  
                                            <select name="group_id" id="group_id" style="width: 100%; height: 32px" required="">
                                                <option value="<%=group_id_show%>"><%=group_name_show%></option>

                                            </select>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Name</label>  
                                            <select name="product_id" id="product_id" style="width: 100%; height: 32px" required="">
                                                <option value="<%=product_id_show%>"><%=product_name_show%></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Type Name</label>  
                                            <select name="type_name" style="width: 100%; height: 32px" required="">
                                                <option value="<%=type_id_show%>"><%=type_name_show%></option>                                                
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Buy Price</label>  
                                            <input type="text" class="form-control" name="product_buy_price" id="product_buy_price" value="<%=buy_price_show%>" maxlength="8" placeholder="Enter Product Buy Price" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Sell Price</label>  
                                            <input type="text" class="form-control" name="product_sell_price" id="product_buy_price" value="<%=sell_price_show%>" maxlength="8" placeholder="Enter Product Sell Price" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Short Quantity</label>  
                                            <input type="text" class="form-control" name="shr_quantity" maxlength="2" id="product_buy_price" placeholder="Enter Short Quantity" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <input type="submit" class="btn btn-primary" value="Edit" />
                                            <input type="text" value="edit" name="status" style="display: none"/>
                                        </div>                                    
                                    </div>
                                </form>
                                <%
                                    }
                                %>
                            </div>                            
                        </div>                                                    <!-- /. PAGE INNER  -->
                    </div>                                                    <!-- /. PAGE WRAPPER  -->
                </div>
            </div>
        </div>
        <script>
              $(function () {
                $('#select2Form')
                        .find('[name="supplier_id"]')
                        .select2();
            });
            
            $("#group_id").change(function () {
                var group_id = $("#group_id").val();
                //alert(group_id);
                $.ajax({
                    type: 'POST',
                    url: "/Tailor/aaaa", // group_id ta aaaa servlet e jacce sakhan thaka session set kortaca tarpor product_name_by_group page load kortaca
                    data: {
                        "group_id_product": group_id,
                        "status": "product"
                    },
                    success: function (data, textStatus, jqXHR) {
                        $("#product_id").load("product_name_by_product.jsp");
                        // alert("Deleted");
                    }
                });
            });
            
            $("#supplier_id").change(function () {
                var supplier_id = $("#supplier_id").val();                
                $.ajax({
                    type: 'POST',
                    url: "/Tailor/aaaa", // group_id ta aaaa servlet e jacce sakhan thaka session set kortaca tarpor product_name_by_group page load kortaca
                    data: {
                        "supplier_id_product": supplier_id                        
                    }                    
                });
            });
            
            $("#product_id").change(function () {
                var product_id = $("#product_id").val();                
                $.ajax({
                    type: 'POST',
                    url: "/Tailor/aaaa", // group_id ta aaaa servlet e jacce sakhan thaka session set kortaca tarpor product_name_by_group page load kortaca
                    data: {
                        "product_id": product_id                        
                    }                    
                });
            });
       
          

            $(function () {
                $("#addproductmsg").fadeIn("slow").delay(3000).fadeOut("slow");
            });
        </script>
<!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script>      
    </body>
</html>
