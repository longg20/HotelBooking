<%-- 
    Document   : login.jsp
    Created on : Oct 21, 2020, 7:19:52 AM
    Author     : Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="css/login.css" rel="stylesheet" type="text/css">
        <script src='https://www.google.com/recaptcha/api.js?hl=en'></script>
    </head>
    <body class="bg">

        <form action="Login" method="POST">
            <div class="imgcontainer">
                <img src="css/login.png" alt="Avatar" class="avatar">
            </div>

            <div class="container">
                <label for="txtId"><b>Email</b></label>
                <input type="text" placeholder="Enter Email" name="txtId" value="${param.txtId}" required>

                <label for="txtPassword"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="txtPassword" required>

                <font color="red">${requestScope.NOTICE}</font>

                <div class="g-recaptcha" data-sitekey="6Le6BdwZAAAAAGotf2f0KA0aOarJ0AeL7pOU_lzu"></div>

                <button type="submit">Log In</button>
            </div>
        </form>
                
        <nav>
            <a href="LoadArea">Back to Home</a> | <a href="register.jsp">Sign Up</a> | <a href="forget.jsp">Forgot Password</a>
        </nav>
    </body>
</html>
