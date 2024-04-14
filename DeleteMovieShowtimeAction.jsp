<%-- 
    Document   : DeleteMovieShowtimeAction
--%>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<%@page import="cinemapackage.Showtime" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Showtime Action</title>
</head>
<body>
    <center>
        <%
            String showtimeIDStr = request.getParameter("showtimeID");
            if (showtimeIDStr != null && !showtimeIDStr.isEmpty()) {
                try {
                    int showtimeID = Integer.parseInt(showtimeIDStr);
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                  
                    Showtime showtime = new Showtime();
                    boolean deleted = showtime.deleteShowtime(connection, showtimeID);
                
                    if (deleted) {
        %>
                        <h2>Showtime Deleted Successfully</h2>
        <%
                    } else {
        %>
                        <h2>Failed to Delete Showtime</h2>
        <%                        
                    }
                
                    connection.close();
                } catch (ClassNotFoundException | SQLException | NumberFormatException e) {
        %>
                    <h2>Error: <%= e.getMessage() %></h2>
        <%
                }
            } else {
        %>
                <h2>No showtime ID provided for deletion.</h2>
        <%
            }
        %>
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
                } catch (SQLException e) {
                    out.println("Error: " + e.getMessage());
                }
            %>
        </table>
        <br><br>
        <form action="TicketStaffMenu.jsp"><input type="submit" value="Go Back" style="height:30px; width:280px"></form>
    </center>
</body>
</html>
