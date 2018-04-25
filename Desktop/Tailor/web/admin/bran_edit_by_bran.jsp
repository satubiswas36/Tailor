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
        } else {
            response.sendRedirect("../index.jsp");
        }

    } catch (Exception e) {
        out.println(e.toString());
    }
%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
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
        <!--    <script src="../admin/assets/js/jquery.js" type="text/javascript"></script>-->   
        <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
            <style>
                .btn-bs-file{
                    position:relative;
                }
                .btn-bs-file input[type="file"]{
                    position: absolute;
                    top: -9999999;
                    filter: alpha(opacity=0);
                    opacity: 0;
                    width:0;
                    height:0;
                    outline: none;
                    cursor: inherit;
                }
            </style>
    </head>
    
    <body>
        <div id="wrapper">
            <!-- /. NAV TOP  -->
            <jsp:include page="../menu/menu.jsp"/>
            <!-- /. NAV SIDE  -->

            <div id="page-wrapper" >
                <div id="page-inner">
                    <div class="">
                        <div class="panel panel-default">
                            <div class="panel-heading">

                            </div>
                            <div class="panel-body">
                                <form action="../Branch_Edit_By_Branch" method="post" enctype="multipart/form-data">
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Address</label>  
                                            <input type="text" class="form-control" name="address"/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">
                                            <label for="name" style="margin-bottom:  0px">Image</label>  
                                            <label class="btn-bs-file btn btn-primary" style="margin-top: 8px">
                                                Browse
                                                <input type="file" name="logo" id="imgInp" style=""  />
                                            </label>
                                            <img id="blah" style="width: 50px; height: 50px; background: #2C86BC" alt="" class="img-circle"/>
                                        </div>
                                    </div>
                                    <div class="row  form-group">
                                        <div class="col-sm-6">                                            
                                            <input type="submit" class="btn btn-primary col-lg-4" value="Update"/>
                                        </div>
                                    </div>
                                </form>
                            </div>                          
                        </div>                                                    
                    </div>                                                    
                </div>
            </div>
        </div>
        <script>
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#blah').attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
            $("#imgInp").change(function () {
                readURL(this);
            });
        </script>
        <script>

            $(function () {
                $("#").fadeIn("slow").delay(3000).fadeOut("slow");
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
