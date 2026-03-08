package com.example.institute.repository;

import com.example.institute.model.EducationalContent;
import com.example.institute.model.ContentCategory;
import com.example.institute.model.ContentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface EducationalContentRepository extends JpaRepository<EducationalContent, Long> {
    
    List<EducationalContent> findBySubjectName(String subjectName);
    
    List<EducationalContent> findByContentCategory(ContentCategory contentCategory);
    
    // CORRECT METHOD - uses teacher.id
    @Query("SELECT ec FROM EducationalContent ec WHERE ec.teacher.id = :teacherId")
    List<EducationalContent> findByTeacherId(@Param("teacherId") Long teacherId);
    
    List<EducationalContent> findBySubjectNameAndContentCategory(String subjectName, ContentCategory contentCategory);
    
    @Query("SELECT DISTINCT ec.subjectName FROM EducationalContent ec WHERE ec.contentStatus = 'PUBLISHED'")
    List<String> findDistinctSubjectNames();
    
    @Query("SELECT ec FROM EducationalContent ec WHERE ec.contentStatus = 'PUBLISHED' ORDER BY ec.publishedDate DESC")
    List<EducationalContent> findAllPublished();
    
    @Query("SELECT ec FROM EducationalContent ec WHERE ec.contentStatus = 'PUBLISHED' AND " +
           "(LOWER(ec.contentTitle) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(ec.contentDescription) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(ec.subjectName) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    List<EducationalContent> searchPublishedContent(@Param("keyword") String keyword);
    
    @Query("SELECT COUNT(ec) FROM EducationalContent ec WHERE ec.contentCategory = 'DOCUMENT' AND ec.contentStatus = 'PUBLISHED'")
    Long countPublishedDocuments();
    
    @Query("SELECT COUNT(ec) FROM EducationalContent ec WHERE ec.contentCategory = 'MEDIA' AND ec.contentStatus = 'PUBLISHED'")
    Long countPublishedMedia();
    
    @Query("SELECT SUM(ec.retrievalCount) FROM EducationalContent ec WHERE ec.contentStatus = 'PUBLISHED'")
    Long totalRetrievals();
    
    @Query("SELECT SUM(ec.engagementCount) FROM EducationalContent ec WHERE ec.contentStatus = 'PUBLISHED'")
    Long totalEngagements();
    
    @Query("SELECT ec FROM EducationalContent ec WHERE ec.subjectName = :subjectName AND ec.contentStatus = 'PUBLISHED' ORDER BY ec.publishedDate DESC")
    List<EducationalContent> findBySubjectNameAndContentStatus(@Param("subjectName") String subjectName);
    
    @Query("SELECT ec FROM EducationalContent ec WHERE ec.contentStatus = 'PUBLISHED' AND " +
           "ec.publishedDate >= :sevenDaysAgo ORDER BY ec.publishedDate DESC")
    List<EducationalContent> findRecentContent(@Param("sevenDaysAgo") LocalDateTime sevenDaysAgo);
}