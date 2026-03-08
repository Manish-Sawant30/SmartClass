package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "student_final_eligibility")
public class StudentFinalEligibility {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "student_id", nullable = false, length = 50)
    private String studentId;
    
    @Column(name = "student_name", nullable = false, length = 100)
    private String studentName;
    
    @Column(name = "course_name", nullable = false, length = 100)
    private String courseName;
    
    @Column(name = "is_eligible")
    private boolean isEligible = false;
    
    @Column(name = "unit_test_avg")
    private Double unitTestAvg;
    
    @Column(name = "unit_tests_taken")
    private Integer unitTestsTaken = 0;
    
    @Column(name = "final_test_attempted")
    private boolean finalTestAttempted = false;
    
    @Column(name = "final_test_id", length = 20)
    private String finalTestId;
    
    @Column(name = "final_test_score")
    private Integer finalTestScore;
    
    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;
    
    // Constructors
    public StudentFinalEligibility() {
        this.updatedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    
    public boolean isEligible() { return isEligible; }
    public void setEligible(boolean eligible) { isEligible = eligible; }
    
    public Double getUnitTestAvg() { return unitTestAvg; }
    public void setUnitTestAvg(Double unitTestAvg) { this.unitTestAvg = unitTestAvg; }
    
    public Integer getUnitTestsTaken() { return unitTestsTaken; }
    public void setUnitTestsTaken(Integer unitTestsTaken) { this.unitTestsTaken = unitTestsTaken; }
    
    public boolean isFinalTestAttempted() { return finalTestAttempted; }
    public void setFinalTestAttempted(boolean finalTestAttempted) { this.finalTestAttempted = finalTestAttempted; }
    
    public String getFinalTestId() { return finalTestId; }
    public void setFinalTestId(String finalTestId) { this.finalTestId = finalTestId; }
    
    public Integer getFinalTestScore() { return finalTestScore; }
    public void setFinalTestScore(Integer finalTestScore) { this.finalTestScore = finalTestScore; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}