<%-- 
    Document   : AddNewMovie
--%>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<%@page import="cinemapackage.Movies" %>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add New Movie</title>
</head>
<body>
<center>      
    <h2>Add New Movie</h2>
    <form action="" method="post">
        <label for="title">Title:</label><br>
        <input type="text" id="title" name="title" required><br><br>
        
        <label for="director">Director:</label><br>
        <input type="text" id="director" name="director" required><br><br>
        
        <label for="genre">Genre:</label><br>
        <input type="text" id="genre" name="genre" required><br><br>
        
        <label for="releaseDate">Release Date:</label><br>
        <input type="date" id="releaseDate" name="releaseDate" required><br><br>
        
        <label for="duration">Duration (minutes):</label><br>
        <input type="number" id="duration" name="duration" required><br><br>
        
        <label for="mtrcbRating">MTRCB Rating:</label><br>
        <select id="mtrcbRating" name="mtrcbRating" required>
            <option value="G">G</option>
            <option value="PG">PG</option>
            <option value="R-13">R-13</option>
            <option value="R-16">R-16</option>
            <option value="R-18">R-18</option>
        </select><br><br>
        
        <input type="submit" value="Add Movie">
    </form><br>
    <%
        Connection connection = null;
        String title = request.getParameter("title");
        String director = request.getParameter("director");
        String genre = request.getParameter("genre");
        String releaseDate = request.getParameter("releaseDate");
        String duration = request.getParameter("duration");
        String mtrcbRating = request.getParameter("mtrcbRating");
        
        if (title == null || title.isEmpty() || director == null || director.isEmpty() ||
            genre == null || genre.isEmpty() || releaseDate == null || releaseDate.isEmpty() ||
            duration == null || duration.isEmpty() || mtrcbRating == null || mtrcbRating.isEmpty()) {
            out.println("<p>Please fill in all fields.</p>");
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "DLSU1234!");
                
                Movies movies = new Movies();            
                boolean movieAdded = movies.addNewMovie(connection, title, director, genre, Date.valueOf(releaseDate), Integer.parseInt(duration), mtrcbRating);
                
                out.println("<p>New movie added successfully.</p>");
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        out.println("<p>Error closing connection: " + e.getMessage() + "</p>");
                    }
                }
            }
        }
    %>
    <br><br>
    <form action="MaintenanceMenu.jsp"><input type="submit" value="Go Back"></form>
</center>
</body>
</html>

