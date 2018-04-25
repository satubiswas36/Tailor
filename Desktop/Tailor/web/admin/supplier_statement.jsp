<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
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
    </head>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp?page_name=supplier_information" flush="true"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">

                            </div>
                            <div class="panel-body">
                                <table class="table table-striped table-bordered" id="mydata">
                                    <thead>
                                        <th style="text-align: center; width: 5%;">SL</th>
                                        <th style="text-align: left">Supplier Name</th>
                                        <th style="text-align: right; width: 15%">Debit</th>
                                        <th style="text-align: right; width: 15%">Credit</th>
                                        <th style="text-align: right; width: 18%">Balance</th>
                                        <th style="text-align: center">Details</th>
                                    </thead>
                                    <tbody>
                                        <%
                                            double total_debit = 0;
                                            double total_credit = 0;
                                            double due = 0;
                                            double all_credit = 0;
                                            double all_debit = 0;
                                            double all_balance = 0;

                                            String supplier_name = null;
                                            String supplier_id = null;
                                            int sl = 1;
                                            try {
                                                String sql_supplier_name = "select * from supplier where suplr_bran_id = '" + session.getAttribute("user_bran_id") + "' order by suplr_name ASC ";
                                                PreparedStatement pst_sup_name = DbConnection.getConn(sql_supplier_name);
                                                ResultSet rs_sup_name = pst_sup_name.executeQuery();
                                                while (rs_sup_name.next()) {
                                                    supplier_name = rs_sup_name.getString("suplr_name");
                                                    supplier_id = rs_sup_name.getString("supplier_id");
                                        %>
                                        <tr>
                                            <td style="text-align: center"><%=sl++%></td>
                                            <td><%=supplier_name%></td>

                                            <%
                                                // for debit 
                                                try {
                                                    String sql_debit = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + supplier_id + "' and (pro_deal_type = 3 or pro_deal_type = 8)";
                                                    PreparedStatement pst_debit = DbConnection.getConn(sql_debit);
                                                    ResultSet rs_debit = pst_debit.executeQuery();
                                                    while (rs_debit.next()) {
                                                        String debit = rs_debit.getString("pro_buy_paid"); // debit holo je tk supplier ke daoa hoyaca 
                                                        String credit = rs_debit.getString("pro_buy_price");   // credit holo je tk pabe
                                                        double Qty = Double.parseDouble(rs_debit.getString("pro_buy_quantity"));
                                                        total_debit += Double.parseDouble(debit);
                                                        total_credit += (Double.parseDouble(credit) * Qty);
                                                    }
                                                    due = total_credit - total_debit;
                                                    all_balance += due;
                                                    all_debit += total_debit;
                                                    all_credit += total_credit;
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>

                                            <td style="text-align: right"><%= NumberFormat.getNumberInstance(Locale.US).format(total_debit) + ".00"%></td>
                                            <td style="text-align: right"><%=NumberFormat.getNumberInstance(Locale.US).format(total_credit) + ".00"%></td>
                                            <td style="text-align: right"><%= NumberFormat.getNumberInstance(Locale.US).format(due) + ".00"%></td>
                                            <td style="text-align: right; width: 10%;"><a class="btn btn-primary" href="supplier_statement_details.jsp?supplier_id=<%=supplier_id%>" style="text-decoration: none">Details</a></td>
                                        </tr>
                                        <%
                                                    total_debit = 0;
                                                    total_credit = 0;
                                                    due = 0;
                                                }

                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            }
                                        %>                                        
                                    </tbody>
                                    <tbody>
                                        <tr>
                                            <td></td>
                                            <td style="text-align: right"><b>Total:</b></td>
                                            <td style="text-align: right"><b><%= NumberFormat.getNumberInstance(Locale.US).format(all_debit) + ".00"%></b></td>
                                            <td style="text-align: right"><b><%= NumberFormat.getNumberInstance(Locale.US).format(all_credit) + ".00"%></b></td>
                                            <td style="text-align: right"><b><%= NumberFormat.getNumberInstance(Locale.US).format(all_balance) + ".00"%></b></td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
