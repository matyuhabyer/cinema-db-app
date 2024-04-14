<%-- 
    Document   : ViewMovies
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Movies</title>
    </head>
    <body>
    <center>
    <h1>Available Movies</h1>
    <table border="1">
        <tr>
            <th>Title</th>
            <th>Director</th>
            <th>Genre</th>
            <th>Release Date</th>
            <th>Duration</th>
            <th>MTRCB Rating</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL",
                        "root", "DLSU1234!");
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery("SELECT * FROM movie");
                while (resultSet.next()) {
        %>
                    <tr>
                        <td><%= resultSet.getString("title") %></td>
                        <td><%= resultSet.getString("director") %></td>
                        <td><%= resultSet.getString("genre") %></td>
                        <td><%= resultSet.getString("release_date") %></td>
                        <td><%= resultSet.getString("duration") %> minutes</td>
                        <td><%= resultSet.getString("mtrcb_rating") %></td>
                    </tr>
        <%
                }
                connection.close();
            } catch (SQLException e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
    <br><br>
    <form action ="index.html"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
</body>
</html>
