<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Employee Profile Management Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        h1, h2 {
            text-align: center;
            color: #ccc;
        }

        form {
            
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"], select {
            width: calc(100% - 22px); 
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #4caf50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background-color:  #45a049;
        }

       
       
        .navbar {
            overflow: hidden;
            background-color: #333;
        }

        .navbar a {
            float: left;
            display: block;
            color: #f2f2f2;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
        .navbar a:active{
            background-color: #f4f4f4;
        }
    </style>
    <script>
        function checkPhoneNumber() {
            // Get the entered phone number
            var phoneNumber = document.getElementById("phn_no").value;

            // Make an AJAX request to check if the phone number exists
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "checkPhoneNumber?phonenumber=" + phoneNumber, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                       
                        var response = xhr.responseText;
                        if (response === "exists") {
                            
                            document.getElementById("phoneNumberWarning").style.display = "block";
                        } else {
                          
                            document.getElementById("phoneNumberWarning").style.display = "none";
                        }
                    }
                }
            };
            xhr.send();
        }
    </script>
</head>
<body>
<div class="navbar">
    <h2>Employee Profile Management</h2>
    <a href="list">List All Employees</a>
    <a href="new">Add New Employee</a>
    
</div>

<div align="center">
    <div class="container">
        
        <form action="${employee != null ? 'update' : 'insert'}" method="post">
            <table>
                <caption>
                </caption>
                <c:if test="${employee != null}">
                    <tr>
                        <td colspan="2">
                            <input type="hidden" name="empid" value="${employee.empid}" />
                        </td>
                    </tr>
                </c:if>

                <tr>
                    <th>First Name: </th>
                    <td>
                        <input type="text" name="firstName" size="25" value="${employee != null ? employee.firstName : ''}" />
                    </td>
                </tr>
                <tr>
                    <th>Last Name </th>
                    <td>
                        <input type="text" name="lastName" size="25" value="${employee != null ? employee.lastName : ''}" />
                    </td>
                </tr>
                <tr>
    <th>Contact Number </th>
    <td>
        <input type="text" name="phn_no" id="phn_no" pattern="[79]{1}[0-9]{9}" size="25" value="${employee != null ? employee.phn_no : ''}" onkeyup="checkPhoneNumberExists()" />
        <span id="phoneNumberExists" style="color: red;"></span>
    </td>
</tr>

                <tr>
                    <th>E-mail</th>
                    <td>
                        <input type="text" name="email" size="25" value="${employee != null ? employee.email : ''}" />
                    </td>
                </tr>
                <tr>
                    <th>Date of Birth</th>
                    <td>
                        <input type="text" name="dob" size="25" value="${employee != null ? employee.dob : ''}" />
                    </td>
                </tr>
                <tr>
                    <th>City </th>
                    <td>
                        <input type="text" name="place" size="25" value="${employee != null ? employee.place : ''}" />
                    </td>
                </tr>
                <tr>
                    <th>Designation </th>
                    <td>
                        <input type="text" name="designation" size="25" value="${employee != null ? employee.designation :''}" />
                    </td>
                </tr>
                <tr>
                    <th>Salary </th>
                    <td>
                        <input type="text" name="salary" size="25" value="${employee != null ? employee.salary : ''}"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="${employee != null ? 'Update' : 'Save'}" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
