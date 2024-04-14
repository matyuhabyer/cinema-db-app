/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cinemapackage;
import java.sql.*;

public class Movies {
    
    public Movies(){
        
    }
    
    public boolean addNewMovie(Connection connection, String title, String director, String genre, Date releaseDate, 
        int duration, String rating) throws SQLException{
        
        String query = "INSERT INTO movie (title, director, genre, release_date, duration, mtrcb_rating) " +
               "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, title);
            preparedStatement.setString(2, director);
            preparedStatement.setString(3, genre);
            preparedStatement.setDate(4, releaseDate);
            preparedStatement.setInt(5, duration);
            preparedStatement.setString(6, rating);

            int rowsAffected = preparedStatement.executeUpdate();

            return rowsAffected > 0;
        }
    }
    
    public boolean deleteMovie(Connection connection, int movieID) throws SQLException {
        String query = "DELETE FROM movie WHERE movie_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, movieID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    public boolean updateDirector(Connection connection, String title, String newDirector) throws SQLException {
        String query = "UPDATE movie SET director = ? WHERE title = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, newDirector);
            preparedStatement.setString(2, title);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateGenre(Connection connection, String title, String newGenre) throws SQLException {
        String query = "UPDATE movie SET genre = ? WHERE title = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, newGenre);
            preparedStatement.setString(2, title);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateReleaseDate(Connection connection, String title, Date newReleaseDate) throws SQLException {
        String query = "UPDATE movie SET release_date = ? WHERE title = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDate(1, newReleaseDate);
            preparedStatement.setString(2, title);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateDuration(Connection connection, String title, int newDuration) throws SQLException {
        String query = "UPDATE movie SET duration = ? WHERE title = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, newDuration);
            preparedStatement.setString(2, title);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateMTRCBRating(Connection connection, String title, String newRating) throws SQLException {
        String query = "UPDATE movie SET mtrcb_rating = ? WHERE title = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, newRating);
            preparedStatement.setString(2, title);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }
 
    public ResultSet listMoviesByMTRCBRating(Connection connection, String rating) throws SQLException{
        String query = "SELECT * FROM movie WHERE mtrcb_rating = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, rating);
        return preparedStatement.executeQuery();
    }
    
    public ResultSet listMoviesByStatus(Connection connection, String status) throws SQLException{
        String query = "SELECT * FROM movie WHERE movie_status = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, status);
        return preparedStatement.executeQuery();
    }
    
    public ResultSet listMoviesByGenre(Connection connection, String genre) throws SQLException{
        String query = "SELECT * FROM movie WHERE genre LIKE ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, "%" + genre + "%");
        return preparedStatement.executeQuery();
    }
}
