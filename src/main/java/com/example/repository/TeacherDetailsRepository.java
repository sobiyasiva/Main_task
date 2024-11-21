package com.example.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.model.TeacherDetails;

@Repository
public class TeacherDetailsRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public void save(TeacherDetails teacherDetails) {
        try (Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            session.saveOrUpdate(teacherDetails);
            session.getTransaction().commit();
        }
    }

    public List<TeacherDetails> findAll() {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM TeacherDetails";
            return session.createQuery(hql, TeacherDetails.class).list();
        }
    }

    public TeacherDetails findById(int id) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(TeacherDetails.class, id);
        }
    }
}
