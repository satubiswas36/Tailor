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
            <jsp:include page="../menu/menu.jsp?page_name=maker"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                Maker Statement
                            </div>
                            <div class="panel-body">
                                <div class="">
                                    <table class="table table-striped table-bordered" id="mydata">
                                        <thead>
                                            <th style="text-align: center; width: 4%;">Sl</th>
                                            <th style="text-align: left">Make Name</th>                                           
                                            <th style="text-align: right; width: 13%">Credit</th>
                                            <th style="text-align: right; width: 13%">Debit</th>
                                            <th style="text-align: right; width: 15%">Balance</th>
                                            <th style="text-align: center">Details</th>
                                        </thead>
                                        <tbody>
                                            <%
                                                int sl = 1;
                                                double total_credit = 0;
                                                double total_debit = 0;
                                                double balance = 0;
                                                double total_balance = 0; 
                                                try {
                                                    String sql_makr = "select * from maker where mk_bran_id = '" + session.getAttribute("user_bran_id") + "' order by mk_name asc";
                                                    PreparedStatement pst_mker = DbConnection.getConn(sql_makr);
                                                    ResultSet rs_maker = pst_mker.executeQuery();
                                                    while (rs_maker.next()) {
                                                        String maker_name = rs_maker.getString("mk_name");
                                                        String maker_id = rs_maker.getString("mk_slno");

                                                        // for credit
                                                        String del_type = "2";
                                                        double credit = 0;
                                                        double debit = 0;

                                                        try {
                                                            String sql_statement = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + maker_id + "' and pro_deal_type = '" + del_type + "' ";
                                                            PreparedStatement pst_statement = DbConnection.getConn(sql_statement);
                                                            ResultSet rs_statement = pst_statement.executeQuery();
                                                            while (rs_statement.next()) {
                                                                String Qty = rs_statement.getString("pro_buy_quantity");
                                                                String buy_price = rs_statement.getString("pro_buy_price");
                                                                String buy_paid = rs_statement.getString("pro_buy_paid");
                                                                credit += ((Double.parseDouble(Qty)) * (Double.parseDouble(buy_price)));
                                                                debit += Double.parseDouble(buy_paid);
                                                            }
                                                            balance = credit - debit;
                                                            total_balance += balance;
                                                            total_credit += credit;
                                                            total_debit += debit;
                                                        } catch (Exception e) {
                                                            out.println(e.toString());
                                                        }
                                            %>
                                            <tr>
                                                <td style="text-align: center"><%=sl++%></td>
                                                <td style="text-align: left"><%=maker_name%></td>
                                                <td style="text-align: right"><%=credit + "0"%></td>
                                                <td style="text-align: right"><%=debit + "0"%></td>
                                                <td style="text-align: right"><%=balance + "0"%></td>
                                                <td style="width: 6%;"><a class="btn btn-primary" href="maker_statement.jsp?mk_nam=<%=maker_name%>">Details</a></td>
                                            </tr>
                                            <%                                                        }

                                                } catch (Exception e) {
                                                    out.println(e.toString());
                                                }
                                            %>
                                        </tbody>
                                        <tbody>
                                            <tr>
                                                <td></td>
                                                <td></td>                                                
                                                <td style="text-align: right"><b><%=total_credit + "0"%></b></td>
                                                <td style="text-align: right"><b><%=total_debit + "0"%></b></td>
                                                <td style="text-align: right"><b><%=total_balance + "0"%></b></td>
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
