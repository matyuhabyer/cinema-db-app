<%-- 
    Document   : SearchEmployee
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Employees" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Employee</title>
    </head>
    <body>
    <center>
        <h2>Search Employee</h2>
        <form action="" method="post">
            Employee Name to Search: <input type="text" name="employeeName">
            <input type="submit" value="Search">
        </form>
        <%
            String employeeName = request.getParameter("employeeName");            
            if(employeeName == null || employeeName.isEmpty()){
                out.println("<p>Please fill in all fields.</p>");
            } else{
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                        
                    String query = "SELECT * FROM employee WHERE full_name LIKE ?";
                    PreparedStatement preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setString(1, "%" + employeeName + "%");
                    ResultSet resultSet = preparedStatement.executeQuery();

                    if (resultSet.next()) {
                        out.println("<h3>Employee Details:</h3>");
                        out.println("<p>Employee ID: " + resultSet.getInt("employee_id") + "</p>");
                        out.println("<p>Full Name: " + resultSet.getString("full_name") + "</p>");
                        out.println("<p>Email: " + resultSet.getString("email") + "</p>");
                        out.println("<p>Password: " + resultSet.getString("password") + "</p>");
                        out.println("<p>Shift Start: " + resultSet.getString("shift_start_time") + "</p>");
                        out.println("<p>Shift End: " + resultSet.getString("shift_end_time") + "</p>");
                        out.println("<p>Position: " + resultSet.getString("position") + "</p>");
                    } else{
                        out.println("<p>Employee cannot be found.</p>");
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
        <form action="ManagerMenu.jsp"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
    </body>
</html>
