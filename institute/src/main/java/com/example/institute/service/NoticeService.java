package com.example.institute.service;

import com.example.institute.model.Notice;
import com.example.institute.model.NoticeRecipient;
import com.example.institute.model.Parent;

import java.util.List;
import java.util.Map;

public interface NoticeService {
    
    // Create and send notices
    Notice createNotice(String title, String content, Notice.TargetType targetType, 
                       String targetValue, String createdBy);
    
    // Get notices
    List<Notice> getAllNotices();
    Notice getNoticeById(Long id);
    Notice getNoticeByNoticeId(String noticeId);
    List<Notice> getNoticesByTargetType(Notice.TargetType targetType);
    
    // For parents
    List<NoticeRecipient> getNoticesForParent(Long parentId);
    List<NoticeRecipient> getUnreadNoticesForParent(Long parentId);
    long countUnreadNoticesForParent(Long parentId);
    boolean markNoticeAsRead(Long recipientId);
    boolean markAllNoticesAsRead(Long parentId);
    
    // For admins
    Map<String, Object> getNoticeStatistics();
    List<Parent> getTargetParents(Notice.TargetType targetType, String targetValue);
    Map<String, Object> getNoticeDeliveryStatus(Long noticeId);
    
    // Delete
    void deleteNotice(Long id);
    
    // ID generation
    String generateNoticeId();
}