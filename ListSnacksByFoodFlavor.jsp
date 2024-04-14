<%-- 
    Document   : ListSnacksByFoodFlavor
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Snacks" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Snacks By Food Flavor</title>
    </head>
    <body>
    <center>
        <h2>List Snacks By Food Flavor</h2>
        <form action="" method="post">
            Select Food Flavor:
            <select name="foodFlavor">
                <option value="BBQ">BBQ</option>
                <option value="Cheese">Cheese</option>
                <option value="Sour Cream">Sour Cream</option>
            </select>
            <input type="submit" value="List">
        </form>
        <%
            String foodFlavor = request.getParameter("foodFlavor");
            if(foodFlavor == null || foodFlavor.isEmpty()){
                out.println("<p>Please select a food flavor.</p>");
            } else{
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                    Snacks snacks = new Snacks();
                    ResultSet resultSet = snacks.listSnacksByFoodFlavor(connection, foodFlavor);
                    
                    out.println("<h3>Snacks with Food Flavor: " + foodFlavor + "</h3>");
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
                        out.println("<p>No snacks found with food flavor: " + foodFlavor + "</p>");
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
