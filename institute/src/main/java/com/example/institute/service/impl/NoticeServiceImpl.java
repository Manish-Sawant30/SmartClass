package com.example.institute.service.impl;

import com.example.institute.model.*;
import com.example.institute.repository.*;
import com.example.institute.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService {
    
    @Autowired
    private NoticeRepository noticeRepository;
    
    @Autowired
    private NoticeRecipientRepository noticeRecipientRepository;
    
    @Autowired
    private ParentRepository parentRepository;
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Override
    public Notice createNotice(String title, String content, Notice.TargetType targetType, 
                              String targetValue, String createdBy) {
        
        System.out.println("=== Creating Notice ===");
        System.out.println("Title: " + title);
        System.out.println("Target Type: " + targetType);
        System.out.println("Target Value: " + targetValue);
        
        // Create notice
        Notice notice = new Notice();
        notice.setNoticeId(generateNoticeId());
        notice.setTitle(title);
        notice.setContent(content);
        notice.setTargetType(targetType);
        notice.setTargetValue(targetValue);
        notice.setCreatedBy(createdBy);
        notice.setCreatedAt(LocalDateTime.now());
        notice.setUpdatedAt(LocalDateTime.now());
        
        Notice savedNotice = noticeRepository.save(notice);
        
        // Find target parents and create recipients
        List<Parent> targetParents = getTargetParents(targetType, targetValue);
        
        System.out.println("Found " + targetParents.size() + " target parents");
        
        if (targetParents.isEmpty()) {
            System.out.println("WARNING: No target parents found for this notice!");
            // Still return the notice even if no recipients
            return savedNotice;
        }
        
        for (Parent parent : targetParents) {
            System.out.println("Processing parent: " + parent.getFullName() + " (ID: " + parent.getId() + ")");
            System.out.println("Parent Student ID: " + parent.getStudentId());
            
            // Get student details for this parent
            Student student = studentRepository.findByStudentId(parent.getStudentId());
            
            if (student != null) {
                System.out.println("Student found: " + student.getFullName() + " (ID: " + student.getStudentId() + ")");
                System.out.println("Student courses: " + student.getCourses());
                
                // Create ONE recipient per parent (not per course)
                // Store courses as comma-separated string
                String coursesStr = (student.getCourses() != null && !student.getCourses().isEmpty()) ? 
                    String.join(", ", student.getCourses()) : "General";
                
                NoticeRecipient recipient = new NoticeRecipient(parent, 
                    student.getStudentId(), 
                    student.getFullName(), 
                    coursesStr);
                
                savedNotice.addRecipient(recipient);
                System.out.println("Added recipient for parent: " + parent.getFullName());
                
            } else {
                System.out.println("WARNING: Student not found for parent: " + parent.getFullName());
                // Fallback - create recipient with available info
                NoticeRecipient recipient = new NoticeRecipient(parent, 
                    parent.getStudentId(), 
                    "Unknown Student", 
                    "General");
                savedNotice.addRecipient(recipient);
            }
        }
        
        // Save the notice with all recipients
        Notice finalNotice = noticeRepository.save(savedNotice);
        
        System.out.println("Notice created with ID: " + finalNotice.getNoticeId());
        System.out.println("Total Recipients: " + finalNotice.getRecipients().size());
        
        // Verify recipients were saved
        List<NoticeRecipient> savedRecipients = noticeRecipientRepository.findByNoticeId(finalNotice.getId());
        System.out.println("Verified recipients in database: " + savedRecipients.size());
        
        return finalNotice;
    }
    
    @Override
    public List<Parent> getTargetParents(Notice.TargetType targetType, String targetValue) {
        List<Parent> parents = new ArrayList<>();
        List<Parent> allParents = parentRepository.findAll();
        
        System.out.println("=== Getting target parents for: " + targetType + " = " + targetValue);
        System.out.println("Total parents in system: " + allParents.size());
        
        switch (targetType) {
            case ALL:
                // Get all parents with active/approved status
                parents = allParents.stream()
                    .filter(p -> p.getStatus() == Parent.ParentStatus.ACTIVE || 
                                 p.getStatus() == Parent.ParentStatus.APPROVED)
                    .collect(Collectors.toList());
                System.out.println("ALL parents (active/approved): " + parents.size());
                break;
                
            case COURSE:
                // Get parents whose children are enrolled in specific course
                List<Student> studentsInCourse = studentRepository.findAll().stream()
                    .filter(s -> s.getCourses() != null && s.getCourses().contains(targetValue))
                    .collect(Collectors.toList());
                
                System.out.println("Students enrolled in course '" + targetValue + "': " + studentsInCourse.size());
                
                for (Student student : studentsInCourse) {
                    System.out.println("Checking student: " + student.getStudentId() + " - " + student.getFullName());
                    
                    // Find parent with matching studentId
                    Parent parent = allParents.stream()
                        .filter(p -> p.getStudentId() != null && 
                                     p.getStudentId().equals(student.getStudentId()) &&
                                     (p.getStatus() == Parent.ParentStatus.ACTIVE || 
                                      p.getStatus() == Parent.ParentStatus.APPROVED))
                        .findFirst()
                        .orElse(null);
                    
                    if (parent != null) {
                        if (!parents.contains(parent)) {
                            parents.add(parent);
                            System.out.println("  -> Added parent: " + parent.getFullName());
                        }
                    } else {
                        System.out.println("  -> No parent found for this student");
                    }
                }
                break;
                
            case STUDENT:
                // Get parent of specific student
                System.out.println("Looking for parent of student ID: " + targetValue);
                
                // First verify the student exists
                Student student = studentRepository.findByStudentId(targetValue);
                if (student != null) {
                    System.out.println("Student found: " + student.getFullName());
                    
                    // Find parent with matching studentId - DIRECT LOOKUP
                    // Instead of stream, try direct repository method
                    Parent parent = parentRepository.findByStudentId(targetValue).orElse(null);
                    
                    if (parent != null) {
                        // Check if parent status allows receiving notices
                        if (parent.getStatus() == Parent.ParentStatus.ACTIVE || 
                            parent.getStatus() == Parent.ParentStatus.APPROVED) {
                            parents.add(parent);
                            System.out.println("Parent found and added: " + parent.getFullName() + 
                                             " (Status: " + parent.getStatus() + ")");
                        } else {
                            System.out.println("Parent found but status is " + parent.getStatus() + 
                                             " - not eligible for notices");
                        }
                    } else {
                        System.out.println("No parent registered for student ID: " + targetValue);
                        
                        // DEBUG: List all parents to see what's in the database
                        System.out.println("All parents in system:");
                        for (Parent p : allParents) {
                            System.out.println("  Parent: " + p.getFullName() + 
                                             ", Student ID: " + p.getStudentId() + 
                                             ", Status: " + p.getStatus());
                        }
                    }
                } else {
                    System.out.println("Student not found with ID: " + targetValue);
                }
                break;
        }
        
        return parents;
    }
    
    @Override
    public List<Notice> getAllNotices() {
        return noticeRepository.findAllOrderByCreatedAtDesc();
    }
    
    @Override
    public Notice getNoticeById(Long id) {
        return noticeRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Notice not found with id: " + id));
    }
    
    @Override
    public Notice getNoticeByNoticeId(String noticeId) {
        return noticeRepository.findByNoticeId(noticeId)
            .orElseThrow(() -> new RuntimeException("Notice not found with ID: " + noticeId));
    }
    
    @Override
    public List<Notice> getNoticesByTargetType(Notice.TargetType targetType) {
        return noticeRepository.findByTargetType(targetType);
    }
    
    @Override
    public List<NoticeRecipient> getNoticesForParent(Long parentId) {
        List<NoticeRecipient> recipients = noticeRecipientRepository.findNoticesForParent(parentId);
        System.out.println("Found " + recipients.size() + " notices for parent ID: " + parentId);
        return recipients;
    }
    
    @Override
    public List<NoticeRecipient> getUnreadNoticesForParent(Long parentId) {
        return noticeRecipientRepository.findByParentIdAndIsReadFalse(parentId);
    }
    
    @Override
    public long countUnreadNoticesForParent(Long parentId) {
        return noticeRecipientRepository.countUnreadNoticesForParent(parentId);
    }
    
    @Override
    public boolean markNoticeAsRead(Long recipientId) {
        try {
            int updated = noticeRecipientRepository.markAsRead(recipientId, LocalDateTime.now());
            return updated > 0;
        } catch (Exception e) {
            System.err.println("Error marking notice as read: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    @Transactional
    public boolean markAllNoticesAsRead(Long parentId) {
        try {
            List<NoticeRecipient> unreadNotices = noticeRecipientRepository.findByParentIdAndIsReadFalse(parentId);
            for (NoticeRecipient recipient : unreadNotices) {
                recipient.setRead(true);
                noticeRecipientRepository.save(recipient);
            }
            return true;
        } catch (Exception e) {
            System.err.println("Error marking all notices as read: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public Map<String, Object> getNoticeStatistics() {
        Map<String, Object> stats = new HashMap<>();
        
        long totalNotices = noticeRepository.count();
        long allNotices = noticeRepository.countByTargetType(Notice.TargetType.ALL);
        long courseNotices = noticeRepository.countByTargetType(Notice.TargetType.COURSE);
        long studentNotices = noticeRepository.countByTargetType(Notice.TargetType.STUDENT);
        
        stats.put("totalNotices", totalNotices);
        stats.put("allNotices", allNotices);
        stats.put("courseNotices", courseNotices);
        stats.put("studentNotices", studentNotices);
        
        return stats;
    }
    
    @Override
    public Map<String, Object> getNoticeDeliveryStatus(Long noticeId) {
        Map<String, Object> status = new HashMap<>();
        
        Notice notice = getNoticeById(noticeId);
        List<NoticeRecipient> recipients = noticeRecipientRepository.findByNoticeId(noticeId);
        
        long totalRecipients = recipients.size();
        long readCount = recipients.stream().filter(NoticeRecipient::isRead).count();
        long unreadCount = totalRecipients - readCount;
        
        status.put("noticeId", notice.getNoticeId());
        status.put("title", notice.getTitle());
        status.put("totalRecipients", totalRecipients);
        status.put("readCount", readCount);
        status.put("unreadCount", unreadCount);
        status.put("readPercentage", totalRecipients > 0 ? (readCount * 100 / totalRecipients) : 0);
        
        return status;
    }
    
    @Override
    @Transactional
    public void deleteNotice(Long id) {
        Notice notice = getNoticeById(id);
        noticeRecipientRepository.deleteByNoticeId(id);
        noticeRepository.delete(notice);
    }
    
    @Override
    public String generateNoticeId() {
        Integer maxIdNumber = noticeRepository.findMaxNoticeIdNumber();
        if (maxIdNumber == null) {
            maxIdNumber = 0;
        }
        int newIdNumber = maxIdNumber + 1;
        return String.format("N%03d", newIdNumber);
    }
}