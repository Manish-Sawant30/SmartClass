package com.example.institute.controller;

import com.example.institute.model.Parent;
import com.example.institute.model.Suggestion;
import com.example.institute.model.Student;
import com.example.institute.service.ParentService;
import com.example.institute.service.StudentService;
import com.example.institute.service.SuggestionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/suggestions")
public class SuggestionController {
    
    @Autowired
    private SuggestionService suggestionService;
    
    @Autowired
    private ParentService parentService;
    
    @Autowired
    private StudentService studentService;
    
    // ==================== PARENT SUGGESTION METHODS ====================
    
    // Show suggestion form for parent
    @GetMapping("/parent/create")
    public String showSuggestionForm(HttpSession session, Model model) {
        Parent parent = (Parent) session.getAttribute("parent");
        
        if (parent == null) {
            return "redirect:/parents/login";
        }
        
        // Get student details
        Student student = studentService.getStudentByStudentId(parent.getStudentId());
        
        model.addAttribute("parent", parent);
        model.addAttribute("student", student);
        
        return "parent-create-suggestion";
    }
    
    // Submit suggestion (parent)
    @PostMapping("/parent/create")
    public String createSuggestion(
            @RequestParam String subject,
            @RequestParam String message,
            @RequestParam(required = false) String courseName,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        Parent parent = (Parent) session.getAttribute("parent");
        
        if (parent == null) {
            return "redirect:/parents/login";
        }
        
        try {
            System.out.println("=== Parent submitting suggestion ===");
            System.out.println("Parent: " + parent.getFullName());
            System.out.println("Subject: " + subject);
            
            // Get student details
            Student student = studentService.getStudentByStudentId(parent.getStudentId());
            
            Suggestion suggestion = suggestionService.createSuggestion(
                parent,
                parent.getStudentId(),
                student != null ? student.getFullName() : "Unknown",
                courseName,
                subject,
                message
            );
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Your suggestion has been submitted! Reference ID: " + suggestion.getSuggestionId());
            
            return "redirect:/suggestions/parent/list";
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Error submitting suggestion: " + e.getMessage());
            return "redirect:/suggestions/parent/create";
        }
    }
    
    // View parent's suggestions
    @GetMapping("/parent/list")
    public String viewParentSuggestions(HttpSession session, Model model) {
        Parent parent = (Parent) session.getAttribute("parent");
        
        if (parent == null) {
            return "redirect:/parents/login";
        }
        
        List<Suggestion> suggestions = suggestionService.getSuggestionsByParent(parent.getId());
        
        System.out.println("Parent " + parent.getFullName() + " has " + suggestions.size() + " suggestions");
        
        model.addAttribute("suggestions", suggestions);
        
        return "parent-suggestions";
    }
    
    // View single suggestion (parent)
    @GetMapping("/parent/view/{id}")
    public String viewParentSuggestion(@PathVariable Long id, HttpSession session, Model model) {
        Parent parent = (Parent) session.getAttribute("parent");
        
        if (parent == null) {
            return "redirect:/parents/login";
        }
        
        Suggestion suggestion = suggestionService.getSuggestionById(id);
        
        // Verify this suggestion belongs to the parent
        if (!suggestion.getParent().getId().equals(parent.getId())) {
            return "redirect:/suggestions/parent/list";
        }
        
        model.addAttribute("suggestion", suggestion);
        
        return "parent-suggestion-detail";
    }
    
    // ==================== ADMIN SUGGESTION METHODS ====================
    
    // Show all suggestions (admin)
    @GetMapping("/admin/list")
    public String showAllSuggestions(Model model) {
        List<Suggestion> suggestions = suggestionService.getAllSuggestions();
        Map<String, Object> stats = suggestionService.getSuggestionStatistics();
        
        System.out.println("Admin viewing all suggestions. Count: " + suggestions.size());
        
        model.addAttribute("suggestions", suggestions);
        model.addAttribute("stats", stats);
        
        return "admin-suggestions";
    }
    
    // Filter by status (admin)
    @GetMapping("/admin/filter/{status}")
    public String filterByStatus(@PathVariable Suggestion.SuggestionStatus status, Model model) {
        List<Suggestion> suggestions = suggestionService.getSuggestionsByStatus(status);
        Map<String, Object> stats = suggestionService.getSuggestionStatistics();
        
        model.addAttribute("suggestions", suggestions);
        model.addAttribute("stats", stats);
        model.addAttribute("currentFilter", status);
        
        return "admin-suggestions";
    }
    
    // View suggestion details (admin)
    @GetMapping("/admin/view/{id}")
    public String viewSuggestionDetails(@PathVariable Long id, Model model) {
        try {
            Suggestion suggestion = suggestionService.getSuggestionById(id);
            
            System.out.println("Admin viewing suggestion ID: " + id + " from " + suggestion.getParentName());
            
            model.addAttribute("suggestion", suggestion);
            model.addAttribute("statuses", Suggestion.SuggestionStatus.values());
            
            return "admin-suggestion-detail";
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Suggestion not found");
            return "redirect:/suggestions/admin/list";
        }
    }
    
    // Respond to suggestion (admin)
    @PostMapping("/admin/respond/{id}")
    public String respondToSuggestion(
            @PathVariable Long id,
            @RequestParam String response,
            @RequestParam Suggestion.SuggestionStatus status,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            String adminName = (String) session.getAttribute("adminName");
            if (adminName == null) adminName = "Admin";
            
            System.out.println("Admin responding to suggestion ID: " + id);
            System.out.println("Response: " + response);
            System.out.println("Status: " + status);
            
            Suggestion suggestion = suggestionService.respondToSuggestion(id, response, adminName);
            
            // Update status if different
            if (status != suggestion.getStatus()) {
                suggestion = suggestionService.updateSuggestionStatus(id, status);
            }
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Response sent to " + suggestion.getParentName());
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Error responding to suggestion: " + e.getMessage());
        }
        
        return "redirect:/suggestions/admin/view/" + id;
    }
    
    // Mark suggestion as read (admin)
    @PostMapping("/admin/mark-read/{id}")
    public String markAsRead(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            suggestionService.updateSuggestionStatus(id, Suggestion.SuggestionStatus.READ);
            redirectAttributes.addFlashAttribute("successMessage", "Suggestion marked as read");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating suggestion");
        }
        return "redirect:/suggestions/admin/view/" + id;
    }
    
    // Delete suggestion (admin)
    @PostMapping("/admin/delete/{id}")
    public String deleteSuggestion(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            suggestionService.deleteSuggestion(id);
            redirectAttributes.addFlashAttribute("successMessage", "Suggestion deleted successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting suggestion: " + e.getMessage());
        }
        
        return "redirect:/suggestions/admin/list";
    }
}