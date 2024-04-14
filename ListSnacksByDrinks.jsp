<%-- 
    Document   : ListSnacksByDrinks
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Snacks" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Snacks By Drinks</title>
    </head>
    <body>
    <center>
        <h2>List Snacks By Drinks</h2>
        <form action="" method="post">
            Select Drinks:
            <select name="drinks">
                <option value="Iced Tea">Iced Tea</option>
                <option value="Coke">Coke</option>
                <option value="Coke Zero">Coke Zero</option>
                <option value="Sprite">Sprite</option>
                <option value="Royal">Royal</option>
                <option value="Pineapple Juice">Pineapple Juice</option>
            </select>
            <input type="submit" value="List">
        </form>
        <%
            String drinks = request.getParameter("drinks");
            if(drinks == null || drinks.isEmpty()){
                out.println("<p>Please select a drink.</p>");
            } else{
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                    Snacks snacks = new Snacks();
                    ResultSet resultSet = snacks.listSnacksByDrinks(connection, drinks);
                    
                    out.println("<h3>Snacks with Drinks: " + drinks + "</h3>");
                    out.println("<table border='1'>");
                    out.println("<tr><th>Food</th><th>Food Size</th><th>Food Flavor</th><th>Food Price</th><th>Drinks</th><th>Drinks Size</th><th>Drinks Price</th></tr>");                   
                    if(resultSet.next()){
                        do{
                            out.println("<tr>");
                            out.println("<td>" + resultSet.getString("food_type") + "</td>");
                            out.println("<td>" + resultSet.getString("food_size") + "</td>");
                            out.println("<td>" + resultSet.getString("food_flavor") + "</td>");
                            out.println("<td>" + resultSet.getDouble("food_price") + "</td>");
                            out.println("<td>" + resultSet.getString("drinks") + "</td>");
                            out.println("<td>" + resultSet.getString("drinks_size") + "</td>");
                            out.println("<td>" + resultSet.getDouble("drinks_price") + "</td>");
                            out.println("</tr>");
                        } while(resultSet.next());
                        out.println("</table>");
                    } else{
                        out.println("<p>No snacks found with drinks: " + drinks + "</p>");
                    }
                } catch (SQLException | ClassNotFoundException e){
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    <br><br>
    <form action="ListSnacks.jsp"><input type="submit" value="Go Back"></form>
    </center>
    </body>
</html>
