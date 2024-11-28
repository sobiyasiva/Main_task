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
            session.setAttribute("student", student);  
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
        List<Teacher> teachers = userService.getTeachers();
        model.addAttribute("teachers", teachers);

        return "studentDashboard"; 
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

    if (userService.getUserByEmail(email) != null) {
        model.addAttribute("errorMessage", "User with this email already exists.");
        return "home";  
    }

    if ("Teacher".equalsIgnoreCase(designation)) {
        if (staffName == null || staffName.isEmpty()) {
            model.addAttribute("errorMessage", "Staff Name is required for Teacher.");
            return "home"; 
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
            return "home"; 
        }
        Student student = new Student();
        student.setEmail(email);
        student.setPassword(password);
        student.setName(studentName);

        userService.saveStudent(student); 
        model.addAttribute("successMessage", "Student created successfully.");
    } else {
        model.addAttribute("errorMessage", "Invalid designation.");
        return "home";  
    }

    return "redirect:/home";  
}

    @GetMapping("/viewDetails")
    public String viewTeachers(Model model) {
        List<Teacher> teachers = userService.getTeachers();
        model.addAttribute("teachers", teachers);
        return "viewDetails";
    }

    @GetMapping("/viewAssignedTeachers")
public String viewAssignedTeachers(HttpSession session, Model model) {
    Object loggedInUser = session.getAttribute("teacher");
    if (loggedInUser == null) {
        loggedInUser = session.getAttribute("student");
    }

    if (loggedInUser == null) {
        model.addAttribute("error", "No valid user session found. Please log in.");
        return "redirect:/login";
    }
    if (loggedInUser instanceof Teacher) {
        Teacher teacher = (Teacher) loggedInUser;
        List<Student> assignedStudents = userService.getStudentsAssignedToTeacher(teacher.getId());
        if (assignedStudents == null || assignedStudents.isEmpty()) {
            model.addAttribute("message", "No students assigned to you.");
        } else {
            model.addAttribute("assignedTeachers", assignedStudents); 
        }

        return "viewAssignedTeachers";
    }

    if (loggedInUser instanceof Student) {
        model.addAttribute("message", "Students cannot view this page.");
        return "home"; 
    }

    
    model.addAttribute("error", "You must be logged in to view this page.");
    return "redirect:/login";
    
}
    
    
    @PostMapping("/assignTeachers")
    public String assignTeachers(
            @RequestParam List<Long> teacherIds,  
            HttpSession session, 
            Model model) {

        Student student = (Student) session.getAttribute("student");  

        if (student == null) {
            model.addAttribute("error", "Student is not logged in.");
            return "redirect:/login";
        }
        for (Long teacherId : teacherIds) {
            Teacher teacher = userService.getTeacherById(teacherId);
            if (teacher != null) {
                userService.assignTeacherToStudent(student.getId(), teacherId);
            }
        }

        model.addAttribute("success", "Teachers assigned successfully!");
        return "redirect:/studentDashboard";  
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    
    }
}
