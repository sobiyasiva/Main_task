<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Root Home</title>
    <link rel="stylesheet" href="<c:url value='/css/home.css' />">
    <style>
        #logoutForm {
            position: fixed;
            top: 10px;
            right: 10px;
        }
        .toast-container {
            position: fixed;
            top: 10px;
            left: 10px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        .toast {
            margin-bottom: 10px;
            padding: 10px;
            background-color: #333;
            color: #fff;
            border-radius: 3px;
            opacity: 0;
        }
        .toast.show {
            opacity: 1;
        }
        .toast.add {
            background-color: green;
        }
        .toast.edit {
            background-color: blue;
        }
        .toast.delete {
            background-color: red;
        }
        .toast.error {
            background-color: orange;
        }
        .hidden {
            display: none;
        }
        /* Style for the teacher details table */
        .teacher-table {
            width: 100%;
            border-collapse: collapse;
        }
        .teacher-table th, .teacher-table td {
            padding: 8px 12px;
            border: 1px solid #ddd;
        }
    </style>
    <script>
        // Function to show toast messages
        function showToast(message, type = 'default') {
            const toastContainer = document.querySelector('.toast-container');
            const toast = document.createElement('div');
            toast.className = `toast ${type}`;
            toast.textContent = message;
            toastContainer.appendChild(toast);

            setTimeout(() => {
                toast.classList.add('show');
            }, 100);

            setTimeout(() => {
                toast.classList.remove('show');
                setTimeout(() => {
                    toastContainer.removeChild(toast);
                }, 300);
            }, 3000);
        }

        // Function to confirm logout
        function confirmLogout(event) {
            event.preventDefault();
            const userConfirmed = confirm("Are you sure you want to log out?");
            if (userConfirmed) {
                document.getElementById("logoutForm").submit();
            }
        }

        // Function to toggle additional fields based on designation
        function toggleAdditionalFields() {
            const teacherFields = document.getElementById("teacherFields");
            const designation = document.querySelector('input[name="designation"]:checked').value;

            if (designation === "Teacher") {
                teacherFields.classList.remove("hidden");
            } else {
                teacherFields.classList.add("hidden");
            }
        }

        // Adding event listener for the logout button and designation toggle
        document.addEventListener('DOMContentLoaded', function () {
            const logoutButton = document.querySelector('#logoutForm button');
            logoutButton.addEventListener('click', confirmLogout);

            const designationRadios = document.querySelectorAll('input[name="designation"]');
            designationRadios.forEach(radio => {
                radio.addEventListener('change', toggleAdditionalFields);
            });
        });
    </script>
</head>
<body>
    <!-- Logout Button -->
    <form id="logoutForm" method="POST" action="<c:url value='/login' />">
        <button type="submit">Logout</button>
    </form>

    <h1>Welcome, Root User!</h1>
    <button id="createUserButton">Create User</button>
    <form id="viewTeacherDetailsForm" method="GET" action="<c:url value='/viewTeachers' />">
        <button type="submit" id="viewTeacherDetailsButton">View Teacher Details</button>
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

                <!-- Additional Fields for Teachers -->
                <div id="teacherFields" class="hidden">
                    <label for="subject">Specialization Subject:</label>
                    <input type="text" id="subject" name="subject" placeholder="Enter subject specialization">

                    <label for="experience">Years of Experience:</label>
                    <input type="number" id="experience" name="experience" placeholder="Enter years of experience" min="0">
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

    <!-- Display Teacher Details Table -->
    <c:if test="${not empty teachers}">
        <table class="teacher-table">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Designation</th>
                    <th>Subject</th>
                    <th>Experience</th>
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
    </c:if>

    <div class="toast-container"></div>

    <script src="<c:url value='/js/home.js' />"></script>
</body>
</html>
