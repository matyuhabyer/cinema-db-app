<%-- 
    Document   : DeleteEmployee
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Employees" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Employee</title>
</head>
    <body>
        <center>        
            <h1>Delete Employee</h1>
            <form action="" method="post">
                Employee Name to Delete: <input type="text" name="employeeName">
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

                        Employees employees = new Employees();
                        String query = "SELECT * FROM employee WHERE full_name LIKE ?";
                        PreparedStatement preparedStatement = connection.prepareStatement(query);
                        preparedStatement.setString(1, "%" + employeeName + "%");
                        ResultSet resultSet = preparedStatement.executeQuery();

                        if (resultSet.next()) {
                            out.println("<h3>Employee Details:</h3>");
                            out.println("<p>Employee ID: " + resultSet.getInt("employee_id") + "</p>");
                            out.println("<p>Full Name: " + resultSet.getString("full_name") + "</p>");
                            out.println("<p>Email: " + resultSet.getString("email") + "</p>");
                            out.println("<p>Shift Start: " + resultSet.getString("shift_start_time") + "</p>");
                            out.println("<p>Shift End: " + resultSet.getString("shift_end_time") + "</p>");
                            out.println("<p>Position: " + resultSet.getString("position") + "</p>");

                            int employeeID = resultSet.getInt("employee_id");
            %>
                            <form method="post" action="DeleteEmployeeAction.jsp">
                                <input type="hidden" name="employeeID" value="<%= employeeID %>">
                                <input type="submit" value="Delete Employee">
                            </form>
            <%
                        } else {
                            out.println("<p>No employee found with the name: " + employeeName + "</p>");
                        }

                        resultSet.close();
                        preparedStatement.close();
                        connection.close();
                    } catch (SQLException e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    }
                }
            %>
            <br><br>
            <form action="ManagerMenu.jsp"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
        </center>
    </body>
</html>

