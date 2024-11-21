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
import com.example.repository.TeacherDetailsRepository;
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
            @RequestParam(value = "subject", required = false) String subject,
            @RequestParam(value = "experience", required = false) Integer experience,
            @ModelAttribute User user,
            Model model) {

        if (!"Teacher".equalsIgnoreCase(designation) && !"Student".equalsIgnoreCase(designation)) {
            model.addAttribute("errorMessage", "Invalid designation selected.");
            return "home";
        }

        userService.saveUser(user, subject, experience != null ? experience : 0);

        return "redirect:/home";
    }

    @Autowired
    private TeacherDetailsRepository teacherDetailsRepository;

    @GetMapping("/viewDetails")
    public String viewTeacherDetails(Model model) {
        model.addAttribute("teachers", teacherDetailsRepository.findAll());
        return "viewDetails"; // Ensure this points to your JSP file
    }
@GetMapping("/viewTeachers")
public String viewTeachers(Model model) {
    List<User> teachers = userService.getUsersByDesignation("Teacher");
    model.addAttribute("teachers", teachers);
    return "viewTeachers";  // Make sure this points to your new JSP for viewing teacher details
}

    
}