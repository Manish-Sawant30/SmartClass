package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "att_attendance")
public class AttAttendance {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "attendance_id")
    private Integer attendanceId;
    
    @Column(name = "student_id", nullable = false, length = 20)
    private String studentId;
    
    @Column(name = "course_id", nullable = false)
    private Integer courseId;
    
    @Column(name = "attendance_date", nullable = false)
    private LocalDate attendanceDate;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, columnDefinition = "ENUM('PRESENT', 'ABSENT', 'LATE')")
    private AttendanceStatus status;
    
    @Column(name = "remarks", length = 200)
    private String remarks;
    
    @Column(name = "marked_by", length = 50)
    private String markedBy;
    
    @Column(name = "marked_at")
    private LocalDateTime markedAt;
    
    // Relationships (not for foreign keys, just for data retrieval)
    @Transient
    private String studentName;
    
    @Transient
    private String courseName;
    
    // Enum for attendance status
    public enum AttendanceStatus {
        PRESENT, ABSENT, LATE
    }
    
    // Constructors
    public AttAttendance() {
        this.attendanceDate = LocalDate.now();
        this.markedAt = LocalDateTime.now();
    }
    
    public AttAttendance(String studentId, Integer courseId, AttendanceStatus status, String markedBy) {
        this.studentId = studentId;
        this.courseId = courseId;
        this.attendanceDate = LocalDate.now();
        this.status = status;
        this.markedBy = markedBy;
        this.markedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Integer getAttendanceId() {
        return attendanceId;
    }
    
    public void setAttendanceId(Integer attendanceId) {
        this.attendanceId = attendanceId;
    }
    
    public String getStudentId() {
        return studentId;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    public Integer getCourseId() {
        return courseId;
    }
    
    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }
    
    public LocalDate getAttendanceDate() {
        return attendanceDate;
    }
    
    public void setAttendanceDate(LocalDate attendanceDate) {
        this.attendanceDate = attendanceDate;
    }
    
    public AttendanceStatus getStatus() {
        return status;
    }
    
    public void setStatus(AttendanceStatus status) {
        this.status = status;
    }
    
    public String getRemarks() {
        return remarks;
    }
    
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
    
    public String getMarkedBy() {
        return markedBy;
    }
    
    public void setMarkedBy(String markedBy) {
        this.markedBy = markedBy;
    }
    
    public LocalDateTime getMarkedAt() {
        return markedAt;
    }
    
    public void setMarkedAt(LocalDateTime markedAt) {
        this.markedAt = markedAt;
    }
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getCourseName() {
        return courseName;
    }
    
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }
}