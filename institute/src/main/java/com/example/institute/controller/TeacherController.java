package com.example.institute.controller;

import com.example.institute.dto.TeacherDTO;
import com.example.institute.dto.TeacherRegistrationDTO;
import com.example.institute.model.Specialization;
import com.example.institute.model.Teacher;
import com.example.institute.model.EducationalContent;
import com.example.institute.repository.EducationalContentRepository;
import com.example.institute.service.SpecializationService;
import com.example.institute.service.TeacherService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/teacher")
public class TeacherController {
    
    @Autowired
    private TeacherService teacherService;
    
    @Autowired
    private SpecializationService specializationService;
    
    @Autowired
    private EducationalContentRepository educationalContentRepository;
    
    // ==================== LOGIN METHODS ====================
    
    @GetMapping("/login")
    public String showLoginForm() {
        return "Teacherlogin";
    }
    
    @PostMapping("/login")
    public String loginTeacher(@RequestParam String userId,
                              @RequestParam String password,
                              HttpSession session,
                              Model model) {
        try {
            System.out.println("=== LOGIN REQUEST ===");
            System.out.println("User ID: " + userId);
            
            Teacher teacher = teacherService.login(userId, password);
            
            System.out.println("=== LOGIN SUCCESS ===");
            System.out.println("Teacher ID: " + teacher.getTeacherId());
            
            session.setAttribute("teacher", teacher);
            session.setAttribute("teacherId", teacher.getTeacherId());
            session.setAttribute("teacherName", teacher.getFullName());
            session.setAttribute("teacherStatus", teacher.getStatus().toString());
            
            return "redirect:/teacher/dashboard";
            
        } catch (RuntimeException e) {
            System.out.println("=== LOGIN FAILED ===");
            System.out.println("Error: " + e.getMessage());
            
            model.addAttribute("error", e.getMessage());
            return "Teacherlogin";
        }
    }
    
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("teacher");
        if (teacher == null) {
            return "redirect:/teacher/login";
        }
        
        model.addAttribute("teacher", teacher);
        model.addAttribute("teacherId", teacher.getTeacherId());
        model.addAttribute("teacherName", teacher.getFullName());
        model.addAttribute("teacherEmail", teacher.getEmail());
        model.addAttribute("specializations", teacher.getSpecializationNames());
        model.addAttribute("status", teacher.getStatus().toString());
        
        return "Teacherdashboard";
    }
    
    @GetMapping("/logout")
    public String logoutTeacher(HttpSession session) {
        session.invalidate();
        return "redirect:/teacher/login";
    }
    
    // ==================== REGISTRATION METHODS ====================
    
    @GetMapping("/signup")
    public String showRegistrationForm(Model model) {
        Map<String, List<Specialization>> specializationsByCategory = 
            specializationService.getSpecializationsByCategory();
        
        model.addAttribute("specializationsByCategory", specializationsByCategory);
        model.addAttribute("teacher", new TeacherRegistrationDTO());
        return "TeacherSignUp";
    }
    
    @PostMapping("/signup")
    public String registerTeacher(@ModelAttribute TeacherRegistrationDTO teacherDTO, 
                                 Model model,
                                 RedirectAttributes redirectAttributes) {
        try {
            if (!teacherDTO.getPassword().equals(teacherDTO.getConfirmPassword())) {
                model.addAttribute("error", "Passwords do not match");
                return showRegistrationForm(model);
            }
            
            if (teacherDTO.getSpecializationIds() == null || teacherDTO.getSpecializationIds().isEmpty()) {
                model.addAttribute("error", "Please select at least one specialization");
                return showRegistrationForm(model);
            }
            
            Teacher teacher = new Teacher();
            teacher.setFullName(teacherDTO.getFullName());
            teacher.setEmail(teacherDTO.getEmail());
            teacher.setPassword(teacherDTO.getPassword());
            
            List<Specialization> specializations = new ArrayList<>();
            for (Long specId : teacherDTO.getSpecializationIds()) {
                Specialization spec = new Specialization();
                spec.setId(specId);
                specializations.add(spec);
            }
            teacher.setSpecializations(specializations);
            
            Teacher registeredTeacher = teacherService.registerTeacher(teacher);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Registration successful! Your Teacher ID: " + registeredTeacher.getTeacherId() + 
                ". Your account is pending admin approval.");
            
            return "redirect:/teacher/store";
            
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return showRegistrationForm(model);
        }
    }
    
    // ==================== TEACHER STORE (ADMIN VIEW) ====================
    
    @GetMapping("/store")
    public String showTeacherStore(@RequestParam(required = false) String keyword,
                                  Model model) {
        List<Teacher> teachers;
        if (keyword != null && !keyword.trim().isEmpty()) {
            teachers = teacherService.searchTeachers(keyword);
        } else {
            teachers = teacherService.getAllTeachers();
        }
        
        List<TeacherDTO> teacherDTOs = teachers.stream()
            .map(TeacherDTO::new)
            .collect(Collectors.toList());
        
        Map<String, List<Specialization>> specializationsByCategory = 
            specializationService.getSpecializationsByCategory();
        
        long totalTeachers = teacherService.countTotalTeachers();
        long activeTeachers = teacherService.countByStatus(Teacher.TeacherStatus.ACTIVE);
        long pendingTeachers = teacherService.countByStatus(Teacher.TeacherStatus.PENDING);
        long rejectedTeachers = teacherService.countByStatus(Teacher.TeacherStatus.REJECTED);
        long inactiveTeachers = teacherService.countByStatus(Teacher.TeacherStatus.INACTIVE);
        
        model.addAttribute("teachers", teacherDTOs);
        model.addAttribute("specializationsByCategory", specializationsByCategory);
        model.addAttribute("searchKeyword", keyword);
        model.addAttribute("totalTeachers", totalTeachers);
        model.addAttribute("activeTeachers", activeTeachers);
        model.addAttribute("pendingTeachers", pendingTeachers);
        model.addAttribute("rejectedTeachers", rejectedTeachers);
        model.addAttribute("inactiveTeachers", inactiveTeachers);
        return "Teacherstore";
    }
    
    @GetMapping("/search")
    public String searchTeachers(@RequestParam String keyword, Model model) {
        List<Teacher> teachers = teacherService.searchTeachers(keyword);
        List<TeacherDTO> teacherDTOs = teachers.stream()
            .map(TeacherDTO::new)
            .collect(Collectors.toList());
        
        Map<String, List<Specialization>> specializationsByCategory = 
            specializationService.getSpecializationsByCategory();
        
        model.addAttribute("teachers", teacherDTOs);
        model.addAttribute("specializationsByCategory", specializationsByCategory);
        model.addAttribute("searchKeyword", keyword);
        return "Teacherstore";
    }
    
    // ==================== DELETE TEACHER ====================
    
    @PostMapping("/delete/{id}")
    public ResponseEntity<Map<String, Object>> deleteTeacher(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            System.out.println("=== CONTROLLER: Deleting teacher with ID: " + id + " ===");
            
            Teacher teacher = teacherService.getTeacherById(id);
            String teacherName = teacher.getFullName();
            
            teacherService.deleteTeacher(id);
            
            response.put("success", true);
            response.put("message", "Teacher " + teacherName + " deleted successfully");
            response.put("teacherId", id);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            System.err.println("=== CONTROLLER ERROR: Failed to delete teacher: " + e.getMessage() + " ===");
            e.printStackTrace();
            
            response.put("success", false);
            response.put("message", "Error deleting teacher: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    // ==================== DEBUG ENDPOINT - FIXED VERSION ====================
    
    @GetMapping("/debug/content/{teacherId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> debugTeacherContent(@PathVariable Long teacherId) {
        Map<String, Object> response = new HashMap<>();
        try {
            Teacher teacher = teacherService.getTeacherById(teacherId);
            
            // FIXED: Use findByTeacherId which exists in your repository
            List<EducationalContent> content = educationalContentRepository.findByTeacherId(teacherId);
            
            response.put("success", true);
            response.put("teacherId", teacherId);
            response.put("teacherName", teacher.getFullName());
            response.put("contentCount", content != null ? content.size() : 0);
            
            List<Map<String, Object>> simplifiedContent = new ArrayList<>();
            if (content != null) {
                for (EducationalContent ec : content) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("contentId", ec.getContentId());
                    item.put("title", ec.getContentTitle());
                    item.put("subject", ec.getSubjectName());
                    simplifiedContent.add(item);
                }
            }
            
            response.put("content", simplifiedContent);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    // ==================== APPROVE/REJECT METHODS ====================
    
    @PostMapping("/approve/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> approveTeacher(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            System.out.println("=== CONTROLLER: Approving Teacher ID: " + id + " ===");
            
            Teacher approvedTeacher = teacherService.approveTeacher(id);
            
            response.put("success", true);
            response.put("message", "Teacher approved successfully");
            response.put("teacherId", approvedTeacher.getTeacherId());
            response.put("teacherName", approvedTeacher.getFullName());
            response.put("newStatus", approvedTeacher.getStatus().toString());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error approving teacher: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @PostMapping("/reject/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> rejectTeacher(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            Teacher rejectedTeacher = teacherService.rejectTeacher(id);
            response.put("success", true);
            response.put("message", "Teacher rejected successfully");
            response.put("teacherId", rejectedTeacher.getTeacherId());
            response.put("teacherName", rejectedTeacher.getFullName());
            response.put("newStatus", rejectedTeacher.getStatus().toString());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error rejecting teacher: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @PostMapping("/updateStatus/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateTeacherStatus(@PathVariable Long id, 
                                                                  @RequestParam String status) {
        Map<String, Object> response = new HashMap<>();
        try {
            Teacher.TeacherStatus newStatus = Teacher.TeacherStatus.valueOf(status.toUpperCase());
            Teacher updatedTeacher = ((com.example.institute.service.impl.TeacherServiceImpl) teacherService).forceUpdateStatus(id, newStatus);
            
            response.put("success", true);
            response.put("message", "Teacher status updated to " + status);
            response.put("teacherId", updatedTeacher.getTeacherId());
            response.put("teacherName", updatedTeacher.getFullName());
            response.put("newStatus", updatedTeacher.getStatus().toString());
            
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            response.put("success", false);
            response.put("message", "Invalid status: " + status);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error updating teacher status: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @GetMapping("/specializations/{teacherId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getTeacherSpecializations(@PathVariable Long teacherId) {
        Map<String, Object> response = new HashMap<>();
        try {
            Teacher teacher = teacherService.getTeacherById(teacherId);
            
            if (teacher == null) {
                response.put("success", false);
                response.put("message", "Teacher not found with ID: " + teacherId);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
            
            List<String> specializations = teacher.getSpecializations().stream()
                .map(Specialization::getName)
                .collect(Collectors.toList());
            
            response.put("success", true);
            response.put("teacherId", teacher.getTeacherId());
            response.put("teacherName", teacher.getFullName());
            response.put("specializations", specializations);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error fetching specializations: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @GetMapping("/teachertestscore")
    public String teacherTestScore(HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("teacher");
        
        if (teacher == null) {
            return "redirect:/teacher/login";
        }
        
        model.addAttribute("teacher", teacher);
        model.addAttribute("teacherId", teacher.getId());
        model.addAttribute("teacherName", teacher.getFullName());
        
        List<String> teacherSubjects = teacher.getSpecializations().stream()
            .map(Specialization::getName)
            .collect(Collectors.toList());
        model.addAttribute("teacherSubjects", teacherSubjects);
        
        return "teachertestscore";
    }
    
    @GetMapping("/specializations")
    @ResponseBody
    public ResponseEntity<Map<String, List<Specialization>>> getSpecializations() {
        Map<String, List<Specialization>> specializations = specializationService.getSpecializationsByCategory();
        return ResponseEntity.ok(specializations);
    }
    
    @PostMapping("/specialization/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addSpecialization(@RequestParam String category,
                                                                @RequestParam String name) {
        Map<String, Object> response = new HashMap<>();
        try {
            Specialization specialization = specializationService.addSpecialization(category, name);
            response.put("success", true);
            response.put("id", specialization.getId());
            response.put("category", specialization.getCategory());
            response.put("name", specialization.getName());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @PostMapping("/specialization/delete/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteSpecialization(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            specializationService.deleteSpecialization(id);
            response.put("success", true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @GetMapping("/check/{teacherId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkTeacherStatus(@PathVariable String teacherId) {
        Map<String, Object> response = new HashMap<>();
        try {
            Teacher teacher = teacherService.getTeacherByTeacherId(teacherId);
            
            response.put("success", true);
            response.put("teacherId", teacher.getTeacherId());
            response.put("fullName", teacher.getFullName());
            response.put("email", teacher.getEmail());
            response.put("specializations", teacher.getSpecializationNames());
            response.put("status", teacher.getStatus().toString());
            response.put("updatedAt", teacher.getUpdatedAt());
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.ok(response);
        }
    }
}