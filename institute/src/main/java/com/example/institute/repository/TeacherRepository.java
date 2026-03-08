package com.example.institute.repository;

import com.example.institute.model.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TeacherRepository extends JpaRepository<Teacher, Long> {
    
    Optional<Teacher> findByEmail(String email);
    
    Optional<Teacher> findByTeacherId(String teacherId);
    
    List<Teacher> findByStatus(Teacher.TeacherStatus status);
    
    boolean existsByEmail(String email);
    
    boolean existsByTeacherId(String teacherId);
    
    // FIXED: Better query for getting max teacher ID number
    @Query("SELECT MAX(CAST(SUBSTRING(t.teacherId, 2) AS integer)) FROM Teacher t WHERE t.teacherId LIKE 'T%'")
    Integer findMaxTeacherIdNumber();
    
    // Alternative: Get all teacher IDs ordered
    @Query("SELECT t.teacherId FROM Teacher t WHERE t.teacherId LIKE 'T%' ORDER BY CAST(SUBSTRING(t.teacherId, 2) AS integer)")
    List<String> findAllTeacherIdsOrdered();
    
    @Query("SELECT t FROM Teacher t WHERE " +
           "LOWER(t.fullName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(t.email) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(t.teacherId) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Teacher> searchTeachers(@Param("keyword") String keyword);
    
    @Query("SELECT COUNT(t) FROM Teacher t WHERE t.status = :status")
    long countByStatus(@Param("status") Teacher.TeacherStatus status);
    
    @Query("SELECT t FROM Teacher t WHERE t.email = :email AND t.password = :password")
    Optional<Teacher> findByEmailAndPassword(@Param("email") String email, @Param("password") String password);
    
    @Query("SELECT t FROM Teacher t WHERE t.teacherId = :teacherId AND t.password = :password")
    Optional<Teacher> findByTeacherIdAndPassword(@Param("teacherId") String teacherId, @Param("password") String password);
}