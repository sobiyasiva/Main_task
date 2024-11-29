<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Root Home</title>
    <!-- <link rel="stylesheet" href="<c:url value='/css/home.css' />"> -->
     <style>
        /* home.css */
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    /* background: linear-gradient(135deg, #6a11cb, #2575fc); */
    color: #fff;
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
    color:black;
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

form {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

input[type="email"],
input[type="password"],
input[type="text"] {
    padding: 10px;
    font-size: 1rem;
    border: none;
    border-radius: 5px;
    box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.2);
    width: 94%;
}

input[type="email"]:focus,
input[type="password"]:focus,
input[type="text"]:focus {
    outline: none;
    border: 2px solid #e52e71;
}

.radio-group {
    display: flex;
    gap: 15px;
}

.radio-group label {
    cursor: pointer;
    font-size: 1rem;
}

.hidden {
    display: none;
}


.modal {
    display: none; 
    position: fixed; 
    top: 50%;
    left: 50%; 
    transform: translate(-50%, -50%); 
    width: 30%; 
    height: auto;
    background-color: white;
    z-index: 1000; 
    /* padding: 20px; */
    border-radius: 10px;
}
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

.modal-overlay.show {
    display: block;
}



.modal-content {
    background: #fff;
    color: #333;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.4);
    width: 90%;
    max-width: 400px;
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
.modal-buttons{
    margin-left: 25%;
}

/* .modal-buttons {
    display: flex;
    justify-content: space-between;
    gap: 10px;
} */

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
/* #cancelButton{
    margin-left: 30%;
} */
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
                modalOverlay.classList.add("show");
            });

            closeModal.addEventListener("click", () => {
                modal.style.display = "none";
                modalOverlay.classList.remove("show");
            });

            cancelButton.addEventListener("click", () => {
                modal.style.display = "none";
                modalOverlay.classList.remove("show");
            });

            // Form submission validation
            const createUserForm = document.getElementById("createUserForm");
            createUserForm.addEventListener("submit", (event) => {
                const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();
        const designation = document.querySelector('input[name="designation"]:checked');
        const staffName = document.getElementById("staffName")?.value.trim();
        const subject = document.getElementById("subject")?.value.trim();
        const experience = document.getElementById("experience")?.value.trim();
        const studentName = document.getElementById("studentName")?.value.trim();
  // Empty field validation
  if (!email) {
            showToast("Email cannot be empty.", "error");
            event.preventDefault();
            return;
        }

        if (!password) {
            showToast("Password cannot be empty.", "error");
            event.preventDefault();
            return;
        }
        if (designation.value === "Teacher") {
            if (!staffName) {
                showToast("Staff Name cannot be empty.", "error");
                event.preventDefault();
                return;
            }
            if (!subject) {
                showToast("Subject cannot be empty.", "error");
                event.preventDefault();
                return;
            }
            if (!experience) {
                showToast("Years of Experience cannot be empty.", "error");
                event.preventDefault();
                return;
            }
        }

        if (designation.value === "Student") {
    if (!studentName) {
        showToast("Student Name cannot be empty.", "error");
        event.preventDefault();
        return;
    }
    // Check if the student name contains numbers
    const containsNumbers = /\d/.test(studentName);
    if (containsNumbers) {
        showToast("Student Name cannot contain numbers.", "error");
        event.preventDefault();
        return;
    }
}

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
                // if (designation.value === "Student") {
                //     if (!studentName) {
                //         showToast("Please fill out the student-related fields.", "error");
                //         event.preventDefault();
                //         return;
                //     }
                // }

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
    <div id="modalOverlay" class="modal-overlay hidden"></div>
    <div id="createUserModal" class="modal hidden"style="display: none;">
     
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
