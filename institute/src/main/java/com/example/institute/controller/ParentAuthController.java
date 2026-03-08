package com.example.institute.controller;

import com.example.institute.model.Parent;
import com.example.institute.service.ParentAuthService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/parent-auth")
public class ParentAuthController {
    
    @Autowired
    private ParentAuthService parentAuthService;
    
    // Show parent login page
    @GetMapping("/login")
    public String showLoginPage(HttpServletRequest request, Model model) {
        // If already logged in, redirect to dashboard
        if (parentAuthService.isParentLoggedIn()) {
            return "redirect:/parent/dashboard";
        }
        
        // Check for error parameter
        String error = request.getParameter("error");
        if (error != null) {
            model.addAttribute("error", "Invalid credentials. Please try again.");
        }
        
        return "parentslogin";
    }
    
    // Handle parent login
    @PostMapping("/login")
    public String processLogin(
            @RequestParam("loginId") String loginId,
            @RequestParam("password") String password,
            Model model,
            RedirectAttributes redirectAttributes,
            HttpSession session) {
        
        try {
            // Authenticate parent
            Parent parent = parentAuthService.authenticate(loginId, password);
            
            // Create session
            parentAuthService.createParentSession(parent);
            
            // Redirect to dashboard
            return "redirect:/parent/dashboard";
            
        } catch (RuntimeException e) {
            // Add error message
            model.addAttribute("error", e.getMessage());
            model.addAttribute("loginId", loginId);
            return "parentslogin";
        }
    }
    
    // Parent logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        parentAuthService.invalidateParentSession();
        return "redirect:/parent-auth/login";
    }
    
    // Parent dashboard (protected)
    @GetMapping("/dashboard")
    public String showDashboard(Model model, HttpSession session) {
        // Check if parent is logged in
        if (!parentAuthService.isParentLoggedIn()) {
            return "redirect:/parent-auth/login";
        }
        
        Parent parent = parentAuthService.getCurrentParent();
        model.addAttribute("parent", parent);
        return "Parentdashboard";
    }
    
    // Check parent status (for AJAX calls)
    @GetMapping("/check-status/{parentId}")
    @ResponseBody
    public String checkParentStatus(@PathVariable String parentId) {
        // Implementation to check status
        return "Status check endpoint";
    }
}