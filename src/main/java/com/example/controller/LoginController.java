package com.example.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.model.Student;
import com.example.model.Teacher;
import com.example.service.UserService;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String handleLogin(
            @RequestParam String email,
            @RequestParam String password,
            Model model,
            HttpServletRequest request) {

        Object userObject = userService.login(email, password);

        if (userObject == null) {
            model.addAttribute("errorMessage", "Invalid email or password");
            return "login"; 
        }

        HttpSession session = request.getSession(true); 

        if (userObject instanceof Teacher) {
            Teacher teacher = (Teacher) userObject;
            session.setAttribute("teacher", teacher); 
            return "redirect:/home"; 
        }

        if (userObject instanceof Student) {
            Student student = (Student) userObject;
            session.setAttribute("student", student);  // Store the student in the session
            return "redirect:/studentDashboard"; 
        }

        model.addAttribute("errorMessage", "Invalid user designation");
        return "login";
    }

    @GetMapping("/home")
    public String showTeacherHomePage(HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("teacher");
        if (teacher == null) {
            return "redirect:/login"; 
        }
        model.addAttribute("teacher", teacher);
        return "home"; 
    }

    @GetMapping("/studentDashboard")
    public String showStudentDashboard(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("student");

        if (student == null) {
            return "redirect:/login"; 
        }

        model.addAttribute("student", student);
        
        // Fetch the list of teachers to display in the form
        List<Teacher> teachers = userService.getTeachers();
        model.addAttribute("teachers", teachers);

        return "studentDashboard"; // Render student dashboard
    }

    @PostMapping("/createUser")
public String createUser(
        @RequestParam String email,
        @RequestParam String password,
        @RequestParam String designation,
        @RequestParam(required = false) String staffName,
        @RequestParam(required = false) String subject,
        @RequestParam(required = false) Integer experience,
        @RequestParam(required = false) String studentName,
        Model model) {

    // Check if the email already exists in the system
    if (userService.getUserByEmail(email) != null) {
        model.addAttribute("errorMessage", "User with this email already exists.");
        return "home";  // Return error if user exists
    }

    // Handle Teacher creation
    if ("Teacher".equalsIgnoreCase(designation)) {
        if (staffName == null || staffName.isEmpty()) {
            model.addAttribute("errorMessage", "Staff Name is required for Teacher.");
            return "home"; // Ensure staff name is provided for teachers
        }
        Teacher teacher = new Teacher();
        teacher.setEmail(email);
        teacher.setPassword(password);
        teacher.setName(staffName);
        teacher.setSubject(subject);
        teacher.setExperience(experience != null ? experience : 0);

        userService.saveTeacher(teacher); 
        model.addAttribute("successMessage", "Teacher created successfully.");
    } else if ("Student".equalsIgnoreCase(designation)) {
        if (studentName == null || studentName.isEmpty()) {
            model.addAttribute("errorMessage", "Student Name is required for Student.");
            return "home"; // Ensure student name is provided for students
        }
        Student student = new Student();
        student.setEmail(email);
        student.setPassword(password);
        student.setName(studentName);

        userService.saveStudent(student); 
        model.addAttribute("successMessage", "Student created successfully.");
    } else {
        model.addAttribute("errorMessage", "Invalid designation.");
        return "home";  // Return error if designation is invalid
    }

    return "redirect:/home";  // Redirect to home page after successful creation
}

    @GetMapping("/viewDetails")
    public String viewTeachers(Model model) {
        List<Teacher> teachers = userService.getTeachers();
        model.addAttribute("teachers", teachers);
        return "viewDetails";
    }

    @GetMapping("/viewAssignedTeachers")
public String viewAssignedTeachers(HttpSession session, Model model) {
    // Retrieve the logged-in user from the session
    Object loggedInUser = session.getAttribute("teacher");
    if (loggedInUser == null) {
        loggedInUser = session.getAttribute("student");
    }

    if (loggedInUser == null) {
        model.addAttribute("error", "No valid user session found. Please log in.");
        return "redirect:/login";
    }

    // If the logged-in user is a Teacher, fetch their assigned students
    if (loggedInUser instanceof Teacher) {
        Teacher teacher = (Teacher) loggedInUser;

        // Fetch assigned students for the teacher
        List<Student> assignedStudents = userService.getStudentsAssignedToTeacher(teacher.getId());
        if (assignedStudents == null || assignedStudents.isEmpty()) {
            model.addAttribute("message", "No students assigned to you.");
        } else {
            model.addAttribute("assignedTeachers", assignedStudents); // Match JSP variable
        }

        return "viewAssignedTeachers";
    }

    // If the logged-in user is a Student, prevent them from viewing this page
    if (loggedInUser instanceof Student) {
        model.addAttribute("message", "Students cannot view this page.");
        return "home"; // Redirect to a student-appropriate page
    }

    // If no valid user is logged in, redirect to the login page
    model.addAttribute("error", "You must be logged in to view this page.");
    return "redirect:/login";
    
}
    
    // Modified assignTeachers (Retrieve studentId from session)
    @PostMapping("/assignTeachers")
    public String assignTeachers(
            @RequestParam List<Long> teacherIds,  // List of teacherIds passed from checkboxes
            HttpSession session, // Get session information
            Model model) {

        Student student = (Student) session.getAttribute("student");  // Get student from session

        if (student == null) {
            model.addAttribute("error", "Student is not logged in.");
            return "redirect:/login";
        }

        // Assign each teacher to the student
        for (Long teacherId : teacherIds) {
            Teacher teacher = userService.getTeacherById(teacherId);
            if (teacher != null) {
                userService.assignTeacherToStudent(student.getId(), teacherId);
            }
        }

        model.addAttribute("success", "Teachers assigned successfully!");
        return "redirect:/studentDashboard";  // Redirect after assignment
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        // Invalidate the session to log the user out
        session.invalidate();
        // Redirect to the login page or home page
        return "redirect:/login";
    
    }
}
