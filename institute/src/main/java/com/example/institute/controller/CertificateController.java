package com.example.institute.controller;

import com.example.institute.model.Student;
import com.example.institute.model.StudentCertificate;
import com.example.institute.service.CertificateService;
import com.example.institute.service.StudentService;
import com.example.institute.service.MCQService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/certificate")
public class CertificateController {

    @Autowired
    private StudentService studentService;
    
    @Autowired
    private CertificateService certificateService;
    
    @Autowired
    private MCQService mcqService;

    // Show certificate verification form
    @GetMapping("/verify")
    public String showVerificationForm(Model model) {
        System.out.println("=== CERTIFICATE VERIFICATION PAGE LOADED ===");
        return "certificateF1";
    }

    // API endpoint to verify student credentials and get eligible courses
    @PostMapping("/api/student/verify")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> verifyStudent(@RequestBody Map<String, String> credentials) {
        Map<String, Object> response = new HashMap<>();
        try {
            String studentId = credentials.get("studentId");
            String password = credentials.get("password");
            
            System.out.println("=== API VERIFY STUDENT ===");
            System.out.println("Student ID: " + studentId);
            
            // Verify student credentials
            Student student = studentService.login(studentId, password);
            
            if (student == null) {
                response.put("success", false);
                response.put("message", "Invalid Student ID or Password");
                return ResponseEntity.ok(response);
            }
            
            // Check if student is active
            if (!"Active".equals(student.getStatus())) {
                response.put("success", false);
                response.put("message", "Your account is not active. Status: " + student.getStatus());
                return ResponseEntity.ok(response);
            }
            
            // Get student's enrolled courses
            List<String> courses = student.getCourses();
            
            // Get eligibility data for ALL courses
            Map<String, Boolean> eligibleCourses = new HashMap<>();
            Map<String, Double> courseAverages = new HashMap<>();
            Map<String, Boolean> finalTestPassed = new HashMap<>();
            
            // Get student statistics once
            Map<String, Object> stats = mcqService.getStudentStatistics(studentId);
            Map<String, Object> courseStats = (Map<String, Object>) stats.get("courseStats");
            
            for (String course : courses) {
                // Check if eligible for certificate (unit tests all passed + final test passed)
                boolean isEligible = mcqService.isEligibleForCertificate(studentId, course);
                eligibleCourses.put(course, isEligible);
                
                // Get unit test average - FIXED: Handle potential Long to Double conversion
                Double avg = 0.0;
                Boolean finalPassed = false;
                
                if (courseStats != null && courseStats.containsKey(course)) {
                    Map<String, Object> courseInfo = (Map<String, Object>) courseStats.get(course);
                    
                    // FIX: Safely convert Number to Double
                    Object avgObj = courseInfo.get("avgPercentage");
                    if (avgObj instanceof Number) {
                        avg = ((Number) avgObj).doubleValue();
                    }
                    
                    Object finalPassedObj = courseInfo.get("finalTestPassed");
                    if (finalPassedObj instanceof Boolean) {
                        finalPassed = (Boolean) finalPassedObj;
                    }
                }
                
                courseAverages.put(course, avg);
                finalTestPassed.put(course, finalPassed != null ? finalPassed : false);
            }
            
            // Count eligible courses
            long eligibleCount = eligibleCourses.values().stream().filter(v -> v).count();
            
            response.put("success", true);
            response.put("studentId", student.getStudentId());
            response.put("studentName", student.getFullName());
            response.put("courses", courses);
            response.put("eligibleCourses", eligibleCourses);
            response.put("courseAverages", courseAverages);
            response.put("finalTestPassed", finalTestPassed);
            response.put("eligibleCount", eligibleCount);
            
            System.out.println("Eligible courses count: " + eligibleCount);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // Process certificate verification
    @PostMapping("/verify")
    public String verifyCertificate(
            @RequestParam("studentId") String studentId,
            @RequestParam("password") String password,
            @RequestParam(value = "courseName", required = false) String courseName,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {
        
        System.out.println("=== CERTIFICATE VERIFICATION STARTED ===");
        System.out.println("Student ID: " + studentId);
        System.out.println("Course Name: " + courseName);
        
        try {
            // Verify student credentials
            Student student = studentService.login(studentId, password);
            
            if (student == null) {
                System.out.println("ERROR: Student not found");
                model.addAttribute("error", "Invalid Student ID or Password");
                return "certificateF1";
            }
            
            System.out.println("Student found: " + student.getFullName());
            System.out.println("Student Status: " + student.getStatus());
            
            // Check if student is active
            if (!"Active".equals(student.getStatus())) {
                System.out.println("ERROR: Student is not active");
                model.addAttribute("error", "Your account is not active. Current status: " + student.getStatus());
                return "certificateF1";
            }
            
            // If course name is not provided, redirect back to form with error
            if (courseName == null || courseName.isEmpty()) {
                model.addAttribute("error", "Please select a course");
                return "certificateF1";
            }
            
            // CRITICAL CHECK: Is student eligible for certificate in this course?
            if (!mcqService.isEligibleForCertificate(studentId, courseName)) {
                System.out.println("Student not eligible for certificate in course: " + courseName);
                
                // Get detailed reason
                var stats = mcqService.getStudentStatistics(studentId);
                var courseStats = (Map<String, Object>) stats.get("courseStats");
                
                StringBuilder reason = new StringBuilder("You are not eligible for a certificate in " + courseName + ". ");
                
                if (courseStats != null && courseStats.containsKey(courseName)) {
                    Map<String, Object> courseInfo = (Map<String, Object>) courseStats.get(courseName);
                    Boolean allUnitTestsPassed = (Boolean) courseInfo.get("allUnitTestsPassed");
                    Boolean finalTestPassed = (Boolean) courseInfo.get("finalTestPassed");
                    
                    if (allUnitTestsPassed != null && !allUnitTestsPassed) {
                        reason.append("You need to pass all unit tests with 50%+ marks.");
                    } else if (finalTestPassed != null && !finalTestPassed) {
                        reason.append("You need to pass the final test with 50%+ marks.");
                    } else {
                        reason.append("You need to complete all unit tests and final test with 50%+ marks.");
                    }
                } else {
                    reason.append("You need to complete all unit tests and final test with 50%+ marks.");
                }
                
                model.addAttribute("error", reason.toString());
                return "certificateF1";
            }
            
            // Check if certificate already exists
            StudentCertificate studentCertificate = certificateService.getCertificate(studentId, courseName);
            
            if (studentCertificate == null) {
                // Generate new certificate
                studentCertificate = certificateService.generateCertificate(student, courseName);
                System.out.println("Generated new certificate");
            } else {
                System.out.println("Using existing certificate");
            }
            
            // Get test statistics for display
            var unitTests = mcqService.getStudentUnitTests(studentId);
            var finalTest = mcqService.getStudentFinalTest(studentId);
            
            // Calculate unit test average for this course
            double unitTestAvg = unitTests.stream()
                .filter(t -> courseName.equals(t.getSubjectName()))
                .mapToDouble(t -> t.getPercentage())
                .average()
                .orElse(0.0);
            
            // Get final test details
            int finalScore = 0;
            int finalTotal = 0;
            double finalPercentage = 0;
            String finalStatus = "Not Attempted";
            
            if (finalTest != null && courseName.equals(finalTest.getSubjectName())) {
                finalScore = finalTest.getScore();
                finalTotal = finalTest.getTotalQuestions();
                finalPercentage = finalTest.getPercentage();
                finalStatus = finalTest.getStatus();
            }
            
            // Calculate grade
            String grade = calculateGrade(unitTestAvg, finalPercentage);
            
            // Store in session
            session.setAttribute("studentCertificate", studentCertificate);
            session.setAttribute("student", student);
            session.setAttribute("selectedCourse", courseName);
            
            // Add all data to model
            model.addAttribute("certificate", studentCertificate);
            model.addAttribute("student", student);
            model.addAttribute("selectedCourse", courseName);
            model.addAttribute("unitTestAvg", Math.round(unitTestAvg));
            model.addAttribute("finalTestScore", finalScore);
            model.addAttribute("finalTestTotal", finalTotal);
            model.addAttribute("finalTestPercentage", Math.round(finalPercentage));
            model.addAttribute("finalTestStatus", finalStatus);
            model.addAttribute("grade", grade);
            
            // Format date properly
            if (studentCertificate != null && studentCertificate.getIssueDate() != null) {
                model.addAttribute("issueDate", studentCertificate.getIssueDate().toString());
            }
            
            System.out.println("=== CERTIFICATE ACCESS GRANTED ===");
            System.out.println("Certificate ID: " + studentCertificate.getCertificateId());
            
            return "CertificateSuccess";
            
        } catch (Exception e) {
            System.err.println("=== EXCEPTION IN CERTIFICATE VERIFICATION ===");
            e.printStackTrace();
            model.addAttribute("error", "System Error: " + e.getMessage());
            return "certificateF1";
        }
    }

    // Display certificate
    @GetMapping("/view")
    public String viewCertificate(HttpSession session, Model model) {
        System.out.println("=== CERTIFICATE VIEW PAGE ACCESSED ===");
        
        StudentCertificate certificate = (StudentCertificate) session.getAttribute("studentCertificate");
        Student student = (Student) session.getAttribute("student");
        String selectedCourse = (String) session.getAttribute("selectedCourse");
        
        if (certificate == null || student == null) {
            System.out.println("ERROR: No certificate found in session");
            return "redirect:/certificate/verify";
        }
        
        // Get test statistics
        var unitTests = mcqService.getStudentUnitTests(student.getStudentId());
        var finalTest = mcqService.getStudentFinalTest(student.getStudentId());
        
        double unitTestAvg = unitTests.stream()
            .filter(t -> selectedCourse != null && selectedCourse.equals(t.getSubjectName()))
            .mapToDouble(t -> t.getPercentage())
            .average()
            .orElse(0.0);
        
        boolean finalTestForCourse = finalTest != null && 
            selectedCourse != null && 
            selectedCourse.equals(finalTest.getSubjectName());
        
        int finalScore = finalTestForCourse ? finalTest.getScore() : 0;
        int finalTotal = finalTestForCourse ? finalTest.getTotalQuestions() : 0;
        double finalPercentage = finalTestForCourse ? finalTest.getPercentage() : 0;
        String finalStatus = finalTestForCourse ? finalTest.getStatus() : "Not Attempted";
        
        model.addAttribute("certificate", certificate);
        model.addAttribute("student", student);
        model.addAttribute("selectedCourse", selectedCourse);
        model.addAttribute("unitTestAvg", Math.round(unitTestAvg));
        model.addAttribute("finalTestScore", finalScore);
        model.addAttribute("finalTestTotal", finalTotal);
        model.addAttribute("finalTestPercentage", Math.round(finalPercentage));
        model.addAttribute("finalTestStatus", finalStatus);
        model.addAttribute("grade", calculateGrade(unitTestAvg, finalPercentage));
        
        if (certificate.getIssueDate() != null) {
            model.addAttribute("issueDate", certificate.getIssueDate().toString());
        }
        
        return "CertificateSuccess";
    }
    
    // Helper method to calculate grade
    private String calculateGrade(double unitAvg, double finalPercentage) {
        double overallPercentage = (unitAvg + finalPercentage) / 2;
        
        if (overallPercentage >= 90) return "A+";
        else if (overallPercentage >= 80) return "A";
        else if (overallPercentage >= 70) return "B";
        else if (overallPercentage >= 60) return "C";
        else return "D";
    }

    // Get available certificates for a student
    @GetMapping("/available/{studentId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getAvailableCertificates(@PathVariable String studentId) {
        Map<String, Object> response = new HashMap<>();
        try {
            Student student = studentService.getStudentByStudentId(studentId);
            
            if (student == null) {
                response.put("success", false);
                response.put("message", "Student not found");
                return ResponseEntity.ok(response);
            }
            
            List<String> courses = student.getCourses();
            Map<String, Boolean> eligibleCourses = new HashMap<>();
            List<StudentCertificate> existingCertificates = certificateService.getCertificatesByStudentId(studentId);
            Map<String, StudentCertificate> certMap = new HashMap<>();
            
            for (StudentCertificate cert : existingCertificates) {
                certMap.put(cert.getCourseName(), cert);
            }
            
            for (String course : courses) {
                boolean isEligible = mcqService.isEligibleForCertificate(studentId, course);
                boolean hasCertificate = certMap.containsKey(course);
                eligibleCourses.put(course, isEligible && !hasCertificate);
            }
            
            response.put("success", true);
            response.put("studentName", student.getFullName());
            response.put("courses", courses);
            response.put("eligibleCourses", eligibleCourses);
            response.put("existingCertificates", certMap.keySet());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // Test endpoint to check if controller is working
    @GetMapping("/test")
    @ResponseBody
    public String testEndpoint() {
        return "Certificate controller is working! Time: " + new java.util.Date();
    }
}