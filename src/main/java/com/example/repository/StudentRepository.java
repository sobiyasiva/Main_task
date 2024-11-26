package com.example.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.model.Student;

@Repository
public class StudentRepository {

    @Autowired
    private SessionFactory sessionFactory;
    public Student getStudentById(Long studentId) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Student.class, studentId);
    }

    public void save(Student student) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(student);
    }

    public List<Student> getAllStudents() {
        Session session = sessionFactory.getCurrentSession();
        Query<Student> query = session.createQuery("FROM Student", Student.class);
        return query.getResultList();
    }


    public void saveStudent(Student student) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(student);
    }


    public List<Student> findAll() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Student", Student.class).getResultList();
    }

    public Student findByEmailAndPassword(String email, String password) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Student WHERE email = :email AND password = :password", Student.class)
                      .setParameter("email", email)
                      .setParameter("password", password)
                      .uniqueResult();
    }
    public Student findById(Long id) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Student.class, id);
    }
    public boolean assignTeacherToStudent(Long studentId, Long teacherId) {
        Session session = sessionFactory.getCurrentSession();
        try {
            System.out.println("Executing SQL to insert into student_teachers table...");
            session.createQuery("INSERT INTO student_teachers (student_id, teacher_id) VALUES (:studentId, :teacherId)")
                   .setParameter("studentId", studentId)
                   .setParameter("teacherId", teacherId)
                   .executeUpdate();
            System.out.println("Insert successful.");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
     
    public Student findByEmail(String email) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Student WHERE email = :email", Student.class)
                      .setParameter("email", email)
                      .uniqueResult();
    }
    
    
}
