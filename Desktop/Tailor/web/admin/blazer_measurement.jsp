<%
    String logger = (String) session.getAttribute("logger");
%>

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
                    response.sendRedirect("/Tailor/index.jsp");
                }
            } else if (logger.equals("branch")) {
                String user_bran_id = (String) session.getAttribute("user_bran_id");
                if (user_bran_id == null) {
                    response.sendRedirect("/Tailor/index.jsp");
                }
            } 
        }else {
            response.sendRedirect("/Tailor/index.jsp");
        }

    } catch (Exception e) {
        out.println(e.toString());
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <div id="wrapper">            
            <jsp:include page="../menu/menu.jsp"/>
            <div id="page-wrapper">
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                blazers Measurement
                                <span id="demo" style="padding-left: 25px">Hi</span>
                            </div>
                            <div class="panel-body">
                                <form action="../Blazers_Measurement" method="post">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label for="" class="control-label" style="margin: 0px;">লম্বা</label>
                                            <input type="text" class="form-control" name="blz_long" id="pant_long" placeholder="14 1/8''" style="margin-bottom: 8px"/>
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="" class="control-label" style="margin: 0px;">বডি</label>
                                            <input type="text" class="form-control" name="blz_body" id="blz_body" placeholder="" style="margin-bottom: 8px"/>
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="" class="control-label" style="margin: 0px;">পেট </label>
                                            <input type="text" class="form-control" name="blz_bally" id="blz_bally" placeholder="" style="margin-bottom: 8px"/>
                                        </div>                                        
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label for="" class="control-label" style="margin: 0px;">হিপঃ</label>
                                            <input type="text" class="form-control" name="blz_hip" id="blz_hip" placeholder="" style="margin-bottom: 8px"/>
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="" class="control-label" style="margin: 0px;">কাধ</label>
                                            <input type="text" class="form-control" name="blz_shoulder" placeholder="" style="margin-bottom: 8px"/>
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="" class="control-label" style="margin: 0px;">হাতা-লম্বাঃ</label>
                                            <input type="text" class="form-control" name="blz_hand_long" placeholder="" style="margin-bottom: 8px"/>
                                        </div>                                        
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label for="" class="control-label" style="margin: 0px;">হাতা-মহরিঃ</label>
                                            <input type="text" class="form-control" name="blz_mohuri" id="blz_mohuri" placeholder="" style="margin-bottom: 8px"/>
                                        </div>
                                        <div class="col-sm-3">
                                            <label for="" class="control-label" style="margin: 0px;">ক্রস ব্যাকঃ</label>
                                            <input type="text" class="form-control" name="blz_crass_back" id="blz_crass_back" placeholder="" style="margin-bottom: 8px"/>
                                        </div>
                                        <div class="col-sm-3" style="margin-top: 10px">
                                            <label for="" class="control-label">বুতাম &nbsp;</label>
                                            <select name="button" style="width: 60%; height: 30px;">
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3" style="margin-top: 10px">
                                            <label for="" class="control-label">নেপেল</label>
                                            <select name="nepel" style="width: 60%; height: 30px;">
                                                <option value="2">2.00</option>
                                                <option value="2.25">2.25</option>
                                                <option value="2.50">2.50</option>
                                                <option value="2.75">2.75</option>
                                                <option value="3.00">3.00</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-3" style="margin-top: 15px">
                                            <label for="" class="control-label">open</label>
                                            <select name="blz_side" style="width: 60%; height: 30px;">
                                                <option>Back Open</option>
                                                <option>Side Open</option>
                                                <option>No Open</option>
                                                <option>back/side Open</option>
                                            </select>                                           
                                        </div>
                                        <div class="col-sm-3" style="margin-top: 15px">
                                            <label for="" class="control-label">বেস্ট </label>
                                            <select name="best" style="width: 60%; height: 30px;">
                                                <option value="2">ডাবল</option>
                                                <option value="1">সিংগেল</option>
                                            </select>                                           
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <label for="" class="control-label" style="margin: 0px;">কেটালগ নং</label>
                                            <input type="text" class="form-control" name="blz_catelog" id="blz_catelog" placeholder="" style="margin-bottom: 8px"/>
                                        </div>
                                        <div class="col-sm-2" style="margin-top: 15px">
                                            <label for="" class="control-label">নিচে</label>
                                            <select name="neca" style="width: 60%; height: 30px;">
                                                <option value="0">রাউন্ড</option>
                                                <option value="1">স্ক্য়ার</option>
                                            </select>                                           
                                        </div>
                                        <div class="col-sm-5">
                                            <label for="" class="control-label" style="margin: 0px;">অনান্য</label>
                                            <input type="text" class="form-control" name="blz_other" id="blz_other" placeholder="" style="margin-bottom: 8px"/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-12" style="margin-top: 10px">
                                            <center>
                                                <input type="submit" class="btn btn-primary" value="Submit">
                                                <input type="reset" class="btn btn-danger" value="Cancel">
                                            </center>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>      
        <script src="assets/js/jquery-1.10.2.js"></script>   
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>   
        <script src="assets/js/custom.js"></script> 
    </body>
</html>
