package com.example.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.model.StudentTeacherAssignment;

@Repository
public class StudentTeacherAssignmentRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public void save(StudentTeacherAssignment assignment) {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.saveOrUpdate(assignment);
            session.getTransaction().commit();
        }
    }

    // Additional methods to retrieve assignments, if needed
}
