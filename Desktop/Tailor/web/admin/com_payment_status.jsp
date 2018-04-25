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
            <jsp:include page="../menu/menu.jsp"/>
            <!-- /. NAV SIDE  -->
            <%
                String branch_id = request.getParameter("b_id");
                String branch_d_status = request.getParameter("bran_d_status");
                String bran_name = null;
            %>
            <%
                try {
                    String sql_bran_name = "select * from user_branch where bran_id = '" + branch_id + "' ";
                    PreparedStatement pst_bran_name = DbConnection.getConn(sql_bran_name);
                    ResultSet rs_bran_name = pst_bran_name.executeQuery();
                    while (rs_bran_name.next()) {
                        bran_name = rs_bran_name.getString("bran_name");
                        if (bran_name != null) {
                            session.setAttribute("bran_name", bran_name);
                        }
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="height: 50px;">
                                Branch Name :<b> <%= session.getAttribute("bran_name") %></b>
                            </div>
                            <div class="panel-body">
                                <div class="" style="background: blueviolet">
                                    <center><ul class="nav navbar-nav">
                                            <li><a href="com_order_view_bran.jsp">order view</a></li>
                                            <li><a href="com_all_customer_view.jsp">All Customer</a></li>
                                            <li><a href="com_payment_status.jsp">payment status</a></li>
                                            <li><a href="com_all_user_view.jsp">view all user</a></li>
                                            <li><a href="com_balance_bran.jsp?balance_status=per_branch">balance</a></li>
                                        </ul></center>
                                </div>
                            </div>
                        </div>                        
                    </div>
                    <div class="">
                        <%
                            String cus_name = null;
                            String customer_id = request.getParameter("customer_id");
                            String sql_customer_name = "select * from customer where cus_customer_id = " + customer_id;
                            PreparedStatement pst_cus_name = DbConnection.getConn(sql_customer_name);
                            ResultSet rs_cus_name = pst_cus_name.executeQuery();
                            if (rs_cus_name.next()) {
                                cus_name = rs_cus_name.getString("cus_name");
                            }
                        %>
                        <div class="panel-body">
                            <form action="../Customer_payment" id="select2Form" class="form-horizontal" method="post">
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="selectbasic">Customer Name</label>
                                    <div class="col-md-4">
                                        <select name="cus_name" id="cus_name"  class="form-control select2-select"
                                                data-placeholder="Please Select Customer" required="">
                                            <%
                                                if (customer_id != null) {
                                            %>
                                            <option value="<%= customer_id%>"><%= cus_name%><%=" (" + rs_cus_name.getString("cus_mobile") + ")"%></option>
                                            <%
                                            } else {
                                            %>
                                            <option>Select customer</option>
                                            <%
                                                }
                                            %>
                                            <%                                                        try {
                                                    String sql_customer = "select * from customer where cus_bran_id = '" + session.getAttribute("bran_id_b_details") + "'  order by cus_name";

                                                    PreparedStatement pst_customer = DbConnection.getConn(sql_customer);
                                                    ResultSet rs_customer = pst_customer.executeQuery();
                                                    while (rs_customer.next()) {
                                                        String customer_name = rs_customer.getString("cus_name");
                                                        session.setAttribute("customer_name", customer_name);
                                            %>                                                    
                                            <option value="<%=rs_customer.getString("cus_customer_id")%>"><%=rs_customer.getString("cus_name")%><%=" (" + rs_customer.getString("cus_mobile") + ")"%></option>
                                            <%
                                                    }
                                                } catch (Exception e) {
                                                    e.printStackTrace();
                                                } finally {

                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                                <!--                                    <center> <input type="submit" class="btn btn-success" value="Submit" /></center>-->
                            </form>     
                        </div>     
                        <div class="">
                            <table class="table table-bordered">
                                <%
                                    int id = 1;
                                    double balance = 0;
                                    double total_debit = 0;
                                    double total_credit = 0;

                                    try {
                                        String sql = "select * from account where acc_customer_id = " + customer_id;
                                        PreparedStatement pst = DbConnection.getConn(sql);
                                        ResultSet rs = pst.executeQuery();
                                        if (rs.next()) {

                                %>

                                <thead>
                                    <th style="text-align: center">SL</th>
                                    <th style="text-align: center">Date</th>
                                    <th style="text-align: center">Description</th>
                                    <th style="text-align: center">Debit</th>
                                    <th style="text-align: center">Credit</th>
                                    <th style="text-align: center">Balance</th>                                        
                                </thead>
                                <%                                        String sql_payment_statement = "select * from account where acc_customer_id = " + customer_id;
                                    PreparedStatement pst_payment_statement = DbConnection.getConn(sql_payment_statement);
                                    ResultSet rs_payment_statement = pst_payment_statement.executeQuery();
                                    while (rs_payment_statement.next()) {
                                        String description = rs_payment_statement.getString("acc_description");
                                        String Debit = rs_payment_statement.getString("acc_debit");
                                        double acc_debit = Double.parseDouble(Debit);
                                        total_debit += acc_debit;
                                        if (Debit.equals("0")) {
                                            Debit = "";
                                        }
                                        String Credit = rs_payment_statement.getString("acc_credit");
                                        double acc_credit = Double.parseDouble(Credit);
                                        total_credit += acc_credit;
                                        if (Credit.equals("0")) {
                                            Credit = "";
                                        }
                                        balance = balance + (acc_credit - acc_debit);
                                        String acc_date = rs_payment_statement.getString("acc_pay_date");
                                %>
                                <tr>
                                    <td style="text-align: center; width: 5%;"><%= id++%></td>
                                    <td style="text-align: center; width: 15%;"><%= acc_date%></td>
                                    <td style="text-align: center"><%= description%></td>
                                    <td style="text-align: center"><%= Debit%></td>
                                    <td style="text-align: center"><%= Credit%></td>
                                    <td style="text-align: center"><%= balance%></td>                                        
                                </tr>
                                <%
                                    }
                                %>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td style="text-align: center"><b>Total Amount</b></td>
                                    <td style="text-align: center"><b><%= total_debit%></b></td>
                                    <td style="text-align: center"><b><%= total_credit%></b></td>
                                    <td style="text-align: center"><b><%= balance%></b></td>
                                </tr>
                                <%
                                } else {
                                    if (customer_id != null) {
                                %>
                                <center><span class="check_data" style="color: red; font-size: 18px; display: none">Nothing Found !!</span></center>
                                    <%
                                    } else {
                                    %>
                                <center><span class="check_data" style="color: red; font-size: 18px; display: none">No Result here !!</span></center>
                                    <%
                                        }
                                    %>

                                <%
                                        }
                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                %>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(function () {
                $('#select2Form')
                        .find('[name="cus_name"]')
                        .select2();
            });

            $(function () {
                $("#customer_payment_date").datepicker({
                    dateFormat: "dd-mm-yy",
                    maxDate: 0
                });
            });

            $(function () {
                $(".check_data").fadeIn("slow");
            });

            $(function () {
                $('#cus_name').bind('change', function () {
                    var url = $(this).val();
                    if (url) {
                        window.location = "/Tailor/admin/com_payment_status.jsp?" + "customer_id=" + url; // redirect
                    }
                    return false;
                });
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
