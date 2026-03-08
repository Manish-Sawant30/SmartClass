package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "att_courses")
public class AttCourse {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "course_id")
    private Integer courseId;
    
    @Column(name = "course_name", nullable = false, unique = true, length = 100)
    private String courseName;
    
    @Column(name = "course_description", columnDefinition = "TEXT")
    private String courseDescription;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    // Constructors
    public AttCourse() {
        this.createdAt = LocalDateTime.now();
    }
    
    public AttCourse(String courseName, String courseDescription) {
        this.courseName = courseName;
        this.courseDescription = courseDescription;
        this.createdAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Integer getCourseId() {
        return courseId;
    }
    
    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }
    
    public String getCourseName() {
        return courseName;
    }
    
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }
    
    public String getCourseDescription() {
        return courseDescription;
    }
    
    public void setCourseDescription(String courseDescription) {
        this.courseDescription = courseDescription;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}