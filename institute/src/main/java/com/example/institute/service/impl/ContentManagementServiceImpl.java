package com.example.institute.service.impl;

import com.example.institute.dto.ContentUploadRequest;
import com.example.institute.dto.EducationalContentDTO;
import com.example.institute.model.ContentCategory;
import com.example.institute.model.ContentStatus;
import com.example.institute.model.EducationalContent;
import com.example.institute.model.Teacher;
import com.example.institute.model.StudentTestAttempt;
import com.example.institute.repository.EducationalContentRepository;
import com.example.institute.repository.TeacherRepository;
import com.example.institute.repository.MCQQuestionRepository;
import com.example.institute.repository.StudentTestAttemptRepository;
import com.example.institute.repository.StudentTestAnswerRepository;
import com.example.institute.service.ContentManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import jakarta.persistence.EntityNotFoundException;
import java.io.IOException;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ContentManagementServiceImpl implements ContentManagementService {
    
    @Autowired
    private EducationalContentRepository educationalContentRepository;
    
    @Autowired
    private TeacherRepository teacherRepository;
    
    @Autowired
    private MCQQuestionRepository mcqQuestionRepository;
    
    @Autowired
    private StudentTestAttemptRepository testAttemptRepository;
    
    @Autowired
    private StudentTestAnswerRepository testAnswerRepository;
    
    @Value("${content.upload.dir:content-uploads}")
    private String contentUploadDir;
    
    private final DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
    
    @Override
    public EducationalContent uploadDocumentContent(ContentUploadRequest request) throws IOException {
        System.out.println("=== UPLOADING DOCUMENT CONTENT ===");
        System.out.println("Title: " + request.getContentTitle());
        System.out.println("Subject: " + request.getSubjectName());
        System.out.println("Teacher ID: " + request.getEducatorId());
        
        Teacher teacher = teacherRepository.findById(request.getEducatorId())
            .orElseThrow(() -> new EntityNotFoundException("Teacher not found with ID: " + request.getEducatorId()));
        
        System.out.println("Teacher found: " + teacher.getFullName());
        
        EducationalContent content = new EducationalContent();
        content.setContentTitle(request.getContentTitle());
        content.setContentDescription(request.getContentDescription());
        content.setSubjectName(request.getSubjectName());
        content.setContentCategory(ContentCategory.DOCUMENT);
        content.setTeacher(teacher);
        content.setPageCount(request.getPageCount());
        content.setPublishedDate(LocalDateTime.now());
        content.setContentStatus(ContentStatus.PUBLISHED);
        
        MultipartFile file = request.getDocumentFile();
        if (file != null && !file.isEmpty()) {
            System.out.println("File received: " + file.getOriginalFilename() + ", size: " + file.getSize());
            String fileName = storeDocumentFile(file);
            content.setFileLocation(fileName);
            System.out.println("File saved as: " + fileName);
        } else {
            System.out.println("No file received!");
            throw new IOException("No file uploaded");
        }
        
        EducationalContent savedContent = educationalContentRepository.save(content);
        System.out.println("Content saved with ID: " + savedContent.getContentId());
        
        return savedContent;
    }
    
    @Override
    public EducationalContent addMediaContent(ContentUploadRequest request) {
        System.out.println("=== ADDING MEDIA CONTENT ===");
        System.out.println("Title: " + request.getContentTitle());
        System.out.println("Subject: " + request.getSubjectName());
        System.out.println("Teacher ID: " + request.getEducatorId());
        
        Teacher teacher = teacherRepository.findById(request.getEducatorId())
            .orElseThrow(() -> new EntityNotFoundException("Teacher not found with ID: " + request.getEducatorId()));
        
        System.out.println("Teacher found: " + teacher.getFullName());
        
        EducationalContent content = new EducationalContent();
        content.setContentTitle(request.getContentTitle());
        content.setContentDescription(request.getContentDescription());
        content.setSubjectName(request.getSubjectName());
        content.setContentCategory(ContentCategory.MEDIA);
        content.setTeacher(teacher);
        content.setMediaLink(request.getMediaUrl());
        content.setDurationValue(request.getDurationValue());
        content.setPublishedDate(LocalDateTime.now());
        content.setContentStatus(ContentStatus.PUBLISHED);
        
        EducationalContent savedContent = educationalContentRepository.save(content);
        System.out.println("Content saved with ID: " + savedContent.getContentId());
        
        return savedContent;
    }
    
    @Override
    public EducationalContent updateContent(Long contentId, ContentUploadRequest request) throws IOException {
        EducationalContent existingContent = educationalContentRepository.findById(contentId)
            .orElseThrow(() -> new EntityNotFoundException("Educational content not found"));
        
        existingContent.setContentTitle(request.getContentTitle());
        existingContent.setContentDescription(request.getContentDescription());
        existingContent.setSubjectName(request.getSubjectName());
        existingContent.setUpdatedAt(LocalDateTime.now());
        
        if ("DOCUMENT".equals(request.getContentCategory())) {
            existingContent.setContentCategory(ContentCategory.DOCUMENT);
            existingContent.setPageCount(request.getPageCount());
            
            MultipartFile file = request.getDocumentFile();
            if (file != null && !file.isEmpty()) {
                if (existingContent.getFileLocation() != null && !existingContent.getFileLocation().isEmpty()) {
                    try {
                        Path oldFilePath = Paths.get(contentUploadDir).resolve(existingContent.getFileLocation());
                        Files.deleteIfExists(oldFilePath);
                    } catch (IOException e) {
                        System.err.println("Error deleting old file: " + e.getMessage());
                    }
                }
                
                String fileName = storeDocumentFile(file);
                existingContent.setFileLocation(fileName);
            }
        } else if ("MEDIA".equals(request.getContentCategory())) {
            existingContent.setContentCategory(ContentCategory.MEDIA);
            existingContent.setMediaLink(request.getMediaUrl());
            existingContent.setDurationValue(request.getDurationValue());
            existingContent.setFileLocation(null);
        }
        
        return educationalContentRepository.save(existingContent);
    }
    
    private String storeDocumentFile(MultipartFile file) throws IOException {
        Path uploadPath = Paths.get(contentUploadDir).toAbsolutePath().normalize();
        System.out.println("DEBUG: Upload directory: " + uploadPath.toString());
        
        if (!Files.exists(uploadPath)) {
            System.out.println("DEBUG: Creating upload directory...");
            Files.createDirectories(uploadPath);
        }
        
        String originalFileName = file.getOriginalFilename();
        System.out.println("DEBUG: Original filename: " + originalFileName);
        
        String fileExtension = "";
        if (originalFileName != null && originalFileName.contains(".")) {
            fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            System.out.println("DEBUG: Extracted extension: " + fileExtension);
        } else {
            String contentType = file.getContentType();
            System.out.println("DEBUG: Content type: " + contentType);
            
            if (contentType != null) {
                if (contentType.equals("application/pdf")) {
                    fileExtension = ".pdf";
                } else if (contentType.equals("application/msword") || contentType.contains("word")) {
                    fileExtension = ".doc";
                } else if (contentType.contains("document") || contentType.contains("docx")) {
                    fileExtension = ".docx";
                } else if (contentType.equals("text/plain")) {
                    fileExtension = ".txt";
                } else if (contentType.startsWith("image/")) {
                    fileExtension = "." + contentType.substring(6);
                }
            }
            
            if (fileExtension.isEmpty()) {
                fileExtension = ".pdf";
            }
        }
        
        String uniqueId = UUID.randomUUID().toString().substring(0, 8);
        String timestamp = String.valueOf(System.currentTimeMillis());
        String fileName = "doc_" + timestamp + "_" + uniqueId + fileExtension;
        System.out.println("DEBUG: Generated filename: " + fileName);
        
        Path filePath = uploadPath.resolve(fileName);
        System.out.println("DEBUG: Saving to: " + filePath.toString());
        
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        
        if (!Files.exists(filePath)) {
            System.out.println("ERROR: Failed to save file: " + fileName);
            throw new IOException("Failed to save file: " + fileName);
        }
        
        long fileSize = Files.size(filePath);
        System.out.println("DEBUG: File saved successfully. Size: " + fileSize + " bytes");
        
        return fileName;
    }
    
    @Override
    public List<EducationalContentDTO> getAllPublishedContent() {
        List<EducationalContent> contents = educationalContentRepository.findAllPublished();
        return contents.stream()
            .map(this::convertToDTO)
            .collect(Collectors.toList());
    }
    
    @Override
    public List<EducationalContentDTO> getContentBySubject(String subjectName) {
        List<EducationalContent> contents = educationalContentRepository.findBySubjectName(subjectName);
        return contents.stream()
            .filter(c -> c.getContentStatus() == ContentStatus.PUBLISHED)
            .map(this::convertToDTO)
            .collect(Collectors.toList());
    }
    
    @Override
    public List<EducationalContentDTO> getContentByCategory(ContentCategory contentCategory) {
        List<EducationalContent> contents = educationalContentRepository.findByContentCategory(contentCategory);
        return contents.stream()
            .filter(c -> c.getContentStatus() == ContentStatus.PUBLISHED)
            .map(this::convertToDTO)
            .collect(Collectors.toList());
    }
    
    @Override
    public EducationalContentDTO getContentById(Long contentId) {
        EducationalContent content = educationalContentRepository.findById(contentId)
            .orElseThrow(() -> new EntityNotFoundException("Educational content not found"));
        
        return convertToDTO(content);
    }
    
    @Override
    public List<EducationalContentDTO> getRecentContent() {
        LocalDateTime sevenDaysAgo = LocalDateTime.now().minusDays(7);
        List<EducationalContent> contents = educationalContentRepository.findRecentContent(sevenDaysAgo);
        return contents.stream()
            .map(this::convertToDTO)
            .collect(Collectors.toList());
    }
    
    @Override
    public void incrementRetrievalCount(Long contentId) {
        EducationalContent content = educationalContentRepository.findById(contentId)
            .orElseThrow(() -> new EntityNotFoundException("Educational content not found"));
        content.incrementRetrievalCount();
        educationalContentRepository.save(content);
    }
    
    @Override
    public void incrementEngagementCount(Long contentId) {
        EducationalContent content = educationalContentRepository.findById(contentId)
            .orElseThrow(() -> new EntityNotFoundException("Educational content not found"));
        content.incrementEngagementCount();
        educationalContentRepository.save(content);
    }
    
    @Override
    public void removeContent(Long contentId) {
        EducationalContent content = educationalContentRepository.findById(contentId)
            .orElseThrow(() -> new EntityNotFoundException("Educational content not found"));
        
        System.out.println("=== DELETING CONTENT AND ASSOCIATED TEST DATA ===");
        System.out.println("Content ID: " + contentId);
        System.out.println("Content Title: " + content.getContentTitle());
        
        try {
            mcqQuestionRepository.deleteByContentId(contentId);
            System.out.println("✓ Deleted MCQ questions for content ID: " + contentId);
        } catch (Exception e) {
            System.err.println("✗ Error deleting MCQ questions: " + e.getMessage());
        }
        
        try {
            List<StudentTestAttempt> attempts = testAttemptRepository.findByContentId(contentId);
            System.out.println("Found " + attempts.size() + " test attempts to delete");
            
            for (StudentTestAttempt attempt : attempts) {
                try {
                    testAnswerRepository.deleteByAttemptId(attempt.getAttemptId());
                    System.out.println("  ✓ Deleted answers for attempt: " + attempt.getAttemptId());
                } catch (Exception e) {
                    System.err.println("  ✗ Error deleting answers for attempt " + attempt.getAttemptId() + ": " + e.getMessage());
                }
            }
            
            if (!attempts.isEmpty()) {
                testAttemptRepository.deleteByContentId(contentId);
                System.out.println("✓ Deleted " + attempts.size() + " test attempts");
            }
        } catch (Exception e) {
            System.err.println("✗ Error deleting test attempts: " + e.getMessage());
        }
        
        if (content.getFileLocation() != null && !content.getFileLocation().isEmpty()) {
            try {
                Path filePath = Paths.get(contentUploadDir).resolve(content.getFileLocation());
                boolean deleted = Files.deleteIfExists(filePath);
                if (deleted) {
                    System.out.println("✓ Deleted file: " + filePath);
                }
            } catch (IOException e) {
                System.err.println("✗ Error deleting file: " + e.getMessage());
            }
        }
        
        educationalContentRepository.delete(content);
        System.out.println("✓ Content deleted with ID: " + contentId);
        System.out.println("=== DELETE OPERATION COMPLETED ===");
    }
    
    @Override
    public List<String> getAllSubjectNames() {
        return educationalContentRepository.findDistinctSubjectNames();
    }
    
    @Override
    public EducationalContentDTO convertToDTO(EducationalContent content) {
        EducationalContentDTO dto = new EducationalContentDTO();
        
        // Ensure all fields are properly set with null checks and default values
        dto.setContentId(content.getContentId());
        dto.setContentTitle(content.getContentTitle() != null ? content.getContentTitle() : "Untitled");
        dto.setContentDescription(content.getContentDescription() != null ? content.getContentDescription() : "");
        dto.setSubjectName(content.getSubjectName() != null ? content.getSubjectName() : "General");
        dto.setContentCategory(content.getContentCategory());
        dto.setFileLocation(content.getFileLocation());
        dto.setMediaLink(content.getMediaLink());
        dto.setPageCount(content.getPageCount());
        dto.setDurationValue(content.getDurationValue());
        dto.setPublishedDate(content.getPublishedDate());
        dto.setRetrievalCount(content.getRetrievalCount() != null ? content.getRetrievalCount() : 0);
        dto.setEngagementCount(content.getEngagementCount() != null ? content.getEngagementCount() : 0);
        
        if (content.getTeacher() != null) {
            dto.setEducatorName(content.getTeacher().getFullName() != null ? content.getTeacher().getFullName() : "Unknown Teacher");
            dto.setEducatorEmail(content.getTeacher().getEmail() != null ? content.getTeacher().getEmail() : "");
            dto.setEducatorId(content.getTeacher().getId());
        } else {
            dto.setEducatorName("Unknown Teacher");
            dto.setEducatorEmail("");
            dto.setEducatorId(0L);
        }
        
        if (content.getPublishedDate() != null) {
            try {
                dto.setFormattedDate(content.getPublishedDate().format(dateFormatter));
            } catch (Exception e) {
                dto.setFormattedDate("");
            }
        } else {
            dto.setFormattedDate("");
        }
        
        // Check if this content has MCQ questions - this is the key part
        // We need to ensure this works for ALL content
        try {
            Long mcqCount = mcqQuestionRepository.countByContentId(content.getContentId());
            // CRITICAL FIX: Set hasMCQ to true if mcqCount > 0
            dto.setHasMCQ(mcqCount != null && mcqCount > 0);
            System.out.println("Content ID " + content.getContentId() + " (" + content.getContentTitle() + ") hasMCQ: " + dto.isHasMCQ() + " (count: " + mcqCount + ")");
        } catch (Exception e) {
            System.err.println("Error checking MCQ count for content " + content.getContentId() + ": " + e.getMessage());
            dto.setHasMCQ(false);
        }
        
        // Check if this is a final test
        try {
            Long finalTestCount = mcqQuestionRepository.countByContentIdAndIsFinalTest(content.getContentId(), true);
            dto.setFinalTest(finalTestCount != null && finalTestCount > 0);
            if (dto.isFinalTest()) {
                System.out.println("Content ID " + content.getContentId() + " is FINAL TEST");
            }
        } catch (Exception e) {
            System.err.println("Error checking final test status for content " + content.getContentId() + ": " + e.getMessage());
            dto.setFinalTest(false);
        }
        
        return dto;
    }
    
    @Override
    public byte[] retrieveDocument(Long contentId) throws IOException {
        EducationalContent content = educationalContentRepository.findById(contentId)
            .orElseThrow(() -> new EntityNotFoundException("Educational content not found"));
        
        if (content.getFileLocation() == null || content.getFileLocation().isEmpty()) {
            throw new IOException("Document file not found");
        }
        
        Path filePath = Paths.get(contentUploadDir).resolve(content.getFileLocation());
        if (!Files.exists(filePath)) {
            throw new IOException("Document file not found on server");
        }
        
        byte[] fileData = Files.readAllBytes(filePath);
        incrementRetrievalCount(contentId);
        
        return fileData;
    }
    
    @Override
    public List<EducationalContentDTO> searchContent(String keyword) {
        List<EducationalContent> contents = educationalContentRepository.searchPublishedContent(keyword);
        return contents.stream()
            .map(this::convertToDTO)
            .collect(Collectors.toList());
    }
    
    @Override
    public Long getTotalDocumentsCount() {
        Long total = educationalContentRepository.countPublishedDocuments();
        return total != null ? total : 0L;
    }
    
    @Override
    public Long getTotalMediaCount() {
        Long total = educationalContentRepository.countPublishedMedia();
        return total != null ? total : 0L;
    }
    
    @Override
    public Long getTotalRetrievals() {
        Long total = educationalContentRepository.totalRetrievals();
        return total != null ? total : 0L;
    }
    
    @Override
    public Long getTotalEngagements() {
        Long total = educationalContentRepository.totalEngagements();
        return total != null ? total : 0L;
    }
    
    @Override
    public Long getDistinctSubjectsCount() {
        return (long) educationalContentRepository.findDistinctSubjectNames().size();
    }
}