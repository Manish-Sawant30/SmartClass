package com.example.institute.controller;

import com.example.institute.model.MCQQuestion;
import com.example.institute.model.StudentTestAttempt;
import com.example.institute.model.StudentTestAnswer;
import com.example.institute.model.Specialization;
import com.example.institute.model.Teacher;
import com.example.institute.service.MCQService;
import com.example.institute.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/api/mcq")
public class MCQController {
    
    @Autowired
    private MCQService mcqService;
    
    @Autowired
    private TeacherService teacherService;
    
    // ==================== QUESTION MANAGEMENT ====================
    
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addQuestions(@RequestBody List<MCQQuestion> questions) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<MCQQuestion> saved = mcqService.addQuestions(questions);
            response.put("success", true);
            response.put("questions", saved);
            response.put("count", saved.size());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @GetMapping("/content/{contentId}")
    @ResponseBody
    public ResponseEntity<List<MCQQuestion>> getQuestionsByContent(@PathVariable Long contentId) {
        List<MCQQuestion> questions = mcqService.getQuestionsByContentId(contentId);
        return ResponseEntity.ok(questions);
    }
    
    @GetMapping("/count/{contentId}")
    @ResponseBody
    public ResponseEntity<Map<String, Long>> getQuestionCount(@PathVariable Long contentId) {
        Map<String, Long> response = new HashMap<>();
        response.put("count", mcqService.getQuestionCountByContentId(contentId));
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/count/teacher/{teacherId}")
    @ResponseBody
    public ResponseEntity<Map<String, Long>> getTeacherQuestionCount(@PathVariable Long teacherId) {
        Map<String, Long> response = new HashMap<>();
        response.put("count", mcqService.getQuestionCountByTeacher(teacherId));
        return ResponseEntity.ok(response);
    }
    
    @DeleteMapping("/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteQuestion(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            mcqService.deleteQuestion(id);
            response.put("success", true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    // ==================== FINAL TEST MANAGEMENT ====================
    
    @PostMapping("/final/create")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createFinalTest(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        try {
            System.out.println("=== CREATE FINAL TEST ===");
            
            String course = (String) request.get("course");
            String title = (String) request.get("title");
            String description = (String) request.get("description");
            
            Integer passingPercentage = 50;
            Object passingObj = request.get("passingPercentage");
            if (passingObj instanceof Integer) {
                passingPercentage = (Integer) passingObj;
            } else if (passingObj instanceof String) {
                passingPercentage = Integer.parseInt((String) passingObj);
            }
            
            Object createdByObj = request.get("createdBy");
            Long teacherId = null;
            if (createdByObj instanceof Integer) {
                teacherId = ((Integer) createdByObj).longValue();
            } else if (createdByObj instanceof Long) {
                teacherId = (Long) createdByObj;
            } else if (createdByObj instanceof String) {
                teacherId = Long.parseLong((String) createdByObj);
            }
            
            System.out.println("Course: " + course);
            System.out.println("Title: " + title);
            System.out.println("Description: " + description);
            System.out.println("Passing Percentage: " + passingPercentage);
            System.out.println("Teacher ID: " + teacherId);
            
            List<Map<String, Object>> questionMaps = (List<Map<String, Object>>) request.get("questions");
            System.out.println("Number of questions: " + (questionMaps != null ? questionMaps.size() : 0));
            
            if (questionMaps == null || questionMaps.isEmpty()) {
                response.put("success", false);
                response.put("message", "No questions provided");
                return ResponseEntity.badRequest().body(response);
            }
            
            List<MCQQuestion> questions = questionMaps.stream().map(q -> {
                MCQQuestion question = new MCQQuestion();
                question.setQuestionText((String) q.get("questionText"));
                question.setOptionA((String) q.get("optionA"));
                question.setOptionB((String) q.get("optionB"));
                question.setOptionC((String) q.get("optionC"));
                question.setOptionD((String) q.get("optionD"));
                question.setCorrectOption((String) q.get("correctOption"));
                return question;
            }).collect(Collectors.toList());
            
            mcqService.createFinalTest(course, title, description, passingPercentage, questions, teacherId);
            
            response.put("success", true);
            response.put("message", "Final test created successfully!");
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error creating final test: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    // ==================== TEST TAKING ====================
    
    @PostMapping("/start")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> startTest(@RequestBody Map<String, Object> request, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            String studentId = (String) session.getAttribute("studentId");
            String studentName = (String) session.getAttribute("studentName");
            
            if (studentId == null) {
                studentId = (String) request.get("studentId");
                studentName = (String) request.get("studentName");
            }
            
            if (studentId == null) {
                throw new RuntimeException("Student not logged in");
            }
            
            Long contentId = Long.parseLong(request.get("contentId").toString());
            String testType = (String) request.get("testType");
            
            if (mcqService.hasAttemptedTest(studentId, contentId)) {
                response.put("success", false);
                response.put("message", "You have already attempted this test");
                return ResponseEntity.ok(response);
            }
            
            StudentTestAttempt attempt = mcqService.startTest(studentId, studentName, contentId, testType);
            
            response.put("success", true);
            response.put("attemptId", attempt.getAttemptId());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @PostMapping("/submit")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> submitTest(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        try {
            String attemptId = (String) request.get("attemptId");
            
            Map<String, Object> answersMap = (Map<String, Object>) request.get("answers");
            Map<Long, String> answers = new HashMap<>();
            
            if (answersMap != null) {
                for (Map.Entry<String, Object> entry : answersMap.entrySet()) {
                    try {
                        Long questionId = Long.parseLong(entry.getKey());
                        String selectedOption = (String) entry.getValue();
                        answers.put(questionId, selectedOption);
                    } catch (NumberFormatException e) {
                        // Skip invalid entries
                    }
                }
            }
            
            StudentTestAttempt attempt = mcqService.submitTest(attemptId, answers);
            
            if ("FINAL".equals(attempt.getTestType())) {
                mcqService.updateFinalEligibility(attempt.getStudentId(), attempt.getSubjectName());
            }
            
            response.put("success", true);
            response.put("score", attempt.getScore());
            response.put("total", attempt.getTotalQuestions());
            response.put("percentage", attempt.getPercentage());
            response.put("status", attempt.getStatus());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    // ==================== TEST RESULTS VIEWING ====================
    
    @GetMapping("/result/{attemptId}")
    public String viewResult(@PathVariable String attemptId, Model model) {
        try {
            StudentTestAttempt attempt = mcqService.getTestAttempt(attemptId);
            List<StudentTestAnswer> answers = mcqService.getTestAnswers(attemptId);
            
            model.addAttribute("attempt", attempt);
            model.addAttribute("answers", answers);
            
            return "mcqresult";
        } catch (Exception e) {
            model.addAttribute("error", "Result not found: " + e.getMessage());
            return "error";
        }
    }
    
    @GetMapping("/result/{studentId}/{contentId}")
    public String viewStudentTestResult(
            @PathVariable String studentId,
            @PathVariable Long contentId,
            Model model,
            HttpSession session) {
        try {
            String loggedInStudentId = (String) session.getAttribute("studentId");
            if (loggedInStudentId == null) {
                return "redirect:/student-login";
            }
            
            if (!loggedInStudentId.equals(studentId)) {
                return "redirect:/student-course";
            }
            
            StudentTestAttempt attempt = mcqService.getTestResult(studentId, contentId);
            
            if (attempt != null) {
                return "redirect:/api/mcq/result/" + attempt.getAttemptId();
            } else {
                model.addAttribute("error", "Test result not found for this content");
                return "error";
            }
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "error";
        }
    }
    
    // ==================== ELIGIBILITY METHODS ====================
    
    @GetMapping("/student/eligibility/{studentId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getStudentEligibility(@PathVariable String studentId) {
        Map<String, Object> response = new HashMap<>();
        try {
            Map<String, Object> eligibilityData = mcqService.getStudentEligibility(studentId);
            return ResponseEntity.ok(eligibilityData);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @GetMapping("/status/{studentId}/{contentId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getTestStatus(
            @PathVariable String studentId, 
            @PathVariable Long contentId) {
        Map<String, Object> response = new HashMap<>();
        try {
            boolean completed = mcqService.hasAttemptedTest(studentId, contentId);
            StudentTestAttempt attempt = mcqService.getTestResult(studentId, contentId);
            
            response.put("success", true);
            response.put("completed", completed);
            if (attempt != null) {
                response.put("attemptId", attempt.getAttemptId());
                response.put("score", attempt.getScore());
                response.put("percentage", attempt.getPercentage());
                response.put("status", attempt.getStatus());
            }
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @GetMapping("/student/{studentId}/results")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getStudentResults(@PathVariable String studentId) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<StudentTestAttempt> results = mcqService.getStudentResults(studentId);
            Map<String, Object> stats = mcqService.getStudentStatistics(studentId);
            
            if (results != null && !results.isEmpty()) {
                response.put("studentName", results.get(0).getStudentName());
            }
            
            response.put("success", true);
            response.put("results", results);
            response.put("stats", stats);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @GetMapping("/all-results")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getAllResults() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<StudentTestAttempt> allResults = mcqService.getAllTestResults();
            
            Map<String, Object> stats = new HashMap<>();
            if (allResults != null && !allResults.isEmpty()) {
                long uniqueStudents = allResults.stream()
                    .map(StudentTestAttempt::getStudentId)
                    .distinct()
                    .count();
                
                double avgPercentage = allResults.stream()
                    .mapToDouble(StudentTestAttempt::getPercentage)
                    .average()
                    .orElse(0.0);
                
                long passedCount = allResults.stream()
                    .filter(a -> a.getPercentage() >= 40)
                    .count();
                
                stats.put("totalStudents", uniqueStudents);
                stats.put("totalTests", allResults.size());
                stats.put("avgScore", Math.round(avgPercentage));
                stats.put("passRate", allResults.size() > 0 ? Math.round((passedCount * 100.0 / allResults.size())) : 0);
            } else {
                stats.put("totalStudents", 0);
                stats.put("totalTests", 0);
                stats.put("avgScore", 0);
                stats.put("passRate", 0);
            }
            
            response.put("success", true);
            response.put("results", allResults);
            response.put("stats", stats);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @GetMapping("/teacher/{teacherId}/results")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getTeacherResults(@PathVariable Long teacherId) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<StudentTestAttempt> results = mcqService.getTeacherResults(teacherId);
            Map<String, Object> stats = mcqService.getTeacherStatistics(teacherId);
            
            response.put("success", true);
            response.put("results", results);
            response.put("stats", stats);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    // ==================== NEW METHOD: GET TEACHER ALL RESULTS WITH FILTERING ====================
    
    @GetMapping("/teacher/{teacherId}/all-results")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getTeacherAllResults(@PathVariable Long teacherId) {
        Map<String, Object> response = new HashMap<>();
        try {
            System.out.println("=== GETTING TEACHER ALL RESULTS FOR TEACHER ID: " + teacherId + " ===");
            
            // Get teacher's subjects first
            Teacher teacher = teacherService.getTeacherById(teacherId);
            List<String> teacherSubjects = teacher.getSpecializations().stream()
                .map(Specialization::getName)
                .collect(Collectors.toList());
            
            System.out.println("Teacher subjects: " + teacherSubjects);
            
            // Get all test results
            List<StudentTestAttempt> allResults = mcqService.getAllTestResults();
            System.out.println("Total results in system: " + allResults.size());
            
            // Filter results to only include teacher's subjects and existing students
            List<StudentTestAttempt> filteredResults;
            if (teacherSubjects.isEmpty()) {
                filteredResults = allResults;
                System.out.println("No teacher subjects found, showing all results");
            } else {
                filteredResults = allResults.stream()
                    .filter(attempt -> attempt.getSubjectName() != null && 
                            teacherSubjects.contains(attempt.getSubjectName()))
                    .collect(Collectors.toList());
                System.out.println("Filtered to " + filteredResults.size() + " results for teacher subjects");
            }
            
            // Get statistics for filtered results
            Map<String, Object> stats = new HashMap<>();
            
            // Unique students
            Set<String> uniqueStudents = filteredResults.stream()
                .map(StudentTestAttempt::getStudentId)
                .collect(Collectors.toSet());
            stats.put("totalStudents", uniqueStudents.size());
            
            stats.put("totalTests", filteredResults.size());
            
            double avgScore = filteredResults.stream()
                .mapToDouble(StudentTestAttempt::getPercentage)
                .average()
                .orElse(0.0);
            stats.put("avgScore", Math.round(avgScore));
            
            long passCount = filteredResults.stream()
                .filter(t -> t.getPercentage() >= 40)
                .count();
            
            stats.put("passRate", filteredResults.size() > 0 ? 
                Math.round((passCount * 100.0) / filteredResults.size()) : 0);
            
            response.put("success", true);
            response.put("results", filteredResults);
            response.put("stats", stats);
            response.put("teacherSubjects", teacherSubjects);
            
            System.out.println("Returning " + filteredResults.size() + " results");
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    // ==================== DEBUG ENDPOINT ====================
    
    @GetMapping("/debug/teacher/{teacherId}/data")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> debugTeacherData(@PathVariable Long teacherId) {
        Map<String, Object> response = new HashMap<>();
        try {
            // Get teacher's subjects
            Teacher teacher = teacherService.getTeacherById(teacherId);
            List<String> teacherSubjects = teacher.getSpecializations().stream()
                .map(Specialization::getName)
                .collect(Collectors.toList());
            
            // Get all test results
            List<StudentTestAttempt> allResults = mcqService.getAllTestResults();
            
            // Get existing student IDs
            Set<String> existingStudentIds = mcqService.getAllExistingStudentIds();
            
            // Debug info
            List<Map<String, Object>> resultsDebug = new ArrayList<>();
            Map<String, Long> subjectCount = new HashMap<>();
            Map<String, Long> subjectCountAfterFilter = new HashMap<>();
            
            int totalBeforeFilter = allResults.size();
            int totalAfterStudentFilter = 0;
            int totalAfterSubjectFilter = 0;
            
            for (StudentTestAttempt result : allResults) {
                String subject = result.getSubjectName();
                String studentId = result.getStudentId();
                boolean studentExists = existingStudentIds.contains(studentId);
                
                // Count by subject (all results)
                subjectCount.put(subject, subjectCount.getOrDefault(subject, 0L) + 1);
                
                // Count by subject (only existing students)
                if (studentExists) {
                    subjectCountAfterFilter.put(subject, subjectCountAfterFilter.getOrDefault(subject, 0L) + 1);
                    totalAfterStudentFilter++;
                    
                    // Check if matches teacher subjects
                    if (teacherSubjects.contains(subject)) {
                        totalAfterSubjectFilter++;
                    }
                }
                
                // Add first 5 results for debugging
                if (resultsDebug.size() < 5) {
                    Map<String, Object> r = new HashMap<>();
                    r.put("attemptId", result.getAttemptId());
                    r.put("studentId", studentId);
                    r.put("studentExists", studentExists);
                    r.put("studentName", result.getStudentName());
                    r.put("subjectName", subject);
                    r.put("testType", result.getTestType());
                    r.put("percentage", result.getPercentage());
                    resultsDebug.add(r);
                }
            }
            
            response.put("success", true);
            response.put("teacherId", teacherId);
            response.put("teacherName", teacher.getFullName());
            response.put("teacherSubjects", teacherSubjects);
            response.put("existingStudentCount", existingStudentIds.size());
            response.put("existingStudentIds", existingStudentIds);
            
            response.put("totalResultsInDB", totalBeforeFilter);
            response.put("totalResultsAfterStudentFilter", totalAfterStudentFilter);
            response.put("totalResultsAfterSubjectFilter", totalAfterSubjectFilter);
            
            response.put("subjectCount", subjectCount);
            response.put("subjectCountAfterStudentFilter", subjectCountAfterFilter);
            response.put("sampleResults", resultsDebug);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
    @GetMapping("/take-test")
    public String takeTest(@RequestParam String attemptId, Model model, HttpSession session) {
        String studentId = (String) session.getAttribute("studentId");
        if (studentId == null) {
            return "redirect:/student-login";
        }
        
        try {
            StudentTestAttempt attempt = mcqService.getTestAttempt(attemptId);
            
            if (!attempt.getStudentId().equals(studentId)) {
                return "redirect:/student-course";
            }
            
            List<MCQQuestion> questions = mcqService.getQuestionsByContentId(attempt.getContentId());
            
            model.addAttribute("attempt", attempt);
            model.addAttribute("questions", questions);
            model.addAttribute("totalQuestions", questions.size());
            
            return "take-test";
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Test not found: " + e.getMessage());
            return "error";
        }
    }
    
    @GetMapping("/teacher/subject/{subject}")
    public String viewSubjectResults(@PathVariable String subject, Model model, HttpSession session) {
        if (session.getAttribute("teacher") == null) {
            return "redirect:/teacher/login";
        }
        
        List<StudentTestAttempt> tests = mcqService.getTestsBySubject(subject);
        Map<String, Object> stats = mcqService.getSubjectStatistics(subject);
        
        model.addAttribute("tests", tests);
        model.addAttribute("subject", subject);
        model.addAttribute("stats", stats);
        
        return "teachertestscore";
    }
    
    @GetMapping("/parent/child/{studentId}")
    public String viewChildResults(@PathVariable String studentId, Model model, HttpSession session) {
        if (session.getAttribute("parent") == null) {
            return "redirect:/parents/login";
        }
        
        List<StudentTestAttempt> results = mcqService.getStudentResults(studentId);
        Map<String, Object> stats = mcqService.getStudentStatistics(studentId);
        
        model.addAttribute("results", results);
        model.addAttribute("stats", stats);
        model.addAttribute("studentId", studentId);
        
        return "parenttestscore";
    }
    
    @GetMapping("/student/results")
    public String viewStudentResults(HttpSession session, Model model) {
        String studentId = (String) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/student-login";
        }
        
        List<StudentTestAttempt> results = mcqService.getStudentResults(studentId);
        Map<String, Object> stats = mcqService.getStudentStatistics(studentId);
        
        model.addAttribute("results", results);
        model.addAttribute("stats", stats);
        
        return "studenttestscore";
    }
    
    @GetMapping("/certificate/{studentId}/{course}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCertificate(@PathVariable String studentId, @PathVariable String course) {
        Map<String, Object> response = new HashMap<>();
        try {
            Map<String, Object> certData = mcqService.getCertificateData(studentId, course);
            response.put("success", true);
            response.put("data", certData);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
    }
    
    @PostMapping("/certificate/generate/{studentId}/{course}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> generateCertificate(@PathVariable String studentId, @PathVariable String course) {
        Map<String, Object> response = new HashMap<>();
        try {
            if (!mcqService.isEligibleForCertificate(studentId, course)) {
                response.put("success", false);
                response.put("message", "Not eligible for certificate. Need to pass all unit tests (50%+) and final test.");
                return ResponseEntity.ok(response);
            }
            
            boolean generated = mcqService.generateCertificate(studentId, course);
            response.put("success", generated);
            if (generated) {
                response.put("message", "Certificate generated successfully");
            } else {
                response.put("message", "Certificate already exists");
            }
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}