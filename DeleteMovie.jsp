<%-- 
    Document   : DeleteMovie
--%>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<%@page import="cinemapackage.Movies" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Movie</title>
    </head>
    <body>
        <center>        
            <h1>Delete Movie</h1>
            <form action="" method="post">
                Movie Name to Delete: <input type="text" name="movieName">
                <input type="submit" value="Search">
            </form>
            <%
                String movieName = request.getParameter("movieName");            
                if(movieName == null || movieName.isEmpty()){
                    out.println("<p>Please fill in all fields.</p>");
                } else{
                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                            "root", "DLSU1234!");

                        Movies movies = new Movies();
                        String query = "SELECT * FROM movie WHERE title LIKE ?";
                        PreparedStatement preparedStatement = connection.prepareStatement(query);
                        preparedStatement.setString(1, "%" + movieName + "%");
                        ResultSet resultSet = preparedStatement.executeQuery();

                        if (resultSet.next()) {
                            out.println("<h3>Movie Details:</h3>");
                            out.println("<p>Title: " + resultSet.getString("title") + "</p>");
                            out.println("<p>Director: " + resultSet.getString("director") + "</p>");
                            out.println("<p>Genre: " + resultSet.getString("genre") + "</p>");
                            out.println("<p>Release Date: " + resultSet.getString("release_date") + "</p>");
                            out.println("<p>Duration: " + resultSet.getInt("duration") + "</p>");
                            out.println("<p>MTRCB Rating: " + resultSet.getString("mtrcb_rating") + "</p>");

                            int movieID = resultSet.getInt("movie_id");
            %>
                            <form method="post" action="DeleteMovieAction.jsp">
                                <input type="hidden" name="movieID" value="<%= movieID %>">
                                <input type="submit" value="Delete Movie">
                            </form>
            <%
                        } else {
                            out.println("<p>No movie found with the name: " + movieName + "</p>");
                        }

                        resultSet.close();
                        preparedStatement.close();
                        connection.close();
                    } catch (SQLException e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    }
                }
            %>
            <br><br>
            <form action="MaintenanceMenu.jsp"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
        </center>
    </body>
</html>
