package com.example.institute.service.impl;

import com.example.institute.model.Student;
import com.example.institute.model.StudentCertificate;
import com.example.institute.model.StudentTestAttempt;
import com.example.institute.repository.StudentCertificateRepository;
import com.example.institute.repository.StudentRepository;
import com.example.institute.service.CertificateService;
import com.example.institute.service.MCQService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class CertificateServiceImpl implements CertificateService {

    @Autowired
    private StudentCertificateRepository certificateRepository;
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private MCQService mcqService;

    @Override
    public StudentCertificate generateCertificate(Student student, String courseName) {
        // Check if already exists
        if (certificateExists(student.getStudentId(), courseName)) {
            return getCertificate(student.getStudentId(), courseName);
        }
        
        // Get test statistics
        var unitTests = mcqService.getStudentUnitTests(student.getStudentId());
        var finalTest = mcqService.getStudentFinalTest(student.getStudentId());
        
        // Calculate averages for this course only
        double unitTestAvg = unitTests.stream()
            .filter(t -> courseName.equals(t.getSubjectName()))
            .mapToDouble(StudentTestAttempt::getPercentage)
            .average()
            .orElse(0.0);
        
        int totalMarks = unitTests.stream()
            .filter(t -> courseName.equals(t.getSubjectName()))
            .mapToInt(StudentTestAttempt::getScore)
            .sum() + (finalTest != null && courseName.equals(finalTest.getSubjectName()) ? finalTest.getScore() : 0);
        
        // Calculate grade
        String grade = calculateGrade(unitTestAvg, finalTest != null && courseName.equals(finalTest.getSubjectName()) ? finalTest.getPercentage() : 0);
        
        StudentCertificate certificate = new StudentCertificate();
        certificate.setCertificateId(generateCertificateId());
        certificate.setStudentId(student.getStudentId());
        certificate.setStudentName(student.getFullName());
        certificate.setCourseName(courseName);
        certificate.setIssueDate(LocalDate.now());
        certificate.setUnitTestAvg(unitTestAvg);
        certificate.setFinalTestScore(finalTest != null && courseName.equals(finalTest.getSubjectName()) ? finalTest.getScore() : 0);
        certificate.setTotalMarks(totalMarks);
        certificate.setGrade(grade);
        certificate.setCreatedAt(LocalDateTime.now());
        
        return certificateRepository.save(certificate);
    }

    @Override
    public StudentCertificate getOrGenerateCertificate(Student student, String courseName) {
        // Check if exists
        var existing = certificateRepository.findByStudentIdAndCourseName(student.getStudentId(), courseName);
        
        if (existing.isPresent()) {
            return existing.get();
        }
        
        // Generate new one
        return generateCertificate(student, courseName);
    }

    @Override
    public StudentCertificate getCertificate(String studentId, String courseName) {
        return certificateRepository.findByStudentIdAndCourseName(studentId, courseName)
            .orElse(null);
    }

    @Override
    public List<StudentCertificate> getCertificatesByStudentId(String studentId) {
        return certificateRepository.findByStudentId(studentId);
    }

    @Override
    public StudentCertificate verifyCertificate(String certificateId) {
        return certificateRepository.findByCertificateId(certificateId)
            .orElse(null);
    }

    @Override
    public boolean certificateExists(String studentId, String courseName) {
        return certificateRepository.existsByStudentIdAndCourseName(studentId, courseName);
    }

    @Override
    public String generateCertificateId() {
        return "CERT-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase() + 
               "-" + System.currentTimeMillis() % 10000;
    }
    
    private String calculateGrade(double unitAvg, double finalPercentage) {
        double overallPercentage = (unitAvg + finalPercentage) / 2;
        
        if (overallPercentage >= 90) return "A+";
        else if (overallPercentage >= 80) return "A";
        else if (overallPercentage >= 70) return "B";
        else if (overallPercentage >= 60) return "C";
        else return "D";
    }
}