<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <style>
        body { 
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            overflow-y: auto; 
        }
        h1 {
            margin-bottom: 20px;
            color: #333;
        }
        button {
            padding: 10px 20px;
            margin: 10px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        .modal {
            display: none; 
            position: fixed;
            z-index: 1; 
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); 
        }

        .modal-content {
            background-color: #fff;
            margin: auto;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            position: relative;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .close-btn {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            position: absolute;
            top: 10px;
            right: 15px;
            cursor: pointer;
        }

        .close-btn:hover,
        .close-btn:focus {
            color: #000;
            text-decoration: none;
        }

        .hidden {
            display: none;
        }

        .teacher-list {
            margin: 20px 0;
            max-height: 200px;
            overflow-y: auto;
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

        .dropdown {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .dropdown-button {
            padding: 10px;
            font-size: 16px;
            width: 100%;
            text-align: left;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: black; 
        }

        .dropdown-list {
            display: none;
            position: absolute;
            background-color: white;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1;
            max-height: 200px;
            overflow-y: auto;
            padding: 10px; 
        }

        .dropdown-list.show {
            display: block;
        }

        .dropdown-item {
            padding: 5px;
            cursor: pointer;
            color: black; 
            display: flex;
            align-items: center;
            justify-content: flex-start; 
        }

        .dropdown-item:hover {
            background-color: #f1f1f1;
        }

        .dropdown-item input[type="checkbox"] {
            margin-right: 10px; 
            vertical-align: middle; 
        }

        .dropdown-item input[type="checkbox"]:checked {
            background-color: #4CAF50;
            border-radius: 4px;
        }

        #assign-button {
            margin-top: 60%;
            display: inline-block;
        }

        #logoutForm {
            position: fixed;
            top: 10px;
            right: 10px;
        }
    </style>
    <script>
        let selectedTeachersCount = 0;

        function toggleAssignSubjects() {
            const modal = document.getElementById("assignSubjectsModal");
            modal.style.display = (modal.style.display === "flex") ? "none" : "flex";
        }

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

        function toggleDropdown() {
            const dropdownList = document.getElementById("teacherDropdownList");
            dropdownList.classList.toggle("show");
        }

        function selectTeacher(checkbox) {
            const maxSelection = 3;

            if (checkbox.checked) {
                selectedTeachersCount++;
            } else {
                selectedTeachersCount--;
            }

            if (selectedTeachersCount > maxSelection) {
                checkbox.checked = false;
                selectedTeachersCount--;
                showToast("You can select a maximum of 3 teachers.", "error");
            }

            const selectedTeachers = [];
            const checkboxes = document.querySelectorAll(".teacher-checkbox:checked");
            checkboxes.forEach(checkbox => selectedTeachers.push(checkbox.value));

            const dropdownButton = document.getElementById("teacherDropdownButton");
            dropdownButton.textContent = selectedTeachers.length > 0 ? selectedTeachers.join(", ") : "Select Faculties";
        }

        function handleAssignSubjects(event) {
            const selectedTeachers = document.querySelectorAll(".teacher-checkbox:checked");

            if (selectedTeachers.length > 0) {
                showToast("Teachers assigned successfully!", "add");

                const form = event.target.closest("form");
                form.submit();
            } else {
                showToast("No teachers selected. Please choose teachers to assign.", "error");
            }
        }

        function confirmLogout() {
        return confirm("Are you sure you want to log out?");
    }

        // document.addEventListener('DOMContentLoaded', function() {
        //     const logoutButton = document.querySelector('#logoutForm button');
        //     logoutButton.addEventListener('click', confirmLogout);
        // });
    </script>
</head>
<body>
    <form id="logoutForm" method="POST" action="<c:url value='/logout' />" onsubmit="return confirmLogout();">
    <button type="submit">Logout</button>
</form>

    <h1>Welcome!</h1>
    <p>This is the student's dashboard.</p>

    <div>
        <button type="button" onclick="toggleAssignSubjects()">Assign Subjects</button>
        <form method="GET" action="<c:url value='/viewDetails' />">
            <button type="submit">View Details</button>
        </form>
    </div>

    <div id="assignSubjectsModal" class="modal">
        <div class="modal-content">
            <button class="close-btn" onclick="toggleAssignSubjects()">×</button>
            <h2>Assign Subjects</h2>
            <p>Select teachers to assign subjects:</p>
    
            <form method="POST" action="<c:url value='/assignTeachers' />">
                <c:if test="${not empty teachers}">
                    <div class="dropdown">
                        <button type="button" class="dropdown-button" id="teacherDropdownButton" onclick="toggleDropdown()">Select Faculties</button>
                        <div id="teacherDropdownList" class="dropdown-list">
                            <c:forEach var="teacher" items="${teachers}">
                                <div class="dropdown-item">
                                    <input type="checkbox" class="teacher-checkbox" name="teacherIds" value="${teacher.id}" onclick="selectTeacher(this)">
                                    ${teacher.name}
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            
                <button type="button" id="assign-button" onclick="handleAssignSubjects(event)">Assign</button>
            </form>
            
            <button type="button" id="cancelAssign" onclick="toggleAssignSubjects()">Cancel</button>
        </div>
    </div>

    <div class="toast-container"></div>
</body>
</html>
