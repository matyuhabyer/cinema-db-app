<%@page import="java.sql.*, java.util.Date, java.text.SimpleDateFormat, java.text.ParseException, cinemapackage.Showtime"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Movie Showtime Action</title>
</head>
<body>
    <center>
        <h1>Add Movie Showtime Action</h1>
        <%
            Connection connection = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "DLSU1234!");
                
                String movieIdStr = request.getParameter("movieId");
                String roomNumberStr = request.getParameter("roomNumber");
                String startTimeStr = request.getParameter("startTime");
                String ticketPriceStr = request.getParameter("ticketPrice");

                if (movieIdStr == null || roomNumberStr == null || startTimeStr == null || ticketPriceStr == null ||
                    movieIdStr.isEmpty() || roomNumberStr.isEmpty() || startTimeStr.isEmpty() || ticketPriceStr.isEmpty()) {
                    throw new IllegalArgumentException("One or more parameters are missing.");
                }

                int movieId = Integer.parseInt(movieIdStr);
                int roomNumber = Integer.parseInt(roomNumberStr);
                double ticketPrice = Double.parseDouble(ticketPriceStr);

                SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
                Date startTime = sdf.parse(startTimeStr);

                Showtime showtime = new Showtime();
                showtime.addNewShowtime(connection, movieId, roomNumber, startTime, ticketPrice);
                
                out.println("<p>Showtime added successfully.</p>");

            } catch (ClassNotFoundException e) {
                out.println("<p>Error: MySQL JDBC driver not found.</p>");
                e.printStackTrace();
            } catch (ParseException e) {
                out.println("<p>Error: Failed to parse date/time. Please enter a valid time format.</p>");
                e.printStackTrace();
            } catch (IllegalArgumentException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        out.println("Error closing connection: " + e.getMessage());
                        e.printStackTrace();
                    }
                }
            }
        %>
        <br><br>
        <form action="TicketStaffMenu.jsp"><input type="submit" value="Go Back"></form>
    </center>
</body>
</html>