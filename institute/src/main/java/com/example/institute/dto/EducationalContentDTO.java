package com.example.institute.dto;

import com.example.institute.model.ContentCategory;
import java.time.LocalDateTime;

public class EducationalContentDTO {
    private Long contentId;
    private String contentTitle;
    private String contentDescription;
    private String subjectName;
    private ContentCategory contentCategory;
    private String fileLocation;
    private String mediaLink;
    private Integer pageCount;
    private Integer durationValue;
    private LocalDateTime publishedDate;
    private Integer retrievalCount;
    private Integer engagementCount;
    private String educatorName;
    private String educatorDepartment;
    private String formattedDate;
    private String educatorEmail;
    private Long educatorId;
    private boolean hasMCQ;
    private boolean isFinalTest;
    
    public EducationalContentDTO() {}
    
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
    
    public String getEducatorName() { return educatorName; }
    public void setEducatorName(String educatorName) { this.educatorName = educatorName; }
    
    public String getEducatorDepartment() { return educatorDepartment; }
    public void setEducatorDepartment(String educatorDepartment) { this.educatorDepartment = educatorDepartment; }
    
    public String getFormattedDate() { return formattedDate; }
    public void setFormattedDate(String formattedDate) { this.formattedDate = formattedDate; }
    
    public String getEducatorEmail() { return educatorEmail; }
    public void setEducatorEmail(String educatorEmail) { this.educatorEmail = educatorEmail; }
    
    public Long getEducatorId() { return educatorId; }
    public void setEducatorId(Long educatorId) { this.educatorId = educatorId; }
    
    public boolean isHasMCQ() { return hasMCQ; }
    public void setHasMCQ(boolean hasMCQ) { this.hasMCQ = hasMCQ; }
    
    public boolean isFinalTest() { return isFinalTest; }
    public void setFinalTest(boolean isFinalTest) { this.isFinalTest = isFinalTest; }
}