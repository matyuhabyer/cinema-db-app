<%-- 
    Document   : UpdateSnacks
--%>
<%@ page import="java.sql.*" %>
<%@ page import="cinemapackage.Snacks" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Snacks</title>
</head>
<body>
    <center>
    <h1>Update Snacks</h1>
    <table border="1">
        <tr>
            <th>Snacks ID</th>
            <th>Food</th>
            <th>Food Size</th>
            <th>Food Flavor</th>
            <th>Food Price</th>
            <th>Food Quantity</th>
            <th>Drinks</th>
            <th>Drinks Size</th>
            <th>Drinks Price</th>
            <th>Drinks Quantity</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL",
                        "root", "DLSU1234!");
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery("SELECT * FROM snacks");
                while (resultSet.next()) {
        %>
                    <tr>
                        <td><%= resultSet.getString("snacks_id") %></td>
                        <td><%= resultSet.getString("food_type") %></td>
                        <td><%= resultSet.getString("food_size") %></td>
                        <td><%= resultSet.getString("food_flavor") %></td>
                        <td><%= resultSet.getString("food_price") %></td>
                        <td><%= resultSet.getString("food_quantity") %></td>
                        <td><%= resultSet.getString("drinks") %></td>
                        <td><%= resultSet.getString("drinks_size") %></td>
                        <td><%= resultSet.getString("drinks_price") %></td>
                        <td><%= resultSet.getString("drink_quantity") %></td>
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
    <form action="UpdateSnacksAction.jsp" method="post">
        Snacks ID: <input type="number" name="snacksID" required><br><br>
        <label for="updateField">Select Field to Update:</label><br>
        <select id="updateField" name="updateField">
            <option value="foodPrice">Food Price</option>
            <option value="foodQuantity">Food Quantity</option>
            <option value="drinksPrice">Drinks Price</option>
            <option value="drinksQuantity">Drinks Quantity</option>
        </select><br><br>
        New Value: <input type="number" name="newValue" required><br><br>
        <input type="submit" value="Update">
    </form>
    <br><br>
    <form action="SnacksVendorMenu.jsp"><input type="submit" value="Go Back"></form>
</center>
</body>
</html>