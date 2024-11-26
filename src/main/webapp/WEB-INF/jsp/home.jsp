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
            transition: opacity 0.5s;
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
        document.addEventListener("DOMContentLoaded", () => {
            // Toggle additional fields based on designation
            function toggleAdditionalFields() {
                const teacherFields = document.getElementById("teacherFields");
                const studentFields = document.getElementById("studentFields");
                const designation = document.querySelector('input[name="designation"]:checked')?.value;

                if (designation === "Teacher") {
                    teacherFields.classList.remove("hidden");
                    studentFields.classList.add("hidden");
                } else if (designation === "Student") {
                    studentFields.classList.remove("hidden");
                    teacherFields.classList.add("hidden");
                }
            }

            // Add event listeners for designation radio buttons
            const designationRadios = document.querySelectorAll('input[name="designation"]');
            designationRadios.forEach(radio => {
                radio.addEventListener('change', toggleAdditionalFields);
            });

            // Modal handling
            const createUserButton = document.getElementById("createUserButton");
            const modal = document.getElementById("createUserModal");
            const closeModal = document.querySelector(".close");
            const cancelButton = document.getElementById("cancelButton");

            createUserButton.addEventListener("click", () => {
                modal.style.display = "block";
            });

            closeModal.addEventListener("click", () => {
                modal.style.display = "none";
            });

            cancelButton.addEventListener("click", () => {
                modal.style.display = "none";
            });

            // Form submission validation
            const createUserForm = document.getElementById("createUserForm");
            createUserForm.addEventListener("submit", (event) => {
                const email = document.getElementById("email").value;
                const password = document.getElementById("password").value;
                const designation = document.querySelector('input[name="designation"]:checked');
                const staffName = document.getElementById("staffName")?.value || "";
                const subject = document.getElementById("subject")?.value || "";
                const experience = document.getElementById("experience")?.value || "";
                const studentName = document.getElementById("studentName")?.value || "";

                // Email validation
                const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                if (!email || !emailRegex.test(email)) {
                    showToast("Please enter a valid email address.", "error");
                    event.preventDefault();
                    return;
                }

                // Designation selection validation
                if (!designation) {
                    showToast("Please select a designation (Teacher or Student).", "error");
                    event.preventDefault();
                    return;
                }

                // Teacher-specific validation
                if (designation.value === "Teacher") {
                    if (!staffName || /\d/.test(staffName)) {
                        showToast("Staff Name should not contain numbers.", "error");
                        event.preventDefault();
                        return;
                    }
                    if (!subject || /\d/.test(subject)) {
                        showToast("Subject should not contain numbers.", "error");
                        event.preventDefault();
                        return;
                    }
                    if (!experience || !/^\d+$/.test(experience)) {
                        showToast("Years of Experience should only contain numeric values.", "error");
                        event.preventDefault();
                        return;
                    }
                }

                // Student-specific validation
                if (designation.value === "Student") {
                    if (!studentName) {
                        showToast("Please fill out the student-related fields.", "error");
                        event.preventDefault();
                        return;
                    }
                }

                modal.style.display = "none";
                showToast("User added successfully.", "add");
            });

            // Show error or success messages passed from the controller
            const errorMessage = "${errorMessage}";
            const successMessage = "${successMessage}";

            if (errorMessage) {
                showToast(errorMessage, "error"); // Show error message with 'error' type
            }

            if (successMessage) {
                showToast(successMessage, "add"); // Show success message with 'add' type
            }
        });

        // Toast notification function
        function showToast(message, type = "default") {
            const toastContainer = document.querySelector(".toast-container");
            const toast = document.createElement("div");
            toast.className = `toast ${type}`;
            toast.textContent = message;
            toastContainer.appendChild(toast);

            setTimeout(() => toast.classList.add("show"), 100);
            setTimeout(() => {
                toast.classList.remove("show");
                setTimeout(() => toastContainer.removeChild(toast), 300);
            }, 3000);
        }

        // Logout confirmation
        function confirmLogout() {
            return confirm("Are you sure you want to log out?");
        }
    </script>
</head>
<body>
    <form id="logoutForm" method="POST" action="<c:url value='/logout' />" onsubmit="return confirmLogout();">
        <button type="submit">Logout</button>
    </form>

    <h1>Welcome!</h1>
    <button id="createUserButton">Create User</button>
    <form id="viewTeacherDetailsForm" method="GET" action="<c:url value='/viewAssignedTeachers' />">
        <!-- <input type="hidden" name="studentId" value="${student.id}" /> -->
        <button type="submit">View Assigned Details</button>
    </form>

    <div id="createUserModal" class="modal hidden">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Create User</h2>
            <form id="createUserForm" method="POST" action="<c:url value='/createUser' />">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Enter email" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required>

                <label>Designation:</label>
                <div class="radio-group">
                    <label><input type="radio" name="designation" value="Teacher" required>Teacher</label>
                    <label><input type="radio" name="designation" value="Student" required>Student</label>
                </div>

                <div id="teacherFields" class="hidden">
                    <label for="staffName">Staff Name:</label>
                    <input type="text" id="staffName" name="staffName">

                    <label for="subject">Subject:</label>
                    <input type="text" id="subject" name="subject">

                    <label for="experience">Years of Experience:</label>
                    <input type="text" id="experience" name="experience">
                </div>

                <div id="studentFields" class="hidden">
                    <label for="studentName">Student Name:</label>
                    <input type="text" id="studentName" name="studentName">
                </div>

                <div class="modal-buttons">
                    <button type="submit">Submit</button>
                    <button type="button" id="cancelButton">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <div class="toast-container"></div>
</body>
</html>
