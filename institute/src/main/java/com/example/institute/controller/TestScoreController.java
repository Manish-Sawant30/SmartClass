package com.example.institute.controller;

import com.example.institute.model.TestScore;
import com.example.institute.service.TestScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/testscore")
public class TestScoreController {
    
    @Autowired
    private TestScoreService testScoreService;
    
    // Teacher Dashboard - Show all scores
    @GetMapping
    public String showTeacherDashboard(Model model) {
        List<TestScore> testScores = testScoreService.getAllTestScores();
        Map<String, Object> dashboardStats = testScoreService.getDashboardStats();
        List<String> allCourses = testScoreService.getAllCourses();
        
        model.addAttribute("testScores", testScores);
        model.addAttribute("dashboardStats", dashboardStats);
        model.addAttribute("allCourses", allCourses);
        
        return "Testscore";
    }
    
    // Add new test score
    @PostMapping("/add")
    public String addTestScore(@RequestParam String studentId,
                               @RequestParam String studentName,
                               @RequestParam String course,
                               @RequestParam Integer testScore,
                               RedirectAttributes redirectAttributes) {
        
        // Check if score already exists for this student and course
        if (testScoreService.scoreExists(studentId, course)) {
            redirectAttributes.addFlashAttribute("error", 
                "A score record for student ID " + studentId + " in " + course + " already exists.");
            return "redirect:/testscore";
        }
        
        // Validate score
        if (testScore < 0 || testScore > 100) {
            redirectAttributes.addFlashAttribute("error", 
                "Test score must be between 0 and 100.");
            return "redirect:/testscore";
        }
        
        // Create and save new test score
        TestScore newTestScore = new TestScore(studentId, studentName, course, testScore);
        testScoreService.saveTestScore(newTestScore);
        
        redirectAttributes.addFlashAttribute("success", 
            "Score added successfully for " + studentName + " in " + course);
        
        return "redirect:/testscore";
    }
    
    // Update test score - FIXED METHOD
    @PostMapping("/update/{id}")
    public String updateTestScore(@PathVariable Long id,
                                  @RequestParam String studentName,
                                  @RequestParam Integer testScore,
                                  RedirectAttributes redirectAttributes) {
        
        // Validate score
        if (testScore < 0 || testScore > 100) {
            redirectAttributes.addFlashAttribute("error", 
                "Test score must be between 0 and 100.");
            return "redirect:/testscore";
        }
        
        TestScore existingScore = testScoreService.getTestScoreById(id);
        if (existingScore != null) {
            // Create updated test score object
            TestScore updatedScore = new TestScore();
            updatedScore.setId(id);
            updatedScore.setStudentId(existingScore.getStudentId());
            updatedScore.setStudentName(studentName);
            updatedScore.setCourse(existingScore.getCourse());
            updatedScore.setTestScore(testScore);
            
            // Save the updated score
            testScoreService.saveTestScore(updatedScore);
            
            redirectAttributes.addFlashAttribute("success", 
                "Score updated successfully for " + studentName);
        } else {
            redirectAttributes.addFlashAttribute("error", 
                "Test score not found!");
        }
        
        return "redirect:/testscore";
    }
    
    // Delete test score
    @GetMapping("/delete/{id}")
    public String deleteTestScore(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        TestScore testScore = testScoreService.getTestScoreById(id);
        if (testScore != null) {
            testScoreService.deleteTestScore(id);
            redirectAttributes.addFlashAttribute("success", 
                "Score deleted successfully for " + testScore.getStudentName());
        } else {
            redirectAttributes.addFlashAttribute("error", "Test score not found!");
        }
        
        return "redirect:/testscore";
    }
    
    // Search test scores
    @GetMapping("/search")
    public String searchTestScores(@RequestParam(required = false) String query, Model model) {
        List<TestScore> testScores;
        if (query != null && !query.trim().isEmpty()) {
            testScores = testScoreService.searchScores(query);
        } else {
            testScores = testScoreService.getAllTestScores();
        }
        
        Map<String, Object> dashboardStats = testScoreService.getDashboardStats();
        List<String> allCourses = testScoreService.getAllCourses();
        
        model.addAttribute("testScores", testScores);
        model.addAttribute("dashboardStats", dashboardStats);
        model.addAttribute("allCourses", allCourses);
        model.addAttribute("searchQuery", query);
        
        return "Testscore";
    }
}

@Controller
@RequestMapping("/parenttestscore")
class ParentTestScoreController {
    
    @Autowired
    private TestScoreService testScoreService;
    
    // Parent Dashboard - Show form to search student
    @GetMapping
    public String showParentDashboard(Model model) {
        List<String> allStudentIds = testScoreService.getAllStudentIds();
        model.addAttribute("allStudentIds", allStudentIds);
        return "Parenttestscore";
    }
    
    // View student scores - FIXED: Should display all subjects
    @PostMapping("/view")
    public String viewStudentScores(@RequestParam String studentId, Model model) {
        List<TestScore> studentScores = testScoreService.getScoresByStudentId(studentId);
        Map<String, Object> studentStats = testScoreService.getStudentStatistics(studentId);
        List<String> allStudentIds = testScoreService.getAllStudentIds();
        
        model.addAttribute("studentScores", studentScores);
        model.addAttribute("studentStats", studentStats);
        model.addAttribute("allStudentIds", allStudentIds);
        model.addAttribute("searchedStudentId", studentId);
        
        // If student exists, get their name from first score
        if (!studentScores.isEmpty()) {
            model.addAttribute("studentName", studentScores.get(0).getStudentName());
        } else {
            model.addAttribute("studentName", "Student Not Found");
        }
        
        return "Parenttestscore";
    }
}