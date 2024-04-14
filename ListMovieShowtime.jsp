<%-- 
    Document   : ListMovieShowtime
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Showtime" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Movie Showtime</title>
    </head>
    <body>
    <center>
        <br><br><br><br><br>
        <h1>List Movie Showtime Menu</h1>
        <form action ="ListShowtimeByRoom.jsp"> <input type="submit" value="By Room Number" style="height:30px; width:280px"> </form>
        <form action ="ListShowtimeByPrice.jsp"> <input type="submit" value="By Ticket Price" style="height:30px; width:280px"> </form>
    <br><br>
    <form action="TicketStaffMenu.jsp"><input type="submit" value="Go Back"></form>
    </center>
    </body>
</html>
