package com.example.institute.controller;

import com.example.institute.model.AttStudent;
import com.example.institute.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/parent/attendance")
public class ParentAttendanceController {
    
    @Autowired
    private AttendanceService attendanceService;
    
    // Show parent attendance page
    @GetMapping("/view")
    public String showParentAttendancePage(Model model) {
        // Initialize with empty student data
        model.addAttribute("hasData", false);
        return "Parentattendance";
    }
    
    // Search student attendance
    @PostMapping("/search")
    public String searchStudentAttendance(
            @RequestParam String studentId,
            Model model) {
        
        Optional<AttStudent> student = attendanceService.getStudentById(studentId);
        
        if (student.isPresent()) {
            // Get attendance statistics
            Map<String, Object> stats = attendanceService.getStudentAttendanceStats(studentId);
            
            model.addAttribute("hasData", true);
            model.addAttribute("student", student.get());
            model.addAttribute("attendanceStats", stats);
            
            // Get recent attendance
            model.addAttribute("recentAttendance", attendanceService.getStudentAttendance(studentId));
            
        } else {
            model.addAttribute("hasData", false);
            model.addAttribute("error", "Student with ID " + studentId + " not found!");
        }
        
        return "Parentattendance";
    }
}