<%-- 
    Document   : SearchMovieShowtime
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Showtime" %>
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
                        
                    String query = "SELECT  m.title AS Movie_Title, "
                    + "m.genre AS Genre, "
                    + "m.mtrcb_rating AS MTRCB_Rating, "
                    + "st.room_number AS Room_Number, "
                    + "st.start_time AS Start_Time, "
                    + "st.end_time AS End_Time, "
                    + "st.ticket_price AS Ticket_Price "
                    + "FROM showtime st "
                    + "LEFT JOIN movie m ON st.movie_id = m.movie_id "
                    + "WHERE title LIKE ?";
                    PreparedStatement preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setString(1, "%" + movieName + "%");
                    ResultSet resultSet = preparedStatement.executeQuery();

                    if (resultSet.next()) {
                        out.println("<h3>Showtime Details:</h3>");
                        out.println("<p>Title: " + resultSet.getString("Movie_Title") + "</p>");
                        out.println("<p>Genre: " + resultSet.getString("Genre") + "</p>");
                        out.println("<p>MTRCB Rating: " + resultSet.getString("MTRCB_Rating") + "</p>");
                        out.println("<p>Room Number: " + resultSet.getString("Room_Number") + "</p>");
                        out.println("<p>Start Time: " + resultSet.getString("Start_Time") + "</p>");
                        out.println("<p>End Time: " + resultSet.getString("End_Time") + "</p>");
                        out.println("<p>Ticket Price: Php " + resultSet.getDouble("Ticket_Price") + "</p>");
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
        <form action="TicketStaffMenu.jsp"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
    </body>
</html>
