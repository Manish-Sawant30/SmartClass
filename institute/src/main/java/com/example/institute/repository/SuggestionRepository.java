package com.example.institute.repository;

import com.example.institute.model.Suggestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface SuggestionRepository extends JpaRepository<Suggestion, Long> {
    
    Optional<Suggestion> findBySuggestionId(String suggestionId);
    
    List<Suggestion> findByParentId(Long parentId);
    
    @Query("SELECT s FROM Suggestion s WHERE s.parent.id = :parentId ORDER BY s.createdAt DESC")
    List<Suggestion> findByParentIdOrderByCreatedAtDesc(@Param("parentId") Long parentId);
    
    List<Suggestion> findByStudentId(String studentId);
    
    List<Suggestion> findByStatus(Suggestion.SuggestionStatus status);
    
    @Query("SELECT s FROM Suggestion s ORDER BY s.createdAt DESC")
    List<Suggestion> findAllOrderByCreatedAtDesc();
    
    @Query("SELECT s FROM Suggestion s WHERE s.status = :status ORDER BY s.createdAt DESC")
    List<Suggestion> findByStatusOrderByCreatedAtDesc(@Param("status") Suggestion.SuggestionStatus status);
    
    @Query("SELECT COUNT(s) FROM Suggestion s WHERE s.status = :status")
    long countByStatus(@Param("status") Suggestion.SuggestionStatus status);
    
    @Modifying
    @Transactional
    @Query("UPDATE Suggestion s SET s.status = :status, s.adminResponse = :response, " +
           "s.respondedBy = :respondedBy, s.respondedAt = :respondedAt, s.updatedAt = :updatedAt " +
           "WHERE s.id = :id")
    int updateSuggestionResponse(@Param("id") Long id,
                                @Param("status") Suggestion.SuggestionStatus status,
                                @Param("response") String response,
                                @Param("respondedBy") String respondedBy,
                                @Param("respondedAt") LocalDateTime respondedAt,
                                @Param("updatedAt") LocalDateTime updatedAt);
    
    @Query("SELECT MAX(CAST(SUBSTRING(s.suggestionId, 4) AS integer)) FROM Suggestion s WHERE s.suggestionId LIKE 'SUG%'")
    Integer findMaxSuggestionIdNumber();
}