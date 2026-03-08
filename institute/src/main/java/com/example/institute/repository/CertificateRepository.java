package com.example.institute.repository;

import com.example.institute.model.Certificate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CertificateRepository extends JpaRepository<Certificate, Long> {
    
    // Find certificate by student ID
    List<Certificate> findByStudentId(String studentId);
    
    // Find certificate by verification code
    Optional<Certificate> findByVerificationCode(String verificationCode);
    
    // Find certificate by certificate ID
    Optional<Certificate> findByCertificateId(String certificateId);
    
    // Check if certificate exists for student
    boolean existsByStudentId(String studentId);
    
    // Get latest certificate for student
    @Query("SELECT c FROM Certificate c WHERE c.studentId = :studentId ORDER BY c.createdAt DESC")
    List<Certificate> findLatestByStudentId(@Param("studentId") String studentId);
}