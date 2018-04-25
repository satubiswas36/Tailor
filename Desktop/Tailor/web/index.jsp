<html>
    <head>
        <link href="admin/assets/css/usr_login_css.css" rel="stylesheet" type="text/css"/>
        <script src="https://use.typekit.net/ayg4pcz.js"></script>
        <script src="admin/assets/js/jquery.js" type="text/javascript"></script>
        <script src="admin/assets/js/jquery-ui.min.js" type="text/javascript"></script>
        <script>try {
                Typekit.load({async: true});
            } catch (e) {
            }</script>
    </head>
    <%
        String user_root = (String) session.getAttribute("user_root");
        String u_id = (String) session.getAttribute("user_user_id");
        String logger = (String)session.getAttribute("logger");
        if (user_root != null) {
            response.sendRedirect("/Tailor/admin/index.jsp");
        } 
        if(u_id != null){
            response.sendRedirect("/Tailor/admin/index.jsp");
        }
        

    %>
    <body style="background: none">
        <div class="container" style="background: none">    
            <div class="card card-container" id="card">
                <center> <h2 class='login_title text-center' style="height: 30px;">
                        <span id="root_login_msgs" style="color: red; font-size: 18px;"><%if(session.getAttribute("root_login_msg") != null){%><%="Incorrect email or password" %><% }  session.removeAttribute("root_login_msg"); %></span>
                    </h2></center>
               
                <form class="form-signin" action="Login" method="post">
                    
                    <p class="input_title">Email</p>
                    <input type="text" id="inputEmail" class="login_box" name="email" required autofocus>
                    <p class="input_title">Password</p>
                    <input type="password" id="inputPassword" class="login_box" name="password" required>
                    <div id="remember" class="checkbox">
                        <label>                        
                        </label>
                    </div>
                    <button class="btn btn-lg btn-success" type="submit">Login</button>
                </form><!-- /form -->
            </div><!-- /card-container -->
        </div><!-- /container -->
        <script>
         $(function(){
            $("#root_login_msgs").show(1500).delay(3000).fadeOut("slow");            
         });
        </script>
    </body>
</html>