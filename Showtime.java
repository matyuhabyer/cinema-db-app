/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cinemapackage;
import java.sql.*;
import java.util.Date;
import java.text.ParseException;

public class Showtime {
    public Showtime(){
        
    }
    
    public void addNewShowtime(Connection connection, int movieId, int roomNumber, Date startTime, double ticketPrice) throws SQLException, ParseException {
        int movieDuration = 0;

        // Retrieve movie duration
        try (PreparedStatement durationStmt = connection.prepareStatement("SELECT m.duration FROM movie m WHERE m.movie_id = ?")) {
            durationStmt.setInt(1, movieId);
            try (ResultSet durationResult = durationStmt.executeQuery()) {
                if (durationResult.next()) {
                    movieDuration = durationResult.getInt("duration");
                } else {
                    throw new IllegalArgumentException("Movie ID not found: " + movieId);
                }
            }
        }

        // Calculate end time
        long endTimeMillis = startTime.getTime() + (movieDuration * 60 * 1000); // Convert minutes to milliseconds
        Time endTime = new Time(endTimeMillis);

        // Check if the showtime already exists
        try (PreparedStatement checkStmt = connection.prepareStatement("SELECT * FROM showtime WHERE movie_id = ? AND room_number = ? AND start_time = ?")) {
            checkStmt.setInt(1, movieId);
            checkStmt.setInt(2, roomNumber);
            checkStmt.setTime(3, new Time(startTime.getTime()));
            try (ResultSet resultSet = checkStmt.executeQuery()) {
                if (resultSet.next()) {
                    throw new IllegalStateException("Showtime for movie ID " + movieId + " in room " + roomNumber + " at " + startTime + " already exists.");
                }
            }
        }

        // Insert new showtime
        try (PreparedStatement insertStmt = connection.prepareStatement("INSERT INTO showtime (movie_id, room_number, start_time, end_time, ticket_price) VALUES (?, ?, ?, ?, ?)")) {
            insertStmt.setInt(1, movieId);
            insertStmt.setInt(2, roomNumber);
            insertStmt.setTime(3, new Time(startTime.getTime()));
            insertStmt.setTime(4, endTime);
            insertStmt.setDouble(5, ticketPrice);
            int rowsAffected = insertStmt.executeUpdate();

            if (rowsAffected <= 0) {
                throw new SQLException("Error adding showtime. No rows affected.");
            }
        }
    }
    
    public boolean deleteShowtime(Connection connection, int showtimeID) throws SQLException {
        String query = "DELETE FROM showtime WHERE showtime_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, showtimeID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    public boolean updateStartTime(Connection connection, int showtimeID, Time newStartTime) throws SQLException {
        String query = "UPDATE showtime s1 " +
                       "INNER JOIN (SELECT s.showtime_id, " +
                                          "m.duration " +
                                    "FROM showtime s " +
                                    "INNER JOIN movie m ON s.movie_id = m.movie_id " +
                                    "WHERE s.showtime_id = ?) AS s2 ON s1.showtime_id = s2.showtime_id " +
                       "SET s1.start_time = ?, s1.end_time = ADDTIME(?, SEC_TO_TIME(s2.duration * 60)) " +
                       "WHERE s1.showtime_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, showtimeID);
            preparedStatement.setTime(2, newStartTime);
            preparedStatement.setTime(3, newStartTime);
            preparedStatement.setInt(4, showtimeID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }


    
    public boolean updateRoomNumber(Connection connection, int showtimeID, int newRoomNumber) throws SQLException {
        String query = "UPDATE showtime SET room_number = ? WHERE showtime_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, newRoomNumber);
            preparedStatement.setInt(2, showtimeID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateTicketPrice(Connection connection, int showtimeID, double newPrice) throws SQLException {
        String query = "UPDATE showtime SET ticket_price = ? WHERE showtime_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDouble(1, newPrice);
            preparedStatement.setInt(2, showtimeID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public ResultSet listShowtimeByRoom(Connection connection, String room) throws SQLException{
        String query = "SELECT m.title AS Movie_Title, "
                + "m.genre AS Genre, "
                + "m.mtrcb_rating AS MTRCB_Rating, "
                + "st.room_number AS Room_Number, "
                + "st.start_time AS Start_Time, "
                + "st.end_time AS End_Time, "
                + "st.ticket_price AS Ticket_Price "
                + "FROM showtime st "
                + "LEFT JOIN movie m ON st.movie_id = m.movie_id "
                + "WHERE st.room_number = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, room);
        return preparedStatement.executeQuery();
    }
    
    public ResultSet listShowtimeByPrice(Connection connection, double price) throws SQLException {
        String query = "SELECT m.title AS Movie_Title, "
                + "m.genre AS Genre, "
                + "m.mtrcb_rating AS MTRCB_Rating, " 
                + "st.room_number AS Room_Number, " 
                + "st.start_time AS Start_Time, " 
                + "st.end_time AS End_Time, " 
                + "st.ticket_price AS Ticket_Price " 
                + "FROM showtime st " 
                + "LEFT JOIN movie m ON st.movie_id = m.movie_id " 
                + "WHERE st.ticket_price >= ? AND st.ticket_price <= ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setDouble(1, price - 0.01); 
        preparedStatement.setDouble(2, price + 0.01);
        return preparedStatement.executeQuery();
    }
}
