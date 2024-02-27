<%-- 
    Document   : filtered-records
    Created on : Feb 28, 2024, 3:52:50 PM
    Author     : Shashank
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Filtered Records</title>
</head>
<body>
    <h2>Filtered Records</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Employee ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <!-- Add more table headers for other employee attributes as needed -->
            </tr>
        </thead>
        <tbody>
            <!-- Iterate over filteredEmployees and display each employee's data -->
            <c:forEach var="employee" items="${filteredEmployees}">
                <tr>
                    <td>${employee.employeeId}</td>
                    <td>${employee.firstName}</td>
                    <td>${employee.lastName}</td>
                    <!-- Add more table cells for other employee attributes as needed -->
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
