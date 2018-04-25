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
        }else {
            response.sendRedirect("../index.jsp");
        }

    } catch (Exception e) {
        out.println(e.toString());
    }
%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp"/>
    <body>
        <div id="wrapper">            
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp"/>
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="color: #ff6666; font-size: 25px">
                                Add Price
                            </div>
                            <div class="panel-body">
                                <form action="../AddPrice" method="post" >
                                    <div class="row  form-group">
                                        <div class="col-sm-4">
                                            <label for="name" style="margin-bottom:  0px">Shirt Price</label>  
                                            <input type="text" class="form-control" name="shirt_price" id="shirt_price" placeholder="Enter price of shirt"  />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-4">
                                            <label for="name" style="margin-bottom:  0px">Pant Price</label>  
                                            <input type="text" class="form-control" name="pant_price" id="pant_price" placeholder="Enter price of pant"  />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-4">
                                            <label for="name" style="margin-bottom:  0px">Blazer Price</label>  
                                            <input type="text" class="form-control" name="blazer_price" id="blazer_price" placeholder="Enter price of blazer"  />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-4">
                                            <label for="name" style="margin-bottom:  0px">Payjama Price</label>  
                                            <input type="text" class="form-control" name="payjama_price" id="payjama_price" placeholder="Enter price of payjama"  />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-4">
                                            <label for="name" style="margin-bottom:  0px">Photua Price</label>  
                                            <input type="text" class="form-control" name="photua_price" id="photua_price" placeholder="Enter price of photua"  />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-4">
                                            <label for="name" style="margin-bottom:  0px">Panjabi Price</label>  
                                            <input type="text" class="form-control" name="panjabi_price" id="panjabi_price" placeholder="Enter price of panjabi"  />
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-4">
                                            <label for="name" style="margin-bottom:  0px">Safari Price</label>  
                                            <input type="text" class="form-control" name="safari_price" id="safari_price" placeholder="Enter price of safari"  />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <input type="submit" class="btn btn-primary" value="Add"  style="width: 100%">
                                        </div>                                    
                                    </div>
                                </form>
                            </div>
                            <p class="error"></p>
                        </div>                                                    <!-- /. PAGE INNER  -->
                    </div>                                                    <!-- /. PAGE WRAPPER  -->
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
