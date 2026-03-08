package com.example.institute.service;

import com.example.institute.model.Student;
import com.example.institute.model.StudentCertificate;
import java.util.List;

public interface CertificateService {
    
    // Generate certificate for eligible student
    StudentCertificate generateCertificate(Student student, String courseName);
    
    // Get existing certificate or generate new one
    StudentCertificate getOrGenerateCertificate(Student student, String courseName);
    
    // Get certificate by student ID and course
    StudentCertificate getCertificate(String studentId, String courseName);
    
    // Get all certificates for a student
    List<StudentCertificate> getCertificatesByStudentId(String studentId);
    
    // Verify certificate by ID
    StudentCertificate verifyCertificate(String certificateId);
    
    // Check if certificate exists
    boolean certificateExists(String studentId, String courseName);
    
    // Generate certificate ID
    String generateCertificateId();
}