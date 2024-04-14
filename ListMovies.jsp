<%-- 
    Document   : ListMoviesByRating
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Movies" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Movies Menu</title>
    </head>
    <body>
    <center>
        <br><br><br><br><br>
        <h1>List Movies Menu</h1>
        <form action ="ListMoviesByRating.jsp"> <input type="submit" value="By MTRCB Rating" style="height:30px; width:280px"> </form>
        <form action ="ListMoviesByGenre.jsp"> <input type="submit" value="By Genre" style="height:30px; width:280px"> </form>
    <br><br>
    <form action="MaintenanceMenu.jsp"><input type="submit" value="Go Back"></form>
    </center>
    </body>
</html>
