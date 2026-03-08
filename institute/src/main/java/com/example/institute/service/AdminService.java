package com.example.institute.service;

import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.Map;

@Service
public class AdminService {
    
    // Hardcoded admin credentials as per your requirement
    private static final String ADMIN_USERNAME = "Admin";
    private static final String ADMIN_PASSWORD = "Admin2025";
    
    /**
     * Authenticate admin credentials
     * @param username Username input
     * @param password Password input
     * @return Map containing authentication result and message
     */
    public Map<String, Object> authenticateAdmin(String username, String password) {
        Map<String, Object> result = new HashMap<>();
        
        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            result.put("success", true);
            result.put("message", "Login successful!");
        } else if (!ADMIN_USERNAME.equals(username) && !ADMIN_PASSWORD.equals(password)) {
            result.put("success", false);
            result.put("message", "Invalid username and password!");
        } else if (!ADMIN_USERNAME.equals(username)) {
            result.put("success", false);
            result.put("message", "Invalid username!");
        } else {
            result.put("success", false);
            result.put("message", "Invalid password!");
        }
        
        return result;
    }
}