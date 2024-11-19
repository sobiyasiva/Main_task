package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.model.User;
import com.example.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public void createRootUserIfNotExists() {
        User existingRootUser = userRepository.findByUsername("root");
        if (existingRootUser == null) {
            // Create and save root user if it doesn't exist
            User rootUser = new User();
            rootUser.setUsername("root");
            rootUser.setPassword("Password"); 
            rootUser.setDesignation("root");
            userRepository.save(rootUser);
        }
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }

    public List<User> getAllUsers() {
        return userRepository.findAllUsers(); 
    }
}
