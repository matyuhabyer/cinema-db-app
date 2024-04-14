/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cinemapackage;
import java.sql.*;

public class Employees {
    public Employees(){

    }
    public String authenticateEmployee(Connection connection, int employeeID, String employeePassword) throws SQLException {
        String query = "SELECT position FROM employee WHERE employee_id = ? AND password = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, employeeID);
        preparedStatement.setString(2, employeePassword);
        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            return resultSet.getString("position"); 
        } else {
            return null; 
        }
    }
    
    public boolean addNewEmployee(Connection connection, String password, String email, String fullName, 
        String shiftStart, String shiftEnd, String position) throws SQLException{
        String query = "INSERT INTO employee (password, email, full_name, shift_start_time, shift_end_time, position) " +
                   "VALUES (?, ?, ?, ?, ?, ?)";
    
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, password);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, fullName);
            preparedStatement.setString(4, shiftStart);
            preparedStatement.setString(5, shiftEnd);
            preparedStatement.setString(6, position);

            int rowsAffected = preparedStatement.executeUpdate();

            return rowsAffected > 0;
        }
    }

    public boolean deleteEmployee(Connection connection, int employeeID) throws SQLException {
        String query = "DELETE FROM employee WHERE employee_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, employeeID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    public boolean updateEmployeeEmail(Connection connection, int employeeID, String newEmail) throws SQLException {
        String query = "UPDATE employee SET email = ? WHERE employee_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, newEmail);
            preparedStatement.setInt(2, employeeID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateEmployeePassword(Connection connection, int employeeID, String newPassword) throws SQLException {
        String query = "UPDATE employee SET password = ? WHERE employee_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, newPassword);
            preparedStatement.setInt(2, employeeID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateEmployeeShiftStart(Connection connection, int employeeID, String newShiftStart) throws SQLException {
        String query = "UPDATE employee SET shift_start_time = ? WHERE employee_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, newShiftStart);
            preparedStatement.setInt(2, employeeID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateEmployeeShiftEnd(Connection connection, int employeeID, String newShiftEnd) throws SQLException {
        String query = "UPDATE employee SET shift_end_time = ? WHERE employee_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, newShiftEnd);
            preparedStatement.setInt(2, employeeID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateEmployeePosition(Connection connection, int employeeID, String newPosition) throws SQLException {
        String query = "UPDATE employee SET position = ? WHERE employee_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, newPosition);
            preparedStatement.setInt(2, employeeID);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    public ResultSet listEmployees(Connection connection, String position) throws SQLException{
        String query = "SELECT * FROM employee WHERE position = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, position);
        return preparedStatement.executeQuery();
    }
}
