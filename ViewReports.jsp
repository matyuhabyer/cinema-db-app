<%-- 
    Document   : ViewReports
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Reports</title>
</head>
<body>
<center>
    <%
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet1 = null;
        ResultSet resultSet2 = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "DLSU1234!");

            // Report #1: Monthly Overall Cinema Sales Report
            String overallSales = "SELECT COALESCE(SUM(st.ticket_price * t.num_tickets), 0) AS Total_Ticket_Sales, " +
                    "COALESCE(SUM((s.food_price * t.num_foods) + (s.drinks_price * t.num_drinks)), 0) AS Total_Snacks_Sales, " +
                    "COALESCE(SUM(st.ticket_price * t.num_tickets), 0) + COALESCE(SUM((s.food_price * t.num_foods) + (s.drinks_price * t.num_drinks)), 0) AS Total_Sales " +
                    "FROM transactions t " +
                    "LEFT JOIN showtime st ON t.showtime_id = st.showtime_id " +
                    "LEFT JOIN snacks s ON t.snacks_id = s.snacks_id;";
            statement = connection.createStatement();
            resultSet1 = statement.executeQuery(overallSales);

            // Display Report #1
            out.println("<h1>Monthly Overall Cinema Sales Report</h1>");
            out.println("<table border='1'>");
            out.println("<tr><th>Total Ticket Sales</th><th>Total Snacks Sales</th><th>Total Sales</th></tr>");
            if (resultSet1.next()) {
                double totalTicketSales = resultSet1.getDouble("Total_Ticket_Sales");
                double totalSnacksSales = resultSet1.getDouble("Total_Snacks_Sales");
                double totalSales = resultSet1.getDouble("Total_Sales");
                out.println("<tr>");
                out.println("<td>Php " + totalTicketSales + "</td>");
                out.println("<td>Php " + totalSnacksSales + "</td>");
                out.println("<td>Php " + totalSales + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");

            // Report #2: Monthly Gross Movie Sales Report
            String movieSales = "SELECT m.title AS Movie_Title, " +
                    "COALESCE(SUM(st.ticket_price * t.num_tickets), 0) AS Total_Ticket_Sales " +
                    "FROM transactions t " +
                    "LEFT JOIN showtime st ON t.showtime_id = st.showtime_id " +
                    "LEFT JOIN movie m ON st.movie_id = m.movie_id " +
                    "GROUP BY m.title " +
                    "ORDER BY m.title;";
            resultSet2 = statement.executeQuery(movieSales);

            // Display Report #2
            out.println("<h1>Monthly Gross Movie Sales Report</h1>");
            out.println("<table border='1'>");
            out.println("<tr><th>Movie Title</th><th>Total Ticket Sales</th></tr>");
            double totalGrossSales = 0;
            while (resultSet2.next()) {
                String movieTitle = resultSet2.getString("Movie_Title");
                double totalTicketSales = resultSet2.getDouble("Total_Ticket_Sales");
                if (movieTitle != null && totalTicketSales > 0) {
                    out.println("<tr>");
                    out.println("<td>" + movieTitle + "</td>");
                    out.println("<td>Php " + totalTicketSales + "</td>");
                    out.println("</tr>");
                    totalGrossSales += totalTicketSales;
                }
            }
            out.println("<tr><td colspan='2'><b>Total Gross Sales: </b> Php " + totalGrossSales + "</td></tr>");
            out.println("</table>");

        } catch (SQLException | ClassNotFoundException e) {
            out.println("<p>An error occurred while processing the request. Please try again later.</p>");
            out.println("<p>Error Details: " + e.getMessage() + "</p>");
        } finally {
            try { if (resultSet1 != null) resultSet1.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (resultSet2 != null) resultSet2.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (statement != null) statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    <br><br>
    <form action="index.html"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
</center>
</body>
</html>
