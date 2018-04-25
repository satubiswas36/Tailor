
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
                                <%
                                    if (session.getAttribute("bank_account_update_ok") != null) {
                                        if (session.getAttribute("bank_account_update_ok").equals("ok")) {
                                %>
                                <span id="bnkrgs" style="color: green; font-size: 18px">Account Updated Successful</span>
                                <%
                                } else {
                                %>
                                <span id="bnkrgs" style="color: red; font-size: 18px">Account Update Failed !!</span>
                                <%
                                        }
                                        session.removeAttribute("bank_account_update_ok");
                                    }
                                %> 
                                <%
                                    if (session.getAttribute("delete_account") != null) {
                                        if (session.getAttribute("delete_account").equals("ok")) {
                                %>
                                <span id="bnkrgs" style="color: red; font-size: 18px">Account Deleted !!</span>
                                <%
                                } else {
                                %>
                                <span id="bnkrgs" style="color: red; font-size: 18px">Account Deleted !!</span>
                                <%
                                        }
                                        session.removeAttribute("delete_account");
                                    }
                                %>
                            </div>
                            <div class="panel-body">
                                <table class="table table-striped table-bordered" id="mydata">
                                    <thead>
                                        <th>SL</th>
                                        <th>Bank Name</th>
                                        <th>Branch Name</th>
                                        <th>Account No</th>                                        
                                        <th>Action</th>
                                    </thead>
                                    <tbody>
                                        <%
                                            int id = 1;
                                            String bank_name = null;
                                            double balance = 0;
                                            try {
                                                String sql = "select * from bank_account where bk_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                PreparedStatement pst = DbConnection.getConn(sql);
                                                ResultSet rs = pst.executeQuery();
                                                while (rs.next()) {
                                                    String bk_sl = rs.getString("bk_sl"); // account no er poriborta
                                                    String bank_id = rs.getString("bk_name");
                                                    String branch_name = rs.getString("bk_branch_name");
                                                    String account_no = rs.getString("bk_account_no");
                                                    String opening_date = rs.getString("bk_open_date");
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
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                        %>
                                        <tr>
                                            <td style="text-align: center"><%=id++%></td>
                                            <td><%=bank_name%></td>
                                            <td><%=branch_name%></td>
                                            <td><%=account_no%></td>                                                        
                                            <td>                                                
                                                <form name="open_bank<%=id%>" action="open_bank_account.jsp" method="post">
                                                    <input type="text" name="bank_id" value="<%=bank_id%>" style="display: none"/>
                                                    <input type="text" name="account_no" value="<%=account_no%>"  style="display: none"/>
                                                    <input type="text" name="branch_name" value="<%=branch_name%>"  style="display: none"/>
                                                    <input type="text" name="opening_date" value="<%=opening_date%>"  style="display: none"/>
                                                </form>
                                                <a href="javascript:open_bank<%=id%>.submit()" style="text-decoration: none; margin: 0px;">Edit</a>                                                
                                                <%
                                                    // account sl no from account 
                                                    String account_sl_no = null;
                                                    try {
                                                        String sql_account_sl = "select * from bank_account where bk_bran_id = '" + session.getAttribute("user_bran_id") + "' and bk_name = '" + bank_id + "' and bk_account_no = '" + account_no + "' ";
                                                        PreparedStatement pst_account_sl = DbConnection.getConn(sql_account_sl);
                                                        ResultSet rs_account_sl = pst_account_sl.executeQuery();
                                                        if (rs_account_sl.next()) {
                                                            account_sl_no = rs_account_sl.getString("bk_sl");
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                    try {
                                                        // check sl is exit or not . for delete option
                                                        String sql_sl = "select * from bank_transaction where bt_bran_id = '" + session.getAttribute("user_bran_id") + "' and bt_account_no = '" + account_sl_no + "' ";
                                                        PreparedStatement pst_sl = DbConnection.getConn(sql_sl);
                                                        ResultSet rs_sl = pst_sl.executeQuery();
                                                        if (rs_sl.next()) {

                                                        } else {
                                                %>
                                                <form name="myform<%=id%>" action="delete_account.jsp" method="post">
                                                    <input type="text" name="bank_id" value="<%=bank_id%>" style="display: none"/>
                                                    <input type="text" name="account_no" value="<%=account_no%>"  style="display: none"/>                                                    
                                                </form>
                                                <a href="javascript:myform<%=id%>.submit()" style="text-decoration: none; margin: 0px;"  onclick="return confirm('Do you want delete?')">Delete</a>
                                                <%
                                                        }
                                                    } catch (Exception e) {
                                                        out.println(e.toString());
                                                    }
                                                %>                                                
                                            </td>
                                        </tr>
                                        <%
                                                }
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
            $("#bnkrgs").fadeIn("slow").delay(3000).fadeOut("slow");
        </script>

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
