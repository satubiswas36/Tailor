<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    session.removeAttribute("user_msg_login");
    session.removeAttribute("company_login_msg");
    session.removeAttribute("branch_login_msg");
    session.removeAttribute("root_login_msg");
    String logger = (String) session.getAttribute("logger");

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
                    response.sendRedirect("/Tailor/index.jsp");
                }
            } else if (logger.equals("branch")) {
                String user_bran_id = (String) session.getAttribute("user_bran_id");
                if (user_bran_id == null) {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            }
        } else {
            response.sendRedirect("/Tailor/index.jsp");
        }

    } catch (Exception e) {
        out.println(e.toString());
    }

    long bran_diffDays = 0;
    String bran_status = null;
    if (logger != null) {
        if (logger.toLowerCase().equals("branch")) {
            String bran_given_date = null;
            String bran_today = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
            try {
                String bran_valid_id = (String) session.getAttribute("user_bran_id");
                String sql_branch_validation = "select * from user_branch where bran_id = '" + bran_valid_id + "' ";
                PreparedStatement pst_branch_validation = DbConnection.getConn(sql_branch_validation);
                ResultSet rs_branch_validation = pst_branch_validation.executeQuery();
                if (rs_branch_validation.next()) {
                    bran_given_date = rs_branch_validation.getString("bran_expire_date");
                    // bran_date_diff = bran_given_date.compareTo(bran_today);
                    bran_status = rs_branch_validation.getString("bran_status");
                    // String given_date = "21-10-2018";
                    // String date = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
                    SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
                    Date d1 = null;
                    Date d2 = null;
                    try {
                        d2 = format.parse(bran_given_date);
                        d1 = format.parse(bran_today);
                    } catch (ParseException e) {
                        out.println(e.toString());
                    }
                    long diff = d2.getTime() - d1.getTime();
                    bran_diffDays = diff / (24 * 60 * 60 * 1000);
                }
                if (bran_diffDays < 0) {
                    response.sendRedirect("/Tailor/admin/validation_check.jsp");
                }
                if(bran_status.equals("3")){
                     response.sendRedirect("/Tailor/admin/suspended.jsp");
                }
            } catch (Exception e) {
                out.println("branch validation");
            }
        }
    }

    long com_date_diff = 0;    
    if (logger != null) {
        if (logger.toLowerCase().equals("company")) {
            String com_given_date = null;
            String com_today = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
            try {
                String com_valid_id = (String) session.getAttribute("user_com_id");
                String sql_company_validation = "select * from user_company where com_company_id = '" + com_valid_id + "' ";
                PreparedStatement pst_company_validation = DbConnection.getConn(sql_company_validation);
                ResultSet rs_company_validation = pst_company_validation.executeQuery();
                if (rs_company_validation.next()) {
                    com_given_date = rs_company_validation.getString("com_expiredate");
                    SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
                    
                    Date d1 = null;
                    Date d2 = null;
                    try {
                        d2 = format.parse(com_given_date);
                        d1 = format.parse(com_today);
                    } catch (ParseException e) {
                        out.println(e.toString());
                    }
                    long diff = d2.getTime() - d1.getTime();
                    com_date_diff = diff / (24 * 60 * 60 * 1000);
                }
                if (com_date_diff < 0) {
                    response.sendRedirect("/Tailor/admin/validation_check.jsp");
                }
            } catch (Exception e) {
                out.println("company validation");
            }
        }
        
        if(logger.equals("user")){
            String userid = null;
            String user_status = null;
            if(session.getAttribute("user_user_id") != null){
                userid = (String)session.getAttribute("user_user_id");
            }
            try {
                    String sql_user_profile = "select * from user_user where user_bran_id = '"+session.getAttribute("user_bran_id")+"' and user_id = '"+userid+"' ";
                    PreparedStatement pst_user_profile = DbConnection.getConn(sql_user_profile);
                    ResultSet rs_user_profile = pst_user_profile.executeQuery();
                    if(rs_user_profile.next()){
                        user_status = rs_user_profile.getString("user_status");
                    }
                    if(user_status.equals("2")){
                        response.sendRedirect("/Tailor/admin/Invalid_user.jsp");
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
        }
    }
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp" flush="true"/>
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" style="height: auto">
                <div id="page-inner" style="height: auto">
                    <%
                        //  out.println(session.getAttribute("user_com_id"));
                        // out.println(session.getAttribute("logger"));
                        // out.println(session.getAttribute("user_user_id"));
                        if (logger != null) {
                            if (logger.equals("user")) {
                    %>
                    <div class="row">
                        <div class="col-md-12">  
                            <h2>
                                <%
                                    if (session.getAttribute("com_reg_msg") != null) {
                                %>
                                <%= session.getAttribute("com_reg_msg")%>
                                <%
                                        session.removeAttribute("com_reg_msg");
                                    }
                                %>
                            </h2>
                        </div>
                    </div>
                    <!-- /. ROW  -->
                    <hr>
                        <div class="row">                            
                            <%
                                // all user from user_user table
                                int total_user = 0;
                                try {

                                    String sql_all_user = "select COUNT(*) from user_user where user_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                    PreparedStatement pst_all_user = DbConnection.getConn(sql_all_user);
                                    ResultSet rs_all_user = pst_all_user.executeQuery();
                                    while (rs_all_user.next()) {
                                        total_user = Integer.parseInt(rs_all_user.getString(1));
                                    }
                                } catch (Exception e) {
                                    out.println(e.toString());
                                }
                            %>
                            <div class="col-md-3 col-sm-6 col-xs-6">
                                <div class="panel panel-back noti-box">
                                    <span class="icon-box bg-color-green set-icon">
                                        <i class="fa fa-user"></i>
                                    </span>
                                    <div class="text-box" >
                                        <p class="main-text"><%= total_user%></p>
                                        <p class="text-muted">Users</p>
                                    </div>
                                </div>
                            </div>
                            <%
                                // all user from user_user table
                                int total_customer = 0;
                                try {
                                    String sql_all_customer = "select COUNT(*) from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                    PreparedStatement pst_all_customer = DbConnection.getConn(sql_all_customer);
                                    ResultSet rs_all_customer = pst_all_customer.executeQuery();
                                    while (rs_all_customer.next()) {
                                        total_customer = Integer.parseInt(rs_all_customer.getString(1));
                                    }
                                } catch (Exception e) {
                                    out.println(e.toString());
                                }
                            %>
                            <div class="col-md-3 col-sm-6 col-xs-6">
                                <div class="panel panel-back noti-box">
                                    <span class="icon-box bg-color-green set-icon">
                                        <i class="fa fa-users"></i>
                                    </span>                                   
                                    <div class="text-box" >
                                        <p class="main-text"><%=total_customer%></p>
                                        <p class="text-muted">Customers </p>
                                    </div>
                                </div>
                            </div>                            
                        </div>
                        <!-- /. ROW  -->
                        <hr />                
                        <div class="row">
                            <div class="col-lg-12 ">
                                <div class="alert alert-info">
                                    <strong>Welcome Jhon Doe! </strong> You Have No pending Task For Today.
                                </div>
                            </div>
                        </div>
                        <!-- /. ROW  --> 
                        <div class="row text-center pad-top">
                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6" style="display: block">
                                <div class="div-square">
                                    <a href="add_sell_order.jsp" >
                                        <i class="fa fa-plus fa-4x" style="color: green"></i>
                                        <h5>Add Order</h5>
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                <div class="div-square">
                                    <a href="customer_payment.jsp" >
                                        <i class="fa fa-usd fa-4x" style="color: #3AAECD"></i>
                                        <h5>Add Payment</h5>
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                <div class="div-square">
                                    <a href="customer_payment_statement.jsp" >
                                        <i class="fa fa-book fa-4x" style="color: #246630"></i>
                                        <h5>Check payment</h5>
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                <div class="div-square">
                                    <a href="all_customer_view.jsp" >
                                        <i class="fa fa-users fa-4x" style="color: green"></i>
                                        <h5>See customers</h5>
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                <div class="div-square">
                                    <a href="report_order.jsp" >
                                        <i class="fa fa-clipboard fa-4x" style="color: #2046CF"></i>
                                        <h5>All Orders</h5>
                                    </a>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                <div class="div-square">
                                    <a href="user_profile_update.jsp" >
                                        <i class="fa fa-gear fa-4x" style="color: black"></i>
                                        <h5>Settings</h5>
                                    </a>
                                </div>
                            </div>  
                        </div> 
                        <div class="row text-center pad-top">
                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                <div class="div-square">
                                    <a href="#" >
                                        <i class="fa fa-bell-o fa-4x" style="color: #DE6E04"></i>
                                        <h5>Notifications </h5>
                                    </a>
                                </div>
                            </div>                            
                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                <div class="div-square">
                                    <a href="customer_registration.jsp" >
                                        <i class="fa fa-user fa-4x" style="color: #3AAECD"></i>
                                        <h5>Customer Registration</h5>
                                    </a>
                                </div>
                            </div> 
                        </div>
                        <%
                                }
                            }
                        %>
                        <%
                            if (logger != null) {
                                if (logger.equals("root")) {
                        %>
                        <div class="row">
                            <div class="col-md-12">  
                                <h2>
                                    <%
                                        if (session.getAttribute("com_reg_msg") != null) {
                                    %>
                                    <%= session.getAttribute("com_reg_msg")%>
                                    <%
                                            session.removeAttribute("com_reg_msg");
                                        }
                                    %>
                                </h2>
                            </div>
                        </div>
                        <!-- /. ROW  -->
                        <hr>
                            <div class="row">                               
                                <%
                                    // all user from user_user table
                                    int total_com = 0;
                                    try {

                                        String sql_all_com = "select COUNT(*) from user_company";
                                        PreparedStatement pst_all_com = DbConnection.getConn(sql_all_com);
                                        ResultSet rs_all_com = pst_all_com.executeQuery();
                                        while (rs_all_com.next()) {
                                            total_com = Integer.parseInt(rs_all_com.getString(1));
                                        }
                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                %>
                                <div class="col-md-3 col-sm-6 col-xs-6">
                                    <div class="panel panel-back noti-box">
                                        <span class="icon-box bg-color-green set-icon">
                                            <span class=""><%= total_com%></span>
                                        </span>
                                        <center> <div class="text-box" >
                                                <p class="main-text"></p>
                                                <p class="text-muted">Company</p>
                                            </div></center>
                                    </div>
                                </div>
                                <%
                                    // all user from user_user table
                                    int total_branch = 0;
                                    try {

                                        String sql_all_branch = "select COUNT(*) from user_branch";
                                        PreparedStatement pst_all_branch = DbConnection.getConn(sql_all_branch);
                                        ResultSet rs_all_branch = pst_all_branch.executeQuery();
                                        while (rs_all_branch.next()) {
                                            total_branch = Integer.parseInt(rs_all_branch.getString(1));
                                        }
                                    } catch (Exception e) {
                                        out.println(e.toString());
                                    }
                                %>
                                <div class="col-md-3 col-sm-6 col-xs-6">
                                    <div class="panel panel-back noti-box">
                                        <span class="icon-box bg-color-green set-icon">
                                            <span class=""><%=total_branch%></span>
                                        </span>                                   
                                        <div class="text-box" >
                                            <p class="main-text"></p>
                                            <p class="text-muted">Branches</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /. ROW  -->
                            <hr />                
                            <div class="row">
                                <div class="col-lg-12 ">
                                    <div class="alert alert-info">
                                        <strong>Welcome Jhon Doe ! </strong> You Have No pending Task For Today.
                                    </div>
                                </div>
                            </div>
                            <!-- /. ROW  --> 
                            <div class="row text-center pad-top">
                                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6" style="display: block">
                                    <div class="div-square">
                                        <a href="com_reg.jsp" >
                                            <i class="fa fa-edit fa-4x" style="color: green"></i>
                                            <h5>Company Registration</h5>
                                        </a>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6" style="display: block">
                                    <div class="div-square">
                                        <a href="company_list.jsp" >
                                            <i class="fa fa-clipboard fa-4x" style="color: #00ADEF"></i>
                                            <h5>View Company</h5>
                                        </a>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6" style="display: block">
                                    <div class="div-square">
                                        <a href="branch_regis.jsp" >
                                            <i class="fa fa-edit fa-4x" style="color: green"></i>
                                            <h5>Branch Registration</h5>
                                        </a>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6" style="display: block">
                                    <div class="div-square">
                                        <a href="branch_list.jsp" >
                                            <i class="fa fa-clipboard fa-4x" style="color: #00ADEF"></i>
                                            <h5>View all branch</h5>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>
                            <%
                                if (logger != null) {
                                    if (logger.equals("company")) {
                            %>
                            <div class="row">
                                <div class="col-md-12">  
                                    <h2>
                                        <%
                                            if (session.getAttribute("com_reg_msg") != null) {
                                        %>
                                        <%= session.getAttribute("com_reg_msg")%>
                                        <%
                                                session.removeAttribute("com_reg_msg");
                                            }
                                        %>
                                        <%
                                            if (com_date_diff < 30 && com_date_diff > 1) {
                                        %>
                                        <center><span id="com_validity" style="font-size: 18px; color: red">Your system has <%=com_date_diff%> days validity</span></center>
                                            <%
                                                }
                                            %>                                        
                                    </h2>
                                </div>
                            </div>
                            <!-- /. ROW  -->
                            <hr>
                                <div class="row">
                                    <div class="col-md-3 col-sm-6 col-xs-6">
                                        <div class="panel panel-back noti-box">
                                            <span class="icon-box bg-color-green set-icon">
                                                <span class=""></span>
                                            </span>
                                            <center> <div class="text-box" >
                                                    <p class="main-text"></p>
                                                    <p class="text-muted">Company</p>
                                                </div></center>
                                        </div>
                                    </div>
                                    <%
                                        // all user from user_user table
                                        int total_branch = 0;
                                        try {

                                            String sql_all_branch = "select COUNT(*) from user_branch where bran_com_id = '" + session.getAttribute("user_com_id") + "' ";
                                            PreparedStatement pst_all_branch = DbConnection.getConn(sql_all_branch);
                                            ResultSet rs_all_branch = pst_all_branch.executeQuery();
                                            while (rs_all_branch.next()) {
                                                total_branch = Integer.parseInt(rs_all_branch.getString(1));
                                            }
                                        } catch (Exception e) {
                                            out.println(e.toString());
                                        }
                                    %>
                                    <div class="col-md-3 col-sm-6 col-xs-6">
                                        <div class="panel panel-back noti-box">
                                            <span class="icon-box bg-color-green set-icon">
                                                <span class=""><%=total_branch%></span>
                                            </span>                                   
                                            <div class="text-box" >
                                                <p class="main-text"></p>
                                                <p class="text-muted">Branches</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /. ROW  -->
                                <hr />                
                                <div class="row">
                                    <div class="col-lg-12 ">
                                        <div class="alert alert-info">
                                            <strong>Welcome Jhon Doe ! </strong> You Have No pending Task For Today.
                                        </div>
                                    </div>
                                </div>
                                <!-- /. ROW  --> 
                                <div class="row text-center pad-top">
                                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6" style="display: block">
                                        <div class="div-square">
                                            <a href="branch_regis.jsp" >
                                                <i class="fa fa-edit fa-4x" style="color: green"></i>
                                                <h5>Branch Registration</h5>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6" style="display: block">
                                        <div class="div-square">
                                            <a href="branch_list_according_com.jsp" >
                                                <i class="fa fa-clipboard fa-4x" style="color: #00ADEF"></i>
                                                <h5>View all branch</h5>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <%
                                        }
                                    }
                                %>
                                <%
                                    if (logger != null) {
                                        if (logger.equals("branch")) {
                                %>
                                <div class="row">
                                    <div class="col-md-12">  
                                        <h2 id="bran_date">
                                            <%
                                                if (session.getAttribute("com_reg_msg") != null) {
                                            %>
                                            <%= session.getAttribute("com_reg_msg")%>
                                            <%
                                                    session.removeAttribute("com_reg_msg");
                                                }
                                            %>
                                        </h2>
                                        <%
                                            if (bran_diffDays < 30 && bran_diffDays > 1) {
                                        %>
                                        <center><span id="bran_validty" style="color: red; font-size: 18px">Your System has <%= bran_diffDays%> days validity</span></center>
                                            <%
                                                } else {

                                                }
                                            %>                                        
                                    </div>
                                </div>
                                <!-- /. ROW  -->
                                <hr>
                                    <div class="row">
                                        <%
                                            int total_customer = 0;
                                            try {
                                                String sql_all_customer = "select count(*) from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                PreparedStatement pst_all_customer = DbConnection.getConn(sql_all_customer);
                                                ResultSet rs_all_customer = pst_all_customer.executeQuery();
                                                while (rs_all_customer.next()) {
                                                    total_customer = Integer.parseInt(rs_all_customer.getString(1));
                                                }
                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            }
                                        %>
                                        <div class="col-md-3 col-sm-6 col-xs-6">
                                            <div class="panel panel-back noti-box">
                                                <span class="icon-box bg-color-green set-icon">
                                                    <span class=""><%= total_customer%></span>
                                                </span>
                                                <center> <div class="text-box" >
                                                        <p class="main-text"></p>
                                                        <p class="text-muted">Customers</p>
                                                    </div></center>
                                            </div>
                                        </div>
                                        <%
                                            // all user from user_user table
                                            int total_user = 0;
                                            try {

                                                String sql_all_branch = "select COUNT(*) from user_user where user_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                                PreparedStatement pst_all_branch = DbConnection.getConn(sql_all_branch);
                                                ResultSet rs_all_branch = pst_all_branch.executeQuery();
                                                while (rs_all_branch.next()) {
                                                    total_user = Integer.parseInt(rs_all_branch.getString(1));
                                                }
                                            } catch (Exception e) {
                                                out.println(e.toString());
                                            }
                                        %>
                                        <div class="col-md-3 col-sm-6 col-xs-6">
                                            <div class="panel panel-back noti-box">
                                                <span class="icon-box bg-color-green set-icon">
                                                    <span class=""><%=total_user%></span>
                                                </span>                                   
                                                <div class="text-box" >
                                                    <p class="main-text"></p>
                                                    <p class="text-muted">user</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /. ROW  -->
                                    <hr />                
                                    <div class="row">
                                        <div class="col-lg-12 ">
                                            <div class="alert alert-info">
                                                <strong>Welcome Jhon Doe ! </strong> You Have No pending Task For Today.
                                                <div id="google_translate_element"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /. ROW  --> 
                                    <div class="row text-center pad-top">   
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                            <div class="div-square">
                                                <a href="customer_payment_statement.jsp" >
                                                    <i class="fa fa-book fa-4x" style="color: #246630"></i>
                                                    <h5>Check payment</h5>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                            <div class="div-square">
                                                <a href="all_customer_view.jsp" >
                                                    <i class="fa fa-users fa-4x" style="color: green"></i>
                                                    <h5>See customers</h5>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                            <div class="div-square">
                                                <a href="report_order.jsp" >
                                                    <i class="fa fa-clipboard fa-4x" style="color: #2046CF"></i>
                                                    <h5>All Orders</h5>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                            <div class="div-square">
                                                <a href="user_profile_update.jsp" >
                                                    <i class="fa fa-gear fa-4x" style="color: black"></i>
                                                    <h5>Settings</h5>
                                                </a>
                                            </div>
                                        </div>  
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6" style="display: block">
                                            <div class="div-square">
                                                <a href="user_reg.jsp" >
                                                    <i class="fa fa-edit fa-4x" style="color: green"></i>
                                                    <h5>User Registration</h5>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                            <div class="div-square">
                                                <a href="#" >
                                                    <i class="fa fa-bell-o fa-4x" style="color: #DE6E04"></i>
                                                    <h5>Notifications </h5>
                                                </a>
                                            </div>
                                        </div>                            
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6">
                                            <div class="div-square">
                                                <a href="customer_registration.jsp" >
                                                    <i class="fa fa-user fa-4x" style="color: #3AAECD"></i>
                                                    <h5>Customer Registration</h5>
                                                </a>
                                            </div>
                                        </div> 
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6" style="display: block">
                                            <div class="div-square">
                                                <a href="all_users.jsp" >
                                                    <i class="fa fa-clipboard fa-4x" style="color: #00ADEF"></i>
                                                    <h5>View all user</h5>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-6" style="display: block">
                                            <div class="div-square">
                                                <a href="price_change_by_user.jsp" >
                                                    <i class="fa fa-refresh fa-4x" style="color: #239B56"></i>
                                                    <h5>Price Update</h5>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                            }
                                        }
                                    %>
                                    </div>
                                    <!-- /. PAGE INNER  -->
                                    </div>
                                    <!-- /. PAGE WRAPPER  -->
                                    </div>    
                                    <script>
                                        $(function () {
                                            $("#bran_validty").fadeIn(500).delay(7000).fadeOut("slow");
                                        });
                                        $(function () {
                                            $("#com_validity").fadeIn(500).delay(7000).fadeOut("slow");
                                        });
                                    </script>
                                    <script src="assets/js/jquery-1.10.2.js"></script>   
                                    <script src="assets/js/bootstrap.min.js"></script>    
                                    <script src="assets/js/jquery.metisMenu.js"></script>     
                                    <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
                                    <script src="assets/js/morris/morris.js"></script>   
                                    <script src="assets/js/custom.js"></script>      
                                    </body>
                                    </html>
