<%-- 
    Document   : UpdateMovieDetails
--%>
<%@ page import="java.sql.*" %>
<%@ page import="cinemapackage.Movies" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Movie Details</title>
</head>
<body>
    <center>
        <h1>Update Movie Details</h1>
        <form action="UpdateMovieDetailsAction.jsp" method="post">
            Movie to Update: <input type="text" name="movieName" placeholder="Enter movie name" required><br><br>
            <label for="updateField">Select Field to Update:</label><br>
            <select id="updateField" name="updateField">
                <option value="director">Director</option>
                <option value="genre">Genre</option>
                <option value="releaseDate">Release Date</option>
                <option value="duration">Duration</option>
                <option value="mtrcbRating">MTRCB Rating</option>
            </select><br><br>
            <% String updateField = request.getParameter("updateField");
               if ("releaseDate".equals(updateField)) { %>
                   New Value: <input type="date" name="newValue" required><br><br>
            <% } else if ("duration".equals(updateField)) { %>
                   New Value: <input type="number" name="newValue" required><br><br>
            <% } else if ("mtrcbRating".equals(updateField)) { %>
                   New Value: <select name="newValue" required>
                       <option value="G">G</option>
                       <option value="PG">PG</option>
                       <option value="R-13">R-13</option>
                       <option value="R-16">R-16</option>
                       <option value="R-18">R-18</option>
                   </select><br><br>
            <% } else { %>
                   New Value: <input type="text" name="newValue" required><br><br>
            <% } %>
            <input type="submit" value="Update">
        </form>
        <br><br>
        <form action="MaintenanceMenu.jsp"><input type="submit" value="Go Back"></form>
    </center>
</body>
</html>
