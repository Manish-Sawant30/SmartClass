package com.example.institute.repository;

import com.example.institute.model.Parent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ParentRepository extends JpaRepository<Parent, Long> {
    Optional<Parent> findByEmail(String email);
    Optional<Parent> findByParentId(String parentId);
    
    // CRITICAL: Make sure this method exists
    Optional<Parent> findByStudentId(String studentId);
    
    boolean existsByEmail(String email);
    boolean existsByParentId(String parentId);
    boolean existsByStudentId(String studentId);
    
    List<Parent> findByStatus(Parent.ParentStatus status);
    
    @Query("SELECT MAX(CAST(SUBSTRING(p.parentId, 2) AS integer)) FROM Parent p WHERE p.parentId LIKE 'P%'")
    Integer findMaxParentIdNumber();
    
    @Query("SELECT p FROM Parent p WHERE " +
           "LOWER(p.fullName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(p.email) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(p.studentId) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(p.parentId) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(p.mobileNumber) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Parent> searchParents(@Param("keyword") String keyword);
    
    @Query("SELECT COUNT(p) FROM Parent p WHERE p.status = :status")
    long countByStatus(@Param("status") Parent.ParentStatus status);
    
    @Modifying
    @Query("UPDATE Parent p SET p.status = :status WHERE p.id = :id")
    int updateStatus(@Param("id") Long id, @Param("status") Parent.ParentStatus status);
}