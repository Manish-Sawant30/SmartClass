package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;


@Entity
@Table(name = "att_students")
public class AttStudent {
    
    @Id
    @Column(name = "student_id", length = 20)
    private String studentId;
    
    @Column(name = "student_name", nullable = false, length = 100)
    private String studentName;
    
    @Column(name = "parent_name", length = 100)
    private String parentName;
    
    @Column(name = "parent_email", length = 100)
    private String parentEmail;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    // Constructors
    public AttStudent() {
        this.createdAt = LocalDateTime.now();
    }
    
    public AttStudent(String studentId, String studentName, String parentName, String parentEmail) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.parentName = parentName;
        this.parentEmail = parentEmail;
        this.createdAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public String getStudentId() {
        return studentId;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getParentName() {
        return parentName;
    }
    
    public void setParentName(String parentName) {
        this.parentName = parentName;
    }
    
    public String getParentEmail() {
        return parentEmail;
    }
    
    public void setParentEmail(String parentEmail) {
        this.parentEmail = parentEmail;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}