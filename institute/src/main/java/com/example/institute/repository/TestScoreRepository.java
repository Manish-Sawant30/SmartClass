package com.example.institute.repository;

import com.example.institute.model.TestScore;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TestScoreRepository extends JpaRepository<TestScore, Long> {
    
    // Find all scores by student ID
    List<TestScore> findByStudentId(String studentId);
    
    // Check if score exists for student and course
    boolean existsByStudentIdAndCourse(String studentId, String course);
    
    // Find scores by student ID and course
    List<TestScore> findByStudentIdAndCourseContainingIgnoreCase(String studentId, String course);
    
    // Find all unique student IDs
    @Query("SELECT DISTINCT t.studentId FROM TestScore t")
    List<String> findAllDistinctStudentIds();
    
    // Get average score for a student
    @Query("SELECT AVG(t.testScore) FROM TestScore t WHERE t.studentId = :studentId")
    Double findAverageScoreByStudentId(@Param("studentId") String studentId);
    
    // Get highest score for a student
    @Query("SELECT MAX(t.testScore) FROM TestScore t WHERE t.studentId = :studentId")
    Integer findHighestScoreByStudentId(@Param("studentId") String studentId);
    
    // Get lowest score for a student
    @Query("SELECT MIN(t.testScore) FROM TestScore t WHERE t.studentId = :studentId")
    Integer findLowestScoreByStudentId(@Param("studentId") String studentId);
    
    // Get all courses
    @Query("SELECT DISTINCT t.course FROM TestScore t")
    List<String> findAllDistinctCourses();
    
    // Search scores
    @Query("SELECT t FROM TestScore t WHERE " +
           "LOWER(t.studentId) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(t.studentName) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(t.course) LIKE LOWER(CONCAT('%', :query, '%'))")
    List<TestScore> searchScores(@Param("query") String query);
}