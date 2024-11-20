package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.model.User;
import com.example.service.UserService;

@Controller
public class HomeController {

    @Autowired
    private UserService userService;

    @GetMapping("/home")
    public String showHomePage() {
        return "home"; 
    }

    @GetMapping("/teacherDashboard")
    public String showTeacherDashboard() {
        return "teacherDashboard"; 
    }


    @GetMapping("/studentDashboard")
    public String showStudentDashboard(Model model) {
        List<User> teachers = userService.getUsersByDesignation("Teacher");
        model.addAttribute("teachers", teachers);
        return "studentDashboard"; 
    }
    @PostMapping("/createUser")
    public String createUser(
            @RequestParam("designation") String designation,
            @ModelAttribute User user,
            Model model) {
        
        if (!"Teacher".equalsIgnoreCase(designation) && !"Student".equalsIgnoreCase(designation)) {
            model.addAttribute("errorMessage", "Invalid designation selected.");
            return "home"; 
        }
    
        
        userService.saveUser(user);
    
        return "redirect:/home"; 
    }

    @GetMapping("/viewDetails")
    public String viewDetails(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "viewDetails"; 
    }
}