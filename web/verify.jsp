<%-- 
    Document   : verify
    Created on : Oct 30, 2020, 10:38:13 PM
    Author     : Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Page</title>
        <link href="css/login.css" rel="stylesheet" type="text/css">
    </head>
    <body class="bg">
        <form action="CartConfirm" method="POST">
            <div class="container">
                <h1>A confirmation code has been sent to your Email.<br/>Paste the code here to process with your Booking Order.<br/></h1>
                <label for="txtCheckCode"><b>Confirm Code:</b></label>
                <input type="number" placeholder="Enter Confirm Code" name="txtCheckCode" min="0" max="999999" required>
                
                <font color="red">${requestScope.NOTICE}</font>
                
                <input type="hidden" name="txtCode" value="${requestScope.CODE}" />
                
                <button type="submit">Confirm</button>
            </div>
        </form>
    </body>
</html>
