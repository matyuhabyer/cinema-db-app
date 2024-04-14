<%-- 
    Document   : DeleteEmployeeAction
--%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="cinemapackage.Employees" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Employee Action</title>
    </head>
    <body>
    <center>
        <%
            int employeeID = Integer.parseInt(request.getParameter("employeeID"));
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinema_db?zeroDateTimeBehavior=CONVERT_TO_NULL", 
                    "root", "DLSU1234!");
                    
                Employees employees = new Employees();
                
                boolean deleted = employees.deleteEmployee(connection, employeeID);
                
                if(deleted){
        %>
                    <h2>Employee Deleted Successfully</h2>
        <%
                } else{
        %>
                    <h2>Failed to Delete Employee</h2>
        <%                        
                }
                
                connection.close();
            } catch(ClassNotFoundException | SQLException e){
                %>
                <h2>Error: <%= e.getMessage() %></h2>
                <%      
            }
        %>
        <br><br>
        <form action="ManagerMenu.jsp"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
    </body>
</html>
