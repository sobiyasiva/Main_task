<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Teacher Details</title>
    <link rel="stylesheet" href="<c:url value='/css/home.css' />">
</head>
<body>
    <h1>Teacher Details</h1>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Experience</th>
                <th>Subject</th>
                <th>Username</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="teacher" items="${teachers}">
                <tr>
                    <td>${teacher.id}</td>
                    <td>${teacher.experience}</td>
                    <td>${teacher.subject}</td>
                    <td>${teacher.username}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <form id="backForm" method="GET" action="<c:url value='/home' />">
        <button type="submit" id="backButton">Back</button>
    </form>
</body>
</html>
