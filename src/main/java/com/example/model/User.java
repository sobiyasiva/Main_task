package com.example.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;


@Entity
public class User {

    @Id
    private String username;
    private String password;
    private String designation;

    @ManyToMany(mappedBy = "teachers")
    private List<User> students;

    @ManyToMany
    @JoinTable(
        name = "student_teacher", 
        joinColumns = @JoinColumn(name = "teacher_username"), 
        inverseJoinColumns = @JoinColumn(name = "student_username")
    )
    private List<User> teachers;

    // Getters and setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public List<User> getStudents() {
        return students;
    }

    public void setStudents(List<User> students) {
        this.students = students;
    }

    public List<User> getTeachers() {
        return teachers;
    }

    public void setTeachers(List<User> teachers) {
        this.teachers = teachers;
    }
}
