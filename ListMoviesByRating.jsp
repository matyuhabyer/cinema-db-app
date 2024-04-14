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
        <title>List Movies By MTRCB Rating</title>
    </head>
    <body>
    <center>
        <h1>List Movies By MTRCB Rating</h1>
        <form action="" method="post">
            Select MTRCB Rating:
            <select name="rating">
                <option value="G">G</option>
                <option value="PG">PG</option>
                <option value="R-13">R-13</option>
                <option value="R-16">R-16</option>
                <option value="R-18">R-18</option>
            </select>
            <input type="submit" value="List">
        </form>
        <%
            String rating = request.getParameter("rating");
            if(rating == null || rating.isEmpty()){
                out.println("<p>Please select a rating.</p>");
            } else{
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                    Movies movies = new Movies();
                    ResultSet resultSet = movies.listMoviesByMTRCBRating(connection, rating);
                    
                    out.println("<h3>Movies with MTRCB Rating: " + rating + "</h3>");
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
                        out.println("<p>No movies found with rating: " + rating + "</p>");
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
