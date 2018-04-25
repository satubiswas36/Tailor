
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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

    <!--      for time picker-->

    <link href="../admin/assets/css/timedropper.css" rel="stylesheet" type="text/css"/>
    <script src="../admin/assets/js/timedropper.js" type="text/javascript"></script>       
        <style>
            @page {
                size: A4;
                min-height: 50px;
            }
            @media print {
                html, body {
                    width: 210mm;
                    min-height: 10mm;
                }
                /* ... the rest of the rules ... */
            }
        </style>
    </head>
    <body>

        <%
            String maker_name = request.getParameter("m_name");
            String product = request.getParameter("product_status");
            String order_id = request.getParameter("order");
            String product_delivery_date = request.getParameter("delivery_date");

        %>
        <%            if (product.equals("shirt")) {
        %>
        <div class="print" id="printableArea">
            <%
                String srt_type_name = null;
                String srt_plet_type_name = null;
                String srt_collar_type_name = null;
                String srt_inner_pocket_name = null;
                try {
                    String sql = "select * from ser_shirt where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
                    PreparedStatement pst = DbConnection.getConn(sql);
                    ResultSet rs = pst.executeQuery();
                    if (rs.next()) {
                        String srt_long = rs.getString("srt_long");
                        String srt_body = rs.getString("srt_body");
                        String body_loose = rs.getString("srt_body_loose");
                        String srt_bally = rs.getString("srt_bally");
                        String srt_hip = rs.getString("srt_hip");
                        String srt_shoulder = rs.getString("srt_shoulder");
                        String srt_neck = rs.getString("srt_neck");
                        String srt_hand_long = rs.getString("srt_hand_long");
                        String srt_hand_moja = rs.getString("srt_hand_moja");
                        String srt_hand_qunu = rs.getString("srt_hand_qunu");
                        String srt_hand_cuff = rs.getString("srt_hand_cuff");
                        String srt_types = rs.getString("srt_types");
                        // srt type check 
                        if (srt_types.equals("1")) {
                            srt_type_name = "চাইনিজ";
                        }
                        if (srt_types.equals("2")) {
                            srt_type_name = "হাওয়াই";
                        }
                        if (srt_types.equals("3")) {
                            srt_type_name = "হাফ";
                        }

                        String srt_plet = rs.getString("srt_plet");
                        if (srt_plet.equals("1")) {
                            srt_plet_type_name = "বক্স প্লেট";
                        }
                        if (srt_plet.equals("2")) {
                            srt_plet_type_name = "সেলাই প্লেট";
                        }
                        if (srt_plet.equals("3")) {
                            srt_plet_type_name = " ইনার প্লেট";
                        }

                        String srt_collar = rs.getString("srt_collar");
                        if (srt_collar.equals("1")) {
                            srt_collar_type_name = "এরো";
                        }
                        if (srt_collar.equals("2")) {
                            srt_collar_type_name = "টাই";
                        }
                        if (srt_collar.equals("3")) {
                            srt_collar_type_name = "বেন";
                        }
                        if (srt_collar.equals("4")) {
                            srt_collar_type_name = "পাঞ্জাবি";
                        }

                        String srt_collar_size = rs.getString("srt_collar_size");
                        String srt_cuff_size = rs.getString("srt_cuff_size");
                        String srt_pocket = rs.getString("srt_pocket");
                        String srt_pocket_inner = rs.getString("srt_pocket_inner");
                        if (srt_pocket_inner.equals("1")) {
                            srt_inner_pocket_name = "পকেট হবে";
                        }
                        if (srt_pocket_inner.equals("0")) {
                            srt_inner_pocket_name = "পকেট হবে ";
                        }
                        String qty = rs.getString("qty");
                        String srt_date = rs.getString("srt_date");
                        String srt_catelog_no = rs.getString("srt_catelog_no");
                        String srt_others = rs.getString("srt_others");
            %>
            <span>Measurement of Shirt. Order id : <%=order_id%>.<br/> Maker Name : <%=maker_name%></span>
            <table width="30%" style="margin: 0px;" border="1" >
                <tr>
                    <td width="148" style="text-align: right">লম্বা </td>
                    <td width="48" style="text-align: center"><%=srt_long%></td>
                    <td width="148" style="text-align: right">বডি</td>
                    <td width="48" style="text-align: center"><%=srt_body%></td>
                </tr>              
                <tr>
                    <td style="text-align: right;">পেট</td>
                    <td style="text-align: center;"><%=srt_bally%></td>                    
                    <td style="text-align: right">হিপ</td>
                    <td style="text-align: center"><%=srt_hip%></td>
                </tr>
                <tr>
                    <td  style="text-align: right">কাধ </td>
                    <td  style="text-align: center"><%=srt_shoulder%></td>
                    <td style="text-align: right;">হাতা লম্বা</td>
                    <td style="text-align: center;"><%=srt_hand_long%></td>                    
                </tr>
                <tr>                    
                    <td style="text-align: right;">হাতা কাপ</td>
                    <td style="text-align: center;"><%=srt_hand_cuff%></td>
                    <td style="text-align: right">গলা</td>
                    <td style="text-align: center"><%=srt_neck%></td>
                </tr>
                <tr>
                    <td style="text-align: right;">হাতা কুনু</td>
                    <td style="text-align: center;"><%=srt_hand_qunu%></td>
                    <td style="text-align: right;">হাতা মোজা</td>
                    <td style="text-align: center;"><%=srt_hand_moja%></td>
                </tr>
                <tr>
                    <td style="text-align: right">বডি লুজ </td>
                    <td style="text-align: center"><%=body_loose%></td>
                    <td style="text-align: right;">ধরন</td>
                    <td style="text-align: center;"><%=srt_type_name%></td>
                </tr>
                <tr>
                    <td style="text-align: right;">প্লেট</td>
                    <td style="text-align: center;"><%=srt_plet_type_name%></td>
                    <td style="text-align: right;">কলার</td>
                    <td style="text-align: center;"><%=srt_collar_type_name%></td>
                </tr>
                <tr>
                    <td style="text-align: right;">কলারের মাপ</td>
                    <td style="text-align: center;"><%=srt_collar_size%></td>
                    <td style="text-align: right;">কাফ সাইজ</td>
                    <td style="text-align: center;"><%=srt_cuff_size%></td>
                </tr>
                <tr>
                    <td style="text-align: right;">পকেট</td>
                    <td style="text-align: center;"><%=srt_pocket + " টি"%></td>
                    <td style="text-align: right;">ভিতর পকেট </td>
                    <td style="text-align: center;"><%=srt_inner_pocket_name%></td>
                </tr>
                <tr>
                    <td style="text-align: right;">জামার সংখ্যা</td>
                    <td style="text-align: center;"><%=qty + " টি"%></td>
                    <td style="text-align: right;">কেটালগ নং</td>
                    <td style="text-align: center;"><%=srt_catelog_no%></td>
                </tr>
                <tr>
                    <td style="text-align: right;">ডেলিভারি তারিখ</td>
                    <td style="text-align: center;"><%=product_delivery_date%></td>
                    <td style="text-align: right;">অনান্য</td>
                    <td style="text-align: center;"></td>
                </tr>
                <tr>
                    <td colspan="4"><%="Others : "+srt_others%></td>
                </tr>
            </table>
            <%
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <br>
            <span>Power By :<b> IGL Web™ Ltd.</b> || 880-1823-037726</span>
        </div>
        <button onclick="printDiv('printableArea')" style="margin-top: 10px;">Print</button>
        <%
            }
        %>
        <%
            if (product.equals("pant")) {
        %>
        <div class="print" id="printableAreapant">
            <%
                String pnt_kuci_name = null;
                String pnt_inner_pocket_status = null;
                String pnt_mohuri_type_status = null;
                try {
                    String sql = "select * from ser_pant where bran_id = '"+session.getAttribute("user_bran_id")+"' and order_id = '" + order_id + "' ";
                    PreparedStatement pst = DbConnection.getConn(sql);
                    ResultSet rs = pst.executeQuery();
                    if (rs.next()) {
                        String pnt_long = rs.getString("pnt_long");
                        String pnt_comor = rs.getString("pnt_comor");
                        String pnt_hip = rs.getString("pnt_hip");
                        String pnt_mohuri = rs.getString("pnt_mohuri");
                        String pnt_run = rs.getString("pnt_run");
                        String pnt_high = rs.getString("pnt_high");
                        String pnt_fly = rs.getString("pnt_fly");
                        String pnt_kuci = rs.getString("pnt_kuci");
                        if (pnt_kuci.equals("1")) {
                            pnt_kuci_name = "হ্যাঁ";
                        }
                        if (pnt_kuci.equals("0")) {
                            pnt_kuci_name = "না";
                        }
                        String pnt_pocket_type = rs.getString("pnt_pocket_type");
                        String pnt_pocket_backside = rs.getString("pnt_pocket_backside");
                        String pnt_pocket_inner = rs.getString("pnt_pocket_inner");
                        if(pnt_pocket_inner.equals("1")){
                            pnt_inner_pocket_status = "হবে";
                        }
                        if(pnt_pocket_inner.equals("0")){
                             pnt_inner_pocket_status = "হবে না";
                        }                        
                        String pnt_mohuri_type = rs.getString("pnt_mohuri_type");
                        if(pnt_mohuri_type.equals("1")){
                            pnt_mohuri_type_status = "ফ্লাডিং";
                        }else if(pnt_mohuri_type.equals("2")){
                            pnt_mohuri_type_status = "নর্মাল";
                        }
                        String pnt_loop = rs.getString("pnt_loop");
                        String pnt_loop_size = rs.getString("pnt_loop_size");
                        String pnt_date = rs.getString("pnt_date");
                        String pnt_catelog_no = rs.getString("pnt_catelog_no");
                        String pnt_others = rs.getString("pnt_others");
                        String qty = rs.getString("qty");
            %>
            <span>Measurement of Pant. Order id : <%=order_id%>.<br/> Maker Name : <%=maker_name%></span>
            <table width="30%" style="margin-top: 10px;" border="1">                
                <tr>
                    <td width="148" style="text-align: right">লম্বা </td>                    
                    <td width="48" style="text-align: center"><%=pnt_long%></td>
                    <td width="148" style="text-align: right">কোমর</td>
                    <td width="48" style="text-align: center"><%=pnt_comor%></td>
                </tr>
                <tr>
                    <td style="text-align: right">হিপ</td>
                    <td style="text-align: center"><%=pnt_hip%></td>
                    <td style="text-align: right">মুহুরি</td>
                    <td style="text-align: center"><%=pnt_mohuri%></td>                    
                </tr>
                <tr>
                    <td style="text-align: right">রান/থাই</td>
                    <td style="text-align: center"><%=pnt_run%></td>
                    <td style="text-align: right">হাই</td>
                    <td style="text-align: center"><%=pnt_high%></td>

                </tr>
                <tr>
                    <td style="text-align: right">ফ্লাই</td>
                    <td style="text-align: center"><%=pnt_fly%></td>
                    <td style="text-align: right">পকেট</td>
                    <td style="text-align: center"><%=pnt_pocket_type%></td>
                </tr>
                <tr>
                    <td style="text-align: right">পকেট পিছ্নে</td>
                    <td style="text-align: center"><%=pnt_pocket_backside%></td>
                    <td style="text-align: right">ইনার পকেট</td>
                    <td style="text-align: center"><%=pnt_inner_pocket_status%></td>
                </tr>
                <tr>
                    <td style="text-align: right">মুহুরি টাইপ</td>
                    <td style="text-align: center"><%=pnt_mohuri_type_status%></td>
                    <td style="text-align: right">লুপ</td>
                    <td style="text-align: center"><%=pnt_loop%></td>
                </tr>
                <tr>
                    <td style="text-align: right">লুপ সাইড</td>
                    <td style="text-align: center"><%=pnt_loop_size%></td>
                    <td style="text-align: right">কুচি</td>
                    <td style="text-align: center"><%=pnt_kuci_name%></td>
                </tr>
                <tr>
                    <td style="text-align: left">প্যান্টের সংখ্যা</td>
                    <td style="text-align: center"><%=qty%></td>
                    <td style="text-align: left">কেটালগ নং</td>
                    <td style="text-align: center"><%=pnt_catelog_no%></td>
                </tr>
                <tr>
                    <td style="text-align: right">ডেলিভারি তারিখ </td>
                    <td style="text-align: center"><%=product_delivery_date%></td>
                    <td style="text-align: right">অনান্য</td>
                    <td style="text-align: center"></td>
                </tr>
                <tr>
                    <td colspan="4"><%="Others : "+pnt_others%></td>
                </tr>                
            </table>
            <%
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>
            <br>
            <span>Power By :<b> IGL Web™ Ltd.</b> || 880-1823-037726</span>
        </div>
        <button onclick="printDiv('printableAreapant')" style="margin-top: 10px;">Print</button>
        <%
            }
        %>

        <%
            String open_name = null;
            String neca_name = null;
            String best_name = null;
            if (product.equals("blazer")) {
                try {
                    String sql = "select * from ser_blazer where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                    PreparedStatement pst = DbConnection.getConn(sql);
                    ResultSet rs = pst.executeQuery();
                    if (rs.next()) {
                        String blz_long = rs.getString("blz_long");
                        String blz_body = rs.getString("blz_body");
                        String blz_bally = rs.getString("blz_bally");
                        String blz_hip = rs.getString("blz_hip");
                        String blz_shoulder = rs.getString("blz_shoulder");
                        String blz_hand_long = rs.getString("blz_hand_long");
                        String blz_hand_mohuri = rs.getString("blz_hand_mohuri");
                        String blz_cross_back = rs.getString("blz_cross_back");
                        String blz_button_num = rs.getString("blz_button_num");
                        String blz_nepel = rs.getString("blz_nepel");
                        String blz_side = rs.getString("blz_side");
                        if (blz_side.equals("1")) {
                            open_name = "ব্যাক ওপেন";
                        }
                        if (blz_side.equals("2")) {
                            open_name = "সাইড ওপেন";
                        }
                        if (blz_side.equals("3")) {
                            open_name = "নো ওপেন";
                        }
                        if (blz_side.equals("4")) {
                            open_name = "ব্যাক ওপেন/সাইড ওপেন";
                        }
                        String blz_catelog_no = rs.getString("blz_catelog_no");
                        String blz_others = rs.getString("blz_others");
                        String blz_date = rs.getString("blz_date");
                        String qty = rs.getString("qty");
                        String best = rs.getString("best");
                        if (best.equals("1")) {
                            best_name = "সিঙ্গেল";
                        }
                        if (best.equals("2")) {
                            best_name = "ডাবল";
                        }
                        String under = rs.getString("under");
                        if (under.equals("0")) {
                            neca_name = "রাউন্ড";
                        }
                        if (under.equals("1")) {
                            neca_name = " স্কোয়ার";
                        }
        %>
        <div id="printableAreablazer">
            <span>Measurement of Blazer. Order id : <%=order_id%>. <br/>Maker Name : <%=maker_name%></span>            
            <table width="30%" style="margin-top: 10px;" border="1">
                <tr>
                    <td width="148" style="text-align: right">লম্বা</td>
                    <td width="48" style="text-align: center"><%=blz_long%></td>
                    <td width="148" style="text-align: right">বডি</td>
                    <td width="48" style="text-align: center"><%=blz_body%></td>
                </tr>
                <tr>
                    <td style="text-align: right">পেট</td>
                    <td style="text-align: center"><%=blz_bally%></td>
                    <td style="text-align: right">হিপঃ</td>
                    <td style="text-align: center"><%=blz_hip%></td>
                </tr>
                <tr>
                    <td style="text-align: right">কাধ</td>
                    <td style="text-align: center"><%=blz_shoulder%></td>
                    <td style="text-align: right">হাতা-লম্বাঃ</td>
                    <td style="text-align: center"><%=blz_hand_long%></td>
                </tr>
                <tr>
                    <td style="text-align: right">হাতা-মহরিঃ</td>
                    <td style="text-align: center"><%=blz_hand_mohuri%></td>
                    <td style="text-align: right">ক্রস ব্যাকঃ</td>
                    <td style="text-align: center"><%=blz_cross_back%></td>
                </tr>
                <tr>
                    <td style="text-align: right">বুতাম</td>
                    <td style="text-align: center"><%=blz_button_num+" টি"%></td>
                    <td style="text-align: right">নেপেল</td>
                    <td style="text-align: center"><%=blz_nepel%></td>
                </tr>
                <tr>
                    <td style="text-align: right">ওপেন</td>
                    <td style="text-align: center"><%=open_name%></td>
                    <td style="text-align: right">বেস্ট</td>
                    <td style="text-align: center"><%=best_name%></td>
                </tr>
                <tr>
                    <td style="text-align: right">নিচে</td>
                    <td style="text-align: center"><%=neca_name%></td>
                    <td style="text-align: right">ব্লেজারের সংখ্যা</td>
                    <td style="text-align: center"><%=qty%></td>
                </tr>
                <tr>
                    <td style="text-align: right">কেটালগ নং</td>
                    <td style="text-align: center"><%=blz_catelog_no%></td>
                    <td style="text-align: right">ডেলিভারি তারিখ</td>
                    <td style="text-align: center"><%=product_delivery_date%></td>
                </tr>
                <tr>                    
                    <td colspan="4"><%="অন্যান্য   : "+blz_others%></td>                   
                </tr>
            </table>  
            <br>
            <span>Power By :<b> IGL Web™ Ltd.</b> || 880-1823-037726</span>
        </div>
        <button onclick="printDiv('printableAreablazer')" style="margin-top: 10px;">Print</button>
        <%
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            }
        %>        

        <%
            if (product.equals("photua")) {
        %>
        <div id="printableAreaphotua">
            <%
                String type_name = null;
                String pht_plet_name = null;
                String pht_collar_name = null;
                String inner_pocket_name = null;
                String pht_open_status = null;
                try {
                    String sql = "select * from ser_photua where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                    PreparedStatement pst = DbConnection.getConn(sql);
                    ResultSet rs = pst.executeQuery();
                    if (rs.next()) {
                        String pht_long = rs.getString("pht_long");
                        String pht_body = rs.getString("pht_body");
                        String pht_body_loose = rs.getString("pht_body_loose");
                        String pht_bally = rs.getString("pht_bally");
                        String pht_hip = rs.getString("pht_hip");
                        String pht_shoulder = rs.getString("pht_shoulder");
                        String pht_neck = rs.getString("pht_neck");
                        String pht_hand_long = rs.getString("pht_hand_long");
                        String pht_hand_moja = rs.getString("pht_hand_moja");
                        String pht_hand_qunu = rs.getString("pht_hand_qunu");
                        String pht_hand_cuff = rs.getString("pht_hand_cuff");
                        String pht_open = rs.getString("pht_open");
                        if(pht_open.equals("1")){
                            pht_open_status = "ওপেন";
                        }else if(pht_open.equals("2")){
                            pht_open_status = "নো ওপেন";
                        }
                        String pht_types = rs.getString("pht_types");
                        if (pht_types.equals("1")) {
                            type_name = "চাইনিজ";
                        }
                        if (pht_types.equals("2")) {
                            type_name = "হাওয়াই";
                        }
                        if (pht_types.equals("3")) {
                            type_name = "হাফ";
                        }
                        String pht_plet = rs.getString("pht_plet");
                        if (pht_plet.equals("1")) {
                            pht_plet_name = "বক্স প্লেট";
                        }
                        if (pht_plet.equals("2")) {
                            pht_plet_name = "সেলাই প্লেট";
                        }
                        if (pht_plet.equals("3")) {
                            pht_plet_name = "ইনার প্লেট";
                        }

                        String pht_collar = rs.getString("pht_plet");
                        if (pht_collar.equals("1")) {
                            pht_collar_name = "এরো";
                        }
                        if (pht_collar.equals("2")) {
                            pht_collar_name = "টাই";
                        }
                        if (pht_collar.equals("3")) {
                            pht_collar_name = "বেন";
                        }
                        if (pht_collar.equals("4")) {
                            pht_collar_name = "পাঞ্জাবি";
                        }
                        String pht_collar_size = rs.getString("pht_collar_size");
                        String pht_cuff_size = rs.getString("pht_cuff_size");

                        String pht_pocket = rs.getString("pht_pocket");
                        String pht_pocket_inner = rs.getString("pht_pocket_inner");
                        if (pht_pocket_inner.equals("1")) {
                            inner_pocket_name = "হবে";
                        }
                        if (pht_pocket_inner.equals("0")) {
                            inner_pocket_name = "হবে না";
                        }
                        String qty = rs.getString("qty");
                        String pht_date = rs.getString("pht_date");
                        String pht_catelog_no = rs.getString("pht_catelog_no");
                        String pht_others = rs.getString("pht_others");
            %>
            <span>Measurement of Photua. Order id : <%=order_id%>. <br/>Maker Name : <%=maker_name%></span>
            <table width="30%" style="margin-top: 10px;"  border="1">
                <tr>
                    <td width="148" style="text-align: right">লম্বা </td>
                    <td width="48" style="text-align: center"><%=pht_long%></td>
                    <td width="148" style="text-align: right">বডি</td>
                    <td width="48" style="text-align: center"><%=pht_body%></td>
                </tr>
                <tr>
                    <td style="text-align: right">পেট</td>
                    <td style="text-align: center"><%=pht_bally%></td>
                    <td style="text-align: right">হিপ</td>
                    <td style="text-align: center"><%=pht_hip%></td>
                </tr>
                <tr>
                    <td style="text-align: right">কাধ</td>
                    <td style="text-align: center"><%=pht_shoulder%></td>
                    <td style="text-align: right">হাতা লম্বা</td>
                    <td style="text-align: center"><%=pht_hand_long%></td>                    
                </tr>
                <tr>
                    <td style="text-align: right">হাতা কাপ</td>
                    <td style="text-align: center"><%=pht_hand_cuff%></td>
                    <td style="text-align: right">গলা</td>
                    <td style="text-align: center"><%=pht_neck%></td>                                  
                </tr>
                <tr>
                    <td style="text-align: right">হাতা কুনু</td>
                    <td style="text-align: center"><%=pht_hand_qunu%></td>
                    <td style="text-align: right">হাতা মোজা</td>
                    <td style="text-align: center"><%=pht_hand_moja%></td>
                </tr>
                <tr>
                    <td style="text-align: right">বডি লুজ</td>
                    <td style="text-align: center"><%=pht_body_loose%></td>      
                    <td style="text-align: right">ধরন</td>
                    <td style="text-align: center"><%=type_name%></td>
                </tr>
                <tr>
                    <td style="text-align: right">প্লেট</td>
                    <td style="text-align: center"><%=pht_plet_name%></td>
                    <td style="text-align: right">কলার</td>
                    <td style="text-align: center"><%=pht_collar_name%></td>
                </tr>
                <tr>
                    <td style="text-align: right">কলারের মাপ</td>
                    <td style="text-align: center"><%=pht_collar_size%></td>
                    <td style="text-align: right">কাফ সাইজ</td>
                    <td style="text-align: center"><%=pht_cuff_size%></td>
                </tr>
                <tr>
                    <td style="text-align: right">পকেট</td>
                    <td style="text-align: center"><%=pht_pocket +" টি"%></td>
                    <td style="text-align: right">ভিতর পকেট </td>
                    <td style="text-align: center"><%=inner_pocket_name%></td>
                </tr>
                <tr>
                    <td style="text-align: right">ফতুয়া সংখ্যা </td>
                    <td style="text-align: center"><%=qty +" টি"%></td>
                    <td style="text-align: right">কেটালগ নং</td>
                    <td style="text-align: center"><%=pht_catelog_no%></td>
                </tr>
                <tr>
                    <td style="text-align: right">ওপেন</td>
                    <td style="text-align: center"><%=pht_open_status%></td>
                    <td style="text-align: right">ডেলিভারি ডেট</td>
                    <td style="text-align: center"><%=product_delivery_date%></td>
                </tr>
                <tr>                  
                    <td style="text-align: right">ডেলিভারি তারিখ</td>
                    <td style="text-align: center"><%=product_delivery_date%></td>
                    <td style="text-align: right">অনান্য  </td>
                    <td style="text-align: center"></td>
                </tr>
                <tr>
                    <td colspan="4"><%="অন্যান্য   : "+pht_others%></td>
                </tr>
            </table>
            <%
                    }
                } catch (Exception e) {
                    out.println(e.toString());
                }
            %>       
            <br>
            <span>Power By :<b> IGL Web™ Ltd.</b> || 880-1823-037726</span>
        </div>
        <button onclick="printDiv('printableAreaphotua')" style="margin-top: 10px;">Print</button>
        <%
            }
        %>
        <%
            if (product.equals("safari")) {
                String sfr_plet_status = null;
                String sfr_back_side_status = null;
                String sfr_collar_status = null;
                String sfr_inner_pocket_status = null;
                String sfr_type_status = null;
                try {
                    String sql_ser_safari = "select * from ser_safari where bran_id =  '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                    PreparedStatement pst_ser_safari = DbConnection.getConn(sql_ser_safari);
                    ResultSet rs_ser_safari = pst_ser_safari.executeQuery();
                    if (rs_ser_safari.next()) {
                        String sfr_long = rs_ser_safari.getString("sfr_long");
                        String sfr_body = rs_ser_safari.getString("sfr_body");
                        String sfr_body_loose = rs_ser_safari.getString("sfr_body_loose");
                        String sfr_belly = rs_ser_safari.getString("sfr_belly");
                        String sfr_belly_loose = rs_ser_safari.getString("sfr_belly_loose");
                        String sfr_hip = rs_ser_safari.getString("sfr_hip");
                        String sfr_hip_loose = rs_ser_safari.getString("sfr_hip_loose");
                        String sfr_shoulder = rs_ser_safari.getString("sfr_shoulder");
                        String sfr_cross_back = rs_ser_safari.getString("sfr_cross_back");
                        String sfr_neck = rs_ser_safari.getString("sfr_neck");
                        String sfr_hand_long = rs_ser_safari.getString("sfr_hand_long");
                        String sfr_hand_cuff = rs_ser_safari.getString("sfr_hand_cuff");
                        String sfr_plet = rs_ser_safari.getString("sfr_plet");
                        if(sfr_plet.equals("1")){
                            sfr_plet_status = "বক্স প্লেট";
                        }else if(sfr_plet.equals("2")){
                            sfr_plet_status = "সেলাই প্লেট";
                        }else if(sfr_plet.equals("3")){
                            sfr_plet_status = "সেলাই প্লেট";
                        }
                        String sfr_collar = rs_ser_safari.getString("sfr_collar");
                        if(sfr_collar.equals("1")){
                            sfr_collar_status = "শার্ট   কলার";
                        }else if(sfr_collar.equals("2")){
                            sfr_collar_status = "ব্যান্ড কলার";
                        }else if(sfr_collar.equals("3")){
                            sfr_collar_status = "ওপেন কলার";
                        }
                        String sfr_collar_size = rs_ser_safari.getString("sfr_collar_size");
                        String sfr_pocket = rs_ser_safari.getString("sfr_pocket");
                        String sfr_back_side = rs_ser_safari.getString("sfr_back_side");
                        if(sfr_back_side.equals("1")){
                            sfr_back_side_status = "ওপেন";
                        }else if(sfr_back_side.equals("2")){
                             sfr_back_side_status = "নো ওপেন";
                        }
                        String qty = rs_ser_safari.getString("qty");
                        String sfr_date = rs_ser_safari.getString("sfr_date");
                        String sfr_catelog_no = rs_ser_safari.getString("sfr_catelog_no");
                        String sfr_others = rs_ser_safari.getString("sfr_others");
                        String sfr_inner_pocket = rs_ser_safari.getString("sfr_inner_pocket");
                        if(sfr_inner_pocket.equals("1")){
                            sfr_inner_pocket_status = "হবে";
                        }else if(sfr_inner_pocket.equals("0")){
                            sfr_inner_pocket_status = "হবে না";
                        }
                        String sfr_type = rs_ser_safari.getString("sfr_type");
                        if(sfr_type.equals("1")){
                            sfr_type_status = "ফুল হাতা";
                        }else if(sfr_type.equals("0")){
                            sfr_type_status = "হাফ হাতা";
                        }

        %>
        <div id="printableArea">
            <span>Measurement of Safari. Order id : <%=order_id%>. <br/>Maker Name : <%=maker_name%></span>
            <table width="30%" style="margin-top: 10px;" border="1">
                <tr>
                    <td width="148" style="text-align: right">লম্বা </td>
                    <td width="48" style="text-align: center"><%=sfr_long%></td>
                    <td width="148" style="text-align: right">বডি</td>
                    <td width="48" style="text-align: center"><%=sfr_body%></td>
                </tr>
                <tr>
                    <td style="text-align: right">পেট</td>
                    <td style="text-align: center"><%=sfr_belly%></td>
                    <td style="text-align: right">হিপ</td>
                    <td style="text-align: center"><%=sfr_hip%></td>                                     
                </tr>
                <tr>                    
                    <td style="text-align: right">কাঁধ</td>
                    <td style="text-align: center"><%=sfr_shoulder%></td>
                    <td style="text-align: right">ক্রস ব্যাক</td>
                    <td style="text-align: center"><%=sfr_cross_back%></td>                    
                </tr>
                <tr>
                    <td style="text-align: right">হাত লম্বা</td>
                    <td style="text-align: center"><%=sfr_hand_long%></td>
                    <td style="text-align: right">কাপ</td>
                    <td style="text-align: center"><%=sfr_hand_cuff%></td>
                </tr>
                <tr>
                    <td style="text-align: right">গলা</td>
                    <td style="text-align: center"><%=sfr_neck%></td>
                    <td style="text-align: right">বডি লুজ</td>
                    <td style="text-align: center"><%=sfr_body_loose%></td>                         
                </tr>   
                <tr>
                    <td style="text-align: right">পেট লুজ</td>
                    <td style="text-align: center"><%=sfr_belly_loose%></td>
                    <td style="text-align: right">হিপ লুজ</td>
                    <td style="text-align: center"><%=sfr_hip_loose%></td>               
                </tr>                            
                <tr>
                    <td style="text-align: right">কলার টাইপ</td>
                    <td style="text-align: center"><%=sfr_collar_status%></td>
                    <td style="text-align: right">প্লেট</td>
                    <td style="text-align: center"><%=sfr_plet_status%></td>
                </tr>
                <tr>
                    <td style="text-align: right">কলার সাইজ</td>
                    <td style="text-align: center"><%=sfr_collar_size%></td>
                    <td style="text-align: right">পকেট</td>
                    <td style="text-align: center"><%=sfr_pocket +" টি"%></td>
                </tr>
                <tr>
                    <td style="text-align: right">ইনার পকেট</td>
                    <td style="text-align: center"><%=sfr_inner_pocket_status%></td>
                    <td style="text-align: right">সাফারি ধরণ</td>
                    <td style="text-align: center"><%=sfr_type_status%></td>
                </tr>
                <tr>
                    <td style="text-align: right">ব্যাক সাইড</td>
                    <td style="text-align: center"><%=sfr_back_side_status%></td>
                    <td style="text-align: right">সাফারি সংখ্যা </td>
                    <td style="text-align: center"><%=qty%></td>
                </tr>
                <tr>
                    <td style="text-align: right">ক্যাটালগ_নো </td>
                    <td style="text-align: center"><%=sfr_catelog_no%></td>
                    <td style="text-align: right">অন্যান্য  </td>
                    <td style="text-align: center"></td>
                </tr>
                <tr>
                    <td colspan="4"><%="অন্যান্য   : "+sfr_others%></td>
                </tr>
            </table><br/>
            <span style="margin-top: 5px;">Power By :<b> IGL Web™ Ltd.</b> || 880-1823-037726</span><br/>        
            <button onclick="printDiv('printableAreaphotua')" style="margin-top: 10px;">Print</button>
        </div>
        <%
                    }
                } catch (Exception e) {
                    out.println("safari measurement " + e.toString());
                }
            }
        %>
        <%
            if (product.equals("panjabi")) {
                String pnjb_plet_status = null;
                String pnjb_inner_pocket_status = null;
                try {
                    String sql_panajbi = "select * from ser_panjabi where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                    PreparedStatement pst_panjabi = DbConnection.getConn(sql_panajbi);
                    ResultSet rs_panjabi = pst_panjabi.executeQuery();
                    if (rs_panjabi.next()) {
                        String pnjb_long = rs_panjabi.getString("pnjb_long");
                        String pnjb_body = rs_panjabi.getString("pnjb_body");
                        String pnjb_body_loose = rs_panjabi.getString("pnjb_body_loose");
                        String pnjb_belly = rs_panjabi.getString("panjb_belly");
                        String pnjb_belly_loose = rs_panjabi.getString("pnjb_belly_loose");
                        String pnjb_hip = rs_panjabi.getString("pnjb_hip");
                        String pnjb_hip_loose = rs_panjabi.getString("pnjb_hip_loose");
                        String pnjb_shoulder = rs_panjabi.getString("pnjb_shoulder");
                        String pnjb_neck = rs_panjabi.getString("pnjb_neck");
                        String pnjb_hand_long = rs_panjabi.getString("pnjb_hand_long");
                        String pnjb_muhuri = rs_panjabi.getString("pnjb_muhuri");
                        String pnjb_plet = rs_panjabi.getString("pnjb_plet");
                        if(pnjb_plet.equals("1")){
                            pnjb_plet_status = "ইনার প্লেট";
                        }else if(pnjb_plet.equals("2")){
                            pnjb_plet_status = "নরমাল প্লেট";
                        }
                        String pnjb_collar_type = rs_panjabi.getString("pnjb_collar_type");
                       
                        String pnjb_collar_size = rs_panjabi.getString("pnjb_collar_size");
                        String pnjb_pocket = rs_panjabi.getString("pnjb_pocket");
                        String pnjb_inner_pocket= rs_panjabi.getString("pnjb_inner_pocket");
                        if(pnjb_inner_pocket.equals("1")){
                            pnjb_inner_pocket_status = "হবে";
                        }else if(pnjb_inner_pocket.equals("0")){
                            pnjb_inner_pocket_status = "হবে না";
                        }
                        String qty = rs_panjabi.getString("qty");
                        String pnjb_catelog_no = rs_panjabi.getString("pnjb_catelog_no");
                        String pnjb_others = rs_panjabi.getString("pnjb_others");

        %>
        <div id="printableAreapanjabi">
            <span>Measurement of Panjabi. Order id : <%=order_id%>. <br/>Maker Name : <%=maker_name%></span>
            <table  width="30%" style="margin-top: 10px;" border="1">
                <tr>
                    <td width="148" style="text-align: right">লম্বা </td>
                    <td width="48" style="text-align: center"><%=pnjb_long%></td>
                    <td width="148" style="text-align: right">বডি</td>
                    <td width="48" style="text-align: center"><%=pnjb_body%></td>
                </tr>
                <tr>                    
                    <td style="text-align: right">পেট</td>
                    <td style="text-align: center"><%=pnjb_belly%></td>
                    <td style="text-align: right">হিপ</td>
                    <td style="text-align: center"><%=pnjb_hip%></td>
                </tr>
                <tr>                    
                    <td style="text-align: right">কাঁধ</td>
                    <td style="text-align: center"><%=pnjb_shoulder%></td>
                    <td style="text-align: right">হাত লম্বা</td>
                    <td style="text-align: center"><%=pnjb_hand_long%></td>
                </tr>
                <tr>
                    <td style="text-align: right">মুহুরী </td>
                    <td style="text-align: center"><%=pnjb_muhuri%></td>
                    <td style="text-align: right">গলা</td>
                    <td style="text-align: center"><%=pnjb_neck%></td>
                </tr>
                <tr>
                    <td style="text-align: right">বডি লুজ</td>
                    <td style="text-align: center"><%=pnjb_body_loose%></td>
                    <td style="text-align: right">পেট লুজ</td>
                    <td style="text-align: center"><%=pnjb_belly_loose%></td>                   
                </tr>                
                <tr>                    
                    <td style="text-align: right">হিপ লুজ</td>
                    <td style="text-align: center"><%=pnjb_hip_loose%></td>
                    <td style="text-align: right">প্লেট</td>
                    <td style="text-align: center"><%=pnjb_plet_status%></td>
                </tr>

                <tr>
                    <td style="text-align: right">কলার সাইজ</td>
                    <td style="text-align: center"><%=pnjb_collar_size%></td>
                    <td style="text-align: right">কলার টাইপ</td>
                    <td style="text-align: center"><%="ব্যান্ড কলার"%></td>
                </tr>
                <tr>
                    <td style="text-align: right">পকেট</td>
                    <td style="text-align: center"><%=pnjb_pocket+" টি"%></td>
                    <td style="text-align: right">ইনার পকেট</td>
                    <td style="text-align: center"><%=pnjb_inner_pocket_status%></td>
                </tr>
                <tr>
                    <td style="text-align: right">সাফারি সংখ্যা </td>
                    <td style="text-align: center"><%=qty +" টি"%></td>
                    <td style="text-align: right">ডেলিভার ডেট</td>
                    <td style="text-align: center"><%=product_delivery_date%></td>
                </tr>
                <tr>
                    <td style="text-align: right">ক্যাটালগ_নো</td>
                    <td style="text-align: center"><%=pnjb_catelog_no%></td>
                    <td style="text-align: right"></td>
                    <td style="text-align: center"></td>
                </tr>
                <tr>
                    <td colspan="4"><%="অন্যান্য   : "+pnjb_others%></td>
                </tr>
            </table>
            <br/>
            <span style="margin-top: 5px;">Power By :<b> IGL Web™ Ltd.</b> || 880-1823-037726</span><br/>        
            <button onclick="printDiv('printableAreapanjabi')" style="margin-top: 10px;">Print</button>
        </div>
        <%
                    }
                } catch (Exception e) {
                    out.println("panjabi measurement " + e.toString());
                }
            }
        %>
        <%
            if (product.equals("payjama")) {
                try {
                    String sql_payjama = "select * from ser_payjama where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                    PreparedStatement pst_payjama = DbConnection.getConn(sql_payjama);
                    ResultSet rs_payjama = pst_payjama.executeQuery();
                    if (rs_payjama.next()) {
                        String pjma_long = rs_payjama.getString("pjma_long");
                        String pjma_comor = rs_payjama.getString("pjma_comor");
                        String pjma_hip = rs_payjama.getString("pjma_hip");
                        String pjma_hip_loose = rs_payjama.getString("pjma_hip_loose");
                        String pjma_mohuri = rs_payjama.getString("pjma_mohuri");
                        String pjma_thai = rs_payjama.getString("pjma_thai");
                        String pjma_fly = rs_payjama.getString("pjma_fly");
                        String pjma_high = rs_payjama.getString("pjma_high");
                        String pjma_pocket = rs_payjama.getString("pjma_pocket");
                        String pjma_catelog_no = rs_payjama.getString("pjma_catelog_no");
                        String pjma_others = rs_payjama.getString("pjma_others");
                        String qty = rs_payjama.getString("qty");

        %>
        <div id="printableAreapayjama">
            <span>Measurement of Pajama. Order id : <%=order_id%>. <br/>Maker Name : <%=maker_name + "."%> Delivery Date <%=product_delivery_date%></span>
            <table width="30%" style="margin-top: 10px;" border="1">
                <tr>
                    <td width="148" style="text-align: right">লম্বা </td>
                    <td width="48" style="text-align: center"><%=pjma_long%></td>
                    <td width="148" style="text-align: right">কোমর</td>
                    <td width="48" style="text-align: center"><%=pjma_comor%></td>
                </tr>
                <tr>
                    <td style="text-align: right">হিপ</td>
                    <td style="text-align: center"><%=pjma_hip%></td>
                    <td style="text-align: right">মুহুরী</td>
                    <td style="text-align: center"><%=pjma_mohuri%></td>                    
                </tr>
                <tr>                    
                    <td style="text-align: right">থাই</td>
                    <td style="text-align: center"><%=pjma_thai%></td>
                    <td style="text-align: right">ফ্লাই</td>
                    <td style="text-align: center"><%=pjma_fly%></td>
                </tr>
                <tr>                    
                    <td style="text-align: right">হাই</td>
                    <td style="text-align: center"><%=pjma_high%></td>
                    <td style="text-align: right">হিপ লুজ</td>
                    <td style="text-align: center"><%=pjma_hip_loose%></td>
                </tr>
                <tr>
                    <td style="text-align: right">পকেট</td>
                    <td style="text-align: center"><%=pjma_pocket +" টি"%></td>
                    <td style="text-align: right">ক্যাটালগ নো</td>
                    <td style="text-align: center"><%=pjma_catelog_no%></td>
                </tr>
                <tr>
                    <td style="text-align: right"></td>
                    <td style="text-align: center"></td>
                    <td style="text-align: right">পাজামা সংখ্যা</td>
                    <td style="text-align: center"><%=qty +" টি"%></td>
                </tr>
                <tr>
                    <td colspan="4"><%="অন্যান্য   : "+pjma_others%></td>
                </tr>
            </table>
            <br/>
            <span style="margin-top: 5px;">Power By :<b> IGL Web™ Ltd.</b> || 880-1823-037726</span><br/>            
        </div>
        <button onclick="printDiv('printableAreapayjama')" style="margin-top: 10px;">Print</button>
        <%
                    }

                } catch (Exception e) {
                    out.println("payjama measurement " + e.toString());
                }
            }
        %>
        <%
            if (product.equals("mojib_cort")) {
                String mjc_inner_pocket_status = null; 
                String mjc_open_status = null;
                try {
                    String sql_mojib_cort = "select * from ser_mojib_cort where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                    PreparedStatement pst_mojib_cort = DbConnection.getConn(sql_mojib_cort);
                    ResultSet rs_mojib_cort = pst_mojib_cort.executeQuery();
                    if (rs_mojib_cort.next()) {
                        String mjc_long = rs_mojib_cort.getString("mjc_long");
                        String mjc_body = rs_mojib_cort.getString("mjc_body");
                        String mjc_body_loose = rs_mojib_cort.getString("mjc_body_loose");
                        String mjc_belly = rs_mojib_cort.getString("mjc_belly");
                        String mjc_belly_loose = rs_mojib_cort.getString("mjc_belly_loose");
                        String mjc_hip = rs_mojib_cort.getString("mjc_hip");
                        String mjc_hip_loose = rs_mojib_cort.getString("mjc_hip_loose");
                        String mjc_shoulder = rs_mojib_cort.getString("mjc_shoulder");
                        String mjc_neck = rs_mojib_cort.getString("mjc_neck");
                        String mjc_collar = rs_mojib_cort.getString("mjc_collar");
                        String mjc_pocket = rs_mojib_cort.getString("mjc_pocket");
                        String mjc_inner_pocket = rs_mojib_cort.getString("mjc_inner_pocket");
                        if(mjc_inner_pocket.equals("1")){
                            mjc_inner_pocket_status = "হবে";
                        }else if(mjc_inner_pocket.equals("2")){
                            mjc_inner_pocket_status = "হবে না";
                        }
                        String mjc_open = rs_mojib_cort.getString("mjc_open");
                        if(mjc_open.equals("1")){
                            mjc_open_status = "ব্যাক ওপেন";
                        }else if(mjc_open.equals("2")){
                            mjc_open_status = "সাইড ওপেন";
                        }
                        String mjc_catelog_no = rs_mojib_cort.getString("mjc_catelog_no");
                        String qty = rs_mojib_cort.getString("qty");
                        String mjc_others = rs_mojib_cort.getString("mjc_others");

        %>
        <div id="printableAreamojibcort">
            <span>Measurement of Mojib Cort. Order id : <%=order_id%>. <br/>Maker Name : <%=maker_name + "."%> Delivery Date <%=product_delivery_date%></span>
            <table width="30%" style="margin-top: 10px;" border="1">
                <tr>
                    <td width="148" style="text-align: right">লম্বা </td>
                    <td width="48" style="text-align: center"><%=mjc_long%></td>
                    <td width="148" style="text-align: right">বডি</td>
                    <td width="48" style="text-align: center"><%=mjc_body%></td>
                </tr>
                <tr>                    
                    <td style="text-align: right">পেট</td>
                    <td style="text-align: center"><%=mjc_belly%></td>
                    <td style="text-align: right">হিপ</td>
                    <td style="text-align: center"><%=mjc_hip%></td>
                </tr>
                <tr>
                    <td style="text-align: right">কাঁধ</td>
                    <td style="text-align: center"><%=mjc_shoulder%></td>
                    <td style="text-align: right">গলা</td>
                    <td style="text-align: center"><%=mjc_neck%></td>                    
                </tr>
                <tr>
                    <td style="text-align: right">বডি লুজ</td>
                    <td style="text-align: center"><%=mjc_body_loose%></td>
                    <td style="text-align: right">পেট লুজ</td>
                    <td style="text-align: center"><%=mjc_belly_loose%></td>                    
                </tr>
                <tr>
                    <td style="text-align: right">হিপ লুজ</td>
                    <td style="text-align: center"><%=mjc_hip_loose%></td>
                    <td style="text-align: right">কলার</td>
                    <td style="text-align: center"><%="ব্যান্ড কলার"%></td>
                </tr>

                <tr>
                    <td style="text-align: right">পকেট</td>
                    <td style="text-align: center"><%=mjc_pocket+" টি"%></td>
                    <td style="text-align: right">ইনার পকেট</td>
                    <td style="text-align: center"><%=mjc_inner_pocket_status%></td>                    
                </tr>
                <tr>
                    <td style="text-align: right">ওপেন</td>
                    <td style="text-align: center"><%=mjc_open_status%></td>                    
                    <td style="text-align: right">মুজিব কোর্ট সংখ্যা </td>
                    <td style="text-align: center"><%=qty%></td>
                </tr>
                <tr>
                    <td style="text-align: right">ক্যাটালগ_নো</td>
                    <td style="text-align: center"><%=mjc_catelog_no%></td>
                    <td style="text-align: right"></td>
                    <td style="text-align: center"></td>                   
                </tr>
                <tr>
                    <td colspan="4"><%="অন্যান্য   : "+mjc_others%></td>
                </tr>
            </table>
            <br/>
            <span style="margin-top: 5px;">Power By :<b> IGL Web™ Ltd.</b> || 880-1823-037726</span><br/>            
        </div>
        <button onclick="printDiv('printableAreamojibcort')" style="margin-top: 10px;">Print</button>
        <%
                    }

                } catch (Exception e) {
                    out.println("Mojib cort measurement " + e.toString());
                }
            }
        %>
        <%
            if (product.equals("kable")) {
                String kbl_collar_type_status = null;
                String kbl_plet_status  = null;
                try {
                    String sql_kable = "select * from ser_kable where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                    PreparedStatement pst_kable = DbConnection.getConn(sql_kable);
                    ResultSet rs_kable = pst_kable.executeQuery();
                    if (rs_kable.next()) {
                        String kbl_long = rs_kable.getString("kbl_long");
                        String kbl_body = rs_kable.getString("kbl_body");
                        String kbl_body_loose = rs_kable.getString("kbl_body_loose");
                        String kbl_belly = rs_kable.getString("kbl_belly");
                        String kbl_belly_loose = rs_kable.getString("kbl_belly_loose");
                        String kbl_hip = rs_kable.getString("kbl_hip");
                        String kbl_hip_loose = rs_kable.getString("kbl_hip_loose");
                        String kbl_shoulder = rs_kable.getString("kbl_shoulder");
                        String kbl_neck = rs_kable.getString("kbl_neck");
                        String kbl_hand_long = rs_kable.getString("kbl_hand_long");
                        String kbl_muhuri = rs_kable.getString("kbl_muhuri");
                        String kbl_plet = rs_kable.getString("kbl_plet");
                        
                        if(kbl_plet.equals("1")){
                            kbl_plet_status = "ইনার প্লেট";
                        }else if(kbl_plet.equals("2")){
                            kbl_plet_status = "নরমাল প্লেট";
                        }
                        String kbl_collar_type = rs_kable.getString("kbl_collar_type");
                        if(kbl_collar_type.equals("1")){
                            kbl_collar_type_status = "শার্ট   কলার";
                        }else if(kbl_collar_type.equals("2")){
                            kbl_collar_type_status = "ব্যান্ড কলার";
                        }
                        String kbl_collar_size = rs_kable.getString("kbl_collar_size");
                        String kbl_pocket = rs_kable.getString("kbl_pocket");
                        String qty = rs_kable.getString("qty");
                        String kbl_catelog_no = rs_kable.getString("kbl_catelog_no");
                        String kbl_others = rs_kable.getString("kbl_others");

        %>
        <div id="printableAreakable">
            <span>Measurement of Kable. Order id : <%=order_id%>. <br/>Maker Name : <%=maker_name + "."%> Delivery Date <%=product_delivery_date%></span>
            <table width="30%" style="margin-top: 10px;" border="1">
                <tr>
                    <td width="148" style="text-align: right">লম্বা </td>
                    <td width="48" style="text-align: center"><%=kbl_long%></td>
                    <td width="148" style="text-align: right">বডি</td>
                    <td width="48" style="text-align: center"><%=kbl_body%></td>
                </tr>
                <tr>                    
                    <td style="text-align: right">পেট</td>
                    <td style="text-align: center"><%=kbl_belly%></td>
                    <td style="text-align: right">হিপ</td>
                    <td style="text-align: center"><%=kbl_hip%></td>
                </tr>
                <tr>
                    <td style="text-align: right">কাঁধ</td>
                    <td style="text-align: center"><%=kbl_shoulder%></td>
                    <td style="text-align: right">হাত লম্বা  </td>
                    <td style="text-align: center"><%=kbl_hand_long%></td>
                </tr>
                <tr>
                    <td style="text-align: right">মুহুরী</td>
                    <td style="text-align: center"><%=kbl_muhuri%></td>
                    <td style="text-align: right">গলা</td>
                    <td style="text-align: center"><%=kbl_neck%></td>                    
                </tr>
                <tr>
                    <td style="text-align: right">বডি লুজ</td>
                    <td style="text-align: center"><%=kbl_body_loose%></td>
                    <td style="text-align: right">পেট লুজ</td>
                    <td style="text-align: center"><%=kbl_belly_loose%></td>                    
                </tr>               
                <tr>
                    <td style="text-align: right">হিপ লুজ</td>
                    <td style="text-align: center"><%=kbl_hip_loose%></td>
                    <td style="text-align: right">প্লেট </td>
                    <td style="text-align: center"><%=kbl_plet_status%></td>
                </tr>              
                <tr>
                    <td style="text-align: right">কলার সাইজ</td>
                    <td style="text-align: center"><%=kbl_collar_size%></td>
                    <td style="text-align: right">কলার টাইপ </td>
                    <td style="text-align: center"><%= kbl_collar_type_status%></td>
                </tr>              
                <tr>
                    <td style="text-align: right">পকেট</td>
                    <td style="text-align: center"><%=kbl_pocket+" টি"%></td>
                    <td style="text-align: right">কাবলি সংখ্যা  </td>
                    <td style="text-align: center"><%= qty+" টি"%></td>
                </tr>              
                <tr>
                    <td style="text-align: right">ক্যাটালগ_নো</td>
                    <td style="text-align: center"><%=kbl_catelog_no%></td>
                    <td style="text-align: right"></td>
                    <td style="text-align: center"></td>
                </tr>
                <tr>
                    <td colspan="4"><%= "অন্যান্য   : "+kbl_others%></td>
                </tr>
            </table>
            <br/>
            <span style="margin-top: 5px;">Power By :<b> IGL Web™ Ltd.</b> || 880-1823-037726</span><br/>            
        </div>
        <button onclick="printDiv('printableAreakable')" style="margin-top: 10px;">Print</button>
        <%
                    }

                } catch (Exception e) {
                    out.println("Kable measurement " + e.toString());
                }
            }
        %>
        <%
            if (product.equals("koti")) {
                String kt_belt_status = null;
                try {
                    String sql_koti = "select * from ser_koti where bran_id = '" + session.getAttribute("user_bran_id") + "' and order_id = '" + order_id + "' ";
                    PreparedStatement pst_koti = DbConnection.getConn(sql_koti);
                    ResultSet rs_koti = pst_koti.executeQuery();
                    if (rs_koti.next()) {
                        String kt_long = rs_koti.getString("kt_long");
                        String kt_body = rs_koti.getString("kt_body");
                        String kt_body_loose = rs_koti.getString("kt_body_loose");
                        String kt_belly = rs_koti.getString("kt_belly");
                        String kt_belly_loose = rs_koti.getString("kt_belly_loose");
                        String kt_hip = rs_koti.getString("kt_hip");
                        String kt_hip_loose = rs_koti.getString("kt_hip_loose");
                        String kt_shoulder = rs_koti.getString("kt_shoulder");
                        String kt_neck = rs_koti.getString("kt_neck");
                        String kt_pocket = rs_koti.getString("kt_pocket");
                        String kt_belt = rs_koti.getString("kt_belt");
                        if(kt_belt.equals("1")){
                            kt_belt_status = "বেল্ট হবে";
                        }else if(kt_belt.equals("0")){
                            kt_belt_status = "বেল্ট হবে না";
                        }
                        String kt_catelog_no = rs_koti.getString("kt_catelog_no");
                        String qty = rs_koti.getString("qty");
                        String kt_others = rs_koti.getString("kt_others");

        %>
        <div id="printableAreakkoti">
            <span>Measurement of Koti. Order id : <%=order_id%>. <br/>Maker Name : <%=maker_name + "."%> Delivery Date <%=product_delivery_date%></span>
            <table width="30%" style="margin-top: 10px;" border="1">
                <tr>
                    <td width="148" style="text-align: right">লম্বা </td>
                    <td width="48" style="text-align: center"><%=kt_long%></td>
                    <td width="148" style="text-align: right">বডি</td>
                    <td width="48" style="text-align: center"><%=kt_body%></td>
                </tr>
                <tr>                    
                    <td style="text-align: right">পেট</td>
                    <td style="text-align: center"><%=kt_belly%></td>
                    <td style="text-align: right">হিপ</td>
                    <td style="text-align: center"><%=kt_hip%></td>
                </tr>
                <tr>
                    <td style="text-align: right">কাঁধ</td>
                    <td style="text-align: center"><%=kt_shoulder%></td>
                    <td style="text-align: right">ডেলিভারি ডেট</td>
                    <td style="text-align: center"><%=product_delivery_date%></td>
                </tr> 
                <tr>
                    <td style="text-align: right">বডি লুজ</td>
                    <td style="text-align: center"><%=kt_body_loose%></td>
                    <td style="text-align: right">পেট লুজ</td>
                    <td style="text-align: center"><%=kt_belly_loose%></td>                    
                </tr>                              
                <tr>
                    <td style="text-align: right">হিপ লুজ</td>
                    <td style="text-align: center"><%=kt_hip_loose%></td>
                    <td style="text-align: right">বেল্ট</td>
                    <td style="text-align: center"><%=kt_belt_status%></td>                    
                </tr> 
                <tr>
                    <td style="text-align: right">পকেট</td>
                    <td style="text-align: center"><%=kt_pocket +" টি"%></td>
                    <td style="text-align: right">কাবলি সংখ্যা  </td>
                    <td style="text-align: center"><%= qty%></td>
                </tr>              
                <tr>
                    <td style="text-align: right">ক্যাটালগ_নো</td>
                    <td style="text-align: center"><%=kt_catelog_no%></td>
                    <td style="text-align: right"></td>
                    <td style="text-align: center"></td>
                </tr>
                <tr>
                    <td colspan="4"><%="অন্যান্য   : "+kt_others%></td>
                </tr>
            </table>
            <br/>
            <span style="margin-top: 5px;">Power By :<b> IGL Web™ Ltd.</b> || 880-1823-037726</span><br/>            
        </div>
        <button onclick="printDiv('printableAreakkoti')" style="margin-top: 10px;">Print</button>
        <%
                    }

                } catch (Exception e) {
                    out.println("Kable measurement " + e.toString());
                }
            }
        %>
        <script>
            function printDiv(divName) {
                var printContents = document.getElementById(divName).innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
            }

            function myFunction() {
                window.print();
            }
        </script>
    </body>
</html>
