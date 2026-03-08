package com.example.institute.repository;

import com.example.institute.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {
    
    // Find by student ID
    Student findByStudentId(String studentId);
    
    // Find by email
    Student findByEmail(String email);
    
    // Find by mobile
    Student findByMobile(String mobile);
    
    // Check if student ID exists
    boolean existsByStudentId(String studentId);
    
    // Check if email exists
    boolean existsByEmail(String email);
    
    // Check if mobile exists
    boolean existsByMobile(String mobile);
    
    // Count by status
    long countByStatus(String status);
    
    // Search students - UPDATED: removed course reference and added join with courses
    @Query("SELECT DISTINCT s FROM Student s LEFT JOIN s.courses c WHERE " +
           "LOWER(s.fullName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(s.email) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(c) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "s.mobile LIKE CONCAT('%', :searchTerm, '%') OR " +
           "s.studentId LIKE CONCAT('%', :searchTerm, '%')")
    List<Student> searchStudents(@Param("searchTerm") String searchTerm);
    
    // Find distinct courses (from the collection table)
    @Query("SELECT DISTINCT c FROM Student s JOIN s.courses c")
    List<String> findDistinctCourses();
    
    // Find max student ID
    @Query("SELECT MAX(s.studentId) FROM Student s WHERE s.studentId LIKE 'STU%'")
    String findMaxStudentId();
    
    // Find by email or student ID
    @Query("SELECT s FROM Student s WHERE s.email = :identifier OR s.studentId = :identifier")
    Optional<Student> findByEmailOrStudentId(@Param("identifier") String identifier);
}