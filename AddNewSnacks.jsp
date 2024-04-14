<%-- 
    Document   : AddNewSnacks
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Snacks" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Snacks</title>
    </head>
    <body>
    <center>      
        <h2>Add New Snacks</h2>
        <form action="" method="post">
            <label for="foodType">Food:</label><br>
            <select id="foodType" name="foodType" required>
                <option value="Popcorn">Popcorn</option>
                <option value="Nachos">Nachos</option>
            </select><br><br>
            
            <label for="foodSize">Food Size:</label><br>
            <select id="foodSize" name="foodSize" required>
                <option value="Small">Small</option>
                <option value="Medium">Medium</option>
                <option value="Large">Large</option>
            </select><br><br>
            
            <label for="foodFlavor">Food Flavor:</label><br>
            <select id="foodFlavor" name="foodFlavor" required>
                <option value="BBQ">BBQ</option>
                <option value="Cheese">Cheese</option>
                <option value="Sour Cream">Sour Cream</option>
            </select><br><br>
            
            <label for="foodPrice">Food Price:</label><br>
            <input type="number" id="foodPrice" name="foodPrice" required><br><br>
            
            <label for="foodQuantity">Food Quantity:</label><br>
            <input type="number" id="foodQuantity" name="foodQuantity" required><br><br>
            
            <label for="drinks">Drinks:</label><br>
            <select id="drinks" name="drinks" required>
                <option value="Coke">Coke</option>
                <option value="Coke Zero">Coke Zero</option>
                <option value="Sprite">Sprite</option>
                <option value="Royal">Royal</option>
                <option value="Iced Tea">Iced Tea</option>
                <option value="Pineapple Juice">Pineapple Juice</option>
            </select><br><br>
            
            <label for="drinksSize">Drinks Size:</label><br>
            <select id="drinksSize" name="drinksSize" required>
                <option value="Small">Small</option>
                <option value="Medium">Medium</option>
                <option value="Large">Large</option>
            </select><br><br>
            
            <label for="drinksPrice">Drinks Price:</label><br>
            <input type="number" id="drinksPrice" name="drinksPrice" required><br><br>
            
            <label for="drinksQuantity">Drinks Quantity:</label><br>
            <input type="number" id="drinksQuantity" name="drinksQuantity" required><br><br>
            
            <input type="submit" value="Add Snacks">
        </form><br>
        <%
            Connection connection = null;
            try {
                String foodType = request.getParameter("foodType");
                String foodSize = request.getParameter("foodSize");
                String foodFlavor = request.getParameter("foodFlavor");
                
                double foodPrice = 0;
                int foodQuantity = 0;
                try {
                    String foodPriceParam = request.getParameter("foodPrice");
                    if (foodPriceParam != null && !foodPriceParam.isEmpty()) {
                        foodPrice = Double.parseDouble(foodPriceParam);
                    }
                } catch (NumberFormatException e) {
                    out.println("<p>Error parsing food price: " + e.getMessage() + "</p>");
                }
                
                try {
                    String foodQuantityParam = request.getParameter("foodQuantity");
                    if (foodQuantityParam != null && !foodQuantityParam.isEmpty()) {
                        foodQuantity = Integer.parseInt(foodQuantityParam);
                    }
                } catch (NumberFormatException e) {
                    out.println("<p>Error parsing food quantity: " + e.getMessage() + "</p>");
                }
                
                String drinks = request.getParameter("drinks");
                String drinksSize = request.getParameter("drinksSize");
                double drinksPrice = 0;
                int drinksQuantity = 0;
                try {
                    String drinksPriceParam = request.getParameter("drinksPrice");
                    if (drinksPriceParam != null && !drinksPriceParam.isEmpty()) {
                        drinksPrice = Double.parseDouble(drinksPriceParam);
                    }
                } catch (NumberFormatException e) {
                    out.println("<p>Error parsing drinks price: " + e.getMessage() + "</p>");
                }
                
                try {
                    String drinksQuantityParam = request.getParameter("drinksQuantity");
                    if (drinksQuantityParam != null && !drinksQuantityParam.isEmpty()) {
                        drinksQuantity = Integer.parseInt(drinksQuantityParam);
                    }
                } catch (NumberFormatException e) {
                    out.println("<p>Error parsing drinks quantity: " + e.getMessage() + "</p>");
                }
                
                if (foodType == null || foodType.isEmpty() || foodSize == null || foodSize.isEmpty() ||
                    foodFlavor == null || foodFlavor.isEmpty() || foodPrice <= 0 || foodQuantity <= 0 ||
                    drinks == null || drinks.isEmpty() || drinksSize == null || drinksSize.isEmpty() ||
                    drinksPrice <= 0 || drinksQuantity <= 0) {
                    out.println("<p>Please fill in all fields.</p>");
                } else {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                                                                  "root", "DLSU1234!");
                        
                        Snacks snacks = new Snacks();
                        
                        boolean snacksAdded = snacks.addNewSnacks(connection, foodType, foodSize, foodFlavor, foodPrice, foodQuantity, 
                                                                   drinks, drinksSize, drinksPrice, drinksQuantity);
                        
                        if (snacksAdded) {
                            out.println("<p>New snacks added successfully.</p>");
                        } else {
                            out.println("<p>Failed to add new snacks. Please try again.</p>");
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (connection != null) {
                            try {
                                connection.close();
                            } catch (SQLException e) {
                                out.println("<p>Error closing connection: " + e.getMessage() + "</p>");
                            }
                        }
                    }
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>
        <br><br>
        <form action="SnacksVendorMenu.jsp"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
    </body>
</html>
