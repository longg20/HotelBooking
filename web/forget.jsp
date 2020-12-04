<%-- 
    Document   : forget
    Created on : Nov 1, 2020, 7:47:39 PM
    Author     : Long
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forget Password</title>
        <link href="css/login.css" rel="stylesheet" type="text/css">
    </head>
    <body class="bg">
        <c:if test="${empty requestScope.CODE}">
        <form action="ResetMail" method="POST">
            <div class="imgcontainer">
                <img src="css/forget.png" alt="Avatar" class="avatar">
            </div>

            <div class="container">
                <label for="txtId"><b>Email</b></label>
                <input type="text" placeholder="Enter Email" name="txtId" required>

                <button type="submit">Request Password Change</button>
            </div>
        </form>
        </c:if>

        <c:if test="${not empty requestScope.CODE}">
            <form action="ResetConfirm" method="POST">
                <div class="container">
                    <h1>A code has been sent to your Email. Paste the code below to process with your Password change request.<br/></h1>

                    <label for="txtCheckCode"><b>Code</b></label>
                    <input type="number" placeholder="Enter Code" name="txtCheckCode" min="0" max="999999" required>

                    <label for="txtPassword"><b>Password</b></label>
                    <input type="password" placeholder="Enter New Pasword" name="txtPassword" required>

                    <label for="txtConfirm"><b>Confirm</b></label>
                    <input type="password" placeholder="Re-enter New Password" name="txtConfirm" required>

                    <font color="red">${requestScope.NOTICE}</font>

                    <input type="hidden" name="txtId" value="${requestScope.EMAIL}" />
                    <input type="hidden" name="txtCode" value="${requestScope.CODE}" />
                    <button type="submit">Change Password</button>
                </div>
            </form>  
        </c:if>

        <nav>
            <a href="login.jsp">Sign In</a> | <a href="register.jsp">Sign Up</a>
        </nav>
    </body>
</html>
