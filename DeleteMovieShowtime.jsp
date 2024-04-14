<%-- 
    Document   : DeleteMovieShowtime
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Showtime" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Showtime</title>
</head>
<body>
    <center>        
        <h1>Delete Showtime</h1>
        <table border="1">
            <tr>
                <th>Showtime ID</th>
                <th>Title</th>
                <th>Genre</th>
                <th>MTRCB Rating</th>
                <th>Room Number</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Ticket Price</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL",
                            "root", "DLSU1234!");
                            
                    String query = "SELECT st.showtime_id AS Showtime_ID, "
                    + "m.title AS Movie_Title, "
                    + "m.genre AS Genre, "
                    + "m.mtrcb_rating AS MTRCB_Rating, "
                    + "st.room_number AS Room_Number, "
                    + "st.start_time AS Start_Time, "
                    + "st.end_time AS End_Time, "
                    + "st.ticket_price AS Ticket_Price "
                    + "FROM showtime st "
                    + "LEFT JOIN movie m ON st.movie_id = m.movie_id ";
                    
                    Statement statement = connection.createStatement();
                    ResultSet resultSet = statement.executeQuery(query);
                    while (resultSet.next()) {
            %>
                        <tr>
                            <td><%= resultSet.getString("Showtime_ID") %></td>
                            <td><%= resultSet.getString("Movie_Title") %></td>
                            <td><%= resultSet.getString("Genre") %></td>
                            <td><%= resultSet.getString("MTRCB_Rating") %></td>
                            <td><%= resultSet.getString("Room_Number") %></td>
                            <td><%= resultSet.getString("Start_Time") %></td>
                            <td><%= resultSet.getString("End_Time") %></td>
                            <td><%= resultSet.getString("Ticket_Price") %></td>
                        </tr>
            <%
                    }
                    connection.close();
                } catch (SQLException | ClassNotFoundException e) {
                    out.println("Error: " + e.getMessage());
                }
            %>
        </table>
        <br><br>
        <form action="" method="post">
            Showtime ID to Delete: <input type="number" name="showtimeID">
            <input type="submit" value="Select">
        </form>
        <%
            String showtimeIDStr = request.getParameter("showtimeID");
            int showtimeID = 0;            
            if(showtimeIDStr == null || showtimeIDStr.isEmpty()){
                out.println("<p>Please fill in all fields.</p>");
            } else {
                try {
                    showtimeID = Integer.parseInt(showtimeIDStr);
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                    String query = "SELECT * FROM showtime st "
                    + "LEFT JOIN movie m ON st.movie_id = m.movie_id "
                    + "WHERE showtime_id = ?";
                    PreparedStatement preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setInt(1, showtimeID);
                    ResultSet resultSet = preparedStatement.executeQuery();

                    if (resultSet.next()) {
                        out.println("<h3>Showtime Details:</h3>");
                        out.println("<p>Showtime ID: " + resultSet.getInt("showtime_id") + "</p>");
                        out.println("<p>Movie Title: " + resultSet.getString("title") + "</p>");
                        out.println("<p>Genre: " + resultSet.getString("genre") + "</p>");
                        out.println("<p>MTRCB Rating: " + resultSet.getString("mtrcb_rating") + "</p>");
                        out.println("<p>Room Number: " + resultSet.getDouble("room_number") + "</p>");
                        out.println("<p>Start Time: " + resultSet.getString("start_time") + "</p>");
                        out.println("<p>End Time: " + resultSet.getString("end_time") + "</p>");
                        out.println("<p>Ticket Price: " + resultSet.getString("ticket_price") + "</p>");
        %>
                        <form method="post" action="DeleteMovieShowtimeAction.jsp">
                            <input type="hidden" name="showtimeID" value="<%= showtimeID %>">
                            <input type="submit" value="Delete Snacks">
                        </form>
        <%
                    } else {
                        out.println("<p>No showtime found with ID: " + showtimeID + "</p>");
                    }

                    resultSet.close();
                    preparedStatement.close();
                    connection.close();
                } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
        <br><br>
        <form action="TicketStaffMenu.jsp"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
</body>
</html>
