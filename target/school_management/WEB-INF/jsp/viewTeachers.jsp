<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Details</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
</head>
<body>
    <h1>Teacher Details</h1>
    
    <table border="1">
        <thead>
            <tr>
                <th>Username</th>
                <th>Designation</th>
                <th>Subject Specialization</th>
                <th>Years of Experience</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="teacher" items="${teachers}">
                <tr>
                    <td>${teacher.username}</td>
                    <td>${teacher.designation}</td>
                    <td>${teacher.subject}</td>
                    <td>${teacher.experience}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="<c:url value='/home' />">Back to Home</a>

    <!-- Toast Message Container -->
    <div class="toast-container"></div>

    <script src="<c:url value='/js/home.js' />"></script>
</body>
</html>
