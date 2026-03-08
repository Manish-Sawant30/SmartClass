package com.example.institute.dto;

import com.example.institute.model.Parent;
import java.util.List;
import java.util.stream.Collectors;

public class ParentDTO {
    private Long id;
    private String parentId;
    private String fullName;
    private String email;
    private String mobileNumber;
    private String studentId;
    private List<String> courses;
    private String password;
    private String status;
    private String rejectionReason;
    private boolean emailVerified;
    private boolean mobileVerified;
    private String createdAt;
    private String updatedAt;
    
    public ParentDTO() {}
    
    public ParentDTO(Parent parent) {
        this.id = parent.getId();
        this.parentId = parent.getParentId();
        this.fullName = parent.getFullName();
        this.email = parent.getEmail();
        this.mobileNumber = parent.getMobileNumber();
        this.studentId = parent.getStudentId();
        this.courses = parent.getCourses().stream()
            .map(course -> course.getCourseName())
            .collect(Collectors.toList());
        this.password = parent.getPassword();
        this.status = parent.getStatus().toString();
        this.rejectionReason = parent.getRejectionReason();
        this.emailVerified = parent.isEmailVerified();
        this.mobileVerified = parent.isMobileVerified();
        this.createdAt = parent.getCreatedAt().toString();
        this.updatedAt = parent.getUpdatedAt().toString();
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
    
    public List<String> getCourses() { return courses; }
    public void setCourses(List<String> courses) { this.courses = courses; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getRejectionReason() { return rejectionReason; }
    public void setRejectionReason(String rejectionReason) { this.rejectionReason = rejectionReason; }
    
    public boolean isEmailVerified() { return emailVerified; }
    public void setEmailVerified(boolean emailVerified) { this.emailVerified = emailVerified; }
    
    public boolean isMobileVerified() { return mobileVerified; }
    public void setMobileVerified(boolean mobileVerified) { this.mobileVerified = mobileVerified; }
    
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
    
    public String getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(String updatedAt) { this.updatedAt = updatedAt; }
}