package com.example.institute.service;

import com.example.institute.model.Student;
import java.util.List;
import java.util.Map;
import java.util.Set;

public interface StudentService {
    
    // CRUD operations
    Student saveStudent(Student student);
    List<Student> getAllStudents();
    Student getStudentById(Long id);
    Student updateStudent(Long id, Student student);
    void deleteStudent(Long id);
    
    // Search and filter
    List<Student> searchStudents(String searchTerm);
    
    // Dashboard statistics
    Map<String, Object> getDashboardStats();
    
    // Get all student IDs
    Set<String> getAllStudentIds();
    
    // Validation methods
    boolean emailExists(String email);
    boolean mobileExists(String mobile);
    boolean studentIdExists(String studentId);
    
    // Login methods
    Student login(String identifier, String password);
    Student loginByEmail(String email, String password);
    
    // Status management methods
    Student approveStudent(Long id);
    Student rejectStudent(Long id);
    Student updateStudentStatus(Long id, String status);
    
    // ID generation
    String generateStudentId();
    
    // Course methods
    List<String> getAllCourses();
    
    // Get student by student ID
    Student getStudentByStudentId(String studentId);
}