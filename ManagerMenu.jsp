<%-- 
    Document   : ManagerMenu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Menu</title>
    </head>
    <body>
    <center>
        <br><br><br><br><br>
        <h1>Manager Menu</h1>
        <form action ="AddNewEmployee.jsp"> <input type="submit" value="Add New Employee" style="height:30px; width:280px"> </form>
        <form action ="UpdateEmployee.jsp"> <input type="submit" value="Update Employee" style="height:30px; width:280px"> </form>
        <form action ="DeleteEmployee.jsp"> <input type="submit" value="Delete Employee" style="height:30px; width:280px"> </form>
        <form action ="ListEmployee.jsp"> <input type="submit" value="List Employees" style="height:30px; width:280px"> </form>
        <form action ="SearchEmployee.jsp"> <input type="submit" value="Search Employee" style="height:30px; width:280px"> </form>
    <br><br>
    <form action ="index.html"> <input type="submit" value="Go Back" style="height:30px; width:280px"> </form>
    </center>
    </body>
</html>
