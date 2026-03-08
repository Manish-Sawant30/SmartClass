package com.example.institute.controller;

import com.example.institute.service.AdminService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private AdminService adminService;
    
    // Session attribute keys
    private static final String SESSION_ADMIN = "adminLoggedIn";
    private static final String SESSION_USERNAME = "adminUsername";
    
    /**
     * Show admin login page
     */
    @GetMapping("/login")
    public String showLoginPage(HttpSession session) {
        // If already logged in, redirect to dashboard
        if (session.getAttribute(SESSION_ADMIN) != null) {
            return "redirect:/admindash";
        }
        return "Adminlogin";
    }
    
    /**
     * Handle admin login form submission
     */
    @PostMapping("/login")
    public String loginAdmin(
            @RequestParam String username,
            @RequestParam String password,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {
        
        // Authenticate admin
        Map<String, Object> authResult = adminService.authenticateAdmin(username, password);
        
        if ((Boolean) authResult.get("success")) {
            // Set session attributes
            session.setAttribute(SESSION_ADMIN, true);
            session.setAttribute(SESSION_USERNAME, username);
            
            // Add success message
            redirectAttributes.addFlashAttribute("success", authResult.get("message"));
            return "redirect:/admindash";
        } else {
            // Add error message and username back to model
            model.addAttribute("error", authResult.get("message"));
            model.addAttribute("username", username);
            return "Adminlogin";
        }
    }
    
    /**
     * Admin logout
     */
    @GetMapping("/logout")
    public String logoutAdmin(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("success", "Logged out successfully!");
        return "redirect:/admin/login";
    }
    
    /**
     * Check if admin is logged in (for other controllers to use)
     */
    public static boolean isAdminLoggedIn(HttpSession session) {
        return session.getAttribute(SESSION_ADMIN) != null;
    }
    
    /**
     * Get logged in admin username
     */
    public static String getLoggedInAdmin(HttpSession session) {
        return (String) session.getAttribute(SESSION_USERNAME);
    }
}