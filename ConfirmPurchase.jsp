<%-- 
    Document   : ConfirmPurchase
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Transactions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Confirm Purchase</title>
</head>
<body>
<center>
    <%
    int movieID = Integer.parseInt(request.getParameter("movieID"));
    int numTickets = Integer.parseInt(request.getParameter("numTickets"));

    Transactions transactions = new Transactions();

    Connection connection = null;
    int showtime_id = -1;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "DLSU1234!");
        showtime_id = transactions.getShowtimeId(connection, movieID);

        if (showtime_id != -1) {
            transactions.buyTickets(movieID, numTickets);

            try (PreparedStatement ticketDetailsStatement = connection.prepareStatement(
                "SELECT m.title, m.mtrcb_rating, s.start_time, s.room_number, t.num_tickets, s.ticket_price " +
                "FROM transactions t " +
                "JOIN showtime s ON t.showtime_id = s.showtime_id " +
                "JOIN movie m ON s.movie_id = m.movie_id " +
                "WHERE t.showtime_id = ?"
            )) {
                ticketDetailsStatement.setInt(1, showtime_id);
                ResultSet ticketDetailsResult = ticketDetailsStatement.executeQuery();

                out.println("=======================" + "<br>");
                out.println("         TICKET        " + "<br>");
                out.println("=======================" + "<br>");
                while (ticketDetailsResult.next()) {
                    out.println("Movie Title: " + ticketDetailsResult.getString("title") + "<br>");
                    out.println("MTRCB Rating: " + ticketDetailsResult.getString("mtrcb_rating") + "<br>");
                    out.println("Start Time: " + ticketDetailsResult.getTime("start_time") + "<br>");
                    out.println("Screen Room Number: " + ticketDetailsResult.getString("room_number") + "<br>");
                    out.println("Number of Tickets: " + numTickets + "<br>");
                    out.println("Amount: Php " + ticketDetailsResult.getDouble("ticket_price") * numTickets + "<br>");
                }
                out.println("=======================" + "<br>");
            }
        } else {
    %>
            <h2>Sorry, this movie doesn't have any showtime yet.</h2>
    <%
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        throw new RuntimeException("Failed to get showtime ID: " + e.getMessage());
    } finally {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    %>
    <br><br>
    <form action ="index.html"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
</center>
</body>
</html>