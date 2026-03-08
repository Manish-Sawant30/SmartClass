package com.example.institute.controller;

import com.example.institute.model.Notice;
import com.example.institute.model.Parent;
import com.example.institute.service.NoticeService;
import com.example.institute.service.ParentService;
import com.example.institute.service.StudentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/notices")
public class NoticeController {
    
    @Autowired
    private NoticeService noticeService;
    
    @Autowired
    private ParentService parentService;
    
    @Autowired
    private StudentService studentService;
    
    // Show all notices (admin)
    @GetMapping
    public String showNotices(Model model) {
        List<Notice> notices = noticeService.getAllNotices();
        Map<String, Object> stats = noticeService.getNoticeStatistics();
        
        model.addAttribute("notices", notices);
        model.addAttribute("stats", stats);
        model.addAttribute("courses", studentService.getAllCourses());
        
        return "admin-notices";
    }
    
    // Show create notice form
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("courses", studentService.getAllCourses());
        model.addAttribute("targetTypes", Notice.TargetType.values());
        return "admin-create-notice";
    }
    
    // Create new notice
    @PostMapping("/create")
    public String createNotice(
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam Notice.TargetType targetType,
            @RequestParam(required = false) String targetValue,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            String adminName = (String) session.getAttribute("adminName");
            if (adminName == null) adminName = "System Admin";
            
            Notice notice = noticeService.createNotice(title, content, targetType, targetValue, adminName);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Notice created successfully! ID: " + notice.getNoticeId() + 
                " | Recipients: " + notice.getRecipientCount());
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error creating notice: " + e.getMessage());
        }
        
        return "redirect:/admin/notices";
    }
    
    // View notice details
    @GetMapping("/{id}")
    public String viewNotice(@PathVariable Long id, Model model) {
        Notice notice = noticeService.getNoticeById(id);
        Map<String, Object> deliveryStatus = noticeService.getNoticeDeliveryStatus(id);
        
        model.addAttribute("notice", notice);
        model.addAttribute("deliveryStatus", deliveryStatus);
        model.addAttribute("recipients", notice.getRecipients());
        
        return "admin-notice-details";
    }
    
    // Delete notice
    @PostMapping("/delete/{id}")
    public String deleteNotice(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            noticeService.deleteNotice(id);
            redirectAttributes.addFlashAttribute("successMessage", "Notice deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting notice: " + e.getMessage());
        }
        return "redirect:/admin/notices";
    }
    
    // Get target parents preview (AJAX)
    @GetMapping("/preview-targets")
    @ResponseBody
    public Map<String, Object> previewTargets(
            @RequestParam Notice.TargetType targetType,
            @RequestParam(required = false) String targetValue) {
        
        List<Parent> parents = noticeService.getTargetParents(targetType, targetValue);
        
        return Map.of(
            "count", parents.size(),
            "parents", parents.stream().map(p -> Map.of(
                "name", p.getFullName(),
                "studentId", p.getStudentId(),
                "email", p.getEmail()
            )).toList()
        );
    }
}