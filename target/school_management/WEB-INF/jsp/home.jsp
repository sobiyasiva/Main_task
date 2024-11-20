<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Root Home</title>
    <link rel="stylesheet" href="<c:url value='/css/home.css' />">
</head>
<body>
    <h1>Welcome, Root User!</h1>
    <button id="createUserButton">Create User</button>
    <form id="viewDetailsForm" method="GET" action="<c:url value='/viewDetails' />">
        <button type="submit" id="viewDetailsButton">View Details</button>
    </form>

    <!-- Modal for Creating User -->
    <div id="createUserModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Create User</h2>
            <form id="createUserForm" method="POST" action="<c:url value='/createUser' />">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" placeholder="Enter username" required>

                <label>Designation:</label>
                <div class="radio-group">
                    <label>
                        <input type="radio" id="teacher" name="designation" value="Teacher" required>
                        Teacher
                    </label>
                    <label>
                        <input type="radio" id="student" name="designation" value="Student" required>
                        Student
                    </label>
                </div>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required>

                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" required>

                <div class="modal-buttons">
                    <button type="submit">Submit</button>
                    <button type="button" id="cancelButton">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script src="<c:url value='/js/home.js' />"></script>
</body>
</html>
