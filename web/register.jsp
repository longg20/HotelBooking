<%-- 
    Document   : register.jsp
    Created on : Oct 21, 2020, 7:19:52 AM
    Author     : Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <link href="css/login.css" rel="stylesheet" type="text/css">
    </head>
    <body class="bg">

        <form action="Register" method="POST">
            <div class="imgcontainer">
                <img src="css/register.png" alt="Avatar" class="avatar">
            </div>

            <div class="container">
                <label for="txtId"><b>Email</b></label>
                <input type="email" placeholder="Enter Email" name="txtId" required>

                <label for="txtPassword"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="txtPassword" required>

                <label for="txtConfirm"><b>Confirm</b></label>
                <input type="password" placeholder="Re-enter Password" name="txtConfirm" required>
                
                <label for="txtName"><b>Name</b></label>
                <input type="text" placeholder="Enter Name" name="txtName" required>
                
                <label for="txtPhone"><b>Phone</b></label>
                <input type="text" placeholder="Enter Phone" name="txtPhone" pattern=".{10}" required>
                
                <label for="txtAddress"><b>Address</b></label>
                <input type="text" placeholder="Enter Address" name="txtAddress" required>
                
                <font color="red">${requestScope.NOTICE}</font>

                <button type="submit">Create</button>
            </div>
        </form>

        <nav>
            <a href="LoadArea">Back to Home</a> | <a href="login.jsp">Sign In</a> | <a href="forget.jsp">Forgot Password</a>
        </nav>
    </body>
</html>
