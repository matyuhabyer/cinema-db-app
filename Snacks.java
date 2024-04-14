/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cinemapackage;
import java.sql.*;

public class Snacks {
    public Snacks(){
        
    }
    
    public boolean addNewSnacks(Connection connection, String foodType, String foodSize, String foodFlavor, double foodPrice, 
        int foodQuantity, String drinks, String drinksSize, double drinksPrice, int drinksQuantity) throws SQLException{
        
        String query = "INSERT INTO snacks (food_type, food_size, food_flavor, food_price, food_quantity, "
                + "drinks, drinks_size, drinks_price, drink_quantity) " +
               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, foodType);
            preparedStatement.setString(2, foodSize);
            preparedStatement.setString(3, foodFlavor);
            preparedStatement.setDouble(4, foodPrice);
            preparedStatement.setInt(5, foodQuantity);
            preparedStatement.setString(6, drinks);
            preparedStatement.setString(7, drinksSize);
            preparedStatement.setDouble(8, drinksPrice);
            preparedStatement.setInt(9, drinksQuantity);

            int rowsAffected = preparedStatement.executeUpdate();

            return rowsAffected > 0;
        }
    }
    
    public boolean deleteSnacks(Connection connection, int snacksID) throws SQLException {
        String query = "DELETE FROM snacks WHERE snacks_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, snacksID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }
   
    public boolean updateFoodPrice(Connection connection, int snacksID, double newPrice) throws SQLException {
        String query = "UPDATE snacks SET food_price = ? WHERE snacks_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDouble(1, newPrice);
            preparedStatement.setInt(2, snacksID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    public boolean updateFoodQuantity(Connection connection, int snacksID, int newQuantity) throws SQLException {
        String query = "UPDATE snacks SET food_quantity = ? WHERE snacks_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, newQuantity);
            preparedStatement.setInt(2, snacksID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateDrinksPrice(Connection connection, int snacksID, double newPrice) throws SQLException {
        String query = "UPDATE snacks SET drinks_price = ? WHERE snacks_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDouble(1, newPrice);
            preparedStatement.setInt(2, snacksID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateDrinksQuantity(Connection connection, int snacksID, int newQuantity) throws SQLException {
        String query = "UPDATE snacks SET drink_quantity = ? WHERE snacks_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, newQuantity);
            preparedStatement.setInt(2, snacksID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    public ResultSet listSnacksByFoodType(Connection connection, String foodType) throws SQLException{
        String query = "SELECT * FROM snacks WHERE food_type = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, foodType);
        return preparedStatement.executeQuery();
    }
    
    public ResultSet listSnacksByFoodSize(Connection connection, String foodSize) throws SQLException{
        String query = "SELECT * FROM snacks WHERE food_size = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, foodSize);
        return preparedStatement.executeQuery();
    }
    
    public ResultSet listSnacksByFoodFlavor(Connection connection, String foodFlavor) throws SQLException{
        String query = "SELECT * FROM snacks WHERE food_flavor = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, foodFlavor);
        return preparedStatement.executeQuery();
    }
    
    public ResultSet listSnacksByDrinks(Connection connection, String drinks) throws SQLException{
        String query = "SELECT * FROM snacks WHERE drinks = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, drinks);
        return preparedStatement.executeQuery();
    }
}
