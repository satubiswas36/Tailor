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
            <jsp:include page="../menu/menu.jsp?page_name=customer" flush="true"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                <span style="font-size: 18px;">Customer Payment Statements</span>
                            </div>
                            <div class="panel-body">
                                <table class="table table-striped table-bordered" id="mydata">
                                    <thead>
                                        <th style="text-align: center; width: 4%;">SL</th>
                                        <th style="text-align: left">Customer Name</th>
                                        <th style="text-align: right; width: 12%">Debit</th>
                                        <th style="text-align: right; width: 12%">Credit</th>
                                        <th style="text-align: right; width: 14%">Balance</th>
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
                                            double sell_price = 0;

                                            String customer_name = null;
                                            String customer_id = null;
                                            int sl = 1;

                                            PreparedStatement pst_cus_name = null;
                                            ResultSet rs_cus_name = null;
                                            try {
                                                String sql_customer_name = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' order by cus_name ASC ";
                                                pst_cus_name = DbConnection.getConn(sql_customer_name);
                                                rs_cus_name = pst_cus_name.executeQuery();
                                                while (rs_cus_name.next()) {
                                                    customer_name = rs_cus_name.getString("cus_name");
                                                    customer_id = rs_cus_name.getString("cus_customer_id");
                                        %>
                                        <tr>
                                            <td style="text-align: center"><%=sl++%></td>
                                            <td><%=customer_name%></td>

                                            <%
                                                // for debit 
                                                PreparedStatement pst_debit = null;
                                                ResultSet rs_debit = null;
                                                try {
                                                    String sql_debit = "select * from inventory_details where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and pro_party_id = '" + customer_id + "' and (pro_deal_type = 5 or pro_deal_type = 1 or pro_deal_type = 4 or pro_deal_type = 6)";
                                                    pst_debit = DbConnection.getConn(sql_debit);
                                                    rs_debit = pst_debit.executeQuery();
                                                    while (rs_debit.next()) {
                                                        String debit = rs_debit.getString("pro_sell_price");
                                                        sell_price = Double.parseDouble(rs_debit.getString("pro_sell_quantity"));
                                                        String credit = rs_debit.getString("pro_sell_paid");
                                                        total_debit += (Double.parseDouble(debit) * sell_price);
                                                        total_credit += Double.parseDouble(credit);
                                                    }
                                                    due = total_credit - total_debit;
                                                    all_balance += due;
                                                    all_debit += total_debit;
                                                    all_credit += total_credit;
                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                } finally {
                                                    pst_debit.close();
                                                    rs_debit.close();
                                                }
                                            %>

                                            <td style="text-align: right"><%=total_debit + "0"%></td>
                                            <td style="text-align: right"><%=total_credit + "0"%></td>
                                            <td style="text-align: right"><%=due + "0"%></td>
                                            <td style="width: 6%;"><a class="btn btn-primary" href="customer_statement_details.jsp?customer_id=<%=customer_id%>" style="text-decoration: none">Details</a></td>
                                        </tr>
                                        <%
                                                    total_debit = 0;
                                                    total_credit = 0;
                                                    due = 0;
                                                }

                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            } finally {
                                                pst_cus_name.close();
                                                rs_cus_name.close();
                                            }
                                        %>
                                    </tbody>
                                    <tbody>
                                        <tr>
                                            <td></td>
                                            <td style="text-align: right"><b>Total</b></td>
                                            <td style="text-align: right"><b><%=all_debit + "0"%></b></td>
                                            <td style="text-align: right"><b><%=all_credit + "0"%></b></td>
                                            <td style="text-align: right"><b><%=all_balance + "0"%></b></td>
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
