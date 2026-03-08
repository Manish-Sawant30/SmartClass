package com.example.institute.interceptor;

import com.example.institute.controller.AdminController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AdminAuthInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, 
                           HttpServletResponse response, 
                           Object handler) throws Exception {
        
        HttpSession session = request.getSession();
        String requestURI = request.getRequestURI();
        
        // Allow login page and login action
        if (requestURI.equals("/admin/login") || 
            requestURI.equals("/admin/login/") ||
            requestURI.equals("/admin") ||
            requestURI.equals("/admin/")) {
            return true;
        }
        
        // Check if accessing admin dashboard without login
        if (requestURI.equals("/admindash") || 
            requestURI.startsWith("/admin/")) {
            
            if (!AdminController.isAdminLoggedIn(session)) {
                // If not logged in, redirect to login page with error message
                session.setAttribute("loginError", "Please login to access admin dashboard");
                response.sendRedirect("/admin/login");
                return false;
            }
        }
        
        return true;
    }
}