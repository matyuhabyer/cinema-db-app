<%-- 
    Document   : MaintenanceMenu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Maintenance Menu</title>
    </head>
    <body>
    <center>
        <br><br><br><br><br>
        <h1>Maintenance Menu</h1>
        <form action ="AddNewMovie.jsp"> <input type="submit" value="Add New Movie" style="height:30px; width:280px"> </form>
        <form action ="UpdateMovieDetails.jsp"> <input type="submit" value="Update Movie Details" style="height:30px; width:280px"> </form>
        <form action ="DeleteMovie.jsp"> <input type="submit" value="Delete Movie" style="height:30px; width:280px"> </form>
        <form action ="ListMovies.jsp"> <input type="submit" value="List Movies" style="height:30px; width:280px"> </form>
        <form action ="SearchMovie.jsp"> <input type="submit" value="Search Movie" style="height:30px; width:280px"> </form>
    <br><br>
    <form action ="index.html"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
    </body>
</html>
