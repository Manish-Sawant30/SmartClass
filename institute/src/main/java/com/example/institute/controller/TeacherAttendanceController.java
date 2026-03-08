package com.example.institute.controller;

import com.example.institute.model.AttAttendance;
import com.example.institute.model.AttCourse;
import com.example.institute.model.AttStudent;
import com.example.institute.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/teacher/attendance")
public class TeacherAttendanceController {
    
    @Autowired
    private AttendanceService attendanceService;
    
    // Show courses for attendance
    @GetMapping("/courses")
    public String showCoursesForAttendance(Model model) {
        List<AttCourse> courses = attendanceService.getAllCourses();
        model.addAttribute("courses", courses);
        return "Courses_Attendance";
    }
    
    // Show form to mark attendance for a specific course
    @GetMapping("/mark/{courseId}")
    public String showMarkAttendanceForm(@PathVariable Integer courseId, Model model) {
        Optional<AttCourse> courseOpt = attendanceService.getAllCourses().stream()
            .filter(c -> c.getCourseId().equals(courseId))
            .findFirst();
        
        if (courseOpt.isPresent()) {
            model.addAttribute("course", courseOpt.get());
            model.addAttribute("today", LocalDate.now());
            model.addAttribute("attendance", new AttAttendance());
            
            // Get today's attendance for this course
            List<java.util.Map<String, Object>> todayAttendance = 
                attendanceService.getTodayAttendanceByCourse(courseId);
            model.addAttribute("todayAttendance", todayAttendance);
            
            return "Markattendance";
        }
        
        return "redirect:/teacher/attendance/courses";
    }
    
    // Process attendance marking
    @PostMapping("/mark")
    public String markAttendance(
            @RequestParam String studentId,
            @RequestParam Integer courseId,
            @RequestParam String status,
            @RequestParam(required = false) String remarks,
            Model model) {
        
        try {
            // Check if student exists
            Optional<AttStudent> student = attendanceService.getStudentById(studentId);
            if (!student.isPresent()) {
                model.addAttribute("error", "Student with ID " + studentId + " not found!");
                return showMarkAttendanceForm(courseId, model);
            }
            
            // Convert status string to enum
            AttAttendance.AttendanceStatus attendanceStatus = 
                AttAttendance.AttendanceStatus.valueOf(status.toUpperCase());
            
            // Mark attendance
            attendanceService.markAttendance(
                studentId, 
                courseId, 
                attendanceStatus, 
                "teacher", 
                remarks
            );
            
            model.addAttribute("success", "Attendance marked successfully for " + student.get().getStudentName());
            
        } catch (Exception e) {
            model.addAttribute("error", "Error marking attendance: " + e.getMessage());
        }
        
        return showMarkAttendanceForm(courseId, model);
    }
    
    // Add new student (for teacher)
    @PostMapping("/add-student")
    public String addStudent(
            @RequestParam String studentId,
            @RequestParam String studentName,
            @RequestParam(required = false) String parentName,
            @RequestParam(required = false) String parentEmail,
            Model model) {
        
        try {
            attendanceService.addStudent(studentId, studentName, parentName, parentEmail);
            model.addAttribute("success", "Student added successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "Error adding student: " + e.getMessage());
        }
        
        return showCoursesForAttendance(model);
    }
}