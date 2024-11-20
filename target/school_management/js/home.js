document.addEventListener("DOMContentLoaded", () => {
    const createUserButton = document.getElementById("createUserButton");
    const modal = document.getElementById("createUserModal");
    const closeModal = document.querySelector(".close");
    const cancelButton = document.getElementById("cancelButton");
    const createUserForm = document.getElementById("createUserForm");

    // Open the modal
    createUserButton.addEventListener("click", () => {
        modal.style.display = "block";
    });

    // Close the modal on 'X' click
    closeModal.addEventListener("click", () => {
        modal.style.display = "none";
    });

    // Close the modal on cancel button click
    cancelButton.addEventListener("click", () => {
        modal.style.display = "none";
    });

    // Submit form after password confirmation validation
    createUserForm.addEventListener("submit", (event) => {
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirmPassword").value;

        if (password !== confirmPassword) {
            alert("Passwords do not match!");
            event.preventDefault(); // Prevent form submission
            return;
        }

        // Allow form submission for valid inputs
        modal.style.display = "none"; // Close modal after form submission
    });
});
