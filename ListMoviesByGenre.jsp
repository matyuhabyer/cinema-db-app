<%-- 
    Document   : ListMoviesByGenre
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Movies" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Movies By Genre</title>
    </head>
    <body>
    <center>
        <h2>List Movies By Genre</h2>
        <form action="" method="post">
            Movie Genre to Search: <input type="text" name="genre">
            <input type="submit" value="Search">
        </form>
        <%
            String genre = request.getParameter("genre");
            if(genre == null || genre.isEmpty()){
                out.println("<p>Please input a genre.</p>");
            } else{
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                    Movies movies = new Movies();
                    ResultSet resultSet = movies.listMoviesByGenre(connection, genre);
                    
                    out.println("<h3>Movies with Genre: " + genre + "</h3>");
                    out.println("<table border='1'>");
                    out.println("<tr><th>Title</th><th>Director</th><th>Genre</th><th>Duration</th><th>MTRCB Rating</th></tr>");                   
                    if(resultSet.next()){
                        do{
                            out.println("<tr>");
                            out.println("<td>" + resultSet.getString("title") + "</td>");
                            out.println("<td>" + resultSet.getString("director") + "</td>");
                            out.println("<td>" + resultSet.getString("genre") + "</td>");
                            out.println("<td>" + resultSet.getInt("duration") + " minutes</td>");
                            out.println("<td>" + resultSet.getString("mtrcb_rating") + "</td>");
                            out.println("</tr>");
                        } while(resultSet.next());
                        out.println("</table>");
                    } else{
                        out.println("<p>No movies found with genre: " + genre + "</p>");
                    }
                } catch (SQLException | ClassNotFoundException e){
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    <br><br>
    <form action="ListMovies.jsp"><input type="submit" value="Go Back"></form>
    </center>
    </body>
</html>
