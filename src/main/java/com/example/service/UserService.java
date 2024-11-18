package com.example.service;

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
            rootUser.setPassword("Password");  // Set password as needed
            // rootUser.setDesignation("root");
            userRepository.save(rootUser);
        }
    }
}
