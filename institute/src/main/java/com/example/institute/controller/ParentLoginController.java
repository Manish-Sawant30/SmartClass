package com.example.institute.controller;

import com.example.institute.model.Parent;
import com.example.institute.service.ParentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/parents")
public class ParentLoginController {
    
    @Autowired
    private ParentService parentService;
    
    // Show login page - ALWAYS show login form, no redirect
    @GetMapping("/login")
    public String showLoginPage(HttpSession session, Model model) {
        // NO AUTO-REDIRECT - Always show login page
        
        // Check for error message in session
        String error = (String) session.getAttribute("loginError");
        if (error != null) {
            model.addAttribute("error", error);
            session.removeAttribute("loginError");
        }
        
        // Check for success message (after registration)
        String success = (String) session.getAttribute("successMessage");
        if (success != null) {
            model.addAttribute("success", success);
            session.removeAttribute("successMessage");
        }
        
        return "parentslogin";
    }
    
    // Handle login - ALWAYS process login attempt
    @PostMapping("/login")
    public String processLogin(
            @RequestParam("userId") String userId,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {
        
        try {
            System.out.println("Login attempt for: " + userId);
            
            // Check if user is already logged in
            Parent existingParent = (Parent) session.getAttribute("parent");
            if (existingParent != null) {
                System.out.println("Already logged in as: " + existingParent.getFullName());
                // Still authenticate to check credentials
                // This allows users to login as different account
            }
            
            // Authenticate parent
            Parent parent = parentService.authenticateParent(userId, password);
            
            // Create/Update session
            session.setAttribute("parent", parent);
            session.setAttribute("parentId", parent.getParentId());
            session.setAttribute("parentName", parent.getFullName());
            session.setAttribute("parentEmail", parent.getEmail());
            session.setAttribute("parentStatus", parent.getStatus().toString());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            System.out.println("Login successful for: " + parent.getFullName());
            
            // Clear any previous errors
            session.removeAttribute("loginError");
            
            return "redirect:/parent/dashboard";
            
        } catch (Exception e) {
            System.err.println("Login failed: " + e.getMessage());
            
            // Clear session if login failed
            session.removeAttribute("parent");
            session.removeAttribute("parentId");
            session.removeAttribute("parentName");
            
            model.addAttribute("error", e.getMessage());
            model.addAttribute("userId", userId);
            return "parentslogin";
        }
    }
    
    // Logout - clear session and show login page
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/parents/login";
    }
    
    // Quick login check endpoint (optional)
    @GetMapping("/check")
    @ResponseBody
    public String checkLoginStatus(HttpSession session) {
        if (session.getAttribute("parent") != null) {
            Parent parent = (Parent) session.getAttribute("parent");
            return "Logged in as: " + parent.getFullName() + " (" + parent.getParentId() + ")";
        }
        return "Not logged in";
    }
}