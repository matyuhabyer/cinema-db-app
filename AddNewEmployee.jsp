<%-- 
    Document   : AddNewEmployee
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Employees" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Employee</title>
    </head>
    <body>
    <center>      
        <h2>Add New Employee</h2>
        <form action ="" method="post">
            <label for="fullName">Full Name:</label><br>
            <input type="text" id="fullName" name="fullName" required><br><br>
            
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" required><br><br>
            
            <label for="fullName">Password:</label><br>
            <input type="password" id="password" name="password" required><br><br>
            
            <label for="position">Position:</label><br>
            <select id="position" name="position" required>
                <option value="Manager">Manager</option>
                <option value="Maintenance">Maintenance</option>
                <option value="Ticket Staff">Ticket Staff</option>
                <option value="Snacks Vendor">Snacks Vendor</option>
            </select><br><br>
            
            <label for="shiftStart">Shift Start Time:</label><br>
            <input type="time" id="shiftStart" name="shiftStart" required><br><br>
            
            <label for="shiftEnd">Shift End Time:</label><br>
            <input type="time" id="shiftEnd" name="shiftEnd" required><br><br>
            
            <input type="submit" value="Add Employee">
        </form><br>
        <%
            Connection connection = null;
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String position = request.getParameter("position");
            String shiftStart = request.getParameter("shiftStart");
            String shiftEnd = request.getParameter("shiftEnd");
            
            if (fullName == null || fullName.isEmpty() || email == null || email.isEmpty() ||
            password == null || password.isEmpty() || position == null || position.isEmpty() ||
            shiftStart == null || shiftStart.isEmpty() || shiftEnd == null || shiftEnd.isEmpty()) {
                out.println("<p>Please fill in all fields.</p>");
            } else{
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                    "root", "DLSU1234!");
                    
                    Employees employees = new Employees();
                    
                    boolean employeeAdded = employees.addNewEmployee(connection, password, email, fullName, shiftStart, shiftEnd, position);
                    
                    if(employeeAdded){
                        out.println("<p>New employee added successfully.</p>");
                        
                        String query = "SELECT * FROM employee WHERE full_name LIKE ?";
                        PreparedStatement preparedStatement = connection.prepareStatement(query);
                        preparedStatement.setString(1, "%" + fullName + "%");
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
                        }
                    } else{
                        out.println("<p>Failed to add new employee. Please try again.</p>");
                    }
                } catch(ClassNotFoundException | SQLException e){
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
        <br><br>
        <form action="ManagerMenu.jsp"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
    </body>
</html>
