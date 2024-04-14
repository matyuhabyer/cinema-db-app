<%-- 
    Document   : UpdateShowtimeAction
--%>
<%@ page import="java.sql.*, java.io.*, java.util.*, cinemapackage.Showtime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Showtime Action</title>
</head>
<body>
<center>
    <%
        String showtimeID = request.getParameter("showtimeID");
        String updateField = request.getParameter("updateField");
        String newValue = request.getParameter("newValue");

        if (showtimeID == null || showtimeID.isEmpty() || updateField == null || updateField.isEmpty() || newValue == null || newValue.isEmpty()) {
            out.println("<p>Please fill in all fields.</p>");
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                    "root", "DLSU1234!");

                PreparedStatement preparedStatement;
                ResultSet resultSet;

                // Query to select the showtime details
                String query = "SELECT st.showtime_id AS Showtime_ID, " +
                                    "m.title AS Movie_Title, " +
                                    "m.genre AS Genre, " +
                                    "m.mtrcb_rating AS MTRCB_Rating, " +
                                    "st.room_number AS Room_Number, " +
                                    "st.start_time AS Start_Time, " +
                                    "st.end_time AS End_Time, " +
                                    "st.ticket_price AS Ticket_Price " +
                                    "FROM showtime st " +
                                    "LEFT JOIN movie m ON st.movie_id = m.movie_id " +
                                    "WHERE st.showtime_id = ?";

                preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, showtimeID);
                resultSet = preparedStatement.executeQuery();
                
                if (resultSet.next()) {
                    int showtimeIDNumber = resultSet.getInt("Showtime_ID");
                    Showtime showtime = new Showtime();
                    boolean updated = false;
                    switch (updateField) {
                        case "startTime":
                            Time newStartTime = Time.valueOf(newValue);
                            updated = showtime.updateStartTime(connection, showtimeIDNumber, newStartTime);
                            break;
                        case "roomNumber":
                            int newRoomNumber = Integer.parseInt(newValue);
                            updated = showtime.updateRoomNumber(connection, showtimeIDNumber, newRoomNumber);
                            break;
                        case "ticketPrice":
                            double newTicketPrice = Double.parseDouble(newValue);
                            updated = showtime.updateTicketPrice(connection, showtimeIDNumber, newTicketPrice);
                            break;
                        default:
                            out.println("<p>Invalid update field.</p>");
                    }

                    if (updated) {
                        out.println("<p>Showtime record updated successfully.</p>");
                    } else {
                        out.println("<p>Failed to update showtime record. Please try again.</p>");
                    }
                } else {
                    out.println("<p>No showtime found with the given ID.</p>");
                }

                connection.close();
            } catch (NumberFormatException e) {
                out.println("<p>Invalid showtime ID or input format.</p>");
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
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
                    // JDBC connection
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
    <form action="TicketStaffMenu.jsp"><input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
</center>
</body>
</html>