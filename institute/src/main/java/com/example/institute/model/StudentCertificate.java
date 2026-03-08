package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "student_certificates")
public class StudentCertificate {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "certificate_id", unique = true, nullable = false, length = 50)
    private String certificateId;
    
    @Column(name = "student_id", nullable = false, length = 50)
    private String studentId;
    
    @Column(name = "student_name", nullable = false, length = 100)
    private String studentName;
    
    @Column(name = "course_name", nullable = false, length = 100)
    private String courseName;
    
    @Column(name = "issue_date", nullable = false)
    private LocalDate issueDate;
    
    @Column(name = "unit_test_avg")
    private Double unitTestAvg;
    
    @Column(name = "final_test_score")
    private Integer finalTestScore;
    
    @Column(name = "total_marks")
    private Integer totalMarks;
    
    @Column(name = "grade", length = 2)
    private String grade;
    
    @Column(name = "pdf_path", length = 500)
    private String pdfPath;
    
    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;
    
    // Constructors
    public StudentCertificate() {
        this.createdAt = LocalDateTime.now();
        this.issueDate = LocalDate.now();
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getCertificateId() { return certificateId; }
    public void setCertificateId(String certificateId) { this.certificateId = certificateId; }
    
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    
    public LocalDate getIssueDate() { return issueDate; }
    public void setIssueDate(LocalDate issueDate) { this.issueDate = issueDate; }
    
    public Double getUnitTestAvg() { return unitTestAvg; }
    public void setUnitTestAvg(Double unitTestAvg) { this.unitTestAvg = unitTestAvg; }
    
    public Integer getFinalTestScore() { return finalTestScore; }
    public void setFinalTestScore(Integer finalTestScore) { this.finalTestScore = finalTestScore; }
    
    public Integer getTotalMarks() { return totalMarks; }
    public void setTotalMarks(Integer totalMarks) { this.totalMarks = totalMarks; }
    
    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }
    
    public String getPdfPath() { return pdfPath; }
    public void setPdfPath(String pdfPath) { this.pdfPath = pdfPath; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}