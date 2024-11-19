document.addEventListener("DOMContentLoaded", () => {
    const createUserButton = document.getElementById("createUserButton");
    const modal = document.getElementById("createUserModal");
    const closeModal = document.querySelector(".close");
    const cancelButton = document.getElementById("cancelButton");
    const createUserForm = document.getElementById("createUserForm");
    const loginForm = document.querySelector("form[action='/login']");

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
        event.preventDefault(); 
        
        createUserForm.reset();

        modal.style.display = "none";
    });

    loginForm.addEventListener("submit", (event) => {
        event.preventDefault(); 
        loginForm.reset();

    });

});
