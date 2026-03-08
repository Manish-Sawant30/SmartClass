package com.example.institute.controller;

import com.example.institute.model.Specialization;
import com.example.institute.model.Teacher;
import com.example.institute.service.TeacherService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class TeacherResultsController {
    
    @Autowired
    private TeacherService teacherService;
    
    @GetMapping("/teachertestscore")
    public String teacherTestScore(HttpSession session, Model model) {
        // Check if teacher is logged in
        Teacher teacher = (Teacher) session.getAttribute("teacher");
        
        if (teacher == null) {
            return "redirect:/teacher/login";
        }
        
        // Add teacher info to model
        model.addAttribute("teacher", teacher);
        model.addAttribute("teacherId", teacher.getId());
        model.addAttribute("teacherName", teacher.getFullName());
        
        // Get teacher's specializations/subjects
        List<String> teacherSubjects = teacher.getSpecializations().stream()
            .map(Specialization::getName)
            .collect(Collectors.toList());
        model.addAttribute("teacherSubjects", teacherSubjects);
        
        return "teachertestscore";
    }
}