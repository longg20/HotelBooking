<%-- 
    Document   : detailHotel
    Created on : Oct 28, 2020, 7:38:52 AM
    Author     : Long
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hotel Detail</title>
        <link href="css/detail.css" rel="stylesheet" type="text/css">
    </head>

    <c:if test="${empty sessionScope.USER}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <c:if test="${sessionScope.USER.role eq 2}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <c:if test="${empty requestScope.HOTEL}">
        <c:redirect url="LoadArea"/>
    </c:if>

    <c:if test="${empty requestScope.ROOM}">
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
            <div class="hotelcontainer">
                <img src="${requestScope.HOTEL.image}"/>

                <h1>${requestScope.HOTEL.name}</h1><br/>

                <h2>${requestScope.HOTEL.areaName}<br/></h2>
            </div>
        </header>

        <main>
            <div class="left">
                <font color="red">
                ${requestScope.NOTICE}
                </font>

                <c:if test="${not empty requestScope.ROOM}" var="checkList">
                    <table>
                        <thead>
                            <tr>
                                <th>Room Type</th>
                                <th>Price</th>
                                <th>Vacant Rooms</th>
                                    <c:if test="${sessionScope.USER.role eq 1}" var="checkUser">
                                    <th>Add to Cart</th>
                                    </c:if>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="room" items="${requestScope.ROOM}">
                                <tr>
                                    <td>${room.typeName}</td>
                                    <td>${room.price}</td>
                                    <td>${room.vacant}</td>
                                    <c:if test="${checkUser}">
                                        <td>
                                            <form action="CartAdd" method="POST">
                                                <input type="submit" value="Add to Cart"/>
                                                <input type="hidden" name="txtRoomId" value="${room.roomId}"/>
                                                <input type="hidden" name="txtVacant" value="${room.vacant}"/>
                                                <input type="hidden" name="txtHotelId" value="${param.txtHotelId}"/>
                                                <input type="hidden" name="txtTypeName" value="${room.typeName}"/>
                                                <input type="hidden" name="txtCheckInDateSearch" value="${param.txtCheckInDateSearch}"/>
                                                <input type="hidden" name="txtCheckOutDateSearch" value="${param.txtCheckOutDateSearch}"/>
                                            </form>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>

            <div class="right">
                <c:if test="${not empty sessionScope.CART}">
                    <table>
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

                    <table>
                        <thead>
                            <tr>
                                <th>Hotel</th>
                                <th>Room Type</th>
                                <th>Quantity</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cart" items="${sessionScope.CART.cart}">
                                <tr>
                                    <td>${cart.value.hotelName}</td>
                                    <td>${cart.value.typeName}</td>
                                    <td>${cart.value.cartQty}</td>
                                    <td>${cart.value.price * cart.value.cartQty}</td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="2"></td>
                                <td>Total:</td>
                                <td>${sessionScope.CART.total}$</td>
                            </tr>
                        </tbody>
                    </table>
                    <form action="detailCart.jsp" method="POST">
                        <input type="submit" value="View Cart Detail"/>
                    </form>
                </c:if>
            </div>
        </main>

        <form action="SearchHotel" method="POST">
            <input type="hidden" name="txtHotelNameSearch" value="${param.txtHotelNameSearch}"/>
            <input type="hidden" name="txtHotelAreaSearch" value="${param.txtHotelAreaSearch}"/>
            <input type="hidden" name="txtRoomAmountSearch" value="${param.txtRoomAmountSearch}"/>
            <input type="hidden" name="txtCheckInDateSearch" value="${param.txtCheckInDateSearch}"/>
            <input type="hidden" name="txtCheckOutDateSearch" value="${param.txtCheckOutDateSearch}"/>
            <button type="submit">Back to Search</button>
        </form>
    </body>
</html>
