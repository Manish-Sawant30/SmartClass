package com.example.institute.repository;

import com.example.institute.model.StudentCertificate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StudentCertificateRepository extends JpaRepository<StudentCertificate, Long> {
    
    Optional<StudentCertificate> findByStudentIdAndCourseName(String studentId, String courseName);
    
    List<StudentCertificate> findByStudentId(String studentId);
    
    Optional<StudentCertificate> findByCertificateId(String certificateId);
    
    @Query("SELECT c FROM StudentCertificate c WHERE c.studentId = :studentId ORDER BY c.issueDate DESC")
    List<StudentCertificate> findLatestByStudentId(@Param("studentId") String studentId);
    
    boolean existsByStudentIdAndCourseName(String studentId, String courseName);
}