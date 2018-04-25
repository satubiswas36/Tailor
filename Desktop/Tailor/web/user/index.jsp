<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../admin/assets/css/usr_login_css.css" rel="stylesheet" type="text/css"/>
        <title>User Login</title>        
        <link href="admin/assets/css/usr_login_css.css" rel="stylesheet" type="text/css"/>
        <script src="https://use.typekit.net/ayg4pcz.js"></script>
        <script src="../admin/assets/js/jquery.js" type="text/javascript"></script>
        <script src="../admin/assets/js/jquery-ui.min.js" type="text/javascript"></script>
        <script>try {
                Typekit.load({async: true});
            } catch (e) {
            }</script>
    </head>
    <%
        String u_id = (String) session.getAttribute("user_user_id");
        if (u_id != null) {
            response.sendRedirect("/Tailor/admin/index.jsp");
        } else {

        }
    %>
    <body style="background: none">
        <div class="container">    
            <div class="card card-container" id="card">
                <center> <h2 class='login_title text-center'>User Login</h2></center>
                <hr>
                <form class="form-signin" action="../User_Login" method="post">

                    <span class="userLogin" style="color: red; font-size: 18px; display: none;"><%if (session.getAttribute("user_msg_login") != null) {%><%= "Incorrect email or password !!"%><%}%></span>
                    <p class="input_title">Email</p>
                    <input type="text" id="inputEmail" class="login_box" name="email" placeholder="" required autofocus>
                    <p class="input_title">Password</p>
                    <input type="password" id="inputPassword" class="login_box" name="password" placeholder="" required>
                    <div id="remember" class="checkbox">
                        <label>                        
                        </label>
                    </div>
                    <button class="btn btn-lg btn-success" type="submit">Login</button>
                </form><!-- /form -->
            </div><!-- /card-container -->
        </div><!-- /container -->
        <script>
            $(function () {
                $(".userLogin").fadeIn(1000).delay(3000).fadeOut("slow");
               // alert("Hi");
            });
        </script>
    </body>
</html>
