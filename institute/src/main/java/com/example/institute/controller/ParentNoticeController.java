package com.example.institute.controller;

import com.example.institute.model.NoticeRecipient;
import com.example.institute.model.Parent;
import com.example.institute.service.NoticeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/parent/notices")
public class ParentNoticeController {
    
    @Autowired
    private NoticeService noticeService;
    
    // Show all notices for parent
    @GetMapping
    public String showParentNotices(HttpSession session, Model model) {
        Parent parent = (Parent) session.getAttribute("parent");
        
        if (parent == null) {
            return "redirect:/parents/login";
        }
        
        List<NoticeRecipient> notices = noticeService.getNoticesForParent(parent.getId());
        long unreadCount = noticeService.countUnreadNoticesForParent(parent.getId());
        
        model.addAttribute("notices", notices);
        model.addAttribute("unreadCount", unreadCount);
        
        return "parent-notices";
    }
    
    // View single notice
    @GetMapping("/{id}")
    public String viewNotice(@PathVariable Long id, HttpSession session, Model model) {
        Parent parent = (Parent) session.getAttribute("parent");
        
        if (parent == null) {
            return "redirect:/parents/login";
        }
        
        // Find the recipient record
        List<NoticeRecipient> notices = noticeService.getNoticesForParent(parent.getId());
        NoticeRecipient notice = notices.stream()
            .filter(n -> n.getId().equals(id))
            .findFirst()
            .orElse(null);
        
        if (notice == null) {
            return "redirect:/parent/notices";
        }
        
        // Mark as read if not already
        if (!notice.isRead()) {
            noticeService.markNoticeAsRead(id);
        }
        
        model.addAttribute("notice", notice);
        
        return "parent-notice-detail";
    }
    
    // Mark a single notice as read
    @PostMapping("/mark-read/{id}")
    @ResponseBody
    public Map<String, Object> markAsRead(@PathVariable Long id, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Parent parent = (Parent) session.getAttribute("parent");
        
        if (parent == null) {
            response.put("success", false);
            response.put("message", "Not logged in");
            return response;
        }
        
        boolean success = noticeService.markNoticeAsRead(id);
        response.put("success", success);
        
        if (success) {
            long unreadCount = noticeService.countUnreadNoticesForParent(parent.getId());
            response.put("unreadCount", unreadCount);
        }
        
        return response;
    }
    
    // Mark all as read
    @PostMapping("/mark-all-read")
    public String markAllAsRead(HttpSession session, RedirectAttributes redirectAttributes) {
        Parent parent = (Parent) session.getAttribute("parent");
        
        if (parent == null) {
            return "redirect:/parents/login";
        }
        
        boolean success = noticeService.markAllNoticesAsRead(parent.getId());
        
        if (success) {
            redirectAttributes.addFlashAttribute("successMessage", "All notices marked as read!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Error marking notices as read");
        }
        
        return "redirect:/parent/notices";
    }
    
    // Get unread count (AJAX)
    @GetMapping("/unread-count")
    @ResponseBody
    public Map<String, Object> getUnreadCount(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Parent parent = (Parent) session.getAttribute("parent");
        
        if (parent == null) {
            response.put("error", "Not logged in");
            return response;
        }
        
        long count = noticeService.countUnreadNoticesForParent(parent.getId());
        
        response.put("unreadCount", count);
        return response;
    }
}