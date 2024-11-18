package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/home")
    public String showHomePage() {
        return "home";  // Return home.jsp for root user
    }

    @GetMapping("/teacherDashboard")
    public String showTeacherDashboard() {
        return "teacherDashboard";  // Return teacherDashboard.jsp
    }

    @GetMapping("/studentDashboard")
    public String showStudentDashboard() {
        return "studentDashboard";  // Return studentDashboard.jsp
    }
}
