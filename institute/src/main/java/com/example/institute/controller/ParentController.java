package com.example.institute.controller;

import com.example.institute.dto.ParentRegistrationDTO;
import com.example.institute.model.Parent;
import com.example.institute.service.ParentService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/parent")
public class ParentController {
    
    @Autowired
    private ParentService parentService;
    
    @Autowired
    private ObjectMapper objectMapper;
    
    // Show registration form
    @GetMapping("/signup")
    public String showRegistrationForm(Model model) {
        model.addAttribute("parent", new ParentRegistrationDTO());
        return "ParentSignUp";
    }
    
    // Handle registration
    @PostMapping("/signup")
    public String registerParent(
            @ModelAttribute ParentRegistrationDTO parentDTO,
            @RequestParam(value = "courses", required = false) String coursesJson,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            System.out.println("Registering parent: " + parentDTO.getFullName());
            
            // Validate password match
            if (!parentDTO.getPassword().equals(parentDTO.getConfirmPassword())) {
                model.addAttribute("error", "Passwords do not match");
                return "ParentSignUp";
            }
            
            // Create parent entity
            Parent parent = new Parent();
            parent.setFullName(parentDTO.getFullName());
            parent.setEmail(parentDTO.getEmail());
            parent.setMobileNumber(parentDTO.getMobileNumber());
            parent.setStudentId(parentDTO.getStudentId());
            parent.setPassword(parentDTO.getPassword());
            
            // Parse and add courses from JSON
            if (coursesJson != null && !coursesJson.isEmpty()) {
                try {
                    List<String> courses = objectMapper.readValue(coursesJson, new TypeReference<List<String>>() {});
                    for (String courseName : courses) {
                        parent.addCourse(courseName);
                    }
                    System.out.println("Added " + courses.size() + " courses for parent");
                } catch (Exception e) {
                    System.err.println("Error parsing courses JSON: " + e.getMessage());
                    model.addAttribute("error", "Error processing courses data");
                    return "ParentSignUp";
                }
            } else {
                model.addAttribute("error", "No courses found for this student");
                return "ParentSignUp";
            }
            
            // Register parent
            Parent registeredParent = parentService.registerParent(parent);
            
            // Set success message in session
            session.setAttribute("successMessage", 
                "Registration successful! Your Parent ID: " + registeredParent.getParentId() + 
                ". You can now login.");
            
            System.out.println("Registration successful. Parent ID: " + registeredParent.getParentId());
            
            return "redirect:/parent/store";
            
        } catch (Exception e) {
            System.err.println("Registration failed: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", e.getMessage());
            model.addAttribute("parent", parentDTO);
            return "ParentSignUp";
        }
    }
    
    // Show dashboard
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        Parent parent = (Parent) session.getAttribute("parent");
        
        if (parent == null) {
            session.setAttribute("loginError", "Please login to access dashboard");
            return "redirect:/parents/login";
        }
        
        Parent currentParent = parentService.getParentById(parent.getId());
        if (currentParent != null) {
            session.setAttribute("parent", currentParent);
            model.addAttribute("parent", currentParent);
        } else {
            model.addAttribute("parent", parent);
        }
        
        return "Parentdashboard";
    }
    
    // Show admin parent store
    @GetMapping("/store")
    public String showParentStore(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String status,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {
        
        // Check if admin is logged in
        if (session.getAttribute("admin") == null && !AdminController.isAdminLoggedIn(session)) {
            System.out.println("Admin not logged in, redirecting to admin login");
            redirectAttributes.addFlashAttribute("errorMessage", "Please login as admin first");
            return "redirect:/admin/login";
        }
        
        System.out.println("=== ACCESSING PARENT STORE PAGE ===");
        
        // Get parents based on search/filter
        List<Parent> parents;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            parents = parentService.searchParents(keyword);
        } else if (status != null && !status.trim().isEmpty()) {
            try {
                Parent.ParentStatus parentStatus = Parent.ParentStatus.valueOf(status.toUpperCase());
                parents = parentService.getParentsByStatus(parentStatus);
            } catch (IllegalArgumentException e) {
                parents = parentService.getAllParents();
            }
        } else {
            parents = parentService.getAllParents();
        }
        
        // Get counts for each status
        long pendingCount = parentService.getParentsByStatus(Parent.ParentStatus.PENDING).size();
        long approvedCount = parentService.getParentsByStatus(Parent.ParentStatus.APPROVED).size();
        long rejectedCount = parentService.getParentsByStatus(Parent.ParentStatus.REJECTED).size();
        long activeCount = parentService.getParentsByStatus(Parent.ParentStatus.ACTIVE).size();
        long inactiveCount = parentService.getParentsByStatus(Parent.ParentStatus.INACTIVE).size();
        long totalParents = parentService.getAllParents().size();
        
        model.addAttribute("parents", parents);
        model.addAttribute("searchKeyword", keyword);
        model.addAttribute("statusFilter", status);
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("approvedCount", approvedCount);
        model.addAttribute("rejectedCount", rejectedCount);
        model.addAttribute("activeCount", activeCount);
        model.addAttribute("inactiveCount", inactiveCount);
        model.addAttribute("totalParents", totalParents);
        
        return "Parentstore";
    }
    
    // ==================== STATUS MANAGEMENT METHODS ====================
    
    @PostMapping("/approve/{id}")
    public String approveParent(@PathVariable Long id,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("admin") == null && !AdminController.isAdminLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please login as admin first");
            return "redirect:/admin/login";
        }
        
        try {
            Parent parent = parentService.getParentById(id);
            if (parent == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Parent not found");
                return "redirect:/parent/store";
            }
            
            // Set status to ACTIVE
            parent.setStatus(Parent.ParentStatus.ACTIVE);
            parent.setRejectionReason(null);
            parentService.updateParent(id, parent);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Parent " + parent.getFullName() + " approved successfully!");
                
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error approving parent: " + e.getMessage());
        }
        
        return "redirect:/parent/store";
    }
    
    @PostMapping("/reject/{id}")
    public String rejectParent(@PathVariable Long id,
                               @RequestParam(required = false) String rejectionReason,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("admin") == null && !AdminController.isAdminLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please login as admin first");
            return "redirect:/admin/login";
        }
        
        try {
            Parent parent = parentService.getParentById(id);
            if (parent == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Parent not found");
                return "redirect:/parent/store";
            }
            
            // Set status to REJECTED
            parent.setStatus(Parent.ParentStatus.REJECTED);
            parent.setRejectionReason(rejectionReason != null ? rejectionReason : "Rejected by admin");
            parentService.updateParent(id, parent);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Parent " + parent.getFullName() + " rejected successfully!");
                
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error rejecting parent: " + e.getMessage());
        }
        
        return "redirect:/parent/store";
    }
    
    @PostMapping("/activate/{id}")
    public String activateParent(@PathVariable Long id,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("admin") == null && !AdminController.isAdminLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please login as admin first");
            return "redirect:/admin/login";
        }
        
        try {
            Parent parent = parentService.getParentById(id);
            if (parent == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Parent not found");
                return "redirect:/parent/store";
            }
            
            // Set status to ACTIVE
            parent.setStatus(Parent.ParentStatus.ACTIVE);
            parentService.updateParent(id, parent);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Parent " + parent.getFullName() + " activated successfully!");
                
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error activating parent: " + e.getMessage());
        }
        
        return "redirect:/parent/store";
    }
    
    @PostMapping("/deactivate/{id}")
    public String deactivateParent(@PathVariable Long id,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("admin") == null && !AdminController.isAdminLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please login as admin first");
            return "redirect:/admin/login";
        }
        
        try {
            Parent parent = parentService.getParentById(id);
            if (parent == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Parent not found");
                return "redirect:/parent/store";
            }
            
            // Set status to INACTIVE
            parent.setStatus(Parent.ParentStatus.INACTIVE);
            parentService.updateParent(id, parent);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Parent " + parent.getFullName() + " deactivated successfully!");
                
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deactivating parent: " + e.getMessage());
        }
        
        return "redirect:/parent/store";
    }
    
    @PostMapping("/delete/{id}")
    public String deleteParent(@PathVariable Long id, 
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("admin") == null && !AdminController.isAdminLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please login as admin first");
            return "redirect:/admin/login";
        }
        
        try {
            Parent parent = parentService.getParentById(id);
            if (parent != null) {
                String parentName = parent.getFullName();
                parentService.deleteParent(id);
                redirectAttributes.addFlashAttribute("successMessage", 
                    "Parent " + parentName + " deleted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Parent not found");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting parent: " + e.getMessage());
        }
        
        return "redirect:/parent/store";
    }
    
    // Keep the old update-status method for backward compatibility
    @PostMapping("/update-status/{id}")
    public String updateParentStatus(
            @PathVariable Long id,
            @RequestParam Parent.ParentStatus status,
            @RequestParam(required = false) String rejectionReason,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("admin") == null && !AdminController.isAdminLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please login as admin first");
            return "redirect:/admin/login";
        }
        
        try {
            Parent parent = parentService.getParentById(id);
            if (parent == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Parent not found");
                return "redirect:/parent/store";
            }
            
            parent.setStatus(status);
            if (status == Parent.ParentStatus.REJECTED) {
                parent.setRejectionReason(rejectionReason != null ? rejectionReason : "Rejected by admin");
            } else {
                parent.setRejectionReason(null);
            }
            
            parentService.updateParent(id, parent);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Parent " + parent.getFullName() + " status updated to " + status);
                
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating status: " + e.getMessage());
        }
        
        return "redirect:/parent/store";
    }
    
}