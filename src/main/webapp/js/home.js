document.addEventListener("DOMContentLoaded", () => {
    const createUserButton = document.getElementById("createUserButton");
    const modal = document.getElementById("createUserModal");
    const closeModal = document.querySelector(".close");
    const cancelButton = document.getElementById("cancelButton");
    const createUserForm = document.getElementById("createUserForm");

    createUserButton.addEventListener("click", () => {
        modal.style.display = "block";
    });

    closeModal.addEventListener("click", () => {
        modal.style.display = "none";
    });

    cancelButton.addEventListener("click", () => {
        modal.style.display = "none";
    });

    createUserForm.addEventListener("submit", (event) => {
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirmPassword").value;

        if (password !== confirmPassword) {
            alert("Passwords do not match!");
            event.preventDefault(); 
            return;
        }

        modal.style.display = "none"; 
    });
});
