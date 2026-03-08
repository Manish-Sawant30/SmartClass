package com.example.institute.controller;

import com.example.institute.model.Parent;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    
    // ==================== HOME & REDIRECT LOGIC ====================
    
    @GetMapping("/")
    public String home(HttpSession session) {
       
        return "index";
    }
    
    
    @GetMapping("/parents")
    public String parentsHome(HttpSession session) {
        // Check if parent is logged in
        if (session.getAttribute("parent") != null) {
            return "redirect:/parent/dashboard";
        }
        return "redirect:/parents/login";
    }
    
    @GetMapping("/parent")
    public String parentHome(HttpSession session) {
        // Check if parent is logged in
        if (session.getAttribute("parent") != null) {
            return "redirect:/parent/dashboard";
        }
        return "redirect:/parents/login";
    }
    
    // ==================== PARENT DASHBOARD ACCESS ====================
    
    @GetMapping("/parent-dashboard")
    public String parentDashboardRedirect(HttpSession session) {
        // Check if parent is logged in
        if (session.getAttribute("parent") == null) {
            return "redirect:/parents/login";
        }
        return "redirect:/parent/dashboard";
    }
    
    // ==================== EXISTING METHODS (KEEP ALL) ====================
    
    @GetMapping("/admindash")
    public String adminDash(HttpSession session, org.springframework.ui.Model model) {
        // Check if admin is logged in
        if (!AdminController.isAdminLoggedIn(session)) {
            model.addAttribute("error", "Please login as admin first!");
            return "redirect:/admin/login";
        }
        
        // Add admin username to model
        String adminUsername = AdminController.getLoggedInAdmin(session);
        model.addAttribute("adminUsername", adminUsername);
        
        return "Admindash";
    }

    @GetMapping("/adminlogin")
    public String adminLogin() { return "Adminlogin"; }

    @GetMapping("/admission")
    public String admission() { return "Admission"; }

    @GetMapping("/ai-quiz")
    public String aiQuiz() { return "ai-quiz"; }

    @GetMapping("/android-quiz")
    public String androidQuiz() { return "android-quiz"; }

    @GetMapping("/cpp-content")
    public String cppContent() { return "c++Content"; }

    @GetMapping("/certificate-error")
    public String certificateError() { return "CertificateError"; }

    @GetMapping("/certificateF1")
    public String certificateF1() { 
        return "redirect:/certificate/verify"; 
    }

    @GetMapping("/certificate-success")
    public String certificateSuccess() { 
        return "redirect:/certificate/view"; 
    }
    @GetMapping("/cloud-quiz")
    public String cloudQuiz() { return "cloud-quiz"; }

    @GetMapping("/contact")
    public String contact() { return "Contact"; }

    @GetMapping("/courses-attendance")
    public String coursesAttendance() { return "Courses_Attendance"; }

    
    
    @GetMapping("/courses")
    public String courses() {
        return "Courses"; // Static courses page for teachers to select course
    }
    @GetMapping("/courses-store")
    public String coursesStore() { return "Coursesstore"; }

    @GetMapping("/cpp-quiz")
    public String cppQuiz() { return "cpp-quiz"; }

    @GetMapping("/cybersecurity-quiz")
    public String cyberQuiz() { return "cybersecurity-quiz"; }

    @GetMapping("/dbms-quiz")
    public String dbmsQuiz() { return "dbms-quiz"; }

    @GetMapping("/dsa-quiz")
    public String dsaQuiz() { return "dsa-quiz"; }

    @GetMapping("/exam")
    public String exam() { return "Exam"; }

    @GetMapping("/fullstack-quiz")
    public String fullstackQuiz() { return "fullstack-quiz"; }

    @GetMapping("/git-quiz")
    public String gitQuiz() { return "git-quiz"; }

    @GetMapping("/giveexamc")
    public String giveExamC() { return "GiveExamC"; }

    @GetMapping("/home-about")
    public String homeAbout() { return "Homeabout"; }

    @GetMapping("/home-contact")
    public String homeContact() { return "Homecontact"; }

    @GetMapping("/home-courses")
    public String homeCourses() { return "Homecourses"; }

    @GetMapping("/java-quiz")
    public String javaQuiz() { return "java-quiz"; }

    @GetMapping("/javascript-quiz")
    public String javascriptQuiz() { return "javascript-quiz"; }

    @GetMapping("/loginusers")
    public String loginUsers() { return "loginusers"; }

    @GetMapping("/markattendance")
    public String markAttendance() { return "Markattendance"; }

    @GetMapping("/networks-quiz")
    public String networksQuiz() { return "networks-quiz"; }

    @GetMapping("/notes")
    public String notes() { return "Notes"; }

    @GetMapping("/os-quiz")
    public String osQuiz() { return "os-quiz"; }

    @GetMapping("/parent-child-progress")
    public String parentChildProgress() { return "Parent_ChildProgress"; }

    @GetMapping("/parent-attendance")
    public String parentAttendance() { return "Parentattendance"; }

    @GetMapping("/parent-contact")
    public String parentContact() { return "Parentcontact"; }

    @GetMapping("/parent-invalid")
    public String parentInvalid() { return "parent-invalid"; }

    @GetMapping("/parent-login")
    public String parentLogin() { return "ParentLoginPage"; }
    
    @GetMapping("/parent-signup")
    public String parentSignUp() { 
        return "redirect:/parent/signup"; 
    }

    @GetMapping("/parentstore")
    public String parentStore() { 
        return "redirect:/parent/store"; 
    }

   
    @GetMapping("/parent-valid")
    public String parentValid() { return "parent-valid"; }

    @GetMapping("/purchase")
    public String purchase() { return "purchase"; }

    @GetMapping("/python-quiz")
    public String pythonQuiz() { return "python-quiz"; }

    @GetMapping("/quiz-results")
    public String quizResults() { return "quiz-results"; }

    @GetMapping("/signup")
    public String signup() { return "signup"; }

    @GetMapping("/software-engineering-quiz")
    public String softwareEngineeringQuiz() { return "software-engineering-quiz"; }

    
    
    @GetMapping("/student-course")
    public String studentCourse() {
        return "redirect:/content/student/portal";
    }
    
    @GetMapping("/student-signup")
    public String studentSignup() { 
        return "redirect:/student/signup"; 
    }
    
    @GetMapping("/studentstore")
    public String studentStore() {
        return "redirect:/student/dashboard";
    }

    @GetMapping("/student-signup-success")
    public String studSignUpSuccess() { return "StudSignUpSuccess"; }

    @GetMapping("/teacher-signup")
    public String teacherSignUp() { 
        return "redirect:/teacher/signup"; 
    }

    @GetMapping("/teacher-store")
    public String teacherStore() { 
        return "redirect:/teacher/store"; 
    }
    @GetMapping("/teacher-login")
    public String teacherlogin() { return "Teacherlogin"; }

    @GetMapping("/teacher-success")
    public String teacherSuccess() { return "TeacherSuccessWindow"; }

   
    
    @GetMapping("/upload-notes")
    public String uploadNotes() {
        return "redirect:/content/instructor/dashboard";
    }
}