<%-- 
    Document   : feedback
    Created on : Oct 31, 2020, 5:06:30 PM
    Author     : Long
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback Page</title>
        <link href="css/feedback.css" rel="stylesheet" type="text/css">
    </head>
    
    <c:if test="${empty sessionScope.USER}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <c:if test="${sessionScope.USER.role eq 2}">
        <c:redirect url="login.jsp"/>
    </c:if>
    
    <c:if test="${empty requestScope.HOTELNAME}">
        <c:redirect url="LoadArea"/>
    </c:if>
    
    <c:if test="${empty requestScope.TYPENAME}">
        <c:redirect url="LoadArea"/>
    </c:if>
    
    <c:if test="${empty requestScope.ROOMID}">
        <c:redirect url="LoadArea"/>
    </c:if>
    
    <c:if test="${empty requestScope.BOOKINGID}">
        <c:redirect url="LoadArea"/>
    </c:if>
    
    <body class="bg">
        <form action="Feedback" method="POST">
            <h1>Feedback</h1>
            <input-label><b>Hotel Name</b></input-label>
            <input-label><b>Room Type</b></input-label>
            <input type="text" value="${requestScope.HOTELNAME}" readonly/>
            <input type="text" value="${requestScope.TYPENAME}" readonly/>

            <h2>How satisfied are you with our room service?</h2>

            <fieldset class="rating">
                <input type="radio" id="star5" name="txtRating" value="5" required/><label class = "full" for="star5" title="Awesome - 5 stars"></label>
                <input type="radio" id="star4half" name="txtRating" value="4.5" /><label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
                <input type="radio" id="star4" name="txtRating" value="4" /><label class = "full" for="star4" title="Pretty good - 4 stars"></label>
                <input type="radio" id="star3half" name="txtRating" value="3.5" /><label class="half" for="star3half" title="Meh - 3.5 stars"></label>
                <input type="radio" id="star3" name="txtRating" value="3" /><label class = "full" for="star3" title="Meh - 3 stars"></label>
                <input type="radio" id="star2half" name="txtRating" value="2.5" /><label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
                <input type="radio" id="star2" name="txtRating" value="2" /><label class = "full" for="star2" title="Kinda bad - 2 stars"></label>
                <input type="radio" id="star1half" name="txtRating" value="1.5" /><label class="half" for="star1half" title="Meh - 1.5 stars"></label>
                <input type="radio" id="star1" name="txtRating" value="1" /><label class = "full" for="star1" title="Sucks big time - 1 star"></label>
                <input type="radio" id="starhalf" name="txtRating" value="0.5" /><label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
            </fieldset><br/><br/>

            <div class="container">
                <textarea placeholder="Your Comment (Optional)" name="txtComment"></textarea>
                <button type="submit">Send Feedback</button>
            </div>
            <input type="hidden" name="txtRoomId" value="${requestScope.ROOMID}"/>
            <input type="hidden" name="txtBookingId" value="${requestScope.BOOKINGID}"/>
        </form>
    </body>

    <nav>
        <c:url value="DetailBooking" var="detailLink">
            <c:param name="txtBookingId" value="${requestScope.BOOKINGID}"/>
        </c:url>
        <a href="${detailLink}">Back to Detail</a>
    </nav>
</html>
