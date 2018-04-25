<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>

<%
    String userid = null;
    String logger = null;
    String bran_id = null;
    if (session != null) {
        userid = (String) session.getAttribute("user_user_id");
        logger = (String) session.getAttribute("logger");
        bran_id = (String) session.getAttribute("user_bran_id");
    } else {
        response.sendRedirect("/Tailor/index.jsp");
    }
    String current_page_cost = null;
    String current_page_account = null;
    String current_page_maker = null;
    String current_page_user = null;
    String current_page_order_report = null;
    String current_page_customer = null;
    String current_page_supplier_information = null;
    String current_page_product_information = null;
    String current_page_all_report = null;
    String current_page_bank_account = null;

    String page_status = request.getParameter("page_name");
    if (page_status != null) {
        if (page_status.equals("cost")) {
            current_page_cost = "active";
        } else if (page_status.equals("maker")) {
            current_page_maker = "active";
        } else if (page_status.equals("customer")) {
            current_page_customer = "active";
        } else if (page_status.equals("order")) {
            current_page_order_report = "active";
        } else if (page_status.equals("product_information")) {
            current_page_product_information = "active";
        } else if (page_status.equals("supplier_information")) {
            current_page_supplier_information = "active";
        } else if (page_status.equals("user")) {
            current_page_user = "active";
        } else if (page_status.equals("account")) {
            current_page_account = "active";
        } else if (page_status.equals("all_report")) {
            current_page_all_report = "active";
        } else if (page_status.equals("bank_account")) {
            current_page_bank_account = "active";
        }
    }

%>
<style>
    .active > a {
        color: blue;
    } 
    .clock {
        color: white;
    }

</style>
<nav class="navbar navbar-default navbar-cls-top " role="navigation" style="margin-bottom: 0; ">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <%            if (logger != null) {
                if (logger.equals("root")) {
        %>
        <a href="../admin/index.jsp"><img src="../admin/assets/img/logo.png" width="260" height="55" style=" background: white"/></a>
            <%
                }
            %>
            <%
                if (logger.equals("user")) {
            %>
        <a href="../admin/index.jsp"><img src="../admin/assets/img/logo.png" width="260" height="55" style=" background: white"/></a>
            <%
                }
            %>
            <%
                if (logger.equals("company")) {
            %>
        <a href="../admin/index.jsp"><img src="../admin/assets/img/logo.png" width="260" height="55" style=" background: white"/></a>
            <%
                }
            %>
            <%
                if (logger.equals("branch")) {
            %>
        <a href="../admin/index.jsp"><img src="../admin/assets/img/logo.png" width="260" height="55" style=" background: white"/></a>
            <%
                    }
                } else {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            %>
    </div>


    <!--    jodi login na thake tobe alada vabe logout kore deba email check kore-->
    <%
        try {

            if (logger != null) {
                if (logger.equals("user")) {
                    String ss_id = (String) session.getAttribute("user_user_id");
                    if (ss_id == null) {
                        response.sendRedirect("/Tailor/index.jsp");
                    }
                } else if (logger.equals("root")) {
                    String user_root = (String) session.getAttribute("user_root");
                    if (user_root == null) {
                        response.sendRedirect("../index.jsp");
                    }
                } else if (logger.equals("company")) {
                    String user_com_id = (String) session.getAttribute("user_com_id");
                    if (user_com_id == null) {
                        response.sendRedirect("/Tailor/company/index.jsp");
                    }
                } else if (logger.equals("branch")) {
                    String user_bran_id = (String) session.getAttribute("user_bran_id");
                    if (user_bran_id == null) {
                        response.sendRedirect("/Tailor/Branch/index.jsp");
                    }
                }
            } else {
                response.sendRedirect("/Tailor/user/index.jsp");
            }

        } catch (Exception e) {
            out.println(e.toString());
        }
    %>

    <%
        if (logger != null) {
    %>
    <%
        if (logger.equals("user")) {
    %>
    <div style="float: left; color: white; margin-left: 30%; line-height: 50px;">
        <%
            String com_name = null;
            String user_pic = null;
            try {
                String sql_company = "select * from user_company where com_company_id = '" + session.getAttribute("user_com_id") + "' ";
                PreparedStatement pst_com = DbConnection.getConn(sql_company);
                ResultSet rs_com = pst_com.executeQuery();
                if (rs_com.next()) {
                    com_name = rs_com.getString("com_name");
                } else {
                    try {
                        String sql_bran_name = "select * from user_branch where bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                        PreparedStatement pst_bran_name = DbConnection.getConn(sql_bran_name);
                        ResultSet rs_bran_name = pst_bran_name.executeQuery();
                        if (rs_bran_name.next()) {
                            com_name = rs_bran_name.getString("bran_name");
                        }
                    } catch (Exception e) {
                        out.println(e.toString());
                    }
                }
                try {
                        // user pic location
                        String sql_user_pic = "select * from user_user where user_bran_id = '"+session.getAttribute("user_bran_id")+"' and user_id = '"+session.getAttribute("user_user_id")+"' ";
                        PreparedStatement pst_user_pic = DbConnection.getConn(sql_user_pic);
                        ResultSet rs_user_pic = pst_user_pic.executeQuery();
                        if(rs_user_pic.next()){
                            user_pic = rs_user_pic.getString("user_pic");
                        }
                    } catch (Exception e) {
                        out.println(e.toString());
                    }
        %>
        <span style="font-size: 18px;"><%if (com_name != null) {%><%=com_name%><%} %></span>
        <%
            } catch (Exception e) {
                out.println(e.toString());
            }
        %>
    </div>    
    <div  style="color: white;
          padding: 15px 50px 5px 50px;
          float: right;
          font-size: 16px;"><img src="../images/<%=user_pic%>" class="img-rounded" alt="" style="height: 35px; width: 50px; margin: 0px;"/><a href="../admin/user_profile_update.jsp" style="text-decoration: none"><span style="padding-right: 10px; color: white; text-decoration: none;"><%= logger.toUpperCase()%></span></a> <a href="/Tailor/logout/user_logout.jsp" class="btn btn-danger square-btn-adjust">Logout</a> </div>
            <%
            } else if (logger.equals("root")) {
            %>
    <div  style="color: white;
          padding: 15px 50px 5px 50px;
          float: right;
          font-size: 16px;"> Last access : 30 May 2014 &nbsp; <a href="/Tailor/logout/root_logout.jsp" class="btn btn-danger square-btn-adjust">Logout</a> </div>
    <%
    } else if (logger.equals("company")) {
        String mydate = java.text.DateFormat.getDateTimeInstance().format(Calendar.getInstance().getTime());
    %>
    <div  style="color: white;
          padding: 15px 50px 5px 50px;
          float: right;
          font-size: 16px;">Company Last access : <%= mydate%> &nbsp; <a href="/Tailor/logout/company_logout.jsp" class="btn btn-danger square-btn-adjust">Logout</a> </div>
    <%
    } else if (logger.equals("branch")) {
        String mydate = java.text.DateFormat.getDateTimeInstance().format(Calendar.getInstance().getTime());
    %>
    <div style="float: left; color: white; margin-left: 30%; line-height: 50px;">
        <%
            String com_name = null;

            PreparedStatement pst_com = null;
            ResultSet rs_com = null;
            try {
                String sql_company = "select * from user_company where com_company_id = '" + session.getAttribute("user_com_id") + "' ";
                pst_com = DbConnection.getConn(sql_company);
                rs_com = pst_com.executeQuery();
                if (rs_com.next()) {
                    com_name = rs_com.getString("com_name");
                } else {
                    PreparedStatement pst_bran_name = null;
                    ResultSet rs_bran_name = null;
                    try {
                        String sql_bran_name = "select * from user_branch where bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                        pst_bran_name = DbConnection.getConn(sql_bran_name);
                        rs_bran_name = pst_bran_name.executeQuery();
                        if (rs_bran_name.next()) {
                            com_name = rs_bran_name.getString("bran_name");
                        }
                    } catch (Exception e) {
                        out.println(e.toString());
                    } finally {
                        //pst_bran_name.close();
                        rs_bran_name.close();
                    }
                }
        %>
        <span style="font-size: 26px;"><%if (com_name != null) {%><%=com_name%><%} %></span>
        <%
            } catch (Exception e) {
                out.println("company namne " + e.toString());
            } finally {
                //pst_com.close();
                rs_com.close();
            }
        %>
    </div>

    <div style="color: white;
         padding: 15px 50px 5px 50px;
         float: right;
         font-size: 12px;">Branch Last access 
        <span class="clock">
            <span class="hours"></span> :
            <span class="minutes"></span> :
            <span class="seconds"></span> 
            <span class="twelvehr"></span>
        </span>
        &nbsp; <a href="/Tailor/logout/branch_logout.jsp" class="btn btn-danger square-btn-adjust">Logout</a> </div>
        <%
            }
        %>
        <%
            } else {

            }
        %>
</nav>   
<!-- /. NAV TOP  -->
<nav class="navbar-default navbar-side" role="navigation">
    <div class="sidebar-collapse" >
        <ul class="nav menu" id="main-menu" style="">
            <li class="text-center">
                <%
                    if (logger != null) {

                        if (logger.equals("root")) {
                %>
                <img src="/Tailor/admin/assets/img/IGL_Group_logo.png" class="user-image img-responsive"/>
                <%
                    }
                    if (logger.equals("company")) {
                %>
                <img src="/Tailor/admin/assets/img/find_user.png" class="user-image img-responsive"/>
                <%
                        }
                        if (logger.equals("branch")) {

                        } else if (logger.equals("user")) {

                        } else {

                        }

                    } else {
                        response.sendRedirect("/Tailor/index.jsp");
                    }
                %>
            </li>

            <%
                //                var pgurl = href.substr(href.lastIndexOf('/') + 1);
                String pag = request.getRequestURI();
                String cur_page = pag.substring(pag.lastIndexOf("/") + 1);
                String style_text = "border: 1px solid #778899 !important";
                String ulStyle = "margin-left: 10%; line-height: 25%";
            %>

            <%
                if (logger != null) {
                    if (logger.equals("user")) {
            %>
            <li>
            <center><a href="/Tailor/admin/product_sale.jsp" style="padding: 0; display: inline"> <img src="../admin/assets/img/jj.png"  class="img-rounded" alt="" style="height: 38px; width: 80%;  margin-top: 5px"/></a></center>
            </li>
            <li>
            <center><a href="/Tailor/admin/add_sell_order.jsp" style="padding: 0"> <img class="img-rounded" src="../admin/assets/img/order.png" alt="" style="height: 50px; width: 80%; margin: 0px;"/></a></center>
            </li>
            <li class="<%=current_page_order_report%>">
                <a href="/Tailor/admin/report_order.jsp"><i class="fa fa-square-o fa-2x"></i>Order Report<span class="fa arrow"></span></a>
                <ul class="nav multiplelabel submenu" style="<%=ulStyle%>">
                    <li>
                        <a href="/Tailor/admin/report_order.jsp"<%if (cur_page.equals("report_order.jsp")) {%>style="<%=style_text%>"<%}%>>Receive</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/processing_order_reports.jsp"<%if (cur_page.equals("processing_order_reports.jsp")) {%>style="<%=style_text%>"<%}%>>Processing</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/order_maker_details.jsp"<%if (cur_page.equals("order_maker_details.jsp")) {%>style="<%=style_text%>"<%}%>>Waiting For Complete</a>
                    </li>                    
                    <li>
                        <a href="/Tailor/admin/order_show_details_searching.jsp"<%if (cur_page.equals("order_show_details_searching.jsp")) {%>style="<%=style_text%>"<%}%>>Show Order Details</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/order_list.jsp"<%if (cur_page.equals("order_list.jsp")) {%>style="<%=style_text%>"<%}%>>Order List</a>
                    </li>
                </ul>
            </li>
            <li class="<%=current_page_customer%>">
                <a href="#"><span class="glyphicon glyphicon-user fa-2x" style="margin-right: 5px;"></span>Customers<span class="fa arrow"></span></a>
                <ul class="nav multiplelabel submenu" style="<%=ulStyle%>">
                    <li>
                        <a href="/Tailor/admin/customer_registration.jsp"<%if (cur_page.equals("customer_registration.jsp")) {%>style="<%=style_text%>"<%}%>>Customer Registration</a>
                    </li>
                    <li id="all_customer">
                        <a href="all_customer_view.jsp"<%if (cur_page.equals("all_customer_view.jsp")) {%>style="<%=style_text%>"<%}%>>All Customers</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/customer_payment.jsp"<%if (cur_page.equals("customer_payment.jsp")) {%>style="<%=style_text%>"<%}%>>Payments</a>
                    </li>
                    <!--                    <li>
                                            <a href="/Tailor/admin/customer_payment_statement.jsp">Payment Statement</a>
                                        </li>-->
                    <li>
                        <a href="/Tailor/admin/customer_statement.jsp"<%if (cur_page.equals("customer_statement.jsp")) {%>style="<%=style_text%>"<%}%>>View Customer Statement</a>
                    </li>
                </ul>
            </li>
            <li class="<%=current_page_maker%>">
                <a href="#"><span class="glyphicon glyphicon-user fa-2x" style="margin-right: 5px;"></span>Worker<span class="fa arrow"></span></a>
                <ul class="nav multiplelabel submenu" style="<%=ulStyle%>">
                    <li> <a href="/Tailor/admin/maker_reg.jsp"<%if (cur_page.equals("maker_reg.jsp")) {%>style="<%=style_text%>"<%}%>>Maker Registration</a></li>
                    <li> <a href="/Tailor/admin/maker_payment.jsp"<%if (cur_page.equals("maker_payment.jsp")) {%>style="<%=style_text%>"<%}%>>Maker Payment</a></li>
                    <li>
                        <a href="/Tailor/admin/maker_complete_orders.jsp"<%if (cur_page.equals("maker_complete_orders.jsp")) {%>style="<%=style_text%>"<%}%>>Maker Pending Payment</a>
                    </li>
                    <!--                    <li>
                                            <a href="/Tailor/admin/maker_statement.jsp">Maker Statement</a>
                                        </li>-->
                    <li>
                        <a href="/Tailor/admin/maker_statement_details.jsp"<%if (cur_page.equals("maker_statement_details.jsp")) {%>style="<%=style_text%>"<%}%>>Statement</a>
                    </li>
                </ul>
            </li>
            
            <li class="<%=current_page_product_information%>">
                <a href="#"><span class="glyphicon glyphicon-gift fa-2x" style="margin-right: 5px"></span>Product Information<span class="fa arrow"></span></a>
                <ul class="nav multiplelabel submenu" style="<%=ulStyle%>">
                    <li>
                        <a href="/Tailor/admin/add_group.jsp"<%if (cur_page.equals("add_group.jsp")) {%>style="<%=style_text%>"<%}%>>Add Group</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/add_product_type.jsp"<%if (cur_page.equals("add_product_type.jsp")) {%>style="<%=style_text%>"<%}%>>Add Product Type</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/add_product_name.jsp"<%if (cur_page.equals("add_product_name.jsp")) {%>style="<%=style_text%>"<%}%>>Add Product Name</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/location.jsp"<%if (cur_page.equals("location.jsp")) {%>style="<%=style_text%>"<%}%>>Add Location</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/add_product.jsp"<%if (cur_page.equals("add_product.jsp")) {%>style="<%=style_text%>"<%}%>>Add Product</a>
                    </li>
                </ul>                               
            </li>
            <li class="<%=current_page_supplier_information%>">
                <a href="#"><span class="glyphicon glyphicon-book fa-2x" style="margin-right: 5px;"></span>Supplier Information<span class="fa arrow"></span></a>
                <ul class="nav multiplelabel submenu" style="<%=ulStyle%>">
                    <li>
                        <a class="menu" href="/Tailor/admin/add_supplier.jsp"<%if (cur_page.equals("add_supplier.jsp")) {%>style="<%=style_text%>"<%}%>>Add Supplier</a>
                    </li>
                    <li>
                        <a class="menu" href="/Tailor/admin/add_supplier_payment.jsp"<%if (cur_page.equals("add_supplier_payment.jsp")) {%>style="<%=style_text%>"<%}%>> Supplier Payment</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/add_supplier_bank.jsp"<%if (cur_page.equals("add_supplier_bank.jsp")) {%>style="<%=style_text%>"<%}%>> Add Supplier Bank</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/add_payment_date.jsp"<%if (cur_page.equals("add_payment_date.jsp")) {%>style="<%=style_text%>"<%}%>> Add Payment Date</a>
                    </li>                    
                </ul>                               
            </li>
            <li class="<%=current_page_bank_account%>">
                <a href="#"><span class="glyphicon glyphicon-book fa-2x" style="margin-right: 5px;"></span>Bank Details<span class="fa arrow"></span></a>
                <ul class="nav" style="<%=ulStyle%>">                    
                    <li>
                        <a class="menu" href="/Tailor/admin/add_bank_deposit.jsp" <%if (cur_page.equals("add_bank_deposit.jsp")) {%>style="<%=style_text%>"<%}%>> Bank Deposit</a>
                    </li>              
                </ul>
            </li>
            <%
                    } else {
                        response.sendRedirect("/Tailor/index.jsp");
                    }
                }
            %>

            <%
                if (logger != null) {
                    if (logger.equals("root")) {
            %>
            <li>
                <a href="/Tailor/admin/com_reg.jsp"><span class="glyphicon glyphicon-edit fa-2x" style="margin-right: 3px;"></span>Company Registration</a>
            </li>
            <li>
                <a href="/Tailor/admin/company_list.jsp"><span class="glyphicon glyphicon-th fa-2x" style="margin-right: 3px;"></span>Company List</a>
            </li>
            <li>
                <a href="/Tailor/admin/branch_regis.jsp"><span class="glyphicon glyphicon-edit fa-2x" style="margin-right: 3px;"></span>Branch Registration</a>
            </li>
            <li>
                <a href="/Tailor/admin/branch_list.jsp"><span class="glyphicon glyphicon-th fa-2x" style="margin-right: 3px;"></span>Branch List</a>
            </li>            
            <%
                    }
                } else {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            %>

            <%
                if (logger != null) {
                    if (logger.equals("branch")) {

            %>

            <!--            <li>
                            <a href="/Tailor/admin/report_order.jsp"><i class="fa fa-square-o fa-2x"></i>Order Report</a>                
                        </li>-->
            <li>
            <center><a href="/Tailor/admin/parchase.jsp" style="padding: 0; display: inline; margin-top: 8px"> <img class="img-rounded" src="../admin/assets/img/purchas.png" alt="" style="width: 38%; height: 40px; margin-top: 8px"/></a><a href="/Tailor/admin/product_sale.jsp" style="padding: 0; display: inline"> <img src="../admin/assets/img/jj.png"  class="img-rounded" alt="" style="width: 38%; height: 40px; margin-top: 8px"/></a></center>
            </li>           
            <li>
            <center><a href="/Tailor/admin/add_sell_order.jsp" style="padding: 0"> <img class="img-rounded" src="../admin/assets/img/order.png" alt="" style="height: 50px; width: 80%; margin: 0px;"/></a></center>
            </li> 
            <li class="<%=current_page_order_report%>">
                <a href="/Tailor/admin/report_order.jsp"><i class="fa fa-square-o fa-2x"></i>Order Report<span class="fa arrow"></span></a>
                <ul class="nav multiplelabel submenu" style="<%=ulStyle%>">
                    <li>
                        <a href="/Tailor/admin/report_order.jsp" <%if (cur_page.equals("report_order.jsp")) {%>style="<%=style_text%>"<%}%>>Receive</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/processing_order_reports.jsp" <%if (cur_page.equals("processing_order_reports.jsp")) {%>style="<%=style_text%>"<%}%>>Processing</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/order_maker_details.jsp" <%if (cur_page.equals("order_maker_details.jsp")) {%>style="<%=style_text%>"<%}%>>Waiting For Complete</a>
                    </li>                    
                    <li>
                        <a href="/Tailor/admin/order_show_details_searching.jsp" <%if (cur_page.equals("order_show_details_searching.jsp")) {%>style="<%=style_text%>"<%}%>>Show Order Details</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/order_list.jsp" <%if (cur_page.equals("order_list.jsp")) {%>style="<%=style_text%>"<%}%>>Order List</a>
                    </li>
                </ul>
            </li>
            <li class="<%=current_page_customer%>">
                <a href="#"><span class="glyphicon glyphicon-user fa-2x" style="margin-right: 5px;"></span>Customers<span class="fa arrow"></span></a>
                <ul class="nav" style="<%=ulStyle%>">
                    <li>
                        <a href="/Tailor/admin/customer_registration.jsp" <%if (cur_page.equals("customer_registration.jsp")) {%>style="<%=style_text%>"<%}%>>Customer Registration</a>
                    </li>
                    <li>
                        <a href="all_customer_view.jsp" <%if (cur_page.equals("all_customer_view.jsp")) {%>style="<%=style_text%>"<%}%>>All Customers</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/customer_payment.jsp" <%if (cur_page.equals("customer_payment.jsp")) {%>style="<%=style_text%>"<%}%>>Payments</a>
                    </li>
                    <!--                    <li>
                                            <a href="/Tailor/admin/customer_payment_statement.jsp">Payment Statement</a>
                                        </li>-->
                    <li>
                        <a href="/Tailor/admin/customer_statement.jsp" <%if (cur_page.equals("customer_statement.jsp")) {%>style="<%=style_text%>"<%}%>>View Customer Statement</a>
                    </li>
                </ul>
            </li>
            <li class="<%=current_page_maker%>">
                <a href="#"><span class="glyphicon glyphicon-user fa-2x" style="margin-right: 5px;"></span>Worker<span class="fa arrow"></span></a>
                <ul class="nav" style="<%=ulStyle%>">
                    <li> <a href="/Tailor/admin/maker_reg.jsp" <%if (cur_page.equals("maker_reg.jsp")) {%>style="<%=style_text%>"<%}%>>Maker Registration</a></li>
                    <li> <a href="/Tailor/admin/maker_payment.jsp" <%if (cur_page.equals("maker_payment.jsp")) {%>style="<%=style_text%>"<%}%>>Maker Payment</a></li>
                    <li>
                        <a href="/Tailor/admin/maker_complete_orders.jsp" <%if (cur_page.equals("maker_complete_orders.jsp")) {%>style="<%=style_text%>"<%}%>>Maker Pending Payment</a>
                    </li>
                    <!--                    <li>
                                            <a href="/Tailor/admin/maker_statement.jsp">Maker Statement</a>
                                        </li>-->
                    <li>
                        <a href="/Tailor/admin/maker_statement_details.jsp" <%if (cur_page.equals("maker_statement_details.jsp")) {%>style="<%=style_text%>"<%}%>>Statement</a>
                    </li>
                </ul>
            </li>
            <li class="<%=current_page_user%>">
                <a href="#"> <span class="glyphicon glyphicon-user fa-2x" style="margin-right: 5px;"></span>User <span class="fa arrow"></span></a>
                <ul class="nav" style="<%=ulStyle%>">
                    <li>
                        <a href="/Tailor/admin/user_reg.jsp" <%if (cur_page.equals("user_reg.jsp")) {%>style="<%=style_text%>"<%}%>>User Registration</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/all_users.jsp" <%if (cur_page.equals("all_users.jsp")) {%>style="<%=style_text%>"<%}%>>User List</a>
                    </li>
                </ul>
            </li>
<!--            <li class="<%=current_page_all_report%>">
                <a href="#"> <span class="glyphicon glyphicon-user fa-2x" style="margin-right: 5px;"></span>Report <span class="fa arrow"></span></a>
                <ul class="nav nav-third-level">
                    <li>
                        <a href="/Tailor/admin/maker_statement_details.jsp?page_name=all_report">Maker Statement</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/customer_statement.jsp?page_name=all_report">View Customer Statement</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/supplier_statement.jsp?page_name=all_report">Supplier Statement</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/branch_expend_statement.jsp?page_name=all_report">Account Statement</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/buy_product_statement.jsp?page_name=all_report">Product Buy Statement</a>                        
                    </li>
                    <li>
                        <a href="/Tailor/admin/sell_product_statement.jsp?page_name=all_report">Product Sell Statement</a>
                    </li>
                </ul>
            </li>-->
            <li class="<%=current_page_product_information%>">
                <a href="#"><span class="glyphicon glyphicon-gift fa-2x" style="margin-right: 5px"></span>Product Information<span class="fa arrow"></span></a>
                <ul class="nav" style="<%=ulStyle%>">
                    <li>
                        <a href="/Tailor/admin/add_group.jsp" <%if (cur_page.equals("add_group.jsp")) {%>style="<%=style_text%>"<%}%>>Add Group</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/view_group.jsp" <%if (cur_page.equals("view_group.jsp")) {%>style="<%=style_text%>"<%}%>>View Group</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/add_product_type.jsp" <%if (cur_page.equals("add_product_type.jsp")) {%>style="<%=style_text%>"<%}%>>Add Product Type</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/view_product_type.jsp" <%if (cur_page.equals("view_product_type.jsp")) {%>style="<%=style_text%>"<%}%>>View Product Type</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/add_product_name.jsp" <%if (cur_page.equals("add_product_name.jsp")) {%>style="<%=style_text%>"<%}%>>Add Product Name</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/view_product_name.jsp" <%if (cur_page.equals("view_product_name.jsp")) {%>style="<%=style_text%>"<%}%>>View Product Name</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/location.jsp" <%if (cur_page.equals("location.jsp")) {%>style="<%=style_text%>"<%}%>>Add Location</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/view_location.jsp" <%if (cur_page.equals("view_location.jsp")) {%>style="<%=style_text%>"<%}%>>View Location</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/add_product.jsp" <%if (cur_page.equals("add_product.jsp")) {%>style="<%=style_text%>"<%}%>>Add Product</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/view_product.jsp" <%if (cur_page.equals("view_product.jsp")) {%>style="<%=style_text%>"<%}%>>View Product</a>
                    </li>
                </ul>                               
            </li>
            <li class="<%=current_page_supplier_information%>">
                <a href="#"><span class="glyphicon glyphicon-book fa-2x" style="margin-right: 5px;"></span>Supplier Information<span class="fa arrow"></span></a>
                <ul class="nav" style="<%=ulStyle%>">
                    <li>
                        <a class="menu" href="/Tailor/admin/add_supplier.jsp" <%if (cur_page.equals("add_supplier.jsp")) {%>style="<%=style_text%>"<%}%>>Add Supplier</a>
                    </li>
                    <li>
                        <a class="menu" href="/Tailor/admin/add_supplier_payment.jsp" <%if (cur_page.equals("add_supplier_payment.jsp")) {%>style="<%=style_text%>"<%}%>> Supplier Payment</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/add_supplier_bank.jsp" <%if (cur_page.equals("add_supplier_bank.jsp")) {%>style="<%=style_text%>"<%}%>> Add Supplier Bank</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/add_payment_date.jsp" <%if (cur_page.equals("add_payment_date.jsp")) {%>style="<%=style_text%>"<%}%>> Add Payment Date</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/supplier_statement.jsp" <%if (cur_page.equals("supplier_statement.jsp")) {%>style="<%=style_text%>"<%}%>>Supplier Statement</a>
                    </li>                    
                </ul>
            </li>
            <li class="<%=current_page_bank_account%>">
                <a href="#"><span class="glyphicon glyphicon-book fa-2x" style="margin-right: 5px;"></span>Bank Details<span class="fa arrow"></span></a>
                <ul class="nav" style="<%=ulStyle%>">
                    <li>
                        <a class="menu" href="/Tailor/admin/open_bank_account.jsp" <%if (cur_page.equals("open_bank_account.jsp")) {%>style="<%=style_text%>"<%}%>>Open Bank Account</a>
                    </li>
                    <li>
                        <a class="menu" href="/Tailor/admin/bank_list.jsp" <%if (cur_page.equals("bank_list.jsp")) {%>style="<%=style_text%>"<%}%>> Bank Account List</a>
                    </li>
                    <li>
                        <a class="menu" href="/Tailor/admin/add_bank_deposit.jsp" <%if (cur_page.equals("add_bank_deposit.jsp")) {%>style="<%=style_text%>"<%}%>> Bank Deposit</a>
                    </li>
                    <li>
                        <a class="menu" href="/Tailor/admin/add_bank_withdraw.jsp" <%if (cur_page.equals("add_bank_withdraw.jsp")) {%>style="<%=style_text%>"<%}%>> Bank WithDraw</a>
                    </li>
                    <li>
                        <a class="menu" href="/Tailor/admin/cash_transfer.jsp" <%if (cur_page.equals("cash_transfer.jsp")) {%>style="<%=style_text%>"<%}%>> Cash Transfer</a>
                    </li>
                    <!--                    <li>
                                            <a class="menu" href="/Tailor/admin/add_cash.jsp" <%if (cur_page.equals("add_cash.jsp")) {%>style="<%=style_text%>"<%}%>>Add Cash</a>
                                        </li>-->
                    <li>
                        <a class="menu" href="/Tailor/admin/bank_statement.jsp" <%if (cur_page.equals("bank_statement.jsp")) {%>style="<%=style_text%>"<%}%>> Bank Statement</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="/Tailor/admin/price_change_by_user.jsp"> <span class="glyphicon glyphicon-repeat fa-2x"></span> Price Update</a>
            </li>
            <li class="<%=current_page_cost%>">
                <a href="#"><span class="glyphicon glyphicon-usd fa-2x" style="margin-right: 5px;"></span>Cost<span class="fa arrow"></span></a>
                <ul class="nav" style="<%=ulStyle%>">
                    <li>
                        <a href="/Tailor/admin/worker_salary.jsp"  <%if (cur_page.equals("worker_salary.jsp")) {%>style="<%=style_text%>"<%}%>>Set Making Cost</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/total_income_spend.jsp" <%if (cur_page.equals("total_income_spend.jsp")) {%>style="<%=style_text%>"<%}%>>Total Income And Spend</a>
                    </li>                   
                    <li>
                        <a href="/Tailor/admin/expend.jsp" <%if (cur_page.equals("expend.jsp")) {%>style="<%=style_text%>"<%}%>>Expend</a>
                    </li>
                    <!--                    <li>
                                            <a href="/Tailor/admin/branch_expend_statement.jsp">Brach Expend Statement</a>
                                        </li>-->
                </ul>
            </li>
            <li class="<%=current_page_account%>">
                <a href="#"><span class="glyphicon glyphicon-usd fa-2x" style="margin-right: 5px;"></span>Account<span class="fa arrow"></span></a>
                <ul class="nav" style="<%=ulStyle%>">                    
                    <!--                    <li>
                                            <a href="/Tailor/admin/branch_statement.jsp">Account Statement</a>
                                        </li>-->
                    <li>
                        <a href="/Tailor/admin/branch_expend_statement.jsp" <%if (cur_page.equals("branch_expend_statement.jsp")) {%>style="<%=style_text%>"<%}%>>Account Statement</a>
                    </li>
                    <li>
                        <a href="/Tailor/admin/buy_product_statement.jsp" <%if (cur_page.equals("buy_product_statement.jsp")) {%>style="<%=style_text%>"<%}%>>Product Buy Statement</a>                        
                    </li>
                    <li>
                        <a href="/Tailor/admin/sell_product_statement.jsp" <%if (cur_page.equals("sell_product_statement.jsp")) {%>style="<%=style_text%>"<%}%>>Product Sell Statement</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="/Tailor/admin/bran_edit_by_bran.jsp"> <span class="glyphicon glyphicon-repeat fa-2x"></span>Edit Logo and address</a>
            </li>

            <%
                    }
                } else {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            %>

            <%
                if (logger != null) {
                    if (logger.equals("company")) {
            %>           
            <li>
                <a href="/Tailor/admin/branch_regis.jsp"><span class="glyphicon glyphicon-edit fa-2x" style="margin-right: 5px;"></span>Branch Registration</a>
            </li>
            <li>
                <a href="/Tailor/admin/branch_list_according_com.jsp"><span class="glyphicon glyphicon-th fa-2x" style="margin-right: 3px;"></span>Branch List</a>
            </li>
            <li>
                <a href="../admin/com_balance_bran.jsp?balance_status=all_branch" ><span class="glyphicon glyphicon-usd fa-2x" style="margin-right: 3px;"></span>Balance</a>
            </li>
            <%
                    }
                } else {
                    response.sendRedirect("/Tailor/index.jsp");
                }

            %>
        </ul>
    </div>

</nav>
<script type="text/javascript">
    function googleTranslateElementInit() {
        new google.translate.TranslateElement({pageLanguage: 'en', layout: google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: false}, 'google_translate_element');
    }
</script> 
<script>

    !function () {
        var href = location.href;
        var pgurl = href.substr(href.lastIndexOf('/') + 1);
        var activeurl = window.location.pathname.replace(/.*\//, '');
        // match all the anchors on the page with the html file name
        var page = this.href;
        console.log("page url " + pgurl + " page " + activeurl);
        $('#nav-accordion').find('a[href="' + activeurl + '"]').parents('ul.sub').siblings('a').addClass('active');
    }();

    var $document = $(document);
    (function () {
        var clock = function () {
            clearTimeout(timer);
            date = new Date();
            hours = date.getHours();
            minutes = date.getMinutes();
            seconds = date.getSeconds();
            seconds = "" + seconds;
            dd = (hours >= 12) ? 'PM' : 'AM';
            hours = (hours > 12) ? (hours - 12) : hours;
            var timer = setTimeout(clock, 1000);
            $('.hours').html(Math.floor(hours));
            $('.minutes').html(Math.floor(minutes));
            $('.seconds').html(Math.floor(seconds));
            $('.twelvehr').html(dd);
        };
        clock();
    })();

    (function () {
        $document.bind('contextmenu', function (e) {
            e.preventDefault();
        });
    })();
</script>
<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>