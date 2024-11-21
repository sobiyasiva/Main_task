package com.example.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.model.User;

@Repository
public class UserRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public User findByUsername(String username) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM User WHERE username = :username";
            return session.createQuery(hql, User.class)
                          .setParameter("username", username)
                          .uniqueResult();
        }
    }

    public void save(User user) {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.saveOrUpdate(user);
            session.getTransaction().commit();
        }
    }

    public List<User> findAllUsers() {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM User";
            return session.createQuery(hql, User.class).list();
        }
    }
    public List<User> findByDesignation(String designation) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM User WHERE designation = :designation";
            return session.createQuery(hql, User.class)
                          .setParameter("designation", designation)
                          .list();
        }
    }
    public void assignTeacherToStudent(String studentUsername, String teacherUsername) {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            String sql = "INSERT INTO student_teacher (student_username, teacher_username) VALUES (:studentUsername, :teacherUsername)";
            session.createNativeQuery(sql)
                   .setParameter("studentUsername", studentUsername)
                   .setParameter("teacherUsername", teacherUsername)
                   .executeUpdate();
            session.getTransaction().commit();
        }
    }
    
}
