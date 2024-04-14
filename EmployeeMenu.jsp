<%-- 
    Document   : EmployeeMenu
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Employees" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employee Menu</title>
    </head>
    <body>
    <center>
        <h1>Employee Menu</h1>
        <form method="post">
            <label for="employeeID">Employee ID:</label>
            <input type="text" id="employeeID" name="employeeID" required><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>
            <input type="submit" value="Login">
        </form>

        <% 
        String employeeIDStr = request.getParameter("employeeID");
        String password = request.getParameter("password");

        if (employeeIDStr != null && password != null) {
            try {
                int employeeID = Integer.parseInt(employeeIDStr);
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL",
                        "root", "DLSU1234!");
                Employees employees = new Employees();
                String position = employees.authenticateEmployee(connection, employeeID, password);

                if (position != null) {
                    %><br><br><%
                    out.println("Authentication successful.<br>");
                    switch (position) {
                        case "Manager":
                            %><br><br>
                            <form action ="ManagerMenu.jsp"><input type="submit" value="Manager Menu" style="height:30px; width:280px"></form><%
                            break;
                        case "Maintenance":
                            %><br><br>
                            <form action ="MaintenanceMenu.jsp"> <input type="submit" value="Maintenance Menu" style="height:30px; width:280px"></form><%
                            break;
                        case "Ticket Staff":
                            %><br><br>
                            <form action ="TicketStaffMenu.jsp"> <input type="submit" value="Ticket Staff Menu" style="height:30px; width:280px"></form><%
                            break;
                        case "Snacks Vendor":
                            %><br><br>
                            <form action ="SnacksVendorMenu.jsp"> <input type="submit" value="Snacks Vendor Menu" style="height:30px; width:280px"></form><%
                            break;
                        default:
                            out.println("Invalid position. Please try again.<br>");
                    }
                } else {
                    out.println("Authentication failed. Please try again.<br>");
                }
                connection.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        }
        %>                        
        <br><br>
        <form action="index.html"><input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
    </body>
</html>
