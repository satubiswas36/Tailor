<%-- 
    Document   : branch_login
    Created on : Apr 20, 2017, 11:21:38 AM
    Author     : Rasel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../admin/assets/css/usr_login_css.css" rel="stylesheet" type="text/css"/>
        <title>user login</title>
        <link href="admin/assets/css/usr_login_css.css" rel="stylesheet" type="text/css"/>
        <script src="https://use.typekit.net/ayg4pcz.js"></script>
        <script>try {
                Typekit.load({async: true});
            } catch (e) {
            }</script>
    </head>
    <body style="background: none">
        <div class="container">    
            <div class="card card-container" id="card">
                <center> <h2 class='login_title text-center'>User Login</h2></center>
                <hr>
                <center><h4>
                        <%
                            String user_msg = (String) session.getAttribute("user_msg");
                            if(user_msg != null){
                                %>
                                <%= "Incorrect" %>
                                <%
                            }
                            %>
                    </h4></center>
                <form class="form-signin" action="../User_Login" method="post">
                    <span id="reauth-email" class="reauth-email"></span>
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
    </body>
</html>
