package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.model.StudentTeacherAssignment;
import com.example.model.TeacherDetails;
import com.example.model.User;
import com.example.repository.StudentTeacherAssignmentRepository;
import com.example.repository.TeacherDetailsRepository;
import com.example.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public void createRootUserIfNotExists() {
        User existingRootUser = userRepository.findByUsername("root");
        if (existingRootUser == null) {
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

    public List<User> getUsersByDesignation(String designation) {
        return userRepository.findByDesignation(designation);
    }


     @Autowired
    private TeacherDetailsRepository teacherDetailsRepository;

    public void saveUser(User user, String subject, int experience) {
        userRepository.save(user);

        if ("Teacher".equalsIgnoreCase(user.getDesignation())) {
            TeacherDetails teacherDetails = new TeacherDetails();
            teacherDetails.setUsername(user.getUsername());
            teacherDetails.setSubject(subject);
            teacherDetails.setExperience(experience);

            teacherDetailsRepository.save(teacherDetails);
        }
    }
     @Autowired
    private StudentTeacherAssignmentRepository studentTeacherAssignmentRepository;

    // Other methods...

    // Method to assign teachers to a student
    public String assignTeachersToStudent(String studentUsername, List<String> teacherUsernames) {
        if (teacherUsernames.size() != 3) {
            return "Please select exactly 3 teachers.";
        }

        // Find student by username
        User student = userRepository.findByUsername(studentUsername);
        if (student == null) {
            return "Student not found!";
        }

        // Check if the selected teachers exist
        for (String teacherUsername : teacherUsernames) {
            User teacher = userRepository.findByUsername(teacherUsername);
            if (teacher == null || !"Teacher".equalsIgnoreCase(teacher.getDesignation())) {
                return "One or more selected users are not teachers.";
            }
            
            // Save each teacher assignment to the new table
            StudentTeacherAssignment assignment = new StudentTeacherAssignment();
            assignment.setStudentUsername(studentUsername);
            assignment.setTeacherUsername(teacherUsername);
            studentTeacherAssignmentRepository.save(assignment);
        }

        return "Teachers successfully assigned to student " + studentUsername;
    }
}

