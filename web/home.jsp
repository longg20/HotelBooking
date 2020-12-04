<%-- 
    Document   : home.jsp
    Created on : Oct 21, 2020, 7:20:52 AM
    Author     : Long
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link href="css/home.css" rel="stylesheet" type="text/css">
    </head>

    <script>
        function checkDates() {
            var searchForm = document.forms['searchForm'];
            var checkinDate = new Date(searchForm['txtCheckInDateSearch'].value);
            var checkoutDate = new Date(searchForm['txtCheckOutDateSearch'].value);

            if (checkinDate > checkoutDate) {
                alert("Check-In Date must be smaller than Check-Out Date");
                return false;
            }
        }

        function setMinDate() {
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January = 0;
            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }
            if (mm < 10) {
                mm = '0' + mm;
            }

            today = yyyy + '-' + mm + '-' + dd;
            var element = document.getElementById("checkinDate");
            if (typeof (element) !== 'undefined' && element !== null) {
                element.setAttribute("min", today);
            }
            var element = document.getElementById("checkoutDate");
            if (typeof (element) !== 'undefined' && element !== null) {
                element.setAttribute("min", today);
            }
            var element = document.getElementById("expireDate");
            if (typeof (element) !== 'undefined' && element !== null) {
                element.setAttribute("min", today);
            }
        }
    </script>

    <body class="bg" onload="setMinDate()">

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
            <c:if test="${sessionScope.USER.role eq 2}" var="checkAdmin">
                <h1>CREATE DISCOUNT CODE</h1>

                <form action="CreateDiscountCode" method="POST">
                    <div class="container">
                        <label for="txtCodeId"><b>Discount Code</b></label>
                        <label for="txtCodeName"><b>Code Name</b></label>
                        <label for="txtDiscountPercent"><b>Discount Percent</b></label>
                        <label for="txtExpireDate"><b>Expire Date</b></label><br/>

                        <input type="text" placeholder="Discount Code" name="txtCodeId" required value="${param.txtCodeId}">
                        <input type="text" placeholder="Code Name" name="txtCodeName" required value="${param.txtCodeName}">
                        <input type="number" name="txtDiscountPercent" required min="0" max="100" value="${param.txtDiscountPercent}"> 
                        <input type="date" name="txtExpireDate" required value="${param.txtExpireDate}" id="expireDate" min="2020-01-01"/>
                        <button type="submit">Create</button>
                    </div>
                </form>
            </c:if>

            <c:if test="${!checkAdmin}">
                <h1>HOTEL BOOKING</h1>

                <form action="SearchHotel" method="POST"  name="searchForm" onsubmit="return checkDates()">
                    <div class="container">
                        <label for="txtHotelNameSearch"><b>Hotel Name</b></label>
                        <label for="txtHotelAreaSearch"><b>Hotel Area</b></label>
                        <label for="txtCheckInDateSearch"><b>Check-In Date</b></label>
                        <label for="txtCheckOutDateSearch"><b>Check-Out Date</b></label>
                        <label for="txtRoomAmountSearch"><b>Room Amount</b></label><br/>

                        <input type="text" placeholder="Search Hotel Name" name="txtHotelNameSearch" value="${param.txtHotelNameSearch}"/>
                        <select name="txtHotelAreaSearch">
                            <option value=""></option>
                            <c:forEach items="${requestScope.AREA}" var="area">
                                <c:if test="${param.txtHotelAreaSearch eq area.areaId}" var="checkStatus">
                                    <option value="${area.areaId}" selected="selected">${area.name}</option>
                                </c:if>
                                <c:if test="${!checkStatus}">
                                    <option value="${area.areaId}">${area.name}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                        <input type="date" name="txtCheckInDateSearch" required value="${param.txtCheckInDateSearch}" id="checkinDate" min="2020-01-01"/>
                        <input type="date" name="txtCheckOutDateSearch" required value="${param.txtCheckOutDateSearch}" id="checkoutDate" min="2020-01-01"/> 
                        <input type="number" placeholder="Search Room Amount" min="0" name="txtRoomAmountSearch" value="${param.txtRoomAmountSearch}"/>

                        <button type="submit">Search</button>
                    </div>
                </form>
            </c:if>

            <font color="red">
            ${requestScope.NOTICE}
            </font>
        </header>


        <main>
            <c:if test="${!checkAdmin}">
                <c:if test="${not empty requestScope.INFO}" var="checkList">
                    <c:forEach var="hotel" items="${requestScope.INFO}">
                        <div class="hotelcontainer">
                            <img src="${hotel.image}"/>

                            <h1>${hotel.name}</h1><br/>

                            <h2>
                                ${hotel.areaName}<br/>
                                ${hotel.roomAmount} vacant room(s)
                            </h2>

                            <c:if test="${checkUser}">
                                <form action="DetailHotel" method="POST">
                                    <input type="hidden" name="txtHotelId" value="${hotel.hotelId}"/>
                                    <input type="hidden" name="txtCheckInDateSearch" value="${param.txtCheckInDateSearch}"/>
                                    <input type="hidden" name="txtCheckOutDateSearch" value="${param.txtCheckOutDateSearch}"/>
                                    <input type="submit" value=" View Room > "/>
                                </form>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:if>
            </c:if>
        </main>
    </body>
</html>
