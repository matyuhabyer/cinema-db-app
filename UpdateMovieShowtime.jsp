<%-- 
    Document   : UpdateMovieShowtime
--%>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%@ page import="cinemapackage.Showtime" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Showtime</title>
</head>
<body>
    <center>
        <h1>Update Showtime</h1>
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
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "DLSU1234!");
                    String query = "SELECT st.showtime_id AS Showtime_ID, " +
                                    "m.title AS Movie_Title, " +
                                    "m.genre AS Genre, " +
                                    "m.mtrcb_rating AS MTRCB_Rating, " +
                                    "st.room_number AS Room_Number, " +
                                    "st.start_time AS Start_Time, " +
                                    "st.end_time AS End_Time, " +
                                    "st.ticket_price AS Ticket_Price " +
                                    "FROM showtime st " +
                                    "LEFT JOIN movie m ON st.movie_id = m.movie_id ";

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
        <form action="UpdateShowtimeAction.jsp" method="post">
            Showtime ID to Update: <input type="number" name="showtimeID" required><br><br>
            <label for="updateField">Select Field to Update:</label><br>
            <select id="updateField" name="updateField">
                <option value="roomNumber">Room Number</option>
                <option value="startTime">Start Time</option>
                <option value="ticketPrice">Ticket Price</option>
            </select><br><br>
            <%
                String updateField = request.getParameter("updateField");
                if ("startTime".equals(updateField)) { 
            %>
                    New Value: <input type="time" name="newValue" required><br><br>
            <% } else if ("roomNumber".equals(updateField)) { %>
                    New Value: <input type="number" name="newValue" required><br><br>
            <% } else if ("ticketPrice".equals(updateField)) { %>
                    New Value: <input type="number" name="newValue" required><br><br>
            <% } else { %>
                    New Value: <input type="text" name="newValue" required><br><br>
            <% } %>
            <input type="submit" value="Update">
        </form>
        <br><br>
        <form action="TicketStaffMenu.jsp"><input type="submit" value="Go Back"></form>
    </center>
</body>
</html>