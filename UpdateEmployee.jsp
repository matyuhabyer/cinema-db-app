<%-- 
    Document   : UpdateEmployee
--%>
<%@ page import="java.sql.*" %>
<%@ page import="cinemapackage.Employees" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Employee</title>
    </head>
    <body>
        <center>
        <h1>Update Employee</h1>
        <form action="UpdateEmployeeAction.jsp" method="post">
            Employee ID: <input type="text" name="employeeID" required><br><br>
            <label for="updateField">Select Field to Update:</label><br>
            <select id="updateField" name="updateField">
                <option value="email">Email</option>
                <option value="password">Password</option>
                <option value="shiftStart">Shift Start Time</option>
                <option value="shiftEnd">Shift End Time</option>
                <option value="position">Position</option>
            </select><br><br>
            New Value: <input type="text" name="newValue" required><br><br>
            <input type="submit" value="Update">
        </form>
        <br><br>
        <form action="ManagerMenu.jsp"><input type="submit" value="Go Back"></form>
    </center>
    </body>
</html>
