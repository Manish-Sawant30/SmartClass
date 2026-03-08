package com.example.institute.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
    
    @GetMapping("/test-api")
    public String testApi(Model model) {
        // Test if controller is working
        model.addAttribute("message", "API Test Successful!");
        model.addAttribute("time", new java.util.Date());
        return "test";
    }
    
    @GetMapping("/test-db")
    public String testDatabase(Model model) {
        try {
            // Add simple test to check if database is accessible
            model.addAttribute("dbStatus", "Connected");
            model.addAttribute("message", "Database connection test");
        } catch (Exception e) {
            model.addAttribute("dbStatus", "Error: " + e.getMessage());
        }
        return "test";
    }
}