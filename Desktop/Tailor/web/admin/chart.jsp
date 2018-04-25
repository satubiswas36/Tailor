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
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../menu/header.jsp" flush="true"/>
    <body>
        <div id="wrapper">            
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp"/> 
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <h2>Morris Charts</h2>   
                            <h5>Welcome Jhon Deo , Love to see you back. </h5>
                        </div>
                    </div>
                    <!-- /. ROW  -->
                    <hr />
                    <div class="row"> 
                        <div class="col-md-6 col-sm-12 col-xs-12">                     
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    Bar Chart Example
                                </div>
                                <div class="panel-body">
                                    <div id="morris-bar-chart"></div>
                                </div>
                            </div>            
                        </div>
                        <div class="col-md-6 col-sm-12 col-xs-12">                     
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    Area Chart Example
                                </div>
                                <div class="panel-body">
                                    <div id="morris-area-chart"></div>
                                </div>
                            </div>            
                        </div> 

                    </div>
                    <!-- /. ROW  -->
                    <div class="row">                     

                        <div class="col-md-6 col-sm-12 col-xs-12">                     
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    Donut Chart Example
                                </div>
                                <div class="panel-body">
                                    <div id="morris-donut-chart"></div>
                                </div>
                            </div>            
                        </div>
                        <div class="col-md-6 col-sm-12 col-xs-12">                     
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    Line Chart Example
                                </div>
                                <div class="panel-body">
                                    <div id="morris-line-chart"></div>
                                </div>
                            </div>            
                        </div> 

                    </div>
                    <!-- /. ROW  -->
                </div>
                <!-- /. PAGE INNER  -->
            </div>
            <!-- /. PAGE WRAPPER  -->
        </div>     
        <script src="assets/js/jquery-1.10.2.js"></script>      
        <script src="assets/js/bootstrap.min.js"></script>    
        <script src="assets/js/jquery.metisMenu.js"></script>     
        <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
        <script src="assets/js/morris/morris.js"></script>      
        <script src="assets/js/custom.js"></script>     
    </body>
</html>
