<%-- 
    Document   : SearchMovie
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Movies" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Movie</title>
    </head>
    <body>
    <center>
        <h1>Search Movie</h1>
        <form action="" method="post">
            Movie to Search: <input type="text" name="movieName">
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
                        out.println("<p>Duration: " + resultSet.getInt("duration") + " minutes</p>");
                        out.println("<p>MTRCB Rating: " + resultSet.getString("mtrcb_rating") + "</p>");
                    } else{
                        out.println("<p>Movie cannot be found.</p>");
                    }
                    
                    resultSet.close();
                    preparedStatement.close();
                    connection.close();
                } catch(SQLException | ClassNotFoundException e){
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
        <br><br>
        <form action="MaintenanceMenu.jsp"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
    </body>
</html>
