<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Assigned Students</title>
    <style>
body {
    margin: 0;
    padding: 0;
    font-family: 'Roboto', sans-serif;
    background: linear-gradient(to bottom right, #e3f2fd, #bbdefb);
    color: #333;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.container {
    background-color: #fff;
    box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.15);
    border-radius: 10px;
    padding: 20px;
    width: 90%;
    max-width: 800px;
    animation: fadeIn 1s ease-in-out;
}

/* Heading */
h1 {
    font-size: 2rem;
    text-align: center;
    color: black;
    margin-bottom: 20px;
    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
}

/* Table Styles */
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    border-radius: 8px;
    overflow: hidden;
}

thead {
    background: linear-gradient(135deg, #ff8a00, #e52e71);
    color: #fff;
}

thead th {
    padding: 12px;
    font-size: 1rem;
    text-align: left;
}

tbody tr {
    border-bottom: 1px solid #e0e0e0;
    transition: background-color 0.3s ease;
}

tbody tr:hover {
    background-color: #f1f1f1;
}

tbody td {
    padding: 10px;
    font-size: 0.9rem;
}

/* Button Styles */
a.back-button {
    background: linear-gradient(135deg, #ff8a00, #e52e71);
    display: inline-block;
    background-color: #1976d2;
    color: #fff;
    text-decoration: none;
    padding: 10px 20px;
    border-radius: 5px;
    font-size: 0.9rem;
    font-weight: bold;
    text-align: center;
    transition: background-color 0.3s ease, transform 0.2s ease;
    margin-left: 45%;
}

a.back-button:hover {
    /* background-color: #1565c0; */
    transform: scale(1.05);
}
.table-container {
    max-height: 400px; /* Set the maximum height of the table container */
    overflow-y: auto; /* Enable vertical scrolling */
    border: 1px solid #e0e0e0; /* Optional: Add a border around the scrollable area */
    border-radius: 8px; /* Optional: Rounded corners */
}
/* Responsive Design */
@media (max-width: 768px) {
    h1 {
        font-size: 1.8rem;
    }

    table {
        font-size: 0.9rem;
    }

    a.back-button {
        font-size: 0.8rem;
    }
}

/* Animation */
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
        <h1>Assigned Students</h1>
        <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Student Email</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="teacher" items="${assignedTeachers}">
                    <tr>
                        <td>${teacher.name}</td>
                        <td>${teacher.email}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
</div>
        <a href="<c:url value='/home' />" class="back-button">Back</a>
    </div>
</body>
</html>
