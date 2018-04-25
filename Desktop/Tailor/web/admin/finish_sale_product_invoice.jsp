<%@page import="java.sql.Blob"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%
    String com_id = null;
    String bran_id = null;
    String usr_id = null;
    String user_name = null;

    if (session.getAttribute("user_com_id") != null) {
        com_id = (String) session.getAttribute("user_com_id");
    }
    if (session.getAttribute("user_bran_id") != null) {
        bran_id = (String) session.getAttribute("user_bran_id");
    }
    if (session.getAttribute("user_user_id") != null) {
        usr_id = (String) session.getAttribute("user_user_id");
    } else {
        usr_id = bran_id;
    }

    // current date 
    Date date = new Date();
    SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
    String c_date = sd.format(date);

    String invoice = request.getParameter("invoice");

    String customer_id = request.getParameter("customer_id");

    // customer name by customer id 
    String customer_name = null;
    try {
        String sql_customer_name = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + customer_id + "' ";
        PreparedStatement pst_customer_name = DbConnection.getConn(sql_customer_name);
        ResultSet rs_customer_name = pst_customer_name.executeQuery();
        if (rs_customer_name.next()) {
            customer_name = rs_customer_name.getString("cus_name");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }

    // add all product in inventory_details from sell_temporary table
    try {
        String sql_temp = "select * from temporary_product_sell where bran_id = '" + session.getAttribute("user_bran_id") + "'  and invoice_id  = '" + invoice + "' ";
        PreparedStatement pst_temp = DbConnection.getConn(sql_temp);
        ResultSet rs_temp = pst_temp.executeQuery();
        while (rs_temp.next()) {
            String product_id = rs_temp.getString("product_id");
            String qty = rs_temp.getString("qty");
            String price = rs_temp.getString("price");

            // sales product add inventory_details table
            try {
                String sql_inv = "insert into inventory_details values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement pst_inv = DbConnection.getConn(sql_inv);
                pst_inv.setString(1, null);
                pst_inv.setString(2, com_id);
                pst_inv.setString(3, bran_id);
                pst_inv.setString(4, usr_id);
                pst_inv.setString(5, customer_id);
                pst_inv.setString(6, product_id);
                pst_inv.setString(7, invoice);
                pst_inv.setString(8, "0");
                pst_inv.setString(9, qty);
                pst_inv.setString(10, "0");
                pst_inv.setString(11, "0");
                pst_inv.setString(12, "0");
                pst_inv.setString(13, price);
                pst_inv.setString(14, "4");
                pst_inv.setString(15, c_date);
                pst_inv.setString(16, null);
                pst_inv.execute();
            } catch (Exception e) {
                out.println(e.toString());
            }
        }
    } catch (Exception e) {
        out.println(e.toString());
    }

    // delete invoice after added in inventory_details table by invoice id
    try {
        String sql_delete_invoice = "delete from temporary_product_sell where invoice_id = '" + invoice + "' ";
        PreparedStatement pst_delete_invoice = DbConnection.getConn(sql_delete_invoice);
        pst_delete_invoice.execute();
    } catch (Exception e) {
        out.println(e.toString());
    }

    if (session.getAttribute("invoice_for_product_sell") != null) {
        session.removeAttribute("invoice_for_product_sell");
    }

// branch name 
    String branch_name = null;
    try {
        String sql_branch_name = "select * from user_branch where bran_id = '" + session.getAttribute("user_bran_id") + "' ";
        PreparedStatement pst_branch_name = DbConnection.getConn(sql_branch_name);
        ResultSet rs_branch_name = pst_branch_name.executeQuery();
        if (rs_branch_name.next()) {
            branch_name = rs_branch_name.getString("bran_name");
        }
    } catch (Exception e) {
        out.println(e.toString());
    }

// customer due 
    // customer due 
    double total_debit = 0;
    double total_credit = 0;
    double due = 0;
    double all_credit = 0;
    double all_debit = 0;
    double all_balance = 0;
    double sell_price2 = 0;

    PreparedStatement pst_debit = null;
    ResultSet rs_debit = null;
    try {
        String sql_debit = "select * from inventory_details where pro_party_id = '" + customer_id + "' and (pro_deal_type = 5 or pro_deal_type = 1 or pro_deal_type = 4 or pro_deal_type = 6)";
        pst_debit = DbConnection.getConn(sql_debit);
        rs_debit = pst_debit.executeQuery();
        while (rs_debit.next()) {
            String debit = rs_debit.getString("pro_sell_price");
            sell_price2 = Double.parseDouble(rs_debit.getString("pro_sell_quantity"));
            String credit = rs_debit.getString("pro_sell_paid");
            total_debit += (Double.parseDouble(debit) * sell_price2);
            total_credit += Double.parseDouble(credit);
        }
        due = total_credit - total_debit;
        all_balance += due;
        all_debit += total_debit;
        all_credit += total_credit;
    } catch (Exception e) {
        out.println(e.toString());
    } finally {
        //pst_debit.close();
        rs_debit.close();
    }

// user id 
    String user_id = null;
    PreparedStatement pst_cus_name = null;
    ResultSet rs_cus_name = null;
    try {
        String sql_cus_name = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_invoice_id = '" + invoice + "' and pro_deal_type = 4";
        pst_cus_name = DbConnection.getConn(sql_cus_name);
        rs_cus_name = pst_cus_name.executeQuery();
        if (rs_cus_name.next()) {
            user_id = rs_cus_name.getString("pro_user_id");

            // user name                         
            try {
                String sql_user = "select * from user_user where user_bran_id = '" + session.getAttribute("user_bran_id") + "' and user_id = '" + user_id + "' ";
                PreparedStatement pst_user = DbConnection.getConn(sql_user);
                ResultSet rs_user = pst_user.executeQuery();
                if (rs_user.next()) {
                    user_name = rs_user.getString("user_name");
                } else {
                    // branch name 
                    try {
                        String sql_branch = "select * from user_branch where bran_id = '" + bran_id + "' ";
                        PreparedStatement pst_branch = DbConnection.getConn(sql_branch);
                        ResultSet rs_branch = pst_branch.executeQuery();
                        if (rs_branch.next()) {
                            user_name = rs_branch.getString("bran_name");
                        }
                    } catch (Exception e) {
                        out.println("Branch name " + e.toString());
                    }
                }
            } catch (Exception e) {
                out.println("user name " + e.toString());
            }
        }
    } catch (Exception e) {
        out.println("user id " + e.toString());
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.</title>
        <link href="assets/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <style>
            .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
                padding: 2px;
                line-height: 1.42857143;
                vertical-align: top;
                border-top: 1px solid #ddd;
                font-size: 14px;
            }

            @page {
                size: A4;
                font-size: 28px;
                min-height: 50px;
            }
            @media print {
                html, body {
                    width: 100%;
                    min-height: 10mm;
                    font-size: 18px;
                }
                /* ... the rest of the rules ... */
            }
        </style>
    </head>
    <body>
        <div id="printableArea">

            <div class="container">
                <center>
                    <%                    // branch image for last_invoice
                        String b64 = null;
                        String bran_name = null;
                        String bran_address = null;
                        String bran_phone = null;
                        String bran_email = null;
                        String bran_image_name = null;
                        try {
                            Blob img = null;
                            String sql_img = "select * from user_branch where bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                            PreparedStatement pst_img = DbConnection.getConn(sql_img);
                            ResultSet rs_img = pst_img.executeQuery();
                            while (rs_img.next()) {
                                img = rs_img.getBlob("bran_com_logo");
                                byte[] imgByte = img.getBytes(1, (int) img.length());
                                b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imgByte);
                                bran_name = rs_img.getString("bran_name");
                                bran_address = rs_img.getString("bran_address");
                                bran_phone = rs_img.getString("bran_mobile");
                                bran_email = rs_img.getString("bran_email");
                                bran_image_name = rs_img.getString("bran_com_logo");
                            }
                        } catch (Exception e) {
                            out.println("show_last_invoice branch image " + e.toString());
                        }
                    %>                   
                </center>
                <table class="table-responsive" style="border: none">
                    <tr>
                        <td><img  style="width: 50px; height: 50px; margin-top: 8px;" class="img-responsive img-rounded" src="../images/<%=bran_image_name%>"/></td>
                        <td style="text-align: right">
                            <h4 style="margin: 0px"><%=bran_name%></h4>                            
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="text-align: right">
                            <h5 style="margin: 0px;">Address : <%=bran_address%></h5>                            
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="text-align: right"><h5 style="margin: 0px;">Phone : <%=bran_phone%></h5></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="text-align: right"><h5 style="margin: 0px;">Email : <%=bran_email%></h5></td>
                    </tr>
                </table><hr style="margin: 0px;">
                <table class="table-responsive" style="border: none; margin: 0px;">                    
                    <tr>
                        <td>Invoice ID : <%=invoice%></td>
                        <td style="text-align: right">Date : <%=c_date%></td>
                    </tr>
                    <tr>
                        <td>Customer Name : <span  style="text-decoration: underline"><%=customer_name%></span></td>
                        <td style="text-align: right">User Name : <%=user_name%></td>
                    </tr>
                </table>
                <div>
                    <table class="table table-bordered table-responsive" style="margin: 0px;">
                        <thead>
                        <th style="text-align: center; width: 8%">SL</th>
                        <th style="text-align: left">Product Name</th>
                        <th style="text-align: center; width: 7%;">Qty</th>
                        <th style="text-align: right; width: 14%;">Price</th>
                        <th style="text-align: right; width: 18%;">Amount</th>
                        </thead>
                        <tbody>
                            <%
                                int sl = 1;
                                String product_name = null;
                                int t_qty = 0;
                                double t_price = 0;
                                double amount = 0;

                                try {
                                    String sql_des = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_party_id = '" + customer_id + "' and pro_invoice_id = '" + invoice + "' and pro_deal_type = 4";
                                    PreparedStatement pst_des = DbConnection.getConn(sql_des);
                                    ResultSet rs_des = pst_des.executeQuery();
                                    while (rs_des.next()) {
                                        String product_id = rs_des.getString("pro_product_id");

                                        // product name 
                                        String sql_product_name = "select * from inv_product_name where prn_slid = '" + product_id + "' ";
                                        PreparedStatement pst_product_name = DbConnection.getConn(sql_product_name);
                                        ResultSet rs_product_name = pst_product_name.executeQuery();
                                        if (rs_product_name.next()) {
                                            product_name = rs_product_name.getString("prn_product_name");
                                        }
                                        String qty = rs_des.getString("pro_sell_quantity");
                                        t_qty = Integer.parseInt(qty);
                                        String price = rs_des.getString("pro_sell_price");
                                        t_price = Double.parseDouble(price);
                                        amount += (t_qty * t_price);
                            %>
                            <tr>
                                <td style="text-align: center"><%=sl++%></td>
                                <td style="text-align: left"><%=product_name%></td>
                                <td style="text-align: center"><%=t_qty%></td>
                                <td style="text-align: right"><%=t_price + "0"%></td>
                                <td style="text-align: right"><%=(t_qty * t_price) + "0"%></td>                            
                            </tr>
                            <%
                                    }
                                    t_qty = 0;
                                    t_price = 0;
                                    //amount = 0;
                                } catch (Exception e) {
                                    out.println(e.toString());
                                }
                            %>                            
                        </tbody> 
                    </table> 
                    <table class="table-responsive" style="border: none; margin: 0px;">
                        <tr>
                            <td></td>
                            <td style="text-align: right"><b>Total : <%=amount + "0 Tk"%></b></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="text-align: right"><b>Total due : <%=due + "0 Tk"%></b></td>
                        </tr>
                    </table>
                    <center>                        
                        <span style="margin: 0px;">Power By : <b>IGL Web™ Ltd.</b> || 880-1823-037726</span>
                    </center>
                </div>
            </div>            
        </div>
        <input type="button" onclick="printDiv('printableArea')" value="print" style="margin-left: 2%;"/>
        <script>
            function printDiv(divName) {
                var printContents = document.getElementById(divName).innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
            }
        </script>
    </body>
</html>
