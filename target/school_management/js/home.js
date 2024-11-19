document.addEventListener("DOMContentLoaded", () => {
    const createUserButton = document.getElementById("createUserButton");
    const modal = document.getElementById("createUserModal");
    const closeModal = document.querySelector(".close");
    const cancelButton = document.getElementById("cancelButton");
    const createUserForm = document.getElementById("createUserForm");
    const loginForm = document.querySelector("form[action='/login']");

    // Open modal for creating user
    createUserButton.addEventListener("click", () => {
        modal.style.display = "block";
    });

    // Close modal on clicking 'X'
    closeModal.addEventListener("click", () => {
        modal.style.display = "none";
    });

    // Close modal on clicking 'Cancel'
    cancelButton.addEventListener("click", () => {
        modal.style.display = "none";
    });

    // Handle Create User Form Submission
    createUserForm.addEventListener("submit", (event) => {
        event.preventDefault();

        // Simulate form submission (AJAX or server-side)
        const formData = new FormData(createUserForm);
        
        fetch('/createUser', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())  // Assuming the server responds with JSON
        .then(data => {
            if (data.success) { // Check if user creation was successful
                createUserForm.reset(); // Reset form fields
                modal.style.display = "none"; // Close modal
            } else {
                alert('Error creating user');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error creating user');
        });
    });

    // Handle Login Form Submission
    loginForm.addEventListener("submit", (event) => {
        event.preventDefault();

        // Simulate login form submission (AJAX or server-side)
        const formData = new FormData(loginForm);

        fetch('/login', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())  // Assuming the server responds with JSON
        .then(data => {
            if (data.success) { // Check if login was successful
                loginForm.reset(); // Reset form fields
                window.location.href = '/home'; // Redirect or load the dashboard
            } else {
                alert('Invalid login credentials');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error logging in');
        });
    });
});
