<%-- 
    Document   : ListSnacks
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Snacks" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Snacks Menu</title>
    </head>
    <body>
    <center>
        <br><br><br><br><br>
        <h2>List Snacks Menu</h2>
        <form action ="ListSnacksByFoodType.jsp"> <input type="submit" value="By Food Type" style="height:30px; width:280px"> </form>
        <form action ="ListSnacksByFoodSize.jsp"> <input type="submit" value="By Food Size" style="height:30px; width:280px"> </form>
        <form action ="ListSnacksByFoodFlavor.jsp"> <input type="submit" value="By Food Flavor" style="height:30px; width:280px"> </form>
        <form action ="ListSnacksByDrinks.jsp"> <input type="submit" value="By Drinks" style="height:30px; width:280px"> </form>
    <br><br>
    <form action="SnacksVendorMenu.jsp"><input type="submit" value="Go Back"></form>
    </center>
    </body>
</html>
