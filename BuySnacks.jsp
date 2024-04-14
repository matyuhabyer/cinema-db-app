<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Transactions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Buy Snacks</title>
</head>
<body>
    <center>
    <%
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "DLSU1234!");
        Transactions transactions = new Transactions();

        out.println("<h1>Buy Snacks</h1>");

        out.println("<h2>Available Snacks</h2>");
        out.println("<form action='ProcessSnackPurchase.jsp' method='post'>");
        out.println("Select Snack Type:");
        out.println("<select name='food_type'>");
        out.println("<option value='Popcorn'>Popcorn</option>");
        out.println("<option value='Nachos'>Nachos</option>");
        out.println("</select><br>");

        out.println("Select Snack Size:");
        out.println("<select name='food_size'>");
        out.println("<option value='Small'>Small</option>");
        out.println("<option value='Medium'>Medium</option>");
        out.println("<option value='Large'>Large</option>");
        out.println("</select><br>");

        out.println("Select Snack Flavor:");
        out.println("<select name='food_flavor'>");
        out.println("<option value='BBQ'>BBQ</option>");
        out.println("<option value='Cheese'>Cheese</option>");
        out.println("<option value='Sour Cream'>Sour Cream</option>");
        out.println("</select><br>");

        out.println("Enter Snack Quantity:");
        out.println("<input type='number' name='snack_quantity' min='1' value='1'><br>");

        out.println("<h2>Available Drinks</h2>");
        out.println("Select Drink:");
        out.println("<select name='drink'>");
        out.println("<option value='Iced Tea'>Iced Tea</option>");
        out.println("<option value='Coke'>Coke</option>");
        out.println("<option value='Coke Zero'>Coke Zero</option>");
        out.println("<option value='Sprite'>Sprite</option>");
        out.println("<option value='Royal'>Royal</option>");
        out.println("<option value='Pineapple Juice'>Pineapple Juice</option>");
        out.println("</select><br>");

        out.println("Select Drink Size:");
        out.println("<select name='drink_size'>");
        out.println("<option value='Small'>Small</option>");
        out.println("<option value='Medium'>Medium</option>");
        out.println("<option value='Large'>Large</option>");
        out.println("</select><br>");

        out.println("Enter Drink Quantity:");
        out.println("<input type='number' name='drink_quantity' min='1' value='1'><br>");

        out.println("<input type='submit' value='Buy Snacks'>");
        out.println("</form>");

    } catch (Exception e){
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
    %>
    </center>
</body>
</html>
