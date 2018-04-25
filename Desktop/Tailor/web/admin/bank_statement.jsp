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
            <jsp:include page="../menu/menu.jsp?page_name=bank_account"/>
            <!-- /. NAV SIDE  -->            
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px">

                            </div>
                            <div class="panel-body">
                                <table class="table table-striped table-bordered" id="mydata">
                                    <thead>
                                        <th>SL</th>
                                        <th>Bank Name</th>
                                        <th>Branch Name</th>
                                        <th>Account No</th>
                                        <th>Balance</th>
                                        <th>Details</th>
                                    </thead>
                                    <tbody>
                                        <%
                                            int id = 1;
                                            String bank_name = null;
                                            double balance = 0;
                                            double total_balance = 0;
                                            try {
                                                String sql = "select * from bank_account where bk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                PreparedStatement pst = DbConnection.getConn(sql);
                                                ResultSet rs = pst.executeQuery();
                                                while (rs.next()) {
                                                    String bk_sl = rs.getString("bk_sl"); // account no er poriborta
                                                    String bank_id = rs.getString("bk_name");
                                                    String branch_name = rs.getString("bk_branch_name");
                                                    String account_no = rs.getString("bk_account_no");
                                                    try {
                                                        // bank name by bank id 
                                                        String sql_bank_name = "select * from bank where sl = '" + bank_id + "' ";
                                                        PreparedStatement pst_bank_name = DbConnection.getConn(sql_bank_name);
                                                        ResultSet rs_bank_name = pst_bank_name.executeQuery();
                                                        if (rs_bank_name.next()) {
                                                            bank_name = rs_bank_name.getString("bank_name");
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                    try {
                                                        // total balance 
                                                        double debit = 0;
                                                        double credit = 0;
                                                        String sql_de_cedit = "select * from bank_transaction where bt_bran_id = '" + session.getAttribute("user_bran_id") + "' and bt_account_no = '" + bk_sl + "' ";
                                                        PreparedStatement pst_de_cedit = DbConnection.getConn(sql_de_cedit);
                                                        ResultSet rs_de_cedit = pst_de_cedit.executeQuery();
                                                        while (rs_de_cedit.next()) {
                                                            String Debit = rs_de_cedit.getString("bt_debit");
                                                            debit += Double.parseDouble(Debit);
                                                            String Credit = rs_de_cedit.getString("bt_credit");
                                                            credit += Double.parseDouble(Credit);
                                                        }
                                                        balance = credit - debit;
                                                        total_balance += balance;
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                        %>
                                        <tr>
                                            <td style="text-align: center"><%=id++%></td>
                                            <td><%=bank_name%></td>
                                            <td><%=branch_name%></td>
                                            <td><%=account_no%></td>
                                            <td style="text-align: right"><%=NumberFormat.getNumberInstance(Locale.US).format(balance) + ".00"%></td>                                                        
                                            <td>
                                                <form name="open_bank<%=id%>" action="bank_statement_details.jsp" method="post">
                                                    <input type="text" name="acc_sl" value="<%=bk_sl%>" style="display: none"/>
                                                    <input type="text" name="account_no" value="<%=account_no%>" style="display: none"/>
                                                    <input type="text" name="branch_name" value="<%=branch_name%>" style="display: none"/>
                                                    <input type="text" name="bank_name" value="<%=bank_name%>" style="display: none"/>
                                                </form>
                                                <a href="javascript:open_bank<%=id%>.submit()" style="text-decoration: none">Details</a> 
                                            </td>
                                        </tr>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            }
                                        %>                                        
                                    </tbody>
                                    <tbody>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right"><b><%=NumberFormat.getNumberInstance(Locale.US).format(total_balance) + ".00"%></b></td>
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

        <!--        <script src="assets/js/jquery-1.10.2.js"></script>   -->
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
