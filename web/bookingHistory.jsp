<%-- 
    Document   : bookingHistory
    Created on : Oct 31, 2020, 11:40:23 AM
    Author     : Long
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking History</title>
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
            <c:if test="${checkUser}">
                <h1>SEARCH BOOKING ORDER</h1>

                <form action="SearchBooking" method="POST">
                    <div class="container">
                        <label for="txtBookingSearch"><b>Booking ID</b></label>
                        <label for="txtDateSearch"><b>Booking Date</b></label><br/>

                        <input type="text" placeholder="Search Booking ID" name="txtBookingSearch" value="${param.txtBookingSearch}"/>
                        <input type="date" name="txtDateSearch" value="${param.txtDateSearch}"/>
                        <button type="submit">Search</button>
                    </div>
                </form>
            </c:if>

            <c:if test="${empty requestScope.BOOKING}" var="checkBooking">
                <font color="red">
                No orders found.
                </font>
            </c:if>

            <font color="red">
            ${requestScope.NOTICE}
            </font>
        </header>

        <main>
            <c:if test="${!checkBooking}">
                <table>
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Booking Date</th>
                            <th>Check In Date</th>
                            <th>Check Out Date</th>
                            <th>View Detail</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${requestScope.BOOKING}">
                            <tr>
                        <form action="DetailBooking" method="POST">
                            <td>${booking.bookingId}</td>
                            <td>${booking.bookingDate}</td>
                            <td>${booking.checkinDate}</td>
                            <td>${booking.checkoutDate}</td>
                            <td>
                                <input type="submit" value="View Detail"/>
                                <input type="hidden" name="txtBookingId" value="${booking.bookingId}"/>
                            </td>
                        </form>
                        <td>
                            <form action="DeleteBooking" method="POST">
                                <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete Booking?')"/>
                                <input type="hidden" name="txtBookingId" value="${booking.bookingId}"/>
                            </form>
                        </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </main>
    </body>
</html>
