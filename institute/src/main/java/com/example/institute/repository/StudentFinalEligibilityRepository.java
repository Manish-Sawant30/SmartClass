package com.example.institute.repository;

import com.example.institute.model.StudentFinalEligibility;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StudentFinalEligibilityRepository extends JpaRepository<StudentFinalEligibility, Long> {
    
    Optional<StudentFinalEligibility> findByStudentIdAndCourseName(String studentId, String courseName);
    
    List<StudentFinalEligibility> findByCourseName(String courseName);
    
    List<StudentFinalEligibility> findByIsEligibleTrue();
    
    @Query("SELECT e FROM StudentFinalEligibility e WHERE e.courseName = :courseName AND e.isEligible = true")
    List<StudentFinalEligibility> findEligibleStudentsByCourse(@Param("courseName") String courseName);
    
    @Query("SELECT e FROM StudentFinalEligibility e WHERE e.studentId = :studentId")
    List<StudentFinalEligibility> findAllByStudentId(@Param("studentId") String studentId);
    
    boolean existsByStudentIdAndCourseName(String studentId, String courseName);
}