package com.example.institute.dto;

import org.springframework.web.multipart.MultipartFile;

public class ContentUploadRequest {
    private String contentTitle;
    private String contentDescription;
    private String subjectName;
    private String contentCategory;
    private MultipartFile documentFile;
    private String mediaUrl;
    private Integer pageCount;
    private Integer durationValue;
    private Long educatorId;
    
    public String getContentTitle() { return contentTitle; }
    public void setContentTitle(String contentTitle) { this.contentTitle = contentTitle; }
    
    public String getContentDescription() { return contentDescription; }
    public void setContentDescription(String contentDescription) { this.contentDescription = contentDescription; }
    
    public String getSubjectName() { return subjectName; }
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }
    
    public String getContentCategory() { return contentCategory; }
    public void setContentCategory(String contentCategory) { this.contentCategory = contentCategory; }
    
    public MultipartFile getDocumentFile() { return documentFile; }
    public void setDocumentFile(MultipartFile documentFile) { this.documentFile = documentFile; }
    
    public String getMediaUrl() { return mediaUrl; }
    public void setMediaUrl(String mediaUrl) { this.mediaUrl = mediaUrl; }
    
    public Integer getPageCount() { return pageCount; }
    public void setPageCount(Integer pageCount) { this.pageCount = pageCount; }
    
    public Integer getDurationValue() { return durationValue; }
    public void setDurationValue(Integer durationValue) { this.durationValue = durationValue; }
    
    public Long getEducatorId() { return educatorId; }
    public void setEducatorId(Long educatorId) { this.educatorId = educatorId; }
}