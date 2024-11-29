<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>

<style>
 body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            /* background: linear-gradient(135deg, #6a11cb, #2575fc); */
            color: black;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 75vh;
        }

        h1 {
            font-size: 2.5rem;
            text-align: center;
            margin-bottom: 20px;
            color: black;
            text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.7);
        }

        button {
            margin-bottom: 10px;
            background: linear-gradient(135deg, #ff8a00, #e52e71);
            color: #fff;
            font-size: 1rem;
            padding: 10px 20px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        button:hover {
            transform: translateY(-3px);
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.4);
        }

        #logoutForm {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 20%;
            background-color: white;
            z-index: 1000;
            /* padding: 20px; */
            border-radius: 10px;
        }

        .modal-content {
            background: #fff;
            color: #333;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.4);
            animation: slide-down 0.5s ease;
        }

        .modal-content h2 {
            font-size: 1.8rem;
            margin-bottom: 15px;
            color: black;
            text-align: center;
        }

        @keyframes slide-down {
            from {
                transform: translateY(-50%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            z-index: 2000;
        }

        .toast {
            background: #333;
            color: #fff;
            padding: 10px 15px;
            border-radius: 5px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
            opacity: 0;
            transform: translateY(-10px);
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .toast.show {
            opacity: 1;
            transform: translateY(0);
        }

        .toast.success {
            background: #28a745;
        }

        .toast.error {
            background: #dc3545;
        }

        .toast.default {
            background: #007bff;
        }

        .dropdown {
            margin: 15px 0;
        }

        .dropdown-button {
            width: 100%;
            background: #007bff;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: left;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        .dropdown-list {
    display: none;
    margin-top: 5px;
    background: #fff;
    border-radius: 5px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    padding: 10px;
    color: #333;
    max-height: 200px; /* Set a maximum height for the list */
    overflow-y: auto;  /* Enable vertical scrolling */
}

        .dropdown-list.show {
            display: block;
        }

        .dropdown-item {
            margin-bottom: 10px;
        }
/* 
        .modal-buttons {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        } */

        .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5); /* Semi-transparent black */
    z-index: 999; /* Below the modal but above other content */
    display: none;
}
.modal-buttons{
    margin-left: 25%;
}
.modal-overlay.show {
    display: block;
}
/* 
#cancelAssign{
    margin-left: 30px;
} */
</style>  
    <script>
        let selectedTeachersCount = 0;

        function toggleAssignSubjects() {
    const modal = document.getElementById("assignSubjectsModal");
    const modalOverlay = document.getElementById("modalOverlay");

    if (modal.style.display === "flex") {
        modal.style.display = "none";
        modalOverlay.classList.remove("show");
    } else {
        modal.style.display = "flex";
        modalOverlay.classList.add("show");
    }
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
    <div id="modalOverlay" class="modal-overlay hidden"></div>
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
                <div class="modal-buttons">
                <button type="button" id="assign-button" onclick="handleAssignSubjects(event)">Assign</button>
                <button type="button" id="cancelAssign" onclick="toggleAssignSubjects()">Cancel</button>
                </div>
            </form>
            
            <!-- <button type="button" id="cancelAssign" onclick="toggleAssignSubjects()">Cancel</button> -->
        </div>
    </div>

    <div class="toast-container"></div>
</body>
</html>

