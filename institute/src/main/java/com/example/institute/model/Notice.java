package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "notices")
public class Notice {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "notice_id", unique = true, nullable = false, length = 20)
    private String noticeId;
    
    @Column(name = "title", nullable = false, length = 200)
    private String title;
    
    @Column(name = "content", nullable = false, columnDefinition = "TEXT")
    private String content;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "target_type", nullable = false, length = 20)
    private TargetType targetType;
    
    @Column(name = "target_value", length = 100)
    private String targetValue;
    
    @Column(name = "created_by", nullable = false, length = 100)
    private String createdBy;
    
    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "notice", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<NoticeRecipient> recipients = new ArrayList<>();
    
    public enum TargetType {
        ALL("All Parents"),
        COURSE("Specific Course"),
        STUDENT("Specific Student");
        
        private final String displayName;
        
        TargetType(String displayName) {
            this.displayName = displayName;
        }
        
        public String getDisplayName() {
            return displayName;
        }
    }
    
    // Constructors
    public Notice() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    public Notice(String title, String content, TargetType targetType, String targetValue, String createdBy) {
        this.title = title;
        this.content = content;
        this.targetType = targetType;
        this.targetValue = targetValue;
        this.createdBy = createdBy;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getNoticeId() { return noticeId; }
    public void setNoticeId(String noticeId) { this.noticeId = noticeId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public TargetType getTargetType() { return targetType; }
    public void setTargetType(TargetType targetType) { this.targetType = targetType; }
    
    public String getTargetValue() { return targetValue; }
    public void setTargetValue(String targetValue) { this.targetValue = targetValue; }
    
    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public List<NoticeRecipient> getRecipients() { return recipients; }
    public void setRecipients(List<NoticeRecipient> recipients) { this.recipients = recipients; }
    
    // Helper methods
    public void addRecipient(NoticeRecipient recipient) {
        recipients.add(recipient);
        recipient.setNotice(this);
    }
    
    public void removeRecipient(NoticeRecipient recipient) {
        recipients.remove(recipient);
        recipient.setNotice(null);
    }
    
    public int getRecipientCount() {
        return recipients.size();
    }
    
    public int getReadCount() {
        return (int) recipients.stream().filter(NoticeRecipient::isRead).count();
    }
    
    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
    
    @Override
    public String toString() {
        return "Notice{" +
                "id=" + id +
                ", noticeId='" + noticeId + '\'' +
                ", title='" + title + '\'' +
                ", targetType=" + targetType +
                ", targetValue='" + targetValue + '\'' +
                '}';
    }
}