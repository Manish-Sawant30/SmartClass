package com.example.institute.repository;

import com.example.institute.model.Notice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface NoticeRepository extends JpaRepository<Notice, Long> {
    
    Optional<Notice> findByNoticeId(String noticeId);
    
    List<Notice> findByTargetType(Notice.TargetType targetType);
    
    List<Notice> findByTargetTypeAndTargetValue(Notice.TargetType targetType, String targetValue);
    
    @Query("SELECT n FROM Notice n ORDER BY n.createdAt DESC")
    List<Notice> findAllOrderByCreatedAtDesc();
    
    @Query("SELECT n FROM Notice n WHERE n.createdAt BETWEEN :startDate AND :endDate ORDER BY n.createdAt DESC")
    List<Notice> findByDateRange(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);
    
    @Query("SELECT COUNT(n) FROM Notice n WHERE n.targetType = :targetType")
    long countByTargetType(@Param("targetType") Notice.TargetType targetType);
    
    @Query("SELECT MAX(CAST(SUBSTRING(n.noticeId, 2) AS integer)) FROM Notice n WHERE n.noticeId LIKE 'N%'")
    Integer findMaxNoticeIdNumber();
}