package com.example.institute.service;

import com.example.institute.dto.ContentUploadRequest;
import com.example.institute.dto.EducationalContentDTO;
import com.example.institute.model.ContentCategory;
import com.example.institute.model.EducationalContent;
import java.io.IOException;
import java.util.List;

public interface ContentManagementService {
    
    EducationalContent uploadDocumentContent(ContentUploadRequest request) throws IOException;
    
    EducationalContent addMediaContent(ContentUploadRequest request);
    
    EducationalContent updateContent(Long contentId, ContentUploadRequest request) throws IOException;
    
    List<EducationalContentDTO> getAllPublishedContent();
    
    List<EducationalContentDTO> getContentBySubject(String subjectName);
    
    List<EducationalContentDTO> getContentByCategory(ContentCategory contentCategory);
    
    EducationalContentDTO getContentById(Long contentId);
    
    void incrementRetrievalCount(Long contentId);
    
    void incrementEngagementCount(Long contentId);
    
    void removeContent(Long contentId);
    
    List<String> getAllSubjectNames();
    
    EducationalContentDTO convertToDTO(EducationalContent content);
    
    byte[] retrieveDocument(Long contentId) throws IOException;
    
    List<EducationalContentDTO> searchContent(String keyword);
    
    List<EducationalContentDTO> getRecentContent();
    
    // Statistics
    Long getTotalDocumentsCount();
    
    Long getTotalMediaCount();
    
    Long getTotalRetrievals();
    
    Long getTotalEngagements();
    
    Long getDistinctSubjectsCount();
}