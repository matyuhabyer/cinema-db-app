<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Transactions" %>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Process Snack Purchase</title>
</head>
<body>
<center>
<%
    Connection connection = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "DLSU1234!");

        String foodType = request.getParameter("food_type");
        String foodSize = request.getParameter("food_size");
        String foodFlavor = request.getParameter("food_flavor");
        String drink = request.getParameter("drink");
        String drinkSize = request.getParameter("drink_size");
        int snackQuantity = Integer.parseInt(request.getParameter("snack_quantity"));
        int drinkQuantity = Integer.parseInt(request.getParameter("drink_quantity"));

        if (foodType == null || foodSize == null || foodFlavor == null || drink == null || drinkSize == null) {
            throw new IllegalArgumentException("One or more snack or drink parameters are missing.");
        }

        Transactions transactions = new Transactions();

        int snacksId = transactions.getSnacksId(connection, foodType, foodSize, foodFlavor);

        transactions.buySnacks(snacksId, snackQuantity, drinkQuantity);

        double snackPrice = transactions.getSnackPrice(connection, foodType, foodSize, foodFlavor);
        double drinkPrice = transactions.getDrinkPrice(connection, drink, drinkSize);
        double totalPrice = (snackPrice * snackQuantity) + (drinkPrice * drinkQuantity);

        out.println("<h1>Snack Purchase Receipt</h1>");
        out.println("<table border=\"1\">");
        out.println("<tr><th>Item</th><th>Details</th><th>Price</th></tr>");
        out.println("<tr><td>Snack Type</td><td>" + foodType + "</td><td>Php " + snackPrice + "</td></tr>");
        out.println("<tr><td>Snack Size</td><td>" + foodSize + "</td><td></td></tr>");
        out.println("<tr><td>Snack Flavor</td><td>" + foodFlavor + "</td><td></td></tr>");
        out.println("<tr><td>Snack Quantity</td><td>" + snackQuantity + "</td><td></td></tr>");
        out.println("<tr><td>Drink Type</td><td>" + drink + "</td><td>Php " + drinkPrice + "</td></tr>");
        out.println("<tr><td>Drink Size</td><td>" + drinkSize + "</td><td></td></tr>");
        out.println("<tr><td>Drink Quantity</td><td>" + drinkQuantity + "</td><td></td></tr>");
        out.println("<tr><td colspan=\"2\"><b>Total</b></td><td><b>Php " + totalPrice + "</b></td></tr>");
        out.println("</table>");

    } catch (Exception e) {
        out.println("<br><br><br>");
        out.println("Error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException ex) {
                out.println("Error closing database connection: " + ex.getMessage());
                ex.printStackTrace();
            }
        }
    }
%>
<br><br>
<form action="index.html">
    <input type="submit" value="Go Back" style="height:30px; width:280px">
</form>
</center>
</body>
</html>