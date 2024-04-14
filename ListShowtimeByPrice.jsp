<%-- 
    Document   : ListShowtimeByPrice
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Showtime" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Showtime By Ticket Price</title>
    </head>
    <body>
    <center>
        <h1>List Showtime By Ticket Price</h1>
        <form action="" method="post">
            Input a Price: <input type="text" name="price">
            <input type="submit" value="List">
        </form>
        <%
            String priceStr = request.getParameter("price");
            if(priceStr == null || priceStr.isEmpty()){
                out.println("<p>Please input a price.</p>");
            } else{
                try{
                    double price = Double.parseDouble(priceStr);
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                    Showtime showtime = new Showtime();
                    ResultSet resultSet = showtime.listShowtimeByPrice(connection, price);
                    
                    out.println("<h3>Closest Showtime with Price: " + price + "</h3>");
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
                        out.println("<p>No showtime found with price: " + price + "</p>");
                    }
                } catch (SQLException | ClassNotFoundException | NumberFormatException e){
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    <br><br>
    <form action="ListMovieShowtime.jsp"><input type="submit" value="Go Back"></form>
    </center>
    </body>
</html>