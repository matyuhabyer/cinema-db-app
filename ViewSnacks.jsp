<%-- 
    Document   : ViewSnacks
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Snacks</title>
    </head>
    <body>
    <center>
    <h1>Available Snacks</h1>
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
            } catch (SQLException e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
    <br><br>
    <form action ="index.html"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
</body>
</html>
