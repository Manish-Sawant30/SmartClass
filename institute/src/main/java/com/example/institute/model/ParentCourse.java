package com.example.institute.model;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "parent_courses")
public class ParentCourse {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "parent_id", nullable = false)
    @JsonIgnore
    private Parent parent;
    
    @Column(name = "course_name", nullable = false)
    private String courseName;
    
    public ParentCourse() {}
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Parent getParent() { return parent; }
    public void setParent(Parent parent) { this.parent = parent; }
    
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    
    @Override
    public String toString() {
        return courseName;
    }
}