<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Details</title>
    <link rel="stylesheet" href="<c:url value='/css/home.css' />">
</head>
<body>
    <h1>User Details</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Username</th>
                <th>Designation</th>
                <th>Password</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.username}</td>
                    <td>${user.designation}</td>
                    <td>${user.password}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <form id="backForm" method="GET" action="<c:url value='/home' />">
        <button type="submit" id="backButton">Back</button>
    </form>
    
  
</body>
</html>
