package com.example.institute.controller;

import com.example.institute.dto.ContentUploadRequest;
import com.example.institute.dto.EducationalContentDTO;
import com.example.institute.model.ContentCategory;
import com.example.institute.model.Student;
import com.example.institute.model.EducationalContent;
import com.example.institute.repository.EducationalContentRepository;
import com.example.institute.service.ContentManagementService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/content")
public class ContentManagementController {
    
    @Autowired
    private ContentManagementService contentManagementService;
    
    @Autowired
    private EducationalContentRepository educationalContentRepository;
    
    @Value("${content.upload.dir:content-uploads}")
    private String contentUploadDir;
    
    // ============ VIEW ENDPOINTS ============
    
    @GetMapping("/instructor/dashboard")
    public String instructorDashboard(Model model) {
        List<EducationalContentDTO> allContent = contentManagementService.getAllPublishedContent();
        List<String> subjectNames = contentManagementService.getAllSubjectNames();
        
        model.addAttribute("educationalContent", allContent);
        model.addAttribute("subjectNames", subjectNames);
        model.addAttribute("documentCount", contentManagementService.getTotalDocumentsCount());
        model.addAttribute("mediaCount", contentManagementService.getTotalMediaCount());
        model.addAttribute("subjectCount", contentManagementService.getDistinctSubjectsCount());
        model.addAttribute("totalAccess", contentManagementService.getTotalRetrievals() + 
                                          contentManagementService.getTotalEngagements());
        
        return "upload_notes";
    }
    
    @GetMapping("/student/portal")
    public String studentContentPortal(Model model) {
        List<EducationalContentDTO> allContent = contentManagementService.getAllPublishedContent();
        List<String> subjectNames = contentManagementService.getAllSubjectNames();
        
        model.addAttribute("educationalContent", allContent);
        model.addAttribute("subjectNames", subjectNames);
        model.addAttribute("documentCount", contentManagementService.getTotalDocumentsCount());
        model.addAttribute("mediaCount", contentManagementService.getTotalMediaCount());
        model.addAttribute("retrievalCount", contentManagementService.getTotalRetrievals());
        model.addAttribute("engagementCount", contentManagementService.getTotalEngagements());
        
        return "Studentcourse";
    }
    
    // ============ FIXED: REST API ENDPOINT for student content ============
    
    @GetMapping("/api/student-content")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<?> getStudentContent(HttpSession session) {
        try {
            // Check if student is logged in
            Student student = (Student) session.getAttribute("student");
            
            if (student == null) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Student not logged in");
                return ResponseEntity.status(401).body(error);
            }
            
            // Get student's enrolled courses
            List<String> studentCourses = student.getCourses();
            
            if (studentCourses == null || studentCourses.isEmpty()) {
                System.out.println("Student has no enrolled courses");
                return ResponseEntity.ok(new ArrayList<>());
            }
            
            System.out.println("=== STUDENT CONTENT REQUEST ===");
            System.out.println("Student: " + student.getFullName() + " (ID: " + student.getStudentId() + ")");
            System.out.println("Enrolled courses: " + studentCourses);
            
            // Get all published content
            List<EducationalContentDTO> allContent = contentManagementService.getAllPublishedContent();
            System.out.println("Total content available in system: " + allContent.size());
            
            // Log all available subjects
            List<String> availableSubjects = allContent.stream()
                .map(EducationalContentDTO::getSubjectName)
                .filter(subject -> subject != null && !subject.isEmpty())
                .distinct()
                .collect(Collectors.toList());
            System.out.println("Available subjects in content: " + availableSubjects);
            
            // Filter content to include materials for ANY of the student's enrolled courses
            List<EducationalContentDTO> filteredContent = allContent.stream()
                .filter(content -> {
                    String subjectName = content.getSubjectName();
                    return subjectName != null && !subjectName.isEmpty() && 
                           studentCourses.contains(subjectName);
                })
                .collect(Collectors.toList());
            
            System.out.println("Filtered content for student's courses: " + filteredContent.size());
            
            // Log each content item for debugging with proper null checks
            if (filteredContent.isEmpty()) {
                System.out.println("WARNING: No content found for student's courses!");
                System.out.println("Student courses: " + studentCourses);
                System.out.println("Available subjects: " + availableSubjects);
                
                // Return empty array but log warning
                return ResponseEntity.ok(new ArrayList<>());
            } else {
                for (EducationalContentDTO content : filteredContent) {
                    System.out.println("  - [" + content.getContentId() + "] " + 
                                      (content.getContentTitle() != null ? content.getContentTitle() : "NO TITLE") + 
                                      " (" + (content.getSubjectName() != null ? content.getSubjectName() : "NO SUBJECT") + ")");
                }
            }
            
            return ResponseEntity.ok(filteredContent);
            
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, String> error = new HashMap<>();
            error.put("error", "Failed to fetch student content: " + e.getMessage());
            return ResponseEntity.status(500).body(error);
        }
    }
    
    // ============ FIXED: REST API endpoint for all content with better logging ============
    
    @GetMapping("/api/all")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<EducationalContentDTO>> getAllContent() {
        List<EducationalContentDTO> content = contentManagementService.getAllPublishedContent();
        System.out.println("API /api/all returning " + content.size() + " items");
        
        // Log first few items for debugging
        for (int i = 0; i < Math.min(3, content.size()); i++) {
            EducationalContentDTO item = content.get(i);
            System.out.println("  Sample " + i + ": ID=" + item.getContentId() + 
                              ", Title=" + item.getContentTitle() + 
                              ", Subject=" + item.getSubjectName());
        }
        
        return ResponseEntity.ok(content);
    }
    
    // ============ REST API ENDPOINTS ============
    
    @GetMapping("/api/student-statistics")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<?> getStudentStatistics(HttpSession session) {
        try {
            Student student = (Student) session.getAttribute("student");
            
            if (student == null) {
                Map<String, String> error = new HashMap<>();
                error.put("error", "Student not logged in");
                return ResponseEntity.status(401).body(error);
            }
            
            List<String> studentCourses = student.getCourses();
            
            if (studentCourses == null || studentCourses.isEmpty()) {
                Map<String, Object> emptyStats = new HashMap<>();
                emptyStats.put("documentCount", 0);
                emptyStats.put("mediaCount", 0);
                emptyStats.put("totalDownloads", 0);
                emptyStats.put("totalEngagements", 0);
                emptyStats.put("enrolledCourses", new ArrayList<>());
                emptyStats.put("totalMaterials", 0);
                return ResponseEntity.ok(emptyStats);
            }
            
            List<EducationalContentDTO> allContent = contentManagementService.getAllPublishedContent();
            
            List<EducationalContentDTO> studentContent = allContent.stream()
                .filter(content -> {
                    String subjectName = content.getSubjectName();
                    return subjectName != null && !subjectName.isEmpty() && 
                           studentCourses.contains(subjectName);
                })
                .collect(Collectors.toList());
            
            Map<String, Object> stats = new HashMap<>();
            
            long documentCount = studentContent.stream()
                .filter(c -> c.getContentCategory() != null && c.getContentCategory().toString().equals("DOCUMENT"))
                .count();
            
            long mediaCount = studentContent.stream()
                .filter(c -> c.getContentCategory() != null && c.getContentCategory().toString().equals("MEDIA"))
                .count();
            
            long totalDownloads = studentContent.stream()
                .mapToLong(c -> c.getRetrievalCount() != null ? c.getRetrievalCount() : 0)
                .sum();
            
            long totalEngagements = studentContent.stream()
                .mapToLong(c -> c.getEngagementCount() != null ? c.getEngagementCount() : 0)
                .sum();
            
            stats.put("documentCount", documentCount);
            stats.put("mediaCount", mediaCount);
            stats.put("totalDownloads", totalDownloads);
            stats.put("totalEngagements", totalEngagements);
            stats.put("enrolledCourses", studentCourses);
            stats.put("totalMaterials", studentContent.size());
            
            System.out.println("Statistics for student " + student.getStudentId() + ": " + stats);
            
            return ResponseEntity.ok(stats);
            
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, String> error = new HashMap<>();
            error.put("error", "Failed to fetch student statistics: " + e.getMessage());
            return ResponseEntity.status(500).body(error);
        }
    }
    
    @PostMapping("/api/upload/document")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<Map<String, Object>> uploadDocument(
            @RequestParam("contentTitle") String contentTitle,
            @RequestParam("contentDescription") String contentDescription,
            @RequestParam("subjectName") String subjectName,
            @RequestParam("pageCount") Integer pageCount,
            @RequestParam("educatorId") Long educatorId,
            @RequestParam(value = "documentFile", required = false) MultipartFile documentFile) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            System.out.println("=== UPLOAD DOCUMENT ===");
            System.out.println("Title: " + contentTitle);
            System.out.println("Subject: " + subjectName);
            System.out.println("Educator ID: " + educatorId);
            System.out.println("File: " + (documentFile != null ? documentFile.getOriginalFilename() : "null"));
            
            ContentUploadRequest request = new ContentUploadRequest();
            request.setContentTitle(contentTitle);
            request.setContentDescription(contentDescription);
            request.setSubjectName(subjectName);
            request.setPageCount(pageCount);
            request.setEducatorId(educatorId);
            request.setContentCategory("DOCUMENT");
            request.setDocumentFile(documentFile);
            
            contentManagementService.uploadDocumentContent(request);
            
            response.put("success", true);
            response.put("message", "Document uploaded successfully!");
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Upload failed: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
    
    @PostMapping("/api/add/media")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<Map<String, Object>> addMediaContent(
            @RequestParam("contentTitle") String contentTitle,
            @RequestParam("contentDescription") String contentDescription,
            @RequestParam("subjectName") String subjectName,
            @RequestParam("mediaUrl") String mediaUrl,
            @RequestParam("durationValue") Integer durationValue,
            @RequestParam("educatorId") Long educatorId) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            System.out.println("=== ADD MEDIA ===");
            System.out.println("Title: " + contentTitle);
            System.out.println("Subject: " + subjectName);
            System.out.println("URL: " + mediaUrl);
            System.out.println("Educator ID: " + educatorId);
            
            ContentUploadRequest request = new ContentUploadRequest();
            request.setContentTitle(contentTitle);
            request.setContentDescription(contentDescription);
            request.setSubjectName(subjectName);
            request.setMediaUrl(mediaUrl);
            request.setDurationValue(durationValue);
            request.setEducatorId(educatorId);
            request.setContentCategory("MEDIA");
            
            contentManagementService.addMediaContent(request);
            
            response.put("success", true);
            response.put("message", "Media content added successfully!");
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Failed to add media: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
    
    @PostMapping("/api/update/{contentId}")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<Map<String, Object>> updateContent(
            @PathVariable Long contentId,
            @RequestParam("contentTitle") String contentTitle,
            @RequestParam("contentDescription") String contentDescription,
            @RequestParam("subjectName") String subjectName,
            @RequestParam("contentCategory") String contentCategory,
            @RequestParam(value = "documentFile", required = false) MultipartFile documentFile,
            @RequestParam(value = "mediaUrl", required = false) String mediaUrl,
            @RequestParam(value = "pageCount", required = false) Integer pageCount,
            @RequestParam(value = "durationValue", required = false) Integer durationValue) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            ContentUploadRequest request = new ContentUploadRequest();
            request.setContentTitle(contentTitle);
            request.setContentDescription(contentDescription);
            request.setSubjectName(subjectName);
            request.setContentCategory(contentCategory);
            
            if (contentCategory.equals("DOCUMENT")) {
                request.setDocumentFile(documentFile);
                request.setPageCount(pageCount);
            } else if (contentCategory.equals("MEDIA")) {
                request.setMediaUrl(mediaUrl);
                request.setDurationValue(durationValue);
            }
            
            contentManagementService.updateContent(contentId, request);
            
            response.put("success", true);
            response.put("message", "Content updated successfully!");
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Update failed: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
    
    @GetMapping("/api/subject/{subjectName}")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<EducationalContentDTO>> getContentBySubject(
            @PathVariable String subjectName) {
        List<EducationalContentDTO> content = contentManagementService.getContentBySubject(subjectName);
        System.out.println("API /api/subject/" + subjectName + " returning " + content.size() + " items");
        return ResponseEntity.ok(content);
    }
    
    @GetMapping("/api/category/{category}")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<EducationalContentDTO>> getContentByCategory(
            @PathVariable String category) {
        ContentCategory contentCategory = ContentCategory.valueOf(category.toUpperCase());
        List<EducationalContentDTO> content = contentManagementService.getContentByCategory(contentCategory);
        return ResponseEntity.ok(content);
    }
    
    @DeleteMapping("/api/remove/{contentId}")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<Map<String, Object>> removeContent(@PathVariable Long contentId) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            contentManagementService.removeContent(contentId);
            response.put("success", true);
            response.put("message", "Content removed successfully!");
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Removal failed: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
    
    @GetMapping("/api/details/{contentId}")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<EducationalContentDTO> getContentDetails(@PathVariable Long contentId) {
        EducationalContentDTO content = contentManagementService.getContentById(contentId);
        return ResponseEntity.ok(content);
    }
    
    @GetMapping("/api/search")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<EducationalContentDTO>> searchContent(
            @RequestParam String keyword) {
        List<EducationalContentDTO> content = contentManagementService.searchContent(keyword);
        return ResponseEntity.ok(content);
    }
    
    @GetMapping("/api/recent")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<EducationalContentDTO>> getRecentContent() {
        List<EducationalContentDTO> content = contentManagementService.getRecentContent();
        return ResponseEntity.ok(content);
    }
    
    @GetMapping("/api/statistics")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<Map<String, Object>> getStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("documentCount", contentManagementService.getTotalDocumentsCount());
        stats.put("mediaCount", contentManagementService.getTotalMediaCount());
        stats.put("subjectCount", contentManagementService.getDistinctSubjectsCount());
        stats.put("retrievalCount", contentManagementService.getTotalRetrievals());
        stats.put("engagementCount", contentManagementService.getTotalEngagements());
        
        return ResponseEntity.ok(stats);
    }
    
    @GetMapping("/download/document/{contentId}")
    @CrossOrigin(origins = "*")
    public ResponseEntity<Resource> downloadDocument(@PathVariable Long contentId) {
        try {
            System.out.println("=== DEBUG: Download request for contentId: " + contentId + " ===");
            
            EducationalContentDTO content = contentManagementService.getContentById(contentId);
            System.out.println("Content found: " + content.getContentTitle());
            System.out.println("File location in DB: " + content.getFileLocation());
            
            if (content.getFileLocation() == null || content.getFileLocation().isEmpty()) {
                System.out.println("ERROR: File location is null or empty in database");
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ByteArrayResource("File location not found in database".getBytes()));
            }
            
            Path uploadDir = Paths.get(contentUploadDir).toAbsolutePath().normalize();
            Path filePath = uploadDir.resolve(content.getFileLocation()).normalize();
            
            System.out.println("Upload directory: " + uploadDir.toString());
            System.out.println("Full file path: " + filePath.toString());
            
            if (!Files.exists(filePath)) {
                System.out.println("ERROR: File does not exist at path: " + filePath);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ByteArrayResource("File not found on server".getBytes()));
            }
            
            byte[] fileData = Files.readAllBytes(filePath);
            System.out.println("File size: " + fileData.length + " bytes");
            
            ByteArrayResource resource = new ByteArrayResource(fileData);
            
            String contentType = determineContentType(content.getFileLocation());
            String fileName = generateFileName(content.getContentTitle(), content.getFileLocation());
            
            System.out.println("Content type: " + contentType);
            System.out.println("File name: " + fileName);
            
            contentManagementService.incrementRetrievalCount(contentId);
            
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType))
                    .header(HttpHeaders.CONTENT_DISPOSITION, 
                           "attachment; filename=\"" + fileName + "\"")
                    .header(HttpHeaders.CONTENT_LENGTH, String.valueOf(fileData.length))
                    .body(resource);
            
        } catch (IOException e) {
            System.out.println("ERROR: IOException during download: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ByteArrayResource(("File read error: " + e.getMessage()).getBytes()));
        } catch (Exception e) {
            System.out.println("ERROR: General exception during download: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(new ByteArrayResource(("Document not found: " + e.getMessage()).getBytes()));
        }
    }
    
    @GetMapping("/test/upload-dir")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<Map<String, Object>> testUploadDir() {
        Map<String, Object> response = new HashMap<>();
        try {
            Path uploadDir = Paths.get(contentUploadDir).toAbsolutePath().normalize();
            
            response.put("uploadDir", contentUploadDir);
            response.put("absolutePath", uploadDir.toString());
            response.put("exists", Files.exists(uploadDir));
            
            if (Files.exists(uploadDir)) {
                List<String> files = Files.list(uploadDir)
                    .map(p -> p.getFileName().toString())
                    .toList();
                response.put("files", files);
                response.put("fileCount", files.size());
            } else {
                response.put("files", List.of());
                response.put("fileCount", 0);
                response.put("message", "Upload directory does not exist. Creating...");
                Files.createDirectories(uploadDir);
                response.put("created", true);
            }
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @GetMapping("/api/subjectNames")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<List<String>> getAllSubjectNames() {
        List<String> subjectNames = contentManagementService.getAllSubjectNames();
        System.out.println("API /api/subjectNames returning: " + subjectNames);
        return ResponseEntity.ok(subjectNames);
    }
    
    @GetMapping("/api/test-student-content")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<?> testStudentContent(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            Student student = (Student) session.getAttribute("student");
            response.put("studentLoggedIn", student != null);
            
            if (student != null) {
                response.put("studentId", student.getStudentId());
                response.put("studentName", student.getFullName());
                response.put("enrolledCourses", student.getCourses());
            }
            
            List<EducationalContentDTO> allContent = contentManagementService.getAllPublishedContent();
            response.put("totalContentCount", allContent.size());
            response.put("allContentSubjects", allContent.stream()
                .map(EducationalContentDTO::getSubjectName)
                .filter(subject -> subject != null && !subject.isEmpty())
                .distinct()
                .collect(Collectors.toList()));
            
            List<Map<String, Object>> contentList = new ArrayList<>();
            for (EducationalContentDTO content : allContent) {
                Map<String, Object> item = new HashMap<>();
                item.put("id", content.getContentId());
                item.put("title", content.getContentTitle() != null ? content.getContentTitle() : "");
                item.put("subject", content.getSubjectName() != null ? content.getSubjectName() : "");
                item.put("category", content.getContentCategory() != null ? content.getContentCategory().toString() : "");
                item.put("hasMCQ", content.isHasMCQ());
                contentList.add(item);
            }
            response.put("allContent", contentList);
            
            if (student != null && student.getCourses() != null) {
                List<EducationalContentDTO> filteredContent = allContent.stream()
                    .filter(content -> {
                        String subjectName = content.getSubjectName();
                        return subjectName != null && !subjectName.isEmpty() && 
                               student.getCourses().contains(subjectName);
                    })
                    .collect(Collectors.toList());
                response.put("filteredContentCount", filteredContent.size());
                
                List<Map<String, Object>> filteredList = new ArrayList<>();
                for (EducationalContentDTO content : filteredContent) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("id", content.getContentId());
                    item.put("title", content.getContentTitle() != null ? content.getContentTitle() : "");
                    item.put("subject", content.getSubjectName() != null ? content.getSubjectName() : "");
                    filteredList.add(item);
                }
                response.put("filteredContent", filteredList);
            }
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("error", e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
    
    @GetMapping("/api/debug/all-content")
    @ResponseBody
    @CrossOrigin(origins = "*")
    public ResponseEntity<Map<String, Object>> debugAllContent() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<EducationalContent> allContent = educationalContentRepository.findAll();
            List<Map<String, Object>> contentList = new ArrayList<>();
            
            for (EducationalContent content : allContent) {
                Map<String, Object> item = new HashMap<>();
                item.put("contentId", content.getContentId());
                item.put("contentTitle", content.getContentTitle() != null ? content.getContentTitle() : "");
                item.put("subjectName", content.getSubjectName() != null ? content.getSubjectName() : "");
                item.put("contentCategory", content.getContentCategory() != null ? content.getContentCategory().toString() : "");
                item.put("contentStatus", content.getContentStatus() != null ? content.getContentStatus().toString() : "");
                item.put("publishedDate", content.getPublishedDate() != null ? content.getPublishedDate().toString() : "");
                item.put("teacher", content.getTeacher() != null ? content.getTeacher().getFullName() : "No teacher");
                contentList.add(item);
            }
            
            response.put("success", true);
            response.put("totalContent", allContent.size());
            response.put("content", contentList);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
    
    private String determineContentType(String filename) {
        if (filename == null || !filename.contains(".")) {
            return "application/octet-stream";
        }
        
        String extension = filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
        switch (extension) {
            case "pdf": return "application/pdf";
            case "doc": return "application/msword";
            case "docx": return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            case "txt": return "text/plain";
            case "ppt": return "application/vnd.ms-powerpoint";
            case "pptx": return "application/vnd.openxmlformats-officedocument.presentationml.presentation";
            case "jpg": case "jpeg": return "image/jpeg";
            case "png": return "image/png";
            case "gif": return "image/gif";
            default: return "application/octet-stream";
        }
    }
    
    private String generateFileName(String contentTitle, String originalFilename) {
        String cleanTitle = contentTitle != null ? contentTitle.replaceAll("[^a-zA-Z0-9._-]", "_") : "document";
        if (cleanTitle.length() > 100) {
            cleanTitle = cleanTitle.substring(0, 100);
        }
        
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        
        if (extension.isEmpty()) {
            extension = ".pdf";
        }
        
        extension = extension.toLowerCase();
        
        return cleanTitle + extension;
    }
}