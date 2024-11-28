<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <!-- <link rel="stylesheet" href="<c:url value='/css/login.css' />"> -->
     <style>
        body {
    margin: 0;
    padding: 0;
    font-family: 'Poppins', sans-serif;
    /* background: linear-gradient(135deg, #74b9ff, #0984e3); */
   
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.container {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(15px);
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    text-align: center;
    width: 100%;
    max-width: 400px;
    animation: fadeIn 1s ease-in-out;
}

h1 {
    font-size: 2rem;
    margin-bottom: 20px;
    color: black;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

form {
    display: flex;
    flex-direction: column;
}

label {
    margin: 10px 0 5px;
    font-size: 1rem;
    color: black;
    text-align: left;
}

input {
    padding: 10px;
    margin-bottom: 20px;
    font-size: 1rem;
    border: none;
    border-radius: 5px;
    outline: none;
    background: rgba(255, 255, 255, 0.8);
    box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.2);
}

input[type="email"]:focus,
input[type="password"]:focus{ 
    outline: none;
    border: 2px solid #e52e71;
}

button {
    padding: 12px;
    font-size: 1rem;
    font-weight: bold;
    color: #ffffff;
    background: linear-gradient(135deg, #ff8a00, #e52e71);
    border: none;
    border-radius: 5px;
    cursor: pointer;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    transition: transform 0.2s, box-shadow 0.2s;
}

button:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.4);
}

.error-message {
    color: #ff7675;
    font-size: 0.9rem;
    margin-top: 10px;
    font-style: italic;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

     </style>

</head>
<body>
    <div class="container">
        <h1>Login</h1>
        <form action="<c:url value='/login' />" method="POST">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>

            <button type="submit">Login</button>
        </form>
        <p class="error-message">
            ${errorMessage}
        </p>
    </div>
</body>
</html>
