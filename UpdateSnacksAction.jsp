<%-- 
    Document   : UpdateSnacksAction
--%>
<%@ page import="java.sql.*" %>
<%@ page import="cinemapackage.Snacks" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Snacks Action</title>
</head>
<body>
<center>
    <%
        String snacksID = request.getParameter("snacksID");
        String updateField = request.getParameter("updateField");
        String newValue = request.getParameter("newValue");

        if (snacksID == null || snacksID.isEmpty() || updateField == null || updateField.isEmpty() || newValue == null || newValue.isEmpty()) {
            out.println("<p>Please fill in all fields.</p>");
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                    "root", "DLSU1234!");

                String query;
                PreparedStatement preparedStatement;
                ResultSet resultSet;

                query = "SELECT * FROM snacks WHERE snacks_id = ?";
                preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, snacksID);
                resultSet = preparedStatement.executeQuery();
                
                if (resultSet.next()) {
                    String snacks_id = resultSet.getString("snacks_id");
                    int snacksIDNumber = Integer.parseInt(snacks_id);
                    Snacks snacks = new Snacks();
                    boolean updated = false;
                    switch (updateField) {
                        case "foodPrice":
                            double newPrice = Double.parseDouble(newValue);
                            updated = snacks.updateFoodPrice(connection, snacksIDNumber, newPrice);
                            break;
                        case "foodQuantity":
                            int newQuantity = Integer.parseInt(newValue);
                            updated = snacks.updateFoodQuantity(connection, snacksIDNumber, newQuantity);
                            break;
                        case "drinksPrice":
                            double newDrinkPrice = Double.parseDouble(newValue);
                            updated = snacks.updateDrinksPrice(connection, snacksIDNumber, newDrinkPrice);
                            break;
                        case "drinksQuantity":
                            int newDrinkQuantity = Integer.parseInt(newValue);
                            updated = snacks.updateDrinksQuantity(connection, snacksIDNumber, newDrinkQuantity);
                            break;
                        default:
                            out.println("<p>Invalid update field.</p>");
                    }

                    if (updated) {
                        out.println("<p>Snacks record updated successfully.</p>");

                        query = "SELECT * FROM snacks WHERE snacks_id = ?";
                        preparedStatement = connection.prepareStatement(query);
                        preparedStatement.setString(1, snacksID);
                        resultSet = preparedStatement.executeQuery();
                        
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
                        }
                    } else {
                        out.println("<p>Failed to update snacks record. Please try again.</p>");
                    }
                } else {
                    out.println("<p>No snacks found with the given ID.</p>");
                }

                connection.close();
            } catch (NumberFormatException e) {
                out.println("<p>Invalid snacks ID.</p>");
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
    <br><br>
    <form action="SnacksVendorMenu.jsp"><input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
</center>
</body>
</html>
