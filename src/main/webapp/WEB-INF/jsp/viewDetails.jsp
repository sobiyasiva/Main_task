<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Teacher Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
            line-height: 1.6;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
            color: #444;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        thead {
            background-color: #4CAF50; 
            color: white;
        }

        thead th {
            padding: 10px;
            text-align: center;
            font-weight: bold;
            font-size: 1rem;
        }

        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tbody td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        tbody tr:hover {
            background-color: #f1f1f1;
            transition: background-color 0.3s;
        }

        #backButton {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #4CAF50; 
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        #backButton:hover {
            background-color: #388E3C; 
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            table {
                width: 100%;
            }

            thead th, tbody td {
                font-size: 0.9rem;
                padding: 8px;
            }

            #backButton {
                font-size: 0.9rem;
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>
    <h1>Teacher Details</h1>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Experience (Years)</th>
                <th>Name</th>
                <th>Subject</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="teacher" items="${teachers}">
                <tr>
                    <td>${teacher.id}</td>
                    <td>${teacher.email}</td>
                    <td>${teacher.experience}</td>
                    <td>${teacher.name}</td>
                    <td>${teacher.subject}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <form id="backForm" method="GET" action="<c:url value='/studentDashboard' />">
        <button type="submit" id="backButton">Back</button>
    </form>
</body>
</html>
