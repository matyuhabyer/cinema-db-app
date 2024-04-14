/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cinemapackage;
import java.sql.*;

public class Transactions {
    public Transactions() {
    }

    public void buyTickets(int movieID, int numTickets) throws SQLException{
        try {
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "DLSU1234!");

            // Get the corresponding showtime_id
            int showtime_id = getShowtimeId(connection, movieID);
            if (showtime_id == -1) {
                throw new IllegalArgumentException("Showtime not found for the selected movie.");
            }

            // Check if there are enough available seats
            int availableSeats = getAvailableSeats(connection, showtime_id);
            if (availableSeats < numTickets) {
                throw new IllegalArgumentException("Sorry, there are not enough available seats.");
            }

            // Proceed with the transaction
            updateAvailableSeats(connection, showtime_id, numTickets);

            // Insert transaction into database
            insertTransaction(connection, showtime_id, numTickets);

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Transaction failed: " + e.getMessage());
        }
    }

    public int getShowtimeId(Connection connection, int movieID) throws SQLException {
        PreparedStatement showtimeIdStatement = connection.prepareStatement("SELECT showtime_id FROM showtime WHERE movie_id = ?");
        showtimeIdStatement.setInt(1, movieID);
        ResultSet showtimeIdResult = showtimeIdStatement.executeQuery();

        if (showtimeIdResult.next()) {
            return showtimeIdResult.getInt("showtime_id");
        } else {
            return -1; // Indicates showtime not found
        }
    }

    public int getAvailableSeats(Connection connection, int showtime_id) throws SQLException {
        PreparedStatement checkSeatsStatement = connection.prepareStatement("SELECT available_seats FROM screen_room WHERE room_number = (SELECT room_number FROM showtime WHERE showtime_id = ?)");
        checkSeatsStatement.setInt(1, showtime_id);
        ResultSet seatsResult = checkSeatsStatement.executeQuery();

        if (seatsResult.next()) {
            return seatsResult.getInt("available_seats");
        } else {
            throw new IllegalStateException("Invalid showtime ID or no available seats.");
        }
    }

    public void updateAvailableSeats(Connection connection, int showtime_id, int numTickets) throws SQLException {
        PreparedStatement updateSeatsStatement = connection.prepareStatement("UPDATE screen_room SET available_seats = available_seats - ? WHERE room_number = (SELECT room_number FROM showtime WHERE showtime_id = ?)");
        updateSeatsStatement.setInt(1, numTickets);
        updateSeatsStatement.setInt(2, showtime_id);
        updateSeatsStatement.executeUpdate();
    }

    public void insertTransaction(Connection connection, int showtime_id, int numTickets) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO transactions (transaction_type, showtime_id, num_tickets) VALUES (?, ?, ?)");
        preparedStatement.setString(1, "Ticket"); // Assuming this transaction is for a ticket purchase
        preparedStatement.setInt(2, showtime_id);
        preparedStatement.setInt(3, numTickets);
        preparedStatement.executeUpdate();
    }
    
    public void buySnacks(int snacksId, int numFoods, int numDrinks) throws SQLException {
        try {
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "DLSU1234!");

            // Check if the snacks exist and have enough available quantity
            if (!checkSnacksExist(connection, snacksId)) {
                throw new IllegalArgumentException("Snacks not found or invalid.");
            }

            // Proceed with the transaction
            updateSnacksQuantity(connection, snacksId, numFoods, numDrinks);

            // Insert transaction into database
            insertTransaction(connection, snacksId, numFoods, numDrinks);

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Transaction failed: " + e.getMessage());
        }
    }
    
    public int getSnacksId(Connection connection, String foodType, String foodSize, String foodFlavor) throws SQLException {
        int snacksId = -1;
        String query = "SELECT snacks_id FROM snacks WHERE food_type = ? AND food_size = ? AND food_flavor = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, foodType);
            statement.setString(2, foodSize);
            statement.setString(3, foodFlavor);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    snacksId = resultSet.getInt("snacks_id");
                }
            }
        }
        return snacksId;
    }
    
    public double getSnackPrice(Connection connection, String foodType, String foodSize, String foodFlavor) throws SQLException {
        double price = 0.0;
        String query = "SELECT food_price FROM snacks WHERE food_type = ? AND food_size = ? AND food_flavor = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, foodType);
            statement.setString(2, foodSize);
            statement.setString(3, foodFlavor);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    price = resultSet.getDouble("food_price");
                }
            }
        }
        return price;
    }
    
    public double getDrinkPrice(Connection connection, String drink, String drinkSize) throws SQLException {
        double price = 0.0;
        String query = "SELECT drinks_price FROM snacks WHERE drinks = ? AND drinks_size = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, drink);
            statement.setString(2, drinkSize);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    price = resultSet.getDouble("drinks_price");
                }
            }
        }
        return price;
    }


    public boolean checkSnacksExist(Connection connection, int snacksId) throws SQLException {
        PreparedStatement checkSnacksStatement = connection.prepareStatement("SELECT snacks_id FROM snacks WHERE snacks_id = ?");
        checkSnacksStatement.setInt(1, snacksId);
        ResultSet snacksResult = checkSnacksStatement.executeQuery();
        return snacksResult.next();
    }

    public void updateSnacksQuantity(Connection connection, int snacksId, int numFoods, int numDrinks) throws SQLException {
        PreparedStatement updateSnacksStatement = connection.prepareStatement("UPDATE snacks SET food_quantity = food_quantity - ?, drink_quantity = drink_quantity - ? WHERE snacks_id = ?");
        updateSnacksStatement.setInt(1, numFoods);
        updateSnacksStatement.setInt(2, numDrinks);
        updateSnacksStatement.setInt(3, snacksId);
        updateSnacksStatement.executeUpdate();
    }

    public void insertTransaction(Connection connection, int snacksId, int numFoods, int numDrinks) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO transactions (transaction_type, snacks_id, num_foods, num_drinks) VALUES (?, ?, ?, ?)");
        preparedStatement.setString(1, "Snack"); // Assuming this transaction is for snacks purchase
        preparedStatement.setInt(2, snacksId);
        preparedStatement.setInt(3, numFoods);
        preparedStatement.setInt(4, numDrinks);
        preparedStatement.executeUpdate();
    }
    
        public void insertSnackTransaction(Connection connection, String foodType, String foodSize, String foodFlavor, double snackPrice, String drink, String drinkSize, double drinkPrice, double totalPrice) throws SQLException {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO transactions (food_type, food_size, food_flavor, snack_price, drink, drink_size, drink_price, total_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            preparedStatement.setString(1, foodType);
            preparedStatement.setString(2, foodSize);
            preparedStatement.setString(3, foodFlavor);
            preparedStatement.setDouble(4, snackPrice);
            preparedStatement.setString(5, drink);
            preparedStatement.setString(6, drinkSize);
            preparedStatement.setDouble(7, drinkPrice);
            preparedStatement.setDouble(8, totalPrice);
            preparedStatement.executeUpdate();
    }

}
