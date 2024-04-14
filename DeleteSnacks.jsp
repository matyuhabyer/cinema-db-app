<%-- 
    Document   : DeleteSnacks
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Snacks" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Snacks</title>
</head>
<body>
    <center>        
        <h1>Delete Snacks</h1>
        <h2>Available Snacks</h2>
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
        <form action="" method="post">
            Snack ID to Delete: <input type="number" name="snacksID">
            <input type="submit" value="Select">
        </form>
        <%
            String snacksIDStr = request.getParameter("snacksID");
            int snacksID = 0;            
            if(snacksIDStr == null || snacksIDStr.isEmpty()){
                out.println("<p>Please fill in all fields.</p>");
            } else {
                try {
                    snacksID = Integer.parseInt(snacksIDStr);
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                    String query = "SELECT * FROM snacks WHERE snacks_id = ?";
                    PreparedStatement preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setInt(1, snacksID);
                    ResultSet resultSet = preparedStatement.executeQuery();

                    if (resultSet.next()) {
                        out.println("<h3>Snacks Details:</h3>");
                        out.println("<p>Snacks ID: " + resultSet.getInt("snacks_id") + "</p>");
                        out.println("<p>Food: " + resultSet.getString("food_type") + "</p>");
                        out.println("<p>Food Size: " + resultSet.getString("food_size") + "</p>");
                        out.println("<p>Food Flavor: " + resultSet.getString("food_flavor") + "</p>");
                        out.println("<p>Food Price: " + resultSet.getDouble("food_price") + "</p>");
                        out.println("<p>Food Quantity: " + resultSet.getInt("food_quantity") + "</p>");
                        out.println("<p>Drinks: " + resultSet.getString("drinks") + "</p>");
                        out.println("<p>Drinks Size: " + resultSet.getString("drinks_size") + "</p>");
                        out.println("<p>Drinks Price: " + resultSet.getDouble("drinks_price") + "</p>");
                        out.println("<p>Drinks Quantity: " + resultSet.getInt("drink_quantity") + "</p>");
        %>
                        <form method="post" action="DeleteSnacksAction.jsp">
                            <input type="hidden" name="snacksID" value="<%= snacksID %>">
                            <input type="submit" value="Delete Snacks">
                        </form>
        <%
                    } else {
                        out.println("<p>No snacks found with ID: " + snacksID + "</p>");
                    }

                    resultSet.close();
                    preparedStatement.close();
                    connection.close();
                } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
        <br><br>
        <form action="SnacksVendorMenu.jsp"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
</body>
</html>
