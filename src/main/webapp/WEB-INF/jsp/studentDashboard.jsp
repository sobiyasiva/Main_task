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
            overflow: auto; 
            padding-top: 50px;
        }

        .modal-content {
            background-color: #fff;
            margin: 6% auto;
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

    </style>
    <script>
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

        function handleAssignSubjects(event) {
            event.preventDefault(); 
          
            const selectedTeachers = document.querySelectorAll('input[name="selectedTeachers"]:checked');

            if (selectedTeachers.length > 0) {
                showToast("Teachers assigned successfully!", "add");
                toggleAssignSubjects(); 
            } else {
                showToast("No teachers selected. Please choose teachers to assign.", "error");
            }
        }

    </script>
</head>
<body>
    <h1>Welcome, Student!</h1>
    <p>This is the student's dashboard.</p>

    <div>
        <button type="button" onclick="toggleAssignSubjects()">Assign Subjects</button>
        <form method="GET" action="<c:url value='/viewDetails' />">
            <button type="submit">View Details</button>
        </form>
    </div>

    <!-- Assign Subjects Modal -->
    <div id="assignSubjectsModal" class="modal">
        <div class="modal-content">
            <button class="close-btn" onclick="toggleAssignSubjects()">×</button>
            <h2>Assign Subjects</h2>
            <p>Select teachers to assign subjects:</p>
            
            <form method="POST" onsubmit="handleAssignSubjects(event)">
                <div class="teacher-list">
                    <c:forEach var="teacher" items="${teachers}">
                        <div>
                            <input type="checkbox" id="${teacher.username}" name="selectedTeachers" value="${teacher.username}">
                            <label for="${teacher.username}">${teacher.username}</label>
                        </div>
                    </c:forEach>
                </div>
                <button type="submit">Assign</button>
            </form>
            
            <button type="button" onclick="toggleAssignSubjects()">Cancel</button>
        </div>
    </div>

    <div class="toast-container"></div>
    <form id="backForm" method="GET" action="<c:url value='/home' />">
        <button type="submit" id="backButton">Back</button>
    </form>
</body>
</html>
