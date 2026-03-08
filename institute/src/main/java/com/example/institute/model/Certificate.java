package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "certificates")
public class Certificate {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "certificate_id", unique = true, nullable = false)
    private String certificateId;

    @Column(name = "student_id", nullable = false, length = 50)
    private String studentId;  // Match the student table column length

    @Column(name = "full_name", nullable = false)
    private String fullName;

    @Column(name = "course_name", nullable = false)
    private String courseName;

    @Column(name = "issue_date", nullable = false)
    private LocalDate issueDate;

    @Column(name = "verification_code", unique = true, nullable = false)
    private String verificationCode;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    // No-args constructor
    public Certificate() {
        this.createdAt = LocalDateTime.now();
    }

    // Constructor with parameters
    public Certificate(String studentId, String fullName, String courseName) {
        this();
        this.studentId = studentId;
        this.fullName = fullName;
        this.courseName = courseName;
        this.issueDate = LocalDate.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getCertificateId() { return certificateId; }
    public void setCertificateId(String certificateId) { this.certificateId = certificateId; }
    
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    
    public LocalDate getIssueDate() { return issueDate; }
    public void setIssueDate(LocalDate issueDate) { this.issueDate = issueDate; }
    
    public String getVerificationCode() { return verificationCode; }
    public void setVerificationCode(String verificationCode) { this.verificationCode = verificationCode; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}