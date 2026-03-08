package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Table(name = "parents")
public class Parent {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "parent_id", unique = true, nullable = false, length = 20)
    private String parentId;
    
    @Column(name = "full_name", nullable = false, length = 100)
    private String fullName;
    
    @Column(name = "email", unique = true, nullable = false, length = 100)
    private String email;
    
    @Column(name = "mobile_number", nullable = false, length = 20)
    private String mobileNumber;
    
    @Column(name = "student_id", nullable = false, length = 50)
    private String studentId;
    
    @Column(name = "password", nullable = false, length = 255)
    private String password;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "status", length = 20)
    private ParentStatus status = ParentStatus.PENDING;
    
    @Column(name = "email_verified")
    private boolean emailVerified = false;
    
    @Column(name = "mobile_verified")
    private boolean mobileVerified = false;
    
    @Column(name = "rejection_reason", columnDefinition = "TEXT")
    private String rejectionReason;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt = LocalDateTime.now();
    
    // FIXED: Changed from orphanRemoval = true to CascadeType.MERGE and removed orphanRemoval
    @OneToMany(mappedBy = "parent", cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.LAZY)
    private List<ParentCourse> courses = new ArrayList<>();
    
    public enum ParentStatus {
        PENDING,
        APPROVED,
        REJECTED,
        ACTIVE,
        INACTIVE
    }
    
    public Parent() {
        this.status = ParentStatus.PENDING;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getParentId() { return parentId; }
    public void setParentId(String parentId) { this.parentId = parentId; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }
    
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public ParentStatus getStatus() { return status; }
    public void setStatus(ParentStatus status) { 
        this.status = status; 
        this.updatedAt = LocalDateTime.now();
    }
    
    public boolean isEmailVerified() { return emailVerified; }
    public void setEmailVerified(boolean emailVerified) { this.emailVerified = emailVerified; }
    
    public boolean isMobileVerified() { return mobileVerified; }
    public void setMobileVerified(boolean mobileVerified) { this.mobileVerified = mobileVerified; }
    
    public String getRejectionReason() { return rejectionReason; }
    public void setRejectionReason(String rejectionReason) { 
        this.rejectionReason = rejectionReason; 
        this.updatedAt = LocalDateTime.now();
    }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public List<ParentCourse> getCourses() { return courses; }
    public void setCourses(List<ParentCourse> courses) { this.courses = courses; }
    
    // Helper method to get course names
    public List<String> getCourseNames() {
        if (courses == null || courses.isEmpty()) {
            return new ArrayList<>();
        }
        return courses.stream()
                .map(ParentCourse::getCourseName)
                .collect(Collectors.toList());
    }
    
    public void addCourse(String courseName) {
        ParentCourse course = new ParentCourse();
        course.setCourseName(courseName);
        course.setParent(this);
        this.courses.add(course);
    }
    
    public void removeCourse(ParentCourse course) {
        this.courses.remove(course);
        course.setParent(null);
    }
    
    public boolean canLogin() {
        return this.status == ParentStatus.APPROVED || 
               this.status == ParentStatus.ACTIVE;
    }
    
    public String getStatusMessage() {
        switch (this.status) {
            case PENDING: return "Your account is pending approval";
            case APPROVED: return "Your account is approved";
            case REJECTED: return "Your account is rejected";
            case ACTIVE: return "Your account is active";
            case INACTIVE: return "Your account is inactive";
            default: return "Unknown status";
        }
    }
    
    @Override
    public String toString() {
        return "Parent{" +
                "id=" + id +
                ", parentId='" + parentId + '\'' +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", status=" + status +
                '}';
    }
}