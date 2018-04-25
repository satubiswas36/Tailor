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
    </head>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=product_information"/>  
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                Product Location
                                <span id="proudct_delete_product_msg" style="font-size: 18px">
                                    <%
                                        if (session.getAttribute("proudct_delete_product_msg") != null) {
                                            if (session.getAttribute("proudct_delete_product_msg").equals("deleted")) {
                                    %>
                                    <span style="margin-left: 20%; color: green">Successfully Deleted !!</span>
                                    <%
                                    } else if (session.getAttribute("proudct_delete_product_msg").equals("notdeleted")) {
                                    %>
                                    <span style="margin-left: 20%; color: red">Delete Failed !!</span>
                                    <%
                                            }
                                        }
                                        if (session.getAttribute("proudct_delete_product_msg") != null) {
                                            session.removeAttribute("proudct_delete_product_msg");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered" id="mydata">
                                    <thead>
                                        <th style="width: 3%; text-align: center">SL</th>
                                        <th>Supplier Name</th>
                                        <th>Group Name</th>
                                        <th>Product Type</th>
                                        <th>Product Name</th>                                        
                                        <th>Description</th>
                                        <th>Buy Price</th>
                                        <th>Sell Price</th>
                                        <th style="width: 15%">Control</th>
                                    </thead>
                                    <tbody>
                                        <%
                                            int sl = 1;
                                            String group_name = null;
                                            String supplier_name = null;
                                            String product_name = null;
                                            String product_type_name = null;
                                            try {
                                                String sql_product_list = "select * from inv_product where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                PreparedStatement pst_product_list = DbConnection.getConn(sql_product_list);
                                                ResultSet rs_product_list = pst_product_list.executeQuery();
                                                while (rs_product_list.next()) {
                                                    String group_id = rs_product_list.getString("pr_group");
                                                    String supplier_id = rs_product_list.getString("pr_supplier_id");
                                                    String product_id = rs_product_list.getString("pr_product_name");
                                                    String product_type_id = rs_product_list.getString("pr_type");
                                                    String buy_price = rs_product_list.getString("pr_buy_price");
                                                    String sell_price = rs_product_list.getString("pr_sell_price");
                                                    String description = rs_product_list.getString("pr_product_detail");

                                                    // product id dhore product name                                                    
                                                    try {
                                                        String sql_product_name = "select * from inv_product_name where prn_slid = '" + product_id + "' ";
                                                        PreparedStatement pst_product_name = DbConnection.getConn(sql_product_name);
                                                        ResultSet rs_product_name = pst_product_name.executeQuery();
                                                        if (rs_product_name.next()) {
                                                            product_name = rs_product_name.getString("prn_product_name");
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }

                                                    //product type id dhore type bar kora 
                                                    try {
                                                        String sql_product_type_name = "select * from inv_product_type where pro_typ_slno = '" + product_type_id + "' ";
                                                        PreparedStatement pst_product_type = DbConnection.getConn(sql_product_type_name);
                                                        ResultSet rs_product_type = pst_product_type.executeQuery();
                                                        if (rs_product_type.next()) {
                                                            product_type_name = rs_product_type.getString("pro_type_name");
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }

                                                    // supplier id dhore supplier name 
                                                    try {
                                                        String sql_supplier = "select * from supplier where supplier_id = '" + supplier_id + "' ";
                                                        PreparedStatement pst_supplier = DbConnection.getConn(sql_supplier);
                                                        ResultSet rs_supplier = pst_supplier.executeQuery();
                                                        if (rs_supplier.next()) {
                                                            supplier_name = rs_supplier.getString("suplr_name");
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }

                                                    // group id dhore group name ber kora                                                    
                                                    try {
                                                        String sql_group_name = "select * from inv_product_group where prg_slid = '" + group_id + "' ";
                                                        PreparedStatement pst_group_name = DbConnection.getConn(sql_group_name);
                                                        ResultSet rs_group_name = pst_group_name.executeQuery();
                                                        if (rs_group_name.next()) {
                                                            group_name = rs_group_name.getString("prg_name");
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                        %>
                                        <tr>
                                            <td style="text-align: center"><%=sl++%></td>
                                            <td><%=supplier_name%></td>
                                            <td><%=group_name%></td>
                                            <td><%=product_type_name%></td>
                                            <td><%=product_name%></td>
                                            <td><%=description%></td>
                                            <td style="text-align: right"><%=buy_price+".00"%></td>
                                            <td style="text-align: right"><%=sell_price+".00"%></td>
                                            <td>
                                                <a href="add_product.jsp?status=edit&supplier_id=<%=supplier_id%>&supplier_name=<%=supplier_name%>&group_id=<%=group_id%>&group_name=<%=group_name%>&product_id=<%=product_id%>&product_name=<%=product_name%>&product_type_id=<%=product_type_id%>&product_type_name=<%=product_type_name%>&buy_price=<%=buy_price%>&sell_price=<%=sell_price%>"><button class="btn btn-success">Edit</button></a>
                                                <a class="btn btn-danger" href="delete_group.jsp?status=product&product_id=<%=product_id%>"  onclick="return confirm('Do you want delete?')">Delete</a>
                                            </td>
                                        </tr>
                                        <%                                                }
                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>                            
                        </div>                                               
                    </div>                                               
                </div>
            </div>
        </div>
        <script>
            $("#proudct_delete_product_msg").fadeIn(4000).delay(3000).fadeOut("slow");
        </script>
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
