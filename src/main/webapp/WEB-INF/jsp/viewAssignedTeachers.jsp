<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Assigned Students</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        h1 {
            color: #333;
            text-align: center;
            margin-top: 20px;
        }

        .container {
            width: 80%;
            max-width: 1000px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .back-button {
            width:7%;
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            text-decoration: none;
            text-align: center;
            border-radius: 4px;
        }

        .back-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Assigned Students</h1>

        <table>
            <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Student Email</th>
                    <!-- <th>Assigned Teachers</th> -->
                </tr>
            </thead>
            <tbody>
                <c:forEach var="teacher" items="${assignedTeachers}">
                    <tr>
                        <td>${teacher.name}</td>
                        <td>${teacher.email}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <a href="<c:url value='/home' />" class="back-button">Back</a>
    </div>
</body>
</html>
