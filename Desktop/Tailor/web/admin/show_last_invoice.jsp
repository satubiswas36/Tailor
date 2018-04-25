
<%@page import="java.sql.Blob"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
            <%
                String last_inv = request.getParameter("last_inv");
                // customer name 
                String customer_name = null;
                String user_name = null;
                String cust_mobile = null;
                String date = null;
                String cust_id = null;
                String bran_id = null;
                String user_id = null;
                PreparedStatement pst_cus_name = null;
                ResultSet rs_cus_name = null;
                try {
                    // customer id from inventory_details 
                    String sql_cus_name = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_invoice_id = '" + last_inv + "' and pro_deal_type = 4";
                    pst_cus_name = DbConnection.getConn(sql_cus_name);
                    rs_cus_name = pst_cus_name.executeQuery();
                    if (rs_cus_name.next()) {
                        cust_id = rs_cus_name.getString("pro_party_id");
                        date = rs_cus_name.getString("pro_entry_date");
                        bran_id = rs_cus_name.getString("pro_bran_id");
                        user_id = rs_cus_name.getString("pro_user_id");

                        PreparedStatement pst_customer_name = null;
                        ResultSet rs_customer_name = null;
                        try {
                            // customer name from customer 
                            String sql_customer_name = "select * from customer where cus_bran_id = '" + session.getAttribute("user_bran_id") + "' and cus_customer_id = '" + cust_id + "' ";
                            pst_customer_name = DbConnection.getConn(sql_customer_name);
                            rs_customer_name = pst_customer_name.executeQuery();
                            if (rs_customer_name.next()) {
                                customer_name = rs_customer_name.getString("cus_name");
                                cust_mobile = rs_customer_name.getString("cus_mobile");
                            }
                        } catch (Exception e) {
                            out.println("customer id from inventory_details " + e.toString());
                        } finally {
                            pst_customer_name.close();
                            rs_customer_name.close();
                        }
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
                    out.println("customer name is last invoice : " + e.toString());
                } finally {
                    pst_cus_name.close();
                    rs_cus_name.close();
                }

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
                    String sql_debit = "select * from inventory_details where pro_party_id = '" + cust_id + "' and (pro_deal_type = 5 or pro_deal_type = 1 or pro_deal_type = 4 or pro_deal_type = 6)";
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

            %>
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
                        <td>Invoice id : <%=last_inv%></td>
                        <td style="text-align: right">Date : <%=date%></td>
                    </tr>
                    <tr>
                        <td>Customer Name : <%=customer_name%></td>
                        <td style="text-align: right">UserName : <%=user_name%></td>
                    </tr>
                    <tr>
                        <td>Customer Mobile : <%=cust_mobile%></td>
                        <td></td>
                    </tr>
                </table>           

                <div>
                    <table class="table table-bordered table-responsive" style="margin: 0px;">
                        <thead>
                        <th style="text-align: center; width: 8%;">SL</th>
                        <th>Name</th>                    
                        <th style="text-align: center; width: 7%;">Qty</th>
                        <th style="text-align: right; width: 14%;">Price</th>
                        <th style="text-align: right; width: 18%;">Amount</th>
                        </thead>
                        <tbody>
                            <%
                                String product_name = null;
                                String sell_price = null;
                                String product_description = null;
                                double amount = 0;
                                double total_amount = 0;
                                int sl = 1;
                                String sql_product = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_invoice_id = '" + last_inv + "' and pro_deal_type = 4";
                                PreparedStatement pst_product = DbConnection.getConn(sql_product);
                                ResultSet rs_product = pst_product.executeQuery();
                                while (rs_product.next()) {
                                    String product_id = rs_product.getString("pro_product_id");
                                    // product name by product id
                                    String sql_product_name = "select * from inv_product_name where prn_bran_id = '" + session.getAttribute("user_bran_id") + "' and prn_slid = '" + product_id + "' ";
                                    PreparedStatement pst_product_name = DbConnection.getConn(sql_product_name);
                                    ResultSet rs_product_name = pst_product_name.executeQuery();
                                    if (rs_product_name.next()) {
                                        product_name = rs_product_name.getString("prn_product_name");
                                    }
                                    String qty = rs_product.getString("pro_sell_quantity");
                                    sell_price = rs_product.getString("pro_sell_price");
                                    amount = (Double.parseDouble(qty) * Double.parseDouble(sell_price));
                                    total_amount += amount;
                                    // get all information form inv_product
                                    String sql_product_inv_product = "select * from inv_product where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' and pr_product_name = '" + product_id + "' ";
                                    PreparedStatement pst_inv_product = DbConnection.getConn(sql_product_inv_product);
                                    ResultSet rs_inv_product = pst_inv_product.executeQuery();
                                    if (rs_inv_product.next()) {
                                        //sell_price = rs_inv_product.getString("pr_sell_price");                                                                                    
                                        product_description = rs_inv_product.getString("pr_product_detail");
                                    }
                            %>
                            <tr>
                                <td style="text-align: center"><%=sl++%></td>
                                <td><%=product_name + " (" + product_description + ")"%></td>                            
                                <td style="text-align: center"><%=qty%></td>
                                <td style="text-align: right"><%=sell_price + ".00"%></td>
                                <td style="text-align: right"><%=amount + "0"%></td>
                            </tr>
                            <%
                                }
                            %>

                        </tbody>
                    </table>
                    <table class="table-responsive" style="border: none; margin: 0px;">
                        <tr>
                            <td></td>
                            <td style="text-align: right"><b>Total : <%=total_amount + "0 Tk"%></b></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="text-align: right"><b>Total due : <%=due + "0 Tk"%></b></td>
                        </tr>
                    </table>
                    <center>                        
                        <span style="margin: 0px;">Power By : <b>IGL Web™ Ltd.</b> || +880-1823-037726</span>
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
