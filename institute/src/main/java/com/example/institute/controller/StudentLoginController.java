package com.example.institute.controller;

import com.example.institute.model.Student;
import com.example.institute.service.StudentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class StudentLoginController {

    @Autowired
    private StudentService studentService;

    // Display login page
    @GetMapping("/student-login")
    public String showLoginPage() {
        return "studentlogin";
    }

    // Process login
    @PostMapping("/student-login")
    public String processLogin(
            @RequestParam("userId") String userId,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {
        
        try {
            // Remove any whitespace
            userId = userId.trim();
            password = password.trim();
            
            // Login with the identifier (could be email or student ID)
            Student student = studentService.login(userId, password);
            
            // Store student in session
            session.setAttribute("student", student);
            session.setAttribute("studentId", student.getStudentId());
            session.setAttribute("studentName", student.getFullName());
            
            return "redirect:/student-dashboard";
            
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "studentlogin";
        }
    }

    // Student dashboard
    @GetMapping("/student-dashboard")
    public String showDashboard(HttpSession session, Model model) {
        // Check if student is logged in
        Student student = (Student) session.getAttribute("student");
        
        if (student == null) {
            return "redirect:/student-login";
        }
        
        model.addAttribute("student", student);
        return "Studentdashboard";
    }
 // Add to StudentLoginController.java

    @GetMapping("/studenttestscore")
    public String studentTestScore(HttpSession session, Model model) {
        // Check if student is logged in
        Student student = (Student) session.getAttribute("student");
        
        if (student == null) {
            return "redirect:/student-login";
        }
        
        // You can add student info to model if needed
        model.addAttribute("student", student);
        model.addAttribute("studentId", student.getStudentId());
        model.addAttribute("studentName", student.getFullName());
        
        return "studenttestscore";
    }
    // Logout
    @GetMapping("/student-logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/student-login";
    }
}