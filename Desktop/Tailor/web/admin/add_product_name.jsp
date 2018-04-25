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
                    response.sendRedirect("/Tailo/index.jsp");
                }
            }
        } else {
            response.sendRedirect("/Tailor/index.jsp");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }
%>
<!DOCTYPE html>
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
                                Add Product Name 
                                <span id="product_name_msg">
                                    <%
                                        if (session.getAttribute("product_name_msg") != null) {
                                            if (session.getAttribute("product_name_msg").equals("inserted")) {
                                    %>
                                    <span style="color: green; margin-left: 20%;">Successfully Inserted !!</span>
                                    <%
                                    } else if (session.getAttribute("product_name_msg").equals("notinserted")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Not Inserted !! try again</span>
                                    <%
                                    } else if (session.getAttribute("product_name_msg").equals("updated")) {
                                    %>
                                    <span style="color: green; margin-left: 20%;">Successfully Updated !!</span>
                                    <%
                                    } else if (session.getAttribute("product_name_msg").equals("notupdated")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Not Updated !! try again</span>
                                    <%
                                    } else if (session.getAttribute("product_name_msg").equals("exit")) {
                                    %>
                                    <span style="color: red; margin-left: 20%;">Exit  !! try again</span>
                                    <%
                                            }
                                        }
                                        if (session.getAttribute("product_name_msg") != null) {
                                            session.removeAttribute("product_name_msg");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="panel-body">
                                <%
                                    if (status == null) {
                                %>
                                <form action="../AddProductName" id="select2Form" class="form-horizontal" method="post" >
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Supplier Name</label>  
                                            <select name="supplier_id" class="form-control select2-select"
                                                    data-placeholder="Please Select Supplier" style="width: 100%; height: 32px" required="">
                                                <option value=""></option>
                                                <%
                                                    try {
                                                        String sql_supplier_name = "select * from supplier where suplr_bran_id = '" + session.getAttribute("user_bran_id") + "' order by suplr_name ASC ";
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
                                            <select name="group_id" style="width: 100%; height: 32px" required="">
                                                
                                                <%
                                                    try {
                                                        String sql_group_name = "select * from inv_product_group where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' ORDER BY prg_name ASC ";
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
                                            <input type="text" class="form-control" name="product_name" id="group_name" maxlength="50" placeholder="Enter Product Name" required=""/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Description</label>  
                                            <input type="text" class="form-control" name="product_desc" id="group_name" maxlength="100" placeholder="Enter Product Description" required=""/>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-2">
                                            <input type="submit" class="btn btn-primary" value="Add"/>
                                            <input type="text" name="status" value="add" style="display: none"/>
                                        </div>                                    
                                    </div>
                                </form>
                                <%
                                    }
                                %>
                                <%
                                    if (status != null) {
                                        String product_id = request.getParameter("product_name_id");
                                        String product_name = request.getParameter("product_name");
                                        String supplier = request.getParameter("product_supplier_id");
                                        String product_group = request.getParameter("product_group_id");
                                        String product_group_name = request.getParameter("product_group_name");
                                        String product_desc = request.getParameter("product_desc");
                                        // out.println("product id " + product_id + " product name " + product_name + " product group " + product_group + " supplier " + supplier + "grop name " + product_group_name);
                                %>
                                <form action="../AddProductName" id="select2Form" method="post" >
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Supplier Name</label>  
                                            <select name="supplier_id" style="width: 100%; height: 32px">
                                                <%
                                                    String supplier_name_edit = null;
                                                    try {
                                                        String sql_supplier = "select * from supplier where supplier_id = '" + supplier + "' ";
                                                        PreparedStatement pst_supplier = DbConnection.getConn(sql_supplier);
                                                        ResultSet rs_supplier = pst_supplier.executeQuery();
                                                        if (rs_supplier.next()) {
                                                            supplier_name_edit = rs_supplier.getString("suplr_name");
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>
                                                <option value="<%=supplier%>"><%=supplier_name_edit%></option>
                                                <%
                                                    try {
                                                        String sql_supplier_name = "select * from supplier where suplr_bran_id = '" + session.getAttribute("user_bran_id") + "' ORDER BY suplr_name ASC";
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
                                            <select name="group_id" style="width: 100%; height: 32px">
                                                <option value="<%=product_group%>"><%=product_group_name%></option>
                                                <%
                                                    try {
                                                        String sql_group_name = "select * from inv_product_group where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' ORDER BY prg_name ASC";
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
                                            <input type="text" class="form-control" name="product_name" id="group_name" value="<%=product_name%>" placeholder="Enter Product Name" />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Product Description</label>  
                                            <input type="text" class="form-control" name="product_desc" value="<%=product_desc%>" id="group_name"  placeholder="Enter Product Description" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-2">
                                            <input type="submit" class="btn btn-primary" value="Edit"/>
                                            <input type="text" name="status" value="edit" style="display: none"/>
                                            <input type="text" name="product_id" value="<%=product_id%>" style="display: none"/>
                                        </div>                                    
                                    </div>
                                </form>
                                <%
                                    }
                                %>
                            </div>                            
                        </div>                                               
                    </div>                                               
                </div>
            </div>
        </div>
        <script>

            $(function () {
                $('#select2Form')
                        .find('[name="supplier_id"]')
                        .select2();
            });
            
            $(function () {
                $("#product_name_msg").fadeIn("slow").delay(3000).fadeOut("slow");
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
