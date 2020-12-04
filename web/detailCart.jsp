<%-- 
    Document   : detailCart
    Created on : Oct 29, 2020, 7:50:29 PM
    Author     : Long
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Detail</title>
        <link href="css/table.css" rel="stylesheet" type="text/css">
    </head>

    <c:if test="${empty sessionScope.USER}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <c:if test="${sessionScope.USER.role eq 2}">
        <c:redirect url="login.jsp"/>
    </c:if>
    
    <c:if test="${empty sessionScope.CART}">
        <c:redirect url="LoadArea"/>
    </c:if>
    
    <body class="bg">
        <div class="navbar">
            <div class="navbar-left">
                <a href="LoadArea">Home</a>
                <c:if test="${not empty sessionScope.USER}" var="checkLogin"> 
                    <c:if test="${sessionScope.USER.role eq 1}" var="checkUser">
                        <a href="SearchBooking">View Booking History</a>
                        <a href="detailCart.jsp">View Your Cart</a>
                    </c:if>
                </c:if>
            </div>

            <div class="navbar-right">
                <c:if test="${checkLogin}">
                    <a href="Logout">Logout</a>
                    <a>Welcome, ${sessionScope.USER.name}.</a>
                </c:if>

                <c:if test="${!checkLogin}">
                    <a href="register.jsp">Register</a>
                    <a href="login.jsp">Login</a>
                </c:if>
            </div>
        </div>

        <header>
            <h1>CART DETAIL</h1>
            <c:if test="${not empty sessionScope.CART}" var="checkCart">
                <table style="table-layout: fixed;">
                    <thead>
                        <tr>
                            <th>Check-In Date</th>
                            <th>Check-Out Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>${sessionScope.CART.checkinDate}</td>
                            <td>${sessionScope.CART.checkoutDate}</td>
                        </tr>
                    </tbody>
                </table>
            </c:if>
            <font color="red">
            ${requestScope.NOTICE}
            </font>
        </header>

        <main>
            <c:if test="${checkCart}">
                <table>
                    <thead>
                        <tr>
                            <th>Hotel</th>
                            <th>Room Type</th>
                            <th>Quantity in Stock</th>
                            <th>Quantity in Cart</th>
                            <th>Price</th>
                            <th>Total</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cart" items="${sessionScope.CART.cart}">
                            <tr>
                        <form action="CartUpdate" method="POST">
                            <td>${cart.value.hotelName}</td>
                            <td>${cart.value.typeName}</td>
                            <td>${cart.value.vacant}</td>
                            <td><input type="number" name="txtCartQty" required min="0" value="${cart.value.cartQty}"</td>
                            <td>${cart.value.price}$</td>
                            <td>${cart.value.price * cart.value.cartQty}$</td>
                            <td><input type="submit" value="Update"<td/>
                            <input type="hidden" name="txtRoomId" value="${cart.value.roomId}"/>
                            <input type="hidden" name="txtQuantity" value="${cart.value.vacant}"/>
                        </form>
                        <form action="CartDelete" method="POST">
                            <td><input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete Room?')"/></td>
                            <input type="hidden" name="txtRoomId" value="${cart.value.roomId}"/>
                        </form>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="5">Total</td>
                        <td>${sessionScope.CART.total}$</td>
                    </tr>
                    </tbody>
                </table>
                <form action="CartVerify" method="POST">
                    <label for="txtCodeId"><b>Discount Code:</b></label><br/>
                    <input type="text" placeholder="Discount Code (Optional)" name="txtCodeId" value="${param.txtCodeId}"/>
                    <input type="submit" value="Confirm" onclick="return confirm('Confirm Cart?')"/>
                </form>
            </c:if>
        </main>
    </body>
</html>
