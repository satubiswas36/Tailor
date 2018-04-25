<%-- 
    Document   : product_autosearch_for_sale
    Created on : Aug 29, 2017, 9:47:30 AM
    Author     : Rasel
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../menu/header.jsp" flush="true" />
    <body>

        <%
            String product_name = request.getParameter("product_name");

            String product_name_inv_product_table = null;
            String group_name = null;
            String product_details = null;
            int total_sell_qty = 0;
            int total_buy_qty = 0;
            int stock = 0;
            String buy_price = null;
            String sell_price = null;
        %>
        <table class="table table-bordered table-responsive">
            <%
                int sl = 1;
                PreparedStatement pst_product_fm_product_name_tble = null;
                ResultSet rs_product_fm_product_name_tble = null;
                if (product_name != null) {
                    try {
                        String sql_product_fm_product_name_tble = "select * from inv_product_name where prn_product_name like ?";
                        pst_product_fm_product_name_tble = DbConnection.getConn(sql_product_fm_product_name_tble);
                        pst_product_fm_product_name_tble.setString(1, product_name + "%");
                        rs_product_fm_product_name_tble = pst_product_fm_product_name_tble.executeQuery();
                        while (rs_product_fm_product_name_tble.next()) {
                            String product_id_fm_product_name_tble = rs_product_fm_product_name_tble.getString("prn_slid");
                            product_name_inv_product_table = rs_product_fm_product_name_tble.getString("prn_product_name");
                            // product_name table thaka je id pelam sai id ta inv_product er modhe ace kin ta tai check korbo jodi thak tahole je id palam sai id dhore
                            // inv_product table thake sob information nebo r jodi na thake tahole continue kore debo
                            PreparedStatement pst_is_exit_id_in_product_tble = null;
                            ResultSet rs_is_exit_id_in_product_tble = null;
                            try {
                                String sql_is_exit_id_in_product_tble = "select * from inv_product where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' and pr_product_name = '" + product_id_fm_product_name_tble + "' ";
                                pst_is_exit_id_in_product_tble = DbConnection.getConn(sql_is_exit_id_in_product_tble);
                                rs_is_exit_id_in_product_tble = pst_is_exit_id_in_product_tble.executeQuery();
                                if (rs_is_exit_id_in_product_tble.next()) {
                                    product_details = rs_is_exit_id_in_product_tble.getString("pr_product_detail");
                                    sell_price = rs_is_exit_id_in_product_tble.getString("pr_sell_price");
                                    buy_price = rs_is_exit_id_in_product_tble.getString("pr_buy_price");
                                    // group id 
                                    String group_id = rs_is_exit_id_in_product_tble.getString("pr_group");
                                    // group name by group id
                                    PreparedStatement pst_group_name = null;
                                    ResultSet rs_group_name = null;
                                    try {
                                        String sql_group_name = "select * from inv_product_group where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' and prg_slid = '" + group_id + "' ";
                                        pst_group_name = DbConnection.getConn(sql_group_name);
                                        rs_group_name = pst_group_name.executeQuery();
                                        if (rs_group_name.next()) {
                                            group_name = rs_group_name.getString("prg_name");
                                        }
                                    } catch (Exception e) {
                                        out.println("group name by gorup id " + e.toString());
                                    } finally {
                                        pst_group_name.close();
                                        rs_group_name.close();
                                    }
                                    // count stock from inventory_details
                                    PreparedStatement pst_stock_inventory_details = null;
                                    ResultSet rs_stock_inventory_details = null;
                                    try {
                                        String sql_stock_inventory_details = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_product_id = '" + product_id_fm_product_name_tble + "' and (pro_deal_type = 3 or pro_deal_type = 4) ";
                                        pst_stock_inventory_details = DbConnection.getConn(sql_stock_inventory_details);
                                        rs_stock_inventory_details = pst_stock_inventory_details.executeQuery();
                                        while (rs_stock_inventory_details.next()) {
                                            int sell_qty = Integer.parseInt(rs_stock_inventory_details.getString("pro_sell_quantity"));
                                            total_sell_qty += sell_qty;
                                            int buy_qty = Integer.parseInt(rs_stock_inventory_details.getString("pro_buy_quantity"));
                                            total_buy_qty += buy_qty;
                                        }
                                        stock = total_buy_qty - total_sell_qty;
                                        total_buy_qty = 0;
                                        total_sell_qty = 0;
                                    } catch (Exception e) {
                                        out.println("stock count " + e.toString());
                                    } finally {
                                        pst_stock_inventory_details.close();
                                        rs_stock_inventory_details.close();
                                    }

                                } else {
                                    continue;
                                }
                            } catch (Exception e) {
                                out.println(e.toString());
                            } finally {
                                pst_is_exit_id_in_product_tble.close();
                                rs_is_exit_id_in_product_tble.close();
                            }
            %>
            <tr>
                <td><%=sl++%></td>
                <td><input type="text" value="<%=product_id_fm_product_name_tble%>" id="product_id<%=sl%>" style="display: none"/><span title="<%=buy_price%>"><%=product_name_inv_product_table%></span></td>
                <td><%=product_details%></td>
                <td><%=group_name%></td>
                <td><input type="text" value="<%=stock%>" id="stock<%=sl%>" style="display: none"/><%=stock%></td>
                <td><%=sell_price + ".00"%></td>
                <td style="width: 15%;">
                    <input type="text" name="qty" id="qty<%=sl%>" size="1"/><a class="btn btn-success" href="#" onclick="sell(<%=sl%>,<%=sell_price%>)">+</a>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                } finally {
                    pst_product_fm_product_name_tble.close();
                    rs_product_fm_product_name_tble.close();
                }
            } else {
            %>            
                <table class="table table-bordered table-responsive">
                    <thead>
                    <th style="text-align: center">SL</th>
                    <th style="text-align: center">Name</th>
                    <th style="text-align: center">Details</th>
                    <th style="text-align: center">Group</th>
                    <th style="text-align: center">Stock</th>
                    <th style="text-align: center">Price</th>
                    <th style="text-align: center">Add</th>
                    </thead>
                    <tbody>
                        <%
                            int sl_2 = 1;
                            String product_name_2 = null;
                            String group_name_2 = null;
                            int total_sell_qty_2 = 0;
                            int total_buy_qty_2 = 0;
                            int stock_2 = 0;
                            try {
                                String sql_product_id = "select * from inv_product where prg_bran_id = '" + session.getAttribute("user_bran_id") + "' ";
                                PreparedStatement pst_product_id = DbConnection.getConn(sql_product_id);
                                ResultSet rs_product_id = pst_product_id.executeQuery();
                                while (rs_product_id.next()) {
                                    String product_id = rs_product_id.getString("pr_product_name");
                                    // product name 
                                    String sql_product_name = "select * from inv_product_name where prn_slid = '" + product_id + "' ";
                                    PreparedStatement pst_product_name = DbConnection.getConn(sql_product_name);
                                    ResultSet rs_product_name = pst_product_name.executeQuery();
                                    if (rs_product_name.next()) {
                                        product_name_2 = rs_product_name.getString("prn_product_name");
                                    }
                                    String product_detail = rs_product_id.getString("pr_product_detail");
                                    String group_id = rs_product_id.getString("pr_group");
                                    // group name
                                    String sql_group_name = "select * from inv_product_group where prg_slid = '" + group_id + "' ";
                                    PreparedStatement pst_group_name = DbConnection.getConn(sql_group_name);
                                    ResultSet rs_group_name = pst_group_name.executeQuery();
                                    if (rs_group_name.next()) {
                                        group_name_2 = rs_group_name.getString("prg_name");
                                    }
                                    String sale_price = rs_product_id.getString("pr_sell_price");
                                    String buy_price_2 = rs_product_id.getString("pr_buy_price");
                                    // product stock 
                                    String sql_product_stock = "select * from inventory_details where pro_bran_id = '" + session.getAttribute("user_bran_id") + "' and pro_product_id = '" + product_id + "' and (pro_deal_type = 3 or pro_deal_type = 4) ";
                                    PreparedStatement pst_product_stock = DbConnection.getConn(sql_product_stock);
                                    ResultSet rs_product_stock = pst_product_stock.executeQuery();
                                    while (rs_product_stock.next()) {
                                        int sell_qty = Integer.parseInt(rs_product_stock.getString("pro_sell_quantity"));
                                        total_sell_qty_2 += sell_qty;
                                        int buy_qty = Integer.parseInt(rs_product_stock.getString("pro_buy_quantity"));
                                        total_buy_qty_2 += buy_qty;
                                    }
                                    stock_2 = total_buy_qty_2 - total_sell_qty_2;
                                    total_buy_qty_2 = 0;
                                    total_sell_qty_2 = 0;
                        %>
                        <tr>
                            <td style="text-align: center"><%=sl_2++%></td>
                            <td><input type="text" value="<%=product_id%>" id="product_id<%=sl%>" style="display: none" /><span title="<%=buy_price_2%>"><%=product_name_2%></span></td>
                            <td><%=product_detail%></td>
                            <td><%=group_name_2%></td>
                            <td><input type="text" id="stock<%=sl%>" value="<%=stock_2%>" style="display: none" /><%=stock_2%></span></td>
                            <td style="text-align: right"><%=sale_price + ".00"%></td>
                            <td style="width: 15%;">
                                <input type="text" name="qty" id="qty<%=sl%>" size="1"/><a class="btn btn-success" href="#" onclick="sell(<%=sl%>,<%=sale_price %>)">+</a>
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
            <%
                }
            %>
        </table>
        <script>
            function sell(id, price) {
                var sale_price = price;
                var p_qty = Number($('#qty' + id).val());
                var has_Qty = Number($('#stock' + id).val());
                var product_id = $('#product_id' + id).val();
                var invoice = $("#invoiceid").val();

                if (p_qty === 0) {
                    // alert("for delete");
                    $.ajax({
                        type: 'POST',
                        url: "delete_temp_product_sell.jsp",
                        data: {
                            "product_id": product_id,
                            "invoice": invoice,
                            "price": sale_price,
                            "qty": p_qty
                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#data_show").html(data);
                        }
                    });
                } else if (p_qty == null || p_qty == "") {
                    alert("Please select Qty ");
                    return false;
                } else if (isNaN(p_qty)) {
                    alert("Select Number Only ");
                    return null;
                } else if (p_qty > has_Qty) {
                    alert("Stock is not available");
                } else {
                    $("#dataShow").fadeIn("slow");
                    $.ajax({
                        type: 'POST',
                        url: "sell_product_temporary.jsp",
                        data: {
                            "product_id": product_id,
                            "invoice": invoice,
                            "price": sale_price,
                            "qty": p_qty
                        },
                        success: function (data) {
                            $("#data_show").html(data);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $("#data_show").html(textStatus);
                        }
                    });
                }
            }
        </script>
    </body>
</html>
