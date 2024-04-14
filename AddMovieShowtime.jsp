<%@page import="java.sql.*, java.util.Date, java.text.SimpleDateFormat, java.text.ParseException"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Movie Showtime</title>
</head>
<body>
    <center>
        <h1>Add Movie Showtime</h1>
        <form action="" method="post">
            Search Movie to add Showtime: <input type="text" name="movieName" required>
            <input type="submit" value="Search">
        </form>
        <br>
        <form action="AddMovieShowtimeAction.jsp" method="post">
            <%
                String movieName = request.getParameter("movieName");            
                if(movieName != null && !movieName.isEmpty()){
                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                            "root", "DLSU1234!");

                        String query = "SELECT * FROM movie WHERE title LIKE ?";
                        PreparedStatement preparedStatement = connection.prepareStatement(query);
                        preparedStatement.setString(1, "%" + movieName + "%");
                        ResultSet resultSet = preparedStatement.executeQuery();

                        while (resultSet.next()) {
                            out.println("<input type='radio' name='movieId' value='" + resultSet.getInt("movie_id") + "' required>");
                            out.println(resultSet.getString("title") + " - Director: " + resultSet.getString("director") + " - Release Date: " + resultSet.getDate("release_date"));
                            out.println("<br>");
                        }

                        resultSet.close();
                        preparedStatement.close();
                        connection.close();
                    } catch(SQLException | ClassNotFoundException e){
                        out.println("<p>An error occurred while fetching movies. Please try again later.</p>");
                        e.printStackTrace();
                    }
                }
            %>
            <br>
            Room Number:
            <select name="roomNumber" required>
                <option value="">Select Room</option>
                <option value="1">Room 1</option>
                <option value="2">Room 2</option>
                <option value="3">Room 3</option>
                <option value="4">Room 4</option>
            </select><br><br>
            Start Time: <input type="time" name="startTime" required><br><br>
            Ticket Price: <input type="number" name="ticketPrice" required><br><br>
            <input type="submit" value="Add Showtime">
        </form>
        <br><br>
        <form action="TicketStaffMenu.jsp"><input type="submit" value="Go Back"></form>
    </center>
</body>
</html>
