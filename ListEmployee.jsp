<%-- 
    Document   : ListEmployee
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Employees" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Employees</title>
    </head>
    <body>
    <center>
        <h2>List Employees</h2>
        <form action="" method="post">
            Select Position:
            <select name="position">
                <option value="Manager">Manager</option>
                <option value="Maintenance">Maintenance</option>
                <option value="Ticket Staff">Ticket Staff</option>
                <option value="Snacks Vendor">Snacks Vendor</option>
            </select>
            <input type="submit" value="List">
        </form>
        <%
            String position = request.getParameter("position");
            if(position == null || position.isEmpty()){
                out.println("<p>Please select a position.</p>");
            } else{
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                        "root", "DLSU1234!");
                    Employees employees = new Employees();
                    ResultSet resultSet = employees.listEmployees(connection, position);
                    
                    out.println("<h3>Employees with Position: " + position + "</h3>");
                    out.println("<table border='1'>");
                    out.println("<tr><th>Employee ID</th><th>Full Name</th><th>Email</th><th>Shift Start</th><th>Shift End</th></tr>");                   
                    if(resultSet.next()){
                        do{
                            out.println("<tr>");
                            out.println("<td>" + resultSet.getInt("employee_id") + "</td>");
                            out.println("<td>" + resultSet.getString("full_name") + "</td>");
                            out.println("<td>" + resultSet.getString("email") + "</td>");
                            out.println("<td>" + resultSet.getString("shift_start_time") + "</td>");
                            out.println("<td>" + resultSet.getString("shift_end_time") + "</td>");
                            out.println("</tr>");
                        } while(resultSet.next());
                        out.println("</table>");
                    } else{
                        out.println("<p>No employees found with position: " + position + "</p>");
                    }
                } catch (SQLException | ClassNotFoundException e){
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    <br><br>
    <form action="ManagerMenu.jsp"><input type="submit" value="Go Back"></form>
    </center>
    </body>
</html>
