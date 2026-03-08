package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "educational_content")
public class EducationalContent {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "content_id")
    private Long contentId;
    
    @Column(name = "content_title", nullable = false, length = 200)
    private String contentTitle;
    
    @Column(name = "content_description", columnDefinition = "TEXT")
    private String contentDescription;
    
    @Column(name = "subject_name", nullable = false, length = 100)
    private String subjectName;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "content_category", nullable = false)
    private ContentCategory contentCategory;
    
    @Column(name = "file_location", length = 500)
    private String fileLocation;
    
    @Column(name = "media_link", length = 500)
    private String mediaLink;
    
    @Column(name = "page_count")
    private Integer pageCount;
    
    @Column(name = "duration_value")
    private Integer durationValue;
    
    @Column(name = "published_date")
    private LocalDateTime publishedDate;
    
    @Column(name = "retrieval_count")
    private Integer retrievalCount = 0;
    
    @Column(name = "engagement_count")
    private Integer engagementCount = 0;
    
    // This is correct - uses teacher field
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "teacher_id", referencedColumnName = "id")
    private Teacher teacher;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "content_status")
    private ContentStatus contentStatus = ContentStatus.PUBLISHED;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Constructors
    public EducationalContent() {
        this.publishedDate = LocalDateTime.now();
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    public EducationalContent(String contentTitle, String subjectName, ContentCategory contentCategory, Teacher teacher) {
        this();
        this.contentTitle = contentTitle;
        this.subjectName = subjectName;
        this.contentCategory = contentCategory;
        this.teacher = teacher;
    }
    
    // Getters and Setters
    public Long getContentId() { return contentId; }
    public void setContentId(Long contentId) { this.contentId = contentId; }
    
    public String getContentTitle() { return contentTitle; }
    public void setContentTitle(String contentTitle) { this.contentTitle = contentTitle; }
    
    public String getContentDescription() { return contentDescription; }
    public void setContentDescription(String contentDescription) { this.contentDescription = contentDescription; }
    
    public String getSubjectName() { return subjectName; }
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }
    
    public ContentCategory getContentCategory() { return contentCategory; }
    public void setContentCategory(ContentCategory contentCategory) { this.contentCategory = contentCategory; }
    
    public String getFileLocation() { return fileLocation; }
    public void setFileLocation(String fileLocation) { this.fileLocation = fileLocation; }
    
    public String getMediaLink() { return mediaLink; }
    public void setMediaLink(String mediaLink) { this.mediaLink = mediaLink; }
    
    public Integer getPageCount() { return pageCount; }
    public void setPageCount(Integer pageCount) { this.pageCount = pageCount; }
    
    public Integer getDurationValue() { return durationValue; }
    public void setDurationValue(Integer durationValue) { this.durationValue = durationValue; }
    
    public LocalDateTime getPublishedDate() { return publishedDate; }
    public void setPublishedDate(LocalDateTime publishedDate) { this.publishedDate = publishedDate; }
    
    public Integer getRetrievalCount() { return retrievalCount; }
    public void setRetrievalCount(Integer retrievalCount) { this.retrievalCount = retrievalCount; }
    
    public Integer getEngagementCount() { return engagementCount; }
    public void setEngagementCount(Integer engagementCount) { this.engagementCount = engagementCount; }
    
    public Teacher getTeacher() { return teacher; }
    public void setTeacher(Teacher teacher) { this.teacher = teacher; }
    
    public ContentStatus getContentStatus() { return contentStatus; }
    public void setContentStatus(ContentStatus contentStatus) { this.contentStatus = contentStatus; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public void incrementRetrievalCount() {
        this.retrievalCount = (this.retrievalCount == null) ? 1 : this.retrievalCount + 1;
        this.updatedAt = LocalDateTime.now();
    }
    
    public void incrementEngagementCount() {
        this.engagementCount = (this.engagementCount == null) ? 1 : this.engagementCount + 1;
        this.updatedAt = LocalDateTime.now();
    }
    
    @Override
    public String toString() {
        return "EducationalContent{" +
                "contentId=" + contentId +
                ", contentTitle='" + contentTitle + '\'' +
                ", subjectName='" + subjectName + '\'' +
                ", contentCategory=" + contentCategory +
                ", teacher=" + (teacher != null ? teacher.getFullName() : "null") +
                ", publishedDate=" + publishedDate +
                '}';
    }
}