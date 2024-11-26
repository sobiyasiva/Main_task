package com.example.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.model.Teacher;

@Repository
public class TeacherRepository {
    public Teacher getTeacherById(Long teacherId) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Teacher.class, teacherId);
    }

    public List<Teacher> getTeachers() {
        Session session = sessionFactory.getCurrentSession();
        Query<Teacher> query = session.createQuery("FROM Teacher", Teacher.class);
        return query.getResultList();
    }

    @Autowired
    private SessionFactory sessionFactory;

    public void saveTeacher(Teacher teacher) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(teacher);
    }


    public List<Teacher> findAll() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Teacher", Teacher.class).getResultList();
    }

    public Teacher findByEmailAndPassword(String email, String password) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Teacher WHERE email = :email AND password = :password", Teacher.class)
                      .setParameter("email", email)
                      .setParameter("password", password)
                      .uniqueResult();
    }

    public Teacher findById(Long id) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Teacher.class, id);
    }
    public Teacher findByEmail(String email) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Teacher WHERE email = :email", Teacher.class)
                      .setParameter("email", email)
                      .uniqueResult();
    }
    
}
