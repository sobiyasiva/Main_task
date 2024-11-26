package com.example.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.model.Student;
import com.example.model.Teacher;
import com.example.repository.StudentRepository;
import com.example.repository.TeacherRepository;

@Service
public class UserService {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private TeacherRepository teacherRepository;

    @Transactional
    public Object login(String email, String password) {
        Student student = studentRepository.findByEmailAndPassword(email, password);
        if (student != null) {
            return student;
        }
        Teacher teacher = teacherRepository.findByEmailAndPassword(email, password);
        if (teacher != null) {
            return teacher;
        }

        addDefaultUsers();
        return null;
    }

    @Transactional
    private void addDefaultUsers() {
        if (studentRepository.findAll().isEmpty()) {
            Student rootStudent = new Student();
            rootStudent.setEmail("sathi@gmail.com");
            rootStudent.setPassword("see");
            saveStudent(rootStudent);
        }

        if (teacherRepository.findAll().isEmpty()) {
            Teacher rootTeacher = new Teacher();
            rootTeacher.setEmail("sobi@gmail.com");
            rootTeacher.setPassword("abc");
            saveTeacher(rootTeacher);
        }
    }

    @Transactional
    public void saveTeacher(Teacher teacher) {
        teacherRepository.saveTeacher(teacher);
    }

    @Transactional
    public void saveStudent(Student student) {
        studentRepository.saveStudent(student);
    }

    @Transactional(readOnly = true)
    public List<Student> getStudents() {
        return studentRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<Teacher> getTeachers() {
        return teacherRepository.findAll();
    }

    @Transactional
    public String assignTeacherToStudent(Long studentId, Long teacherId) {
        Student student = studentRepository.findById(studentId);
        Teacher teacher = teacherRepository.findById(teacherId);

        if (student == null || teacher == null) {
            return "Student or Teacher not found!";
        }

        if (student.getTeachers().size() >= 3) {
            return "Student cannot have more than 3 teachers.";
        }

        student.getTeachers().add(teacher);
        teacher.getStudents().add(student);

        studentRepository.saveStudent(student);
        teacherRepository.saveTeacher(teacher);

        return "Teacher assigned successfully!";
    }

    @Transactional(readOnly = true)
    public Student getStudentById(Long id) {
        return studentRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    @Transactional
    public void assignTeacherToStudent(Student student, Teacher teacher) {
        student.getTeachers().add(teacher);
        studentRepository.saveStudent(student);
    }

    @Transactional(readOnly = true)
    public Teacher getTeacherById(Long id) {
        return teacherRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public List<Teacher> getAssignedTeachersForStudent(Long studentId) {
        Student student = studentRepository.findById(studentId);
        if (student != null) {
            return new ArrayList<>(student.getTeachers()); 
        }
        return new ArrayList<>();
    }
    @Transactional(readOnly = true)
public List<Student> getStudentsAssignedToTeacher(Long teacherId) {
    Teacher teacher = teacherRepository.findById(teacherId);

    if (teacher != null) {
        return new ArrayList<>(teacher.getStudents()); 
    }
    return new ArrayList<>();
}
@Transactional(readOnly = true)
public Object getUserByEmail(String email) {
    Student student = studentRepository.findByEmail(email);
    if (student != null) {
        return student;
    }
    Teacher teacher = teacherRepository.findByEmail(email);
    if (teacher != null) {
        return teacher;
    }

    return null; 
}

    
    

}
