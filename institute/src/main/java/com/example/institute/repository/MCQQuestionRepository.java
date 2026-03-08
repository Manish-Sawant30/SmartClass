package com.example.institute.repository;

import com.example.institute.model.MCQQuestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public interface MCQQuestionRepository extends JpaRepository<MCQQuestion, Long> {
    
    List<MCQQuestion> findByContentId(Long contentId);
    
    List<MCQQuestion> findByCreatedBy(Long teacherId);
    
    List<MCQQuestion> findByIsFinalTest(boolean isFinalTest);
    
    @Query("SELECT q FROM MCQQuestion q WHERE q.contentId = :contentId AND q.isFinalTest = :isFinalTest")
    List<MCQQuestion> findByContentIdAndIsFinalTest(@Param("contentId") Long contentId, @Param("isFinalTest") boolean isFinalTest);
    
    @Query("SELECT COUNT(q) FROM MCQQuestion q WHERE q.contentId = :contentId")
    Long countByContentId(@Param("contentId") Long contentId);
    
    @Query("SELECT COUNT(q) FROM MCQQuestion q WHERE q.createdBy = :teacherId")
    Long countByCreatedBy(@Param("teacherId") Long teacherId);
    
    @Query("SELECT DISTINCT q.contentId FROM MCQQuestion q WHERE q.createdBy = :teacherId")
    List<Long> findDistinctContentIdsByTeacher(@Param("teacherId") Long teacherId);
    
    @Query("SELECT q FROM MCQQuestion q WHERE q.isFinalTest = true AND q.testTitle LIKE %:course%")
    List<MCQQuestion> findFinalTestsByCourse(@Param("course") String course);
    
    Optional<MCQQuestion> findByQuestionId(String questionId);
    
    @Modifying
    @Transactional
    @Query("DELETE FROM MCQQuestion q WHERE q.contentId = :contentId")
    void deleteByContentId(@Param("contentId") Long contentId);
    
    @Modifying
    @Transactional
    @Query("DELETE FROM MCQQuestion q WHERE q.createdBy = :teacherId")
    void deleteByCreatedBy(@Param("teacherId") Long teacherId);
    @Query("SELECT COUNT(q) FROM MCQQuestion q WHERE q.contentId = :contentId AND q.isFinalTest = :isFinalTest")
    Long countByContentIdAndIsFinalTest(@Param("contentId") Long contentId, @Param("isFinalTest") boolean isFinalTest);
    @Modifying
    @Transactional
    void deleteByQuestionId(String questionId);
    
    @Query("SELECT CASE WHEN COUNT(q) > 0 THEN true ELSE false END FROM MCQQuestion q WHERE q.contentId = :contentId")
    boolean existsByContentId(@Param("contentId") Long contentId);
}