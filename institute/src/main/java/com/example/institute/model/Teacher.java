package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "teachers")
public class Teacher {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "teacher_id", unique = true, nullable = false)
    private String teacherId;
    
    @Column(name = "full_name", nullable = false)
    private String fullName;
    
    @Column(name = "email", unique = true, nullable = false)
    private String email;
    
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "teacher_specializations",
        joinColumns = @JoinColumn(name = "teacher_id"),
        inverseJoinColumns = @JoinColumn(name = "specialization_id")
    )
    private List<Specialization> specializations = new ArrayList<>();
    
    @Column(name = "password", nullable = false)
    private String password;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private TeacherStatus status = TeacherStatus.PENDING;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt = LocalDateTime.now();
    
    public enum TeacherStatus {
        PENDING, ACTIVE, REJECTED, INACTIVE
    }
    
    public Teacher() {}
    
    public Teacher(String fullName, String email, String password) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
    }
    
    // Getters and Setters
    public Long getId() { 
        return id; 
    }
    
    public void setId(Long id) { 
        this.id = id; 
    }
    
    public String getTeacherId() { 
        return teacherId; 
    }
    
    public void setTeacherId(String teacherId) { 
        this.teacherId = teacherId; 
    }
    
    public String getFullName() { 
        return fullName; 
    }
    
    public void setFullName(String fullName) { 
        this.fullName = fullName; 
    }
    
    public String getEmail() { 
        return email; 
    }
    
    public void setEmail(String email) { 
        this.email = email; 
    }
    
    public List<Specialization> getSpecializations() { 
        return specializations; 
    }
    
    public void setSpecializations(List<Specialization> specializations) { 
        this.specializations = specializations; 
    }
    
    public String getPassword() { 
        return password; 
    }
    
    public void setPassword(String password) { 
        this.password = password; 
    }
    
    public TeacherStatus getStatus() { 
        return status; 
    }
    
    public void setStatus(TeacherStatus status) { 
        this.status = status; 
    }
    
    public LocalDateTime getCreatedAt() { 
        return createdAt; 
    }
    
    public void setCreatedAt(LocalDateTime createdAt) { 
        this.createdAt = createdAt; 
    }
    
    public LocalDateTime getUpdatedAt() { 
        return updatedAt; 
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) { 
        this.updatedAt = updatedAt; 
    }
    
    // Helper method to get specialization names as string
    public String getSpecializationNames() {
        if (specializations == null || specializations.isEmpty()) {
            return "N/A";
        }
        return specializations.stream()
                .map(Specialization::getName)
                .reduce((a, b) -> a + ", " + b)
                .orElse("N/A");
    }
    
    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
    
    @Override
    public String toString() {
        return "Teacher{" +
                "id=" + id +
                ", teacherId='" + teacherId + '\'' +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", specializations=" + (specializations != null ? specializations.size() : 0) +
                ", status=" + status +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}