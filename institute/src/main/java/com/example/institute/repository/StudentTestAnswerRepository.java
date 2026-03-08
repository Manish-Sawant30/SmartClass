package com.example.institute.repository;

import com.example.institute.model.StudentTestAnswer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface StudentTestAnswerRepository extends JpaRepository<StudentTestAnswer, Long> {
    
    List<StudentTestAnswer> findByAttemptId(String attemptId);
    
    @Query("SELECT a FROM StudentTestAnswer a WHERE a.attemptId = :attemptId ORDER BY a.id")
    List<StudentTestAnswer> findAnswersByAttemptId(@Param("attemptId") String attemptId);
    
    @Query("SELECT COUNT(a) FROM StudentTestAnswer a WHERE a.attemptId = :attemptId AND a.isCorrect = true")
    Long countCorrectAnswers(@Param("attemptId") String attemptId);
    
    @Modifying
    @Transactional
    @Query("DELETE FROM StudentTestAnswer a WHERE a.attemptId = :attemptId")
    void deleteByAttemptId(@Param("attemptId") String attemptId);  // ADD THIS METHOD
}