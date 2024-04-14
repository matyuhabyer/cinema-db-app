<%-- 
    Document   : UpdateEmployeeAction
--%>
<%@ page import="java.sql.*" %>
<%@ page import="cinemapackage.Employees" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Employee Action</title>
    </head>
    <body>
    <center>
        <%
            String employeeIDString = request.getParameter("employeeID");
            String updateField = request.getParameter("updateField");
            String newValue = request.getParameter("newValue");

            if (employeeIDString == null || employeeIDString.isEmpty() || updateField == null || updateField.isEmpty() || newValue == null || newValue.isEmpty()) {
                out.println("<p>Please fill in all fields.</p>");
            } else {
                try {
                    int employeeID = Integer.parseInt(employeeIDString);
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                    Employees employees = new Employees();

                    boolean updated = false;
                    switch (updateField) {
                        case "email":
                            updated = employees.updateEmployeeEmail(connection, employeeID, newValue);
                            break;
                        case "password":
                            updated = employees.updateEmployeePassword(connection, employeeID, newValue);
                            break;
                        case "shiftStart":
                            updated = employees.updateEmployeeShiftStart(connection, employeeID, newValue);
                            break;
                        case "shiftEnd":
                            updated = employees.updateEmployeeShiftEnd(connection, employeeID, newValue);
                            break;
                        case "position":
                            updated = employees.updateEmployeePosition(connection, employeeID, newValue);
                            break;
                        default:
                            out.println("<p>Invalid update field.</p>");
                    }
                    
                    String query = "SELECT * FROM employee WHERE employee_id = ?";
                    PreparedStatement preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setInt(1, employeeID);
                    ResultSet resultSet = preparedStatement.executeQuery();
                    
                    if(resultSet.next()){
                        out.println("<h3>Employee Details:</h3>");
                        out.println("<p>Employee ID: " + resultSet.getInt("employee_id") + "</p>");
                        out.println("<p>Full Name: " + resultSet.getString("full_name") + "</p>");
                        out.println("<p>Email: " + resultSet.getString("email") + "</p>");
                        out.println("<p>Password: " + resultSet.getString("password") + "</p>");
                        out.println("<p>Shift Start: " + resultSet.getString("shift_start_time") + "</p>");
                        out.println("<p>Shift End: " + resultSet.getString("shift_end_time") + "</p>");
                        out.println("<p>Position: " + resultSet.getString("position") + "</p>");
                    } else{
                        out.println("<p>Error.</p>");
                    }
                    
                    if (updated) {
                        out.println("<p>Employee record updated successfully.</p>");
                    } else {
                        out.println("<p>Failed to update employee record. Please try again.</p>");
                    }

                    connection.close();
                } catch (NumberFormatException e) {
                    out.println("<p>Invalid employee ID.</p>");
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
        <br><br>
        <form action="ManagerMenu.jsp"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
    </body>
</html>
