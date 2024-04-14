<%--
    Document   : DeleteMovieAction
--%>
<%@page import="java.sql.*, java.io.*, cinemapackage.Movies" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Movie Action</title>
</head>
<body>
    <center>
    <%
        int movieID = Integer.parseInt(request.getParameter("movieID"));
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "DLSU1234!");

            String deleteShowtimesQuery = "DELETE FROM showtime WHERE movie_id = ?";
            PreparedStatement deleteShowtimesStatement = connection.prepareStatement(deleteShowtimesQuery);
            deleteShowtimesStatement.setInt(1, movieID);
            deleteShowtimesStatement.executeUpdate();

            Movies movies = new Movies();
            boolean deleted = movies.deleteMovie(connection, movieID);
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM movie");

            if (deleted) {
    %>
                <h2>Movie Deleted Successfully</h2>
    <%
            } else {
    %>
                <h2>Failed to Delete Movie</h2>
    <%
            }
    %>
            <table border="1">
                <tr>
                    <th>Title</th>
                    <th>Director</th>
                    <th>Genre</th>
                    <th>Release Date</th>
                    <th>Duration</th>
                    <th>MTRCB Rating</th>
                </tr>
    <%
            while (resultSet.next()) {
    %>
                <tr>
                    <td><%= resultSet.getString("title") %></td>
                    <td><%= resultSet.getString("director") %></td>
                    <td><%= resultSet.getString("genre") %></td>
                    <td><%= resultSet.getString("release_date") %></td>
                    <td><%= resultSet.getString("duration") %> minutes</td>
                    <td><%= resultSet.getString("mtrcb_rating") %></td>
                </tr>
    <%
            }
    %>
            </table>
    <%
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
    %>
            <h2>Error: <%= e.getMessage() %></h2>
    <%
        }
    %>
    <br><br>
    <form action="MaintenanceMenu.jsp"><input type="submit" value="Go Back" style="height:30px; width:280px"></form>
    </center>
</body>
</html>