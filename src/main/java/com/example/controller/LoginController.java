package com.example.controller;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.model.User;
import com.example.repository.UserRepository;
import com.example.service.UserService;

@Controller
public class LoginController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    @PostConstruct
    public void init() {
        userService.createRootUserIfNotExists();
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";  // Return login.jsp
    }

    @PostMapping("/login")
    public String handleLogin(String username, String password, Model model, HttpServletRequest request) {
        User user = userRepository.findByUsername(username);

        if (user == null || !user.getPassword().equals(password)) {
            model.addAttribute("errorMessage", "Invalid username or password");
            return "login";  // Return to login page if credentials are invalid
        }

        // Set user in session after successful login
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        // Redirect based on the user's designation
        if ("root".equalsIgnoreCase(user.getDesignation())) {
            return "redirect:/home";  // Root user's home page
        } else if ("teacher".equalsIgnoreCase(user.getDesignation())) {
            return "redirect:/teacherDashboard";  // Teacher's dashboard
        } else if ("student".equalsIgnoreCase(user.getDesignation())) {
            return "redirect:/studentDashboard";  // Student's dashboard
        }

        model.addAttribute("errorMessage", "Invalid user designation");
        return "login";  // If no designation matches, return to login page
    }
}
