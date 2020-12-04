<%-- 
    Document   : bookingHistoryDetail
    Created on : Oct 31, 2020, 12:08:31 PM
    Author     : Long
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Detail</title>
        <link href="css/table.css" rel="stylesheet" type="text/css">
    </head>

    <c:if test="${empty sessionScope.USER}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <c:if test="${sessionScope.USER.role eq 2}">
        <c:redirect url="login.jsp"/>
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
            <h1>BOOKING ORDER DETAIL</h1>
        </header>

        <main>
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>User ID</th>
                        <th>Booking Date</th>
                        <th>Check-In Date</th>
                        <th>Check-Out Date</th>
                        <th>Total</th>
                        <th>Code Used</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${requestScope.BOOKING.bookingId}</td>
                        <td>${requestScope.BOOKING.userId}</td>
                        <td>${requestScope.BOOKING.bookingDate}</td>
                        <td>${requestScope.BOOKING.checkinDate}</td>
                        <td>${requestScope.BOOKING.checkoutDate}</td>
                        <td>${requestScope.BOOKING.total}$</td>
                        <td>${requestScope.BOOKING.code}</td>
                    </tr>
                </tbody>
            </table><br/>

            <font color="red">
            ${requestScope.NOTICE}
            </font>

            <table>
                <thead>
                    <tr>
                        <th>Hotel</th>
                        <th>Room Type</th>
                        <th>Quantity</th>
                        <th>Total Price</th>
                        <th>Feedback</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="detail" items="${requestScope.DETAIL}">
                        <tr>
                            <td>${detail.hotelName}</td>
                            <td>${detail.typeName}</td>
                            <td>${detail.quantity}</td>
                            <td>${detail.total}$</td>
                            <td>
                                <form action="LoadFeedback" method="POST">
                                    <input type="hidden" name="txtRoomId" value="${detail.roomId}"/>
                                    <input type="hidden" name="txtHotelName" value="${detail.hotelName}"/>
                                    <input type="hidden" name="txtTypeName" value="${detail.typeName}"/>
                                    <input type="hidden" name="txtBookingId" value="${requestScope.BOOKING.bookingId}"/>
                                    <c:if test="${requestScope.FEEDBACK eq true}" var="checkFeedback">
                                        <input type="submit" value="Give Feedback"/>
                                    </c:if> 
                                    <c:if test="${!checkFeedback}">
                                        <input type="submit" disabled value="Give Feedback"/>
                                    </c:if>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
            
        <form action="SearchBooking" method="POST">
            <button type="submit">Back to Booking History</button>
        </form>
    </body>
</html>
