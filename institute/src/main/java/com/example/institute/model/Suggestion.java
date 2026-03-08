package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "suggestions")
public class Suggestion {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "suggestion_id", unique = true, nullable = false, length = 20)
    private String suggestionId;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "parent_id", nullable = false)
    private Parent parent;
    
    @Column(name = "parent_name", nullable = false, length = 100)
    private String parentName;
    
    @Column(name = "parent_email", nullable = false, length = 100)
    private String parentEmail;
    
    @Column(name = "student_id", nullable = false, length = 50)
    private String studentId;
    
    @Column(name = "student_name", nullable = false, length = 100)
    private String studentName;
    
    @Column(name = "course_name", length = 100)
    private String courseName;
    
    @Column(name = "subject", nullable = false, length = 200)
    private String subject;
    
    @Column(name = "message", nullable = false, columnDefinition = "TEXT")
    private String message;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    private SuggestionStatus status = SuggestionStatus.PENDING;
    
    @Column(name = "admin_response", columnDefinition = "TEXT")
    private String adminResponse;
    
    @Column(name = "responded_by", length = 100)
    private String respondedBy;
    
    @Column(name = "responded_at")
    private LocalDateTime respondedAt;
    
    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;
    
    public enum SuggestionStatus {
        PENDING("Pending Review"),
        READ("Read"),
        RESPONDED("Responded"),
        CLOSED("Closed");
        
        private final String displayName;
        
        SuggestionStatus(String displayName) {
            this.displayName = displayName;
        }
        
        public String getDisplayName() {
            return displayName;
        }
    }
    
    // Constructors
    public Suggestion() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getSuggestionId() { return suggestionId; }
    public void setSuggestionId(String suggestionId) { this.suggestionId = suggestionId; }
    
    public Parent getParent() { return parent; }
    public void setParent(Parent parent) { 
        this.parent = parent;
        if (parent != null) {
            this.parentName = parent.getFullName();
            this.parentEmail = parent.getEmail();
        }
    }
    
    public String getParentName() { return parentName; }
    public void setParentName(String parentName) { this.parentName = parentName; }
    
    public String getParentEmail() { return parentEmail; }
    public void setParentEmail(String parentEmail) { this.parentEmail = parentEmail; }
    
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    
    public SuggestionStatus getStatus() { return status; }
    public void setStatus(SuggestionStatus status) { 
        this.status = status;
        this.updatedAt = LocalDateTime.now();
    }
    
    public String getAdminResponse() { return adminResponse; }
    public void setAdminResponse(String adminResponse) { 
        this.adminResponse = adminResponse;
        this.updatedAt = LocalDateTime.now();
    }
    
    public String getRespondedBy() { return respondedBy; }
    public void setRespondedBy(String respondedBy) { 
        this.respondedBy = respondedBy;
        this.respondedAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    public LocalDateTime getRespondedAt() { return respondedAt; }
    public void setRespondedAt(LocalDateTime respondedAt) { this.respondedAt = respondedAt; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
    
    @Override
    public String toString() {
        return "Suggestion{" +
                "id=" + id +
                ", suggestionId='" + suggestionId + '\'' +
                ", parentName='" + parentName + '\'' +
                ", studentId='" + studentId + '\'' +
                ", subject='" + subject + '\'' +
                ", status=" + status +
                '}';
    }
}