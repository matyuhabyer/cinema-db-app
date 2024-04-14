<%-- 
    Document   : BuyTickets
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Transactions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buy Tickets</title>
    </head>
    <body>
    <center>
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "DLSU1234!");
            Transactions transactions = new Transactions();

            out.println("<h1>Buy Movie Tickets</h1>");

            out.println("<h2>Available Movies</h2>");
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM movie");

            out.println("<ul>");
            while (resultSet.next()) {
                out.println("<li>" + resultSet.getInt("movie_id") + ". " + resultSet.getString("title") + "</li>");
            }
            out.println("</ul>");

            out.println("<form action='ConfirmPurchase.jsp' method='post'>");
            out.println("Enter movie ID: <input type='text' name='movieID'><br>");
            out.println("Enter number of tickets: <input type='text' name='numTickets'><br>");
            out.println("<input type='submit' value='Buy Tickets'>");
            out.println("</form>");

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    %>
    </center>
    </body>
</html>
