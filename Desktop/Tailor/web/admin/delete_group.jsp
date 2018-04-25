<%-- 
    Document   : delete_group
    Created on : Aug 10, 2017, 7:25:07 PM
    Author     : Rasel
--%>

<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String status = request.getParameter("status");
            if (status != null) {
                if (status.equals("group")) {
                    String gid = request.getParameter("gid");
                    try {
                        String sql_delete_group = "delete from inv_product_group where prg_slid = '" + gid + "' ";
                        PreparedStatement pst_delete_group = DbConnection.getConn(sql_delete_group);
                        pst_delete_group.execute();
                        session.setAttribute("groupdelete", "ok");
                        response.sendRedirect("/Tailor/admin/view_group.jsp");
                    } catch (Exception e) {
                        session.setAttribute("groupdelete", "no");
                        response.sendRedirect("/Tailor/admin/view_group.jsp");
                    }
                }
                if (status.equals("product_type")) {
                    String product_type_id = request.getParameter("product_type_id");
                    try {
                        String sql_product_type_delete = "delete from inv_product_type where pro_typ_slno = '" + product_type_id + "' ";
                        PreparedStatement pst_product_type_delete = DbConnection.getConn(sql_product_type_delete);
                        pst_product_type_delete.execute();
                        session.setAttribute("product_type_delete_msg", "deleted");
                        response.sendRedirect("/Tailor/admin/view_product_type.jsp");
                    } catch (Exception e) {
                        session.setAttribute("product_type_delete_msg", "notdeleted");
                        response.sendRedirect("/Tailor/admin/view_product_type.jsp");
                    }
                }
                if (status.equals("prduct_name")) {
                    String product_name_id = request.getParameter("product_name_id");
                    try {
                        String sql_product_name_delete = "delete from inv_product_name where prn_slid = '" + product_name_id + "' ";
                        PreparedStatement pst_product_name_delete = DbConnection.getConn(sql_product_name_delete);
                        pst_product_name_delete.execute();
                        session.setAttribute("product_name_delete_msg", "deleted");
                        response.sendRedirect("/Tailor/admin/view_product_name.jsp");
                    } catch (Exception e) {
                        session.setAttribute("product_name_delete_msg", "notdeleted");
                        response.sendRedirect("/Tailor/admin/view_product_name.jsp");
                    }
                }
                if (status.equals("location")) {
                    String product_id_location = request.getParameter("product_id_location");
                    try {
                        String sql_location_delete = "delete from inv_product_location where pl_product_id = '" + product_id_location + "' ";
                        PreparedStatement pst_location_delete = DbConnection.getConn(sql_location_delete);
                        pst_location_delete.execute();
                        session.setAttribute("product_location_delete_msg", "deleted");
                        response.sendRedirect("/Tailor/admin/view_location.jsp");
                    } catch (Exception e) {
                        session.setAttribute("product_location_delete_msg", "notdeleted");
                        response.sendRedirect("/Tailor/admin/view_location.jsp");
                    }
                }
                if (status.equals("product")) {
                    String product_id = request.getParameter("product_id");
                    try {
                        String sql_delete = "delete inv_product where pr_product_name = '" + product_id + "' ";
                        PreparedStatement pst_delete = DbConnection.getConn(sql_delete);
                        pst_delete.execute();
                        session.setAttribute("proudct_delete_product_msg", "deleted");
                        response.sendRedirect("/Tailor/admin/view_product.jsp");
                    } catch (Exception e) {
                        session.setAttribute("proudct_delete_product_msg", "notdeleted");
                        response.sendRedirect("/Tailor/admin/view_product.jsp");
                    }
                }
                if(status.equals("product_parchase_delete")){
                    String product = request.getParameter("productid");
                    String invoiceid = request.getParameter("invoiceid");
                    String supplier = request.getParameter("supplier");
                    String statusP = "3";
                    out.println(product);
                    try {
                            String sql_product_parchase_delete = "delete inventory_details where pro_bran_id = '"+session.getAttribute("user_bran_id")+"' and (pro_invoice_id = '"+invoiceid+"' and  pro_party_id = '"+supplier+"' and pro_product_id = '"+product+"' and pro_deal_type = '"+statusP+"' )";
                            PreparedStatement pst_product_parchase_delete = DbConnection.getConn(sql_product_parchase_delete);
                            pst_product_parchase_delete.execute();
                            session.setAttribute("addproductparchase", "deleted");
                            response.sendRedirect("/Tailor/admin/product_parchase.jsp");
                        } catch (Exception e) {
                            out.println(e.toString());
                        }
                }
            }
        %>
    </body>
</html>
