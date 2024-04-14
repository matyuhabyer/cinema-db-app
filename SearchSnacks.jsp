<%-- 
    Document   : SearchSnacks
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Snacks" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Search Snacks</title>
</head>
<body>
    <center>
        <h2>Search Snacks</h2>
        <form action="" method="post">
            Food Snack to Search: <input type="text" name="snacksName">
            <input type="submit" value="Search">
        </form>
        <%
            String snacksName = request.getParameter("snacksName");            
            if(snacksName == null || snacksName.isEmpty()){
                out.println("<p>Please fill in all fields.</p>");
            } else{
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                        
                    String query = "SELECT * FROM snacks WHERE food_type LIKE ?";
                    PreparedStatement preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setString(1, "%" + snacksName + "%");
                    ResultSet resultSet = preparedStatement.executeQuery();

                    if (resultSet.next()) {
        %>
                        <h3>Snacks Details:</h3>
                        <table border="1">
                            <tr>
                                <th>Food Type</th>
                                <th>Food Size</th>
                                <th>Food Flavor</th>
                                <th>Food Price</th>
                                <th>Drinks</th>
                                <th>Drinks Size</th>
                                <th>Drinks Price</th>
                            </tr>
        <% 
                        do {
        %>
                            <tr>
                                <td><%= resultSet.getString("food_type") %></td>
                                <td><%= resultSet.getString("food_size") %></td>
                                <td><%= resultSet.getString("food_flavor") %></td>
                                <td><%= resultSet.getString("food_price") %></td>
                                <td><%= resultSet.getString("drinks") %></td>
                                <td><%= resultSet.getString("drinks_size") %></td>
                                <td><%= resultSet.getString("drinks_price") %></td>
                            </tr>
        <% 
                        } while(resultSet.next()); 
        %>
                        </table>
        <%
                    } else{
                        out.println("<p>Snacks cannot be found.</p>");
                    }                   
                    resultSet.close();
                    preparedStatement.close();
                    connection.close();
                } catch(SQLException | ClassNotFoundException e){
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
        <br><br>
        <form action="SnacksVendorMenu.jsp"><input type="submit" value="Go Back" style="height:30px; width:280px"></form>
    </center>
</body>
</html>