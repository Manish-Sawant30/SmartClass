package com.example.institute.repository;

import com.example.institute.model.StudentTestAttempt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public interface StudentTestAttemptRepository extends JpaRepository<StudentTestAttempt, Long> {
    
    List<StudentTestAttempt> findByStudentId(String studentId);
    
    List<StudentTestAttempt> findByStudentIdAndTestType(String studentId, String testType);
    
    List<StudentTestAttempt> findByContentId(Long contentId);
    
    List<StudentTestAttempt> findAllByOrderByCompletedAtDesc();
    
    @Query("SELECT t FROM StudentTestAttempt t WHERE t.studentId = :studentId AND t.contentId = :contentId")
    Optional<StudentTestAttempt> findByStudentAndContent(@Param("studentId") String studentId, @Param("contentId") Long contentId);
    
    @Query("SELECT t FROM StudentTestAttempt t WHERE t.studentId = :studentId AND t.testType = 'UNIT' ORDER BY t.completedAt DESC")
    List<StudentTestAttempt> findUnitTestsByStudent(@Param("studentId") String studentId);
    
    @Query("SELECT t FROM StudentTestAttempt t WHERE t.studentId = :studentId AND t.testType = 'FINAL'")
    Optional<StudentTestAttempt> findFinalTestByStudent(@Param("studentId") String studentId);
    
    @Query("SELECT AVG(t.percentage) FROM StudentTestAttempt t WHERE t.studentId = :studentId AND t.testType = 'UNIT'")
    Double findAverageUnitTestPercentage(@Param("studentId") String studentId);
    
    @Query("SELECT COUNT(t) FROM StudentTestAttempt t WHERE t.studentId = :studentId AND t.testType = 'UNIT'")
    Long countUnitTestsByStudent(@Param("studentId") String studentId);
    
    @Query("SELECT t FROM StudentTestAttempt t WHERE t.contentId IN :contentIds ORDER BY t.completedAt DESC")
    List<StudentTestAttempt> findByContentIds(@Param("contentIds") List<Long> contentIds);
    
    @Query("SELECT t FROM StudentTestAttempt t WHERE t.subjectName = :subjectName ORDER BY t.completedAt DESC")
    List<StudentTestAttempt> findBySubject(@Param("subjectName") String subjectName);
    
    boolean existsByStudentIdAndContentId(String studentId, Long contentId);
    
    Optional<StudentTestAttempt> findByAttemptId(String attemptId);
    
    @Modifying
    @Transactional
    @Query("DELETE FROM StudentTestAttempt t WHERE t.contentId = :contentId")
    void deleteByContentId(@Param("contentId") Long contentId);
}