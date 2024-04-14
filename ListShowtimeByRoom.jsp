<%-- 
    Document   : ListShowtimeByRoom
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Showtime" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Showtime By Room</title>
    </head>
    <body>
    <center>
        <h1>List Showtime By Room</h1>
        <form action="" method="post">
            Select Room Number:
            <select name="roomNumber">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
            </select>
            <input type="submit" value="List">
        </form>
        <%
            String roomNumber = request.getParameter("roomNumber");
            if(roomNumber == null || roomNumber.isEmpty()){
                out.println("<p>Please select a room number.</p>");
            } else{
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                    Showtime showtime = new Showtime();
                    ResultSet resultSet = showtime.listShowtimeByRoom(connection, roomNumber);
                    
                    out.println("<h3>Showtime with Room Number: " + roomNumber + "</h3>");
                    out.println("<table border='1'>");
                    out.println("<tr><th>Title</th><th>Genre</th><th>MTRCB Rating</th><th>Room Number</th><th>Start Time</th><th>End Time</th><th>Ticket Price</th></tr>");                   
                    if(resultSet.next()){
                        do{
                            out.println("<tr>");
                            out.println("<td>" + resultSet.getString("Movie_Title") + "</td>");
                            out.println("<td>" + resultSet.getString("Genre") + "</td>");
                            out.println("<td>" + resultSet.getString("MTRCB_Rating") + "</td>");
                            out.println("<td>" + resultSet.getInt("Room_Number") + "</td>");
                            out.println("<td>" + resultSet.getString("Start_Time") + "</td>");
                            out.println("<td>" + resultSet.getString("End_Time") + "</td>");
                            out.println("<td>Php " + resultSet.getString("Ticket_Price") + "</td>");
                            out.println("</tr>");
                        } while(resultSet.next());
                        out.println("</table>");
                    } else{
                        out.println("<p>No showtime found with room number: " + roomNumber + "</p>");
                    }
                } catch (SQLException | ClassNotFoundException e){
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    <br><br>
    <form action="ListMovieShowtime.jsp"><input type="submit" value="Go Back"></form>
    </center>
    </body>
</html>
