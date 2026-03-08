package com.example.institute.controller;

import com.example.institute.model.Student;
import com.example.institute.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentService studentService;

    // Dashboard
    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        try {
            List<Student> students = studentService.getAllStudents();
            Map<String, Object> stats = studentService.getDashboardStats();
            
            model.addAttribute("students", students);
            model.addAttribute("stats", stats);
            return "Studentstore";
        } catch (Exception e) {
            model.addAttribute("error", "Error loading dashboard: " + e.getMessage());
            return "error";
        }
    }

    // Display student signup form
    @GetMapping("/signup")
    public String showSignupForm(Model model) {
        try {
            model.addAttribute("student", new Student());
            return "StudSignUp";
        } catch (Exception e) {
            model.addAttribute("error", "Error loading signup form: " + e.getMessage());
            return "error";
        }
    }

    // Process student signup with multiple courses
    @PostMapping("/signup")
    public String processSignup(@ModelAttribute Student student, 
                               @RequestParam(value = "courses", required = false) List<String> courses,
                               Model model) {
        try {
            // Set the courses list
            student.setCourses(courses);
            
            Student savedStudent = studentService.saveStudent(student);
            model.addAttribute("student", savedStudent);
            model.addAttribute("message", "Registration successful! Your Student ID is: " + 
                savedStudent.getStudentId() + ". Your account is pending admin approval.");
            return "StudSignUpSuccess";
        } catch (RuntimeException e) {
            model.addAttribute("student", student);
            model.addAttribute("error", e.getMessage());
            return "StudSignUp";
        }
    }

    // Search students
    @GetMapping("/search")
    public String searchStudents(@RequestParam("searchTerm") String searchTerm, Model model) {
        try {
            List<Student> students = studentService.searchStudents(searchTerm);
            model.addAttribute("students", students);
            model.addAttribute("searchTerm", searchTerm);
            model.addAttribute("stats", studentService.getDashboardStats());
            return "Studentstore";
        } catch (Exception e) {
            model.addAttribute("error", "Error searching students: " + e.getMessage());
            return "error";
        }
    }

    // ================ AJAX ENDPOINTS ================

    // Get student by ID
    @GetMapping("/{id}")
    @ResponseBody
    public Map<String, Object> getStudent(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            Student student = studentService.getStudentById(id);
            response.put("success", true);
            response.put("student", student);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // Update student with multiple courses
    @PostMapping("/update")
    @ResponseBody
    public Map<String, Object> updateStudent(@RequestBody Map<String, Object> studentData) {
        Map<String, Object> response = new HashMap<>();
        try {
            Long id = Long.parseLong(studentData.get("id").toString());
            Student existingStudent = studentService.getStudentById(id);
            
            // Update basic fields
            existingStudent.setFullName((String) studentData.get("fullName"));
            existingStudent.setEmail((String) studentData.get("email"));
            existingStudent.setMobile((String) studentData.get("mobile"));
            existingStudent.setStatus((String) studentData.get("status"));
            
            // Update courses
            List<String> courses = (List<String>) studentData.get("courses");
            existingStudent.setCourses(courses);
            
            // Update password if provided
            if (studentData.containsKey("password") && 
                studentData.get("password") != null && 
                !((String) studentData.get("password")).isEmpty()) {
                existingStudent.setPassword((String) studentData.get("password"));
            }
            
            Student updatedStudent = studentService.updateStudent(id, existingStudent);
            response.put("success", true);
            response.put("student", updatedStudent);
            response.put("message", "Student updated successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // Delete student
    @PostMapping("/delete/{id}")
    @ResponseBody
    public Map<String, Object> deleteStudent(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            studentService.deleteStudent(id);
            response.put("success", true);
            response.put("message", "Student deleted successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // Approve student
    @PostMapping("/approve/{id}")
    @ResponseBody
    public Map<String, Object> approveStudent(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            Student approvedStudent = studentService.approveStudent(id);
            response.put("success", true);
            response.put("student", approvedStudent);
            response.put("message", "Student approved successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error approving student: " + e.getMessage());
        }
        return response;
    }

    // Reject student
    @PostMapping("/reject/{id}")
    @ResponseBody
    public Map<String, Object> rejectStudent(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            Student rejectedStudent = studentService.rejectStudent(id);
            response.put("success", true);
            response.put("student", rejectedStudent);
            response.put("message", "Student rejected successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error rejecting student: " + e.getMessage());
        }
        return response;
    }

    // Activate student
    @PostMapping("/activate/{id}")
    @ResponseBody
    public Map<String, Object> activateStudent(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            Student activatedStudent = studentService.updateStudentStatus(id, "Active");
            response.put("success", true);
            response.put("student", activatedStudent);
            response.put("message", "Student activated successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error activating student: " + e.getMessage());
        }
        return response;
    }

    // Deactivate student
    @PostMapping("/deactivate/{id}")
    @ResponseBody
    public Map<String, Object> deactivateStudent(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            Student deactivatedStudent = studentService.updateStudentStatus(id, "Inactive");
            response.put("success", true);
            response.put("student", deactivatedStudent);
            response.put("message", "Student deactivated successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error deactivating student: " + e.getMessage());
        }
        return response;
    }

    // Check email availability
    @GetMapping("/check-email")
    @ResponseBody
    public Map<String, Boolean> checkEmail(@RequestParam String email) {
        boolean exists = studentService.emailExists(email);
        return Map.of("exists", exists);
    }

    // Check mobile availability
    @GetMapping("/check-mobile")
    @ResponseBody
    public Map<String, Boolean> checkMobile(@RequestParam String mobile) {
        boolean exists = studentService.mobileExists(mobile);
        return Map.of("exists", exists);
    }
    
    // Get student courses by student ID (for parent registration)
    @GetMapping("/courses/{studentId}")
    @ResponseBody
    public Map<String, Object> getStudentCourses(@PathVariable String studentId) {
        Map<String, Object> response = new HashMap<>();
        try {
            Student student = studentService.getStudentByStudentId(studentId);
            
            if (student == null) {
                response.put("success", false);
                response.put("message", "Student not found with ID: " + studentId);
                return response;
            }
            
            List<String> courses = student.getCourses();
            
            if (courses == null || courses.isEmpty()) {
                response.put("success", false);
                response.put("message", "Student has no enrolled courses");
                return response;
            }
            
            response.put("success", true);
            response.put("studentId", student.getStudentId());
            response.put("studentName", student.getFullName());
            response.put("courses", courses);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error fetching student courses: " + e.getMessage());
        }
        return response;
    }
}