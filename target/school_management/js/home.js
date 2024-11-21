document.addEventListener("DOMContentLoaded", () => {
    const createUserButton = document.getElementById("createUserButton");
    const modal = document.getElementById("createUserModal");
    const closeModal = document.querySelector(".close");
    const cancelButton = document.getElementById("cancelButton");
    const createUserForm = document.getElementById("createUserForm");

    createUserButton.addEventListener("click", () => {
        modal.style.display = "block"; // Show the modal when "Create User" is clicked
    });

    closeModal.addEventListener("click", () => {
        modal.style.display = "none"; // Close the modal when the close button is clicked
    });

    cancelButton.addEventListener("click", () => {
        modal.style.display = "none"; // Close the modal when the cancel button is clicked
    });

    createUserForm.addEventListener("submit", (event) => {
        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirmPassword").value;

        // Check if username contains numbers
        if (/\d/.test(username)) {
            alert("Username should not contain numbers.");
            event.preventDefault(); // Prevent form submission
            return; // Keep the modal open
        }

        // Check if passwords match
        if (password !== confirmPassword) {
            alert("Passwords do not match!");
            event.preventDefault(); // Prevent form submission
            return; // Keep the modal open
        }

        // Close the modal if validation passes
        modal.style.display = "none";
        showToast("User added successfully.", "add");
    });
});
