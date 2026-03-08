package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "notice_recipients")
public class NoticeRecipient {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "notice_id", nullable = false)
    private Notice notice;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id", nullable = false)
    private Parent parent;
    
    @Column(name = "parent_name", nullable = false, length = 100)
    private String parentName;
    
    @Column(name = "student_id", nullable = false, length = 50)
    private String studentId;
    
    @Column(name = "student_name", nullable = false, length = 100)
    private String studentName;
    
    @Column(name = "course_name", length = 100)
    private String courseName;
    
    @Column(name = "is_read", nullable = false)
    private boolean isRead = false;
    
    @Column(name = "read_at")
    private LocalDateTime readAt;
    
    @Column(name = "delivered_at", nullable = false)
    private LocalDateTime deliveredAt;
    
    // Constructors
    public NoticeRecipient() {
        this.deliveredAt = LocalDateTime.now();
    }
    
    public NoticeRecipient(Parent parent, String studentId, String studentName, String courseName) {
        this.parent = parent;
        this.parentName = parent.getFullName();
        this.studentId = studentId;
        this.studentName = studentName;
        this.courseName = courseName;
        this.deliveredAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Notice getNotice() { return notice; }
    public void setNotice(Notice notice) { this.notice = notice; }
    
    public Parent getParent() { return parent; }
    public void setParent(Parent parent) { 
        this.parent = parent;
        this.parentName = parent.getFullName();
    }
    
    public String getParentName() { return parentName; }
    public void setParentName(String parentName) { this.parentName = parentName; }
    
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    
    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { 
        isRead = read;
        if (read) {
            this.readAt = LocalDateTime.now();
        }
    }
    
    public LocalDateTime getReadAt() { return readAt; }
    public void setReadAt(LocalDateTime readAt) { this.readAt = readAt; }
    
    public LocalDateTime getDeliveredAt() { return deliveredAt; }
    public void setDeliveredAt(LocalDateTime deliveredAt) { this.deliveredAt = deliveredAt; }
    
    @Override
    public String toString() {
        return "NoticeRecipient{" +
                "id=" + id +
                ", parentName='" + parentName + '\'' +
                ", studentId='" + studentId + '\'' +
                ", isRead=" + isRead +
                '}';
    }
}