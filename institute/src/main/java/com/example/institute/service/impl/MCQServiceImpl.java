package com.example.institute.service.impl;

import com.example.institute.model.*;
import com.example.institute.repository.*;
import com.example.institute.service.MCQService;
import com.example.institute.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
public class MCQServiceImpl implements MCQService {
    
    @Autowired
    private MCQQuestionRepository mcqQuestionRepository;
    
    @Autowired
    private StudentTestAttemptRepository testAttemptRepository;
    
    @Autowired
    private StudentTestAnswerRepository testAnswerRepository;
    
    @Autowired
    private StudentFinalEligibilityRepository eligibilityRepository;
    
    @Autowired
    private StudentCertificateRepository certificateRepository;
    
    @Autowired
    private EducationalContentRepository contentRepository;
    
    @Autowired
    private TeacherRepository teacherRepository;
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private StudentService studentService;
    
    // Cache of existing student IDs to avoid repeated DB calls
    private Set<String> existingStudentIds = null;
    private long lastCacheUpdate = 0;
    private static final long CACHE_DURATION = 60000; // 1 minute cache
    
    // ==================== HELPER METHODS ====================
    
    private Set<String> getExistingStudentIds() {
        // Refresh cache if needed
        long now = System.currentTimeMillis();
        if (existingStudentIds == null || (now - lastCacheUpdate) > CACHE_DURATION) {
            existingStudentIds = studentService.getAllStudentIds();
            lastCacheUpdate = now;
            System.out.println("Refreshed student ID cache: " + existingStudentIds.size() + " students exist");
        }
        return existingStudentIds;
    }
    
    private boolean studentExists(String studentId) {
        return getExistingStudentIds().contains(studentId);
    }
    
    private List<StudentTestAttempt> filterResultsByExistingStudents(List<StudentTestAttempt> results) {
        if (results == null || results.isEmpty()) {
            return results;
        }
        
        Set<String> existingIds = getExistingStudentIds();
        List<StudentTestAttempt> filtered = results.stream()
            .filter(attempt -> attempt.getStudentId() != null && existingIds.contains(attempt.getStudentId()))
            .collect(Collectors.toList());
        
        System.out.println("Filtered " + results.size() + " results to " + filtered.size() + " (removed " + 
                          (results.size() - filtered.size()) + " results for deleted students)");
        
        return filtered;
    }
    
    // ==================== ALL RESULTS FOR TEACHER ====================
    
    @Override
    public List<StudentTestAttempt> getAllTestResults() {
        List<StudentTestAttempt> allResults = testAttemptRepository.findAllByOrderByCompletedAtDesc();
        return filterResultsByExistingStudents(allResults);
    }
    
    // ==================== QUESTION MANAGEMENT ====================
    
    @Override
    public List<MCQQuestion> addQuestions(List<MCQQuestion> questions) {
        List<MCQQuestion> savedQuestions = new ArrayList<>();
        
        for (MCQQuestion question : questions) {
            question.setQuestionId(generateQuestionId());
            question.setCreatedAt(LocalDateTime.now());
            question.setUpdatedAt(LocalDateTime.now());
            savedQuestions.add(mcqQuestionRepository.save(question));
        }
        
        return savedQuestions;
    }
    
    @Override
    public List<MCQQuestion> getQuestionsByContentId(Long contentId) {
        return mcqQuestionRepository.findByContentId(contentId);
    }
    
    @Override
    public MCQQuestion getQuestionById(Long id) {
        return mcqQuestionRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Question not found with id: " + id));
    }
    
    @Override
    public MCQQuestion updateQuestion(Long id, MCQQuestion question) {
        MCQQuestion existing = getQuestionById(id);
        
        existing.setQuestionText(question.getQuestionText());
        existing.setOptionA(question.getOptionA());
        existing.setOptionB(question.getOptionB());
        existing.setOptionC(question.getOptionC());
        existing.setOptionD(question.getOptionD());
        existing.setCorrectOption(question.getCorrectOption());
        existing.setExplanation(question.getExplanation());
        existing.setUpdatedAt(LocalDateTime.now());
        
        return mcqQuestionRepository.save(existing);
    }
    
    @Override
    public void deleteQuestion(Long id) {
        mcqQuestionRepository.deleteById(id);
    }
    
    @Override
    public void deleteQuestionsByContentId(Long contentId) {
        mcqQuestionRepository.deleteByContentId(contentId);
    }
    
    @Override
    public Long getQuestionCountByContentId(Long contentId) {
        return mcqQuestionRepository.countByContentId(contentId);
    }
    
    @Override
    public Long getQuestionCountByTeacher(Long teacherId) {
        return mcqQuestionRepository.countByCreatedBy(teacherId);
    }
    
    // ==================== FINAL TEST MANAGEMENT ====================
    
    @Override
    public MCQQuestion createFinalTest(String course, String title, String description,
                                      Integer passingPercentage, List<MCQQuestion> questions, Long teacherId) {
        
        System.out.println("=== Creating Final Test ===");
        System.out.println("Course: " + course);
        System.out.println("Title: " + title);
        System.out.println("Questions count: " + questions.size());
        System.out.println("Teacher ID: " + teacherId);
        
        // Check if final test already exists for this course
        List<MCQQuestion> existingTests = mcqQuestionRepository.findFinalTestsByCourse(course);
        if (!existingTests.isEmpty()) {
            throw new RuntimeException("Final test already exists for course: " + course);
        }
        
        // Get the teacher from the database
        Teacher teacher = teacherRepository.findById(teacherId)
            .orElseThrow(() -> new RuntimeException("Teacher not found with ID: " + teacherId));
        
        // Create a special content entry for final test
        EducationalContent finalTestContent = new EducationalContent();
        finalTestContent.setContentTitle(title);
        finalTestContent.setContentDescription(description);
        finalTestContent.setSubjectName(course);
        finalTestContent.setContentCategory(ContentCategory.DOCUMENT);
        finalTestContent.setPublishedDate(LocalDateTime.now());
        finalTestContent.setContentStatus(ContentStatus.PUBLISHED);
        finalTestContent.setTeacher(teacher);
        
        EducationalContent savedContent = contentRepository.save(finalTestContent);
        System.out.println("Created content with ID: " + savedContent.getContentId());
        
        // Save all questions as final test questions
        for (MCQQuestion question : questions) {
            question.setContentId(savedContent.getContentId());
            question.setQuestionId(generateQuestionId());
            question.setFinalTest(true);
            question.setTestTitle(title);
            question.setPassingPercentage(passingPercentage);
            question.setCreatedBy(teacherId);
            question.setCreatedAt(LocalDateTime.now());
            question.setUpdatedAt(LocalDateTime.now());
            mcqQuestionRepository.save(question);
            System.out.println("Saved question: " + question.getQuestionText());
        }
        
        return questions.get(0);
    }
    
    @Override
    public List<MCQQuestion> getFinalTestsByCourse(String course) {
        return mcqQuestionRepository.findFinalTestsByCourse(course);
    }
    
    @Override
    public List<MCQQuestion> getAllFinalTests() {
        return mcqQuestionRepository.findByIsFinalTest(true);
    }
    
    // ==================== TEST TAKING ====================
    
    @Override
    public StudentTestAttempt startTest(String studentId, String studentName, Long contentId, String testType) {
        // Check if student exists
        if (!studentExists(studentId)) {
            throw new RuntimeException("Student not found in system");
        }
        
        // Check if already attempted
        if (hasAttemptedTest(studentId, contentId)) {
            throw new RuntimeException("You have already attempted this test");
        }
        
        EducationalContent content = contentRepository.findById(contentId)
            .orElseThrow(() -> new RuntimeException("Content not found"));
        
        StudentTestAttempt attempt = new StudentTestAttempt();
        attempt.setAttemptId(generateAttemptId());
        attempt.setStudentId(studentId);
        attempt.setStudentName(studentName);
        attempt.setContentId(contentId);
        attempt.setContentTitle(content.getContentTitle());
        attempt.setSubjectName(content.getSubjectName());
        attempt.setTestType(testType);
        attempt.setScore(0);
        attempt.setTotalQuestions(getQuestionCountByContentId(contentId).intValue());
        attempt.setPercentage(0.0);
        attempt.setStatus("IN_PROGRESS");
        attempt.setStartedAt(LocalDateTime.now());
        attempt.setCompletedAt(LocalDateTime.now());
        
        return testAttemptRepository.save(attempt);
    }
    
    @Override
    public StudentTestAttempt submitTest(String attemptId, Map<Long, String> answers) {
        StudentTestAttempt attempt = testAttemptRepository.findByAttemptId(attemptId)
            .orElseThrow(() -> new RuntimeException("Test attempt not found"));
        
        // Check if student still exists
        if (!studentExists(attempt.getStudentId())) {
            throw new RuntimeException("Student no longer exists in system");
        }
        
        List<MCQQuestion> questions = mcqQuestionRepository.findByContentId(attempt.getContentId());
        int correctCount = 0;
        
        // Delete any existing answers
        testAnswerRepository.deleteByAttemptId(attemptId);
        
        // Save each answer
        for (MCQQuestion question : questions) {
            String selectedOption = answers.get(question.getId());
            boolean isCorrect = selectedOption != null && selectedOption.equals(question.getCorrectOption());
            
            if (isCorrect) correctCount++;
            
            StudentTestAnswer answer = new StudentTestAnswer();
            answer.setAttemptId(attemptId);
            answer.setQuestionId(question.getId());
            answer.setSelectedOption(selectedOption);
            answer.setCorrect(isCorrect);
            answer.setQuestionText(question.getQuestionText());
            
            // Set the actual answer text based on selected option
            if (selectedOption != null) {
                switch (selectedOption) {
                    case "A": answer.setYourAnswer(question.getOptionA()); break;
                    case "B": answer.setYourAnswer(question.getOptionB()); break;
                    case "C": answer.setYourAnswer(question.getOptionC()); break;
                    case "D": answer.setYourAnswer(question.getOptionD()); break;
                    default: answer.setYourAnswer("Not answered");
                }
            } else {
                answer.setYourAnswer("Not answered");
            }
            
            // Set correct answer text based on correct option
            switch (question.getCorrectOption()) {
                case "A": answer.setCorrectAnswer(question.getOptionA()); break;
                case "B": answer.setCorrectAnswer(question.getOptionB()); break;
                case "C": answer.setCorrectAnswer(question.getOptionC()); break;
                case "D": answer.setCorrectAnswer(question.getOptionD()); break;
                default: answer.setCorrectAnswer("N/A");
            }
            
            answer.setCorrectOption(question.getCorrectOption());
            answer.setExplanation(question.getExplanation());
            
            testAnswerRepository.save(answer);
        }
        
        // Update attempt
        double percentage = questions.size() > 0 ? (correctCount * 100.0) / questions.size() : 0;
        boolean passed = percentage >= 50; // 50% passing criteria
        
        attempt.setScore(correctCount);
        attempt.setPercentage(percentage);
        attempt.setStatus(passed ? "PASSED" : "FAILED");
        attempt.setCompletedAt(LocalDateTime.now());
        
        // For unit tests, check if eligible for final
        if ("UNIT".equals(attempt.getTestType()) && passed) {
            attempt.setEligibleForFinal(true);
        }
        
        StudentTestAttempt savedAttempt = testAttemptRepository.save(attempt);
        
        // Update eligibility for final test
        if ("UNIT".equals(attempt.getTestType())) {
            updateFinalEligibility(attempt.getStudentId(), attempt.getSubjectName());
        }
        
        return savedAttempt;
    }
    
    @Override
    public StudentTestAttempt getTestAttempt(String attemptId) {
        StudentTestAttempt attempt = testAttemptRepository.findByAttemptId(attemptId)
            .orElseThrow(() -> new RuntimeException("Test attempt not found"));
        
        // Check if student still exists
        if (!studentExists(attempt.getStudentId())) {
            throw new RuntimeException("Student no longer exists in system");
        }
        
        return attempt;
    }
    
    @Override
    public List<StudentTestAnswer> getTestAnswers(String attemptId) {
        StudentTestAttempt attempt = getTestAttempt(attemptId);
        return testAnswerRepository.findAnswersByAttemptId(attemptId);
    }
    
    // ==================== RESULTS AND ELIGIBILITY ====================
    
    @Override
    public List<StudentTestAttempt> getStudentResults(String studentId) {
        if (!studentExists(studentId)) {
            return new ArrayList<>(); // Return empty list for deleted students
        }
        return testAttemptRepository.findByStudentId(studentId);
    }
    
    @Override
    public List<StudentTestAttempt> getStudentUnitTests(String studentId) {
        if (!studentExists(studentId)) {
            return new ArrayList<>();
        }
        List<StudentTestAttempt> allTests = testAttemptRepository.findByStudentId(studentId);
        return allTests.stream()
            .filter(t -> "UNIT".equals(t.getTestType()))
            .collect(Collectors.toList());
    }
    
    @Override
    public StudentTestAttempt getStudentFinalTest(String studentId) {
        if (!studentExists(studentId)) {
            return null;
        }
        List<StudentTestAttempt> allTests = testAttemptRepository.findByStudentId(studentId);
        return allTests.stream()
            .filter(t -> "FINAL".equals(t.getTestType()))
            .max((t1, t2) -> t2.getCompletedAt().compareTo(t1.getCompletedAt()))
            .orElse(null);
    }
    
    @Override
    public StudentTestAttempt getTestResult(String studentId, Long contentId) {
        if (!studentExists(studentId)) {
            return null;
        }
        return testAttemptRepository.findByStudentAndContent(studentId, contentId).orElse(null);
    }
    
    @Override
    public boolean hasAttemptedTest(String studentId, Long contentId) {
        if (!studentExists(studentId)) {
            return false;
        }
        return testAttemptRepository.existsByStudentIdAndContentId(studentId, contentId);
    }
    
    @Override
    public boolean checkFinalEligibility(String studentId, String courseName) {
        if (!studentExists(studentId)) {
            return false;
        }
        
        // Get all unit tests for this student and course
        List<StudentTestAttempt> unitTests = testAttemptRepository.findByStudentIdAndTestType(studentId, "UNIT")
            .stream()
            .filter(t -> courseName.equals(t.getSubjectName()))
            .collect(Collectors.toList());
        
        if (unitTests.isEmpty()) {
            return false;
        }
        
        // Check if ALL unit tests are passed (percentage >= 50)
        boolean allUnitTestsPassed = unitTests.stream()
            .allMatch(t -> t.getPercentage() >= 50);
        
        // Check if final test already attempted for this course
        boolean finalAttempted = testAttemptRepository.findByStudentIdAndTestType(studentId, "FINAL")
            .stream()
            .anyMatch(t -> courseName.equals(t.getSubjectName()));
        
        // Eligible only if all unit tests passed AND final not attempted
        return allUnitTestsPassed && !finalAttempted;
    }
    
    @Override
    public Map<String, Object> getStudentStatistics(String studentId) {
        if (!studentExists(studentId)) {
            Map<String, Object> emptyStats = new HashMap<>();
            emptyStats.put("unitTestsCount", 0);
            emptyStats.put("avgPercentage", 0);
            emptyStats.put("passedCount", 0);
            emptyStats.put("eligibleForAnyCourse", false);
            return emptyStats;
        }
        
        List<StudentTestAttempt> allTests = testAttemptRepository.findByStudentId(studentId);
        List<StudentTestAttempt> unitTests = allTests.stream()
            .filter(t -> "UNIT".equals(t.getTestType()))
            .collect(Collectors.toList());
        StudentTestAttempt finalTest = allTests.stream()
            .filter(t -> "FINAL".equals(t.getTestType()))
            .findFirst().orElse(null);
        
        Map<String, Object> stats = new HashMap<>();
        
        // Overall statistics
        double avgPercentage = unitTests.stream()
            .mapToDouble(StudentTestAttempt::getPercentage)
            .average()
            .orElse(0.0);
        
        long passedCount = unitTests.stream()
            .filter(t -> t.getPercentage() >= 50)
            .count();
        
        stats.put("unitTestsCount", unitTests.size());
        stats.put("avgPercentage", Math.round(avgPercentage));
        stats.put("passedCount", passedCount);
        stats.put("highestScore", unitTests.stream()
            .mapToInt(StudentTestAttempt::getScore)
            .max()
            .orElse(0));
        stats.put("lowestScore", unitTests.stream()
            .mapToInt(StudentTestAttempt::getScore)
            .min()
            .orElse(0));
        
        // Course-wise statistics
        Map<String, Object> courseStats = new HashMap<>();
        Map<String, List<StudentTestAttempt>> unitTestsByCourse = unitTests.stream()
            .collect(Collectors.groupingBy(StudentTestAttempt::getSubjectName));
        
        for (Map.Entry<String, List<StudentTestAttempt>> entry : unitTestsByCourse.entrySet()) {
            String course = entry.getKey();
            List<StudentTestAttempt> courseUnitTests = entry.getValue();
            
            double courseAvg = courseUnitTests.stream()
                .mapToDouble(StudentTestAttempt::getPercentage)
                .average()
                .orElse(0.0);
            
            boolean allUnitTestsPassed = courseUnitTests.stream()
                .allMatch(t -> t.getPercentage() >= 50);
            
            boolean hasFinalTest = finalTest != null && course.equals(finalTest.getSubjectName());
            boolean finalPassed = hasFinalTest && finalTest.getPercentage() >= 50;
            
            Map<String, Object> courseInfo = new HashMap<>();
            courseInfo.put("avgPercentage", Math.round(courseAvg));
            courseInfo.put("unitTestsTaken", courseUnitTests.size());
            courseInfo.put("allUnitTestsPassed", allUnitTestsPassed);
            courseInfo.put("finalTestTaken", hasFinalTest);
            courseInfo.put("finalTestPassed", finalPassed);
            courseInfo.put("eligibleForCertificate", allUnitTestsPassed && finalPassed);
            
            courseStats.put(course, courseInfo);
        }
        
        stats.put("courseStats", courseStats);
        
        if (finalTest != null) {
            stats.put("finalTestScore", finalTest.getScore());
            stats.put("finalTestTotal", finalTest.getTotalQuestions());
            stats.put("finalTestPercentage", finalTest.getPercentage());
            stats.put("finalTestStatus", finalTest.getStatus());
            stats.put("finalTestCourse", finalTest.getSubjectName());
        } else {
            stats.put("finalTestStatus", "Not Attempted");
        }
        
        // Check overall eligibility (for any course)
        boolean eligibleForAnyCourse = courseStats.values().stream()
            .map(c -> (Map<String, Object>) c)
            .anyMatch(c -> Boolean.TRUE.equals(c.get("eligibleForCertificate")));
        
        stats.put("eligibleForAnyCourse", eligibleForAnyCourse);
        
        return stats;
    }
    
    @Override
    public Map<String, Object> getStudentEligibility(String studentId) {
        if (!studentExists(studentId)) {
            Map<String, Object> emptyResult = new HashMap<>();
            emptyResult.put("success", false);
            emptyResult.put("message", "Student not found");
            return emptyResult;
        }
        
        System.out.println("=== CALCULATING ELIGIBILITY FOR STUDENT: " + studentId + " ===");
        
        List<StudentTestAttempt> allTests = testAttemptRepository.findByStudentId(studentId);
        List<StudentTestAttempt> unitTests = allTests.stream()
            .filter(t -> "UNIT".equals(t.getTestType()))
            .collect(Collectors.toList());
        
        List<StudentTestAttempt> finalTests = allTests.stream()
            .filter(t -> "FINAL".equals(t.getTestType()))
            .collect(Collectors.toList());
        
        Map<String, Object> result = new HashMap<>();
        
        // STEP 1: Find ALL courses that have FINAL tests (these are the courses we care about)
        List<EducationalContent> allContent = contentRepository.findAll();
        Set<String> coursesWithFinalTests = new HashSet<>();
        
        for (EducationalContent content : allContent) {
            Long finalQuestionCount = mcqQuestionRepository.countByContentIdAndIsFinalTest(content.getContentId(), true);
            if (finalQuestionCount > 0) {
                coursesWithFinalTests.add(content.getSubjectName());
                System.out.println("Course with final test found: " + content.getSubjectName());
            }
        }
        
        // STEP 2: For each course with a final test, find ALL unit tests that exist for that course
        Map<String, List<EducationalContent>> unitTestsByCourse = new HashMap<>();
        
        for (EducationalContent content : allContent) {
            // Check if this content has unit test questions (has MCQ but not final test)
            Long unitQuestionCount = mcqQuestionRepository.countByContentIdAndIsFinalTest(content.getContentId(), false);
            if (unitQuestionCount > 0) {
                String course = content.getSubjectName();
                if (!unitTestsByCourse.containsKey(course)) {
                    unitTestsByCourse.put(course, new ArrayList<>());
                }
                unitTestsByCourse.get(course).add(content);
                System.out.println("Unit test found for course " + course + ": " + content.getContentTitle() + " (ID: " + content.getContentId() + ")");
            }
        }
        
        // STEP 3: Calculate eligibility for each course
        Map<String, Boolean> courseEligibility = new HashMap<>();
        Map<String, Double> courseAverages = new HashMap<>();
        Map<String, Boolean> courseFinalAttempted = new HashMap<>();
        Map<String, Boolean> courseFinalPassed = new HashMap<>();
        Map<String, Integer> courseUnitTestsTaken = new HashMap<>();
        Map<String, Integer> courseUnitTestsTotal = new HashMap<>();
        
        int eligibleCourseCount = 0;
        
        for (String course : coursesWithFinalTests) {
            System.out.println("\n--- Processing course: " + course + " ---");
            
            // Get all unit tests that exist for this course
            List<EducationalContent> existingUnitTests = unitTestsByCourse.getOrDefault(course, new ArrayList<>());
            int totalUnitTestsInCourse = existingUnitTests.size();
            courseUnitTestsTotal.put(course, totalUnitTestsInCourse);
            
            System.out.println("Total unit tests that exist for this course: " + totalUnitTestsInCourse);
            
            // Get student's unit test attempts for this course
            List<StudentTestAttempt> studentUnitTestsForCourse = unitTests.stream()
                .filter(t -> course.equals(t.getSubjectName()))
                .collect(Collectors.toList());
            
            int takenUnitTests = studentUnitTestsForCourse.size();
            courseUnitTestsTaken.put(course, takenUnitTests);
            
            System.out.println("Student has taken: " + takenUnitTests + " unit tests");
            
            // Calculate average
            double avgPercentage = studentUnitTestsForCourse.stream()
                .mapToDouble(StudentTestAttempt::getPercentage)
                .average()
                .orElse(0.0);
            courseAverages.put(course, Math.round(avgPercentage * 10) / 10.0);
            
            // Check if ALL unit tests are passed (need to have taken ALL existing unit tests AND each ≥50%)
            boolean allUnitTestsPassed = false;
            
            if (takenUnitTests == totalUnitTestsInCourse && totalUnitTestsInCourse > 0) {
                allUnitTestsPassed = studentUnitTestsForCourse.stream()
                    .allMatch(t -> t.getPercentage() >= 50);
                System.out.println("All unit tests passed? " + allUnitTestsPassed);
            } else {
                System.out.println("Not all unit tests taken yet");
            }
            
            // Check if final test attempted
            boolean finalAttemptedForCourse = finalTests.stream()
                .anyMatch(t -> course.equals(t.getSubjectName()));
            courseFinalAttempted.put(course, finalAttemptedForCourse);
            
            // Check if final test passed
            boolean finalPassedForCourse = false;
            if (finalAttemptedForCourse) {
                StudentTestAttempt finalTest = finalTests.stream()
                    .filter(t -> course.equals(t.getSubjectName()))
                    .max((t1, t2) -> t2.getCompletedAt().compareTo(t1.getCompletedAt()))
                    .orElse(null);
                finalPassedForCourse = finalTest != null && finalTest.getPercentage() >= 50;
            }
            courseFinalPassed.put(course, finalPassedForCourse);
            
            // Student is eligible for final test ONLY IF:
            // 1. They have taken ALL unit tests that exist for this course
            // 2. ALL unit tests are passed (≥50%)
            // 3. They have NOT attempted the final test yet
            boolean isEligibleForFinal = totalUnitTestsInCourse > 0 && 
                                 takenUnitTests == totalUnitTestsInCourse && 
                                 allUnitTestsPassed && 
                                 !finalAttemptedForCourse;
            
            courseEligibility.put(course, isEligibleForFinal);
            
            if (isEligibleForFinal) {
                eligibleCourseCount++;
                System.out.println("✅ STUDENT IS ELIGIBLE for " + course + " final test");
            } else {
                System.out.println("❌ Student is NOT eligible for " + course + " final test");
            }
        }
        
        result.put("success", true);
        result.put("coursesWithFinalTests", new ArrayList<>(coursesWithFinalTests));
        result.put("courseEligibility", courseEligibility);
        result.put("courseAverages", courseAverages);
        result.put("courseFinalAttempted", courseFinalAttempted);
        result.put("courseFinalPassed", courseFinalPassed);
        result.put("courseUnitTestsTaken", courseUnitTestsTaken);
        result.put("courseUnitTestsTotal", courseUnitTestsTotal);
        result.put("eligibleCourseCount", eligibleCourseCount);
        result.put("isEligible", eligibleCourseCount > 0);
        
        // Also add unit tests taken count for backward compatibility
        result.put("unitTestsTaken", unitTests.size());
        
        System.out.println("\n=== ELIGIBILITY CALCULATION COMPLETE ===");
        System.out.println("Eligible courses: " + eligibleCourseCount);
        
        return result;
    }
    
    @Override
    public boolean isEligibleForCertificate(String studentId, String courseName) {
        if (!studentExists(studentId)) {
            return false;
        }
        
        System.out.println("=== CHECKING CERTIFICATE ELIGIBILITY ===");
        System.out.println("Student ID: " + studentId);
        System.out.println("Course: " + courseName);
        
        try {
            // Check if student exists and is active
            Student student = studentRepository.findByStudentId(studentId);
            if (student == null) {
                System.out.println("Student not found");
                return false;
            }
            
            if (!"Active".equals(student.getStatus())) {
                System.out.println("Student not active. Status: " + student.getStatus());
                return false;
            }
            
            // Get ALL tests for this student
            List<StudentTestAttempt> allTests = testAttemptRepository.findByStudentId(studentId);
            
            // Get unit tests for this course
            List<StudentTestAttempt> courseUnitTests = allTests.stream()
                .filter(t -> courseName.equals(t.getSubjectName()) && "UNIT".equals(t.getTestType()))
                .collect(Collectors.toList());
            
            System.out.println("Unit tests found for course: " + courseUnitTests.size());
            
            if (courseUnitTests.isEmpty()) {
                System.out.println("No unit tests taken for this course");
                return false;
            }
            
            // Check if ALL unit tests are passed (percentage >= 50)
            boolean allUnitTestsPassed = courseUnitTests.stream()
                .allMatch(t -> t.getPercentage() >= 50);
            
            System.out.println("All unit tests passed: " + allUnitTestsPassed);
            
            if (!allUnitTestsPassed) {
                System.out.println("Some unit tests failed");
                return false;
            }
            
            // Get final tests for this course
            List<StudentTestAttempt> courseFinalTests = allTests.stream()
                .filter(t -> courseName.equals(t.getSubjectName()) && "FINAL".equals(t.getTestType()))
                .collect(Collectors.toList());
            
            System.out.println("Final tests found for course: " + courseFinalTests.size());
            
            if (courseFinalTests.isEmpty()) {
                System.out.println("No final test taken for this course");
                return false;
            }
            
            // Check if final test is passed (percentage >= 50)
            // Use the most recent final test
            StudentTestAttempt finalTest = courseFinalTests.stream()
                .max((t1, t2) -> t2.getCompletedAt().compareTo(t1.getCompletedAt()))
                .orElse(null);
            
            boolean finalTestPassed = finalTest.getPercentage() >= 50;
            System.out.println("Final test passed: " + finalTestPassed);
            
            if (!finalTestPassed) {
                System.out.println("Final test failed");
                return false;
            }
            
            System.out.println("=== STUDENT IS ELIGIBLE FOR CERTIFICATE ===");
            return true;
            
        } catch (Exception e) {
            System.err.println("Error checking eligibility: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public void updateFinalEligibility(String studentId, String courseName) {
        if (!studentExists(studentId)) {
            return;
        }
        
        List<StudentTestAttempt> unitTests = testAttemptRepository.findByStudentIdAndTestType(studentId, "UNIT")
            .stream()
            .filter(t -> courseName.equals(t.getSubjectName()))
            .collect(Collectors.toList());
        
        double avgPercentage = unitTests.stream()
            .mapToDouble(StudentTestAttempt::getPercentage)
            .average()
            .orElse(0.0);
        
        long passedTests = unitTests.stream()
            .filter(t -> "PASSED".equals(t.getStatus()))
            .count();
        
        boolean isEligible = avgPercentage >= 50 && passedTests > 0;
        
        StudentFinalEligibility eligibility = eligibilityRepository
            .findByStudentIdAndCourseName(studentId, courseName)
            .orElse(new StudentFinalEligibility());
        
        Student student = studentRepository.findByStudentId(studentId);
        
        eligibility.setStudentId(studentId);
        eligibility.setStudentName(student != null ? student.getFullName() : "");
        eligibility.setCourseName(courseName);
        eligibility.setEligible(isEligible);
        eligibility.setUnitTestAvg(avgPercentage);
        eligibility.setUnitTestsTaken((int) passedTests);
        eligibility.setUpdatedAt(LocalDateTime.now());
        
        eligibilityRepository.save(eligibility);
    }
    
    // ==================== TEACHER VIEW ====================
    
    @Override
    public List<StudentTestAttempt> getTestsByContentId(Long contentId) {
        List<StudentTestAttempt> results = testAttemptRepository.findByContentId(contentId);
        return filterResultsByExistingStudents(results);
    }
    
    @Override
    public List<StudentTestAttempt> getTestsBySubject(String subjectName) {
        List<StudentTestAttempt> results = testAttemptRepository.findBySubject(subjectName);
        return filterResultsByExistingStudents(results);
    }
    
    @Override
    public Map<String, Object> getSubjectStatistics(String subjectName) {
        List<StudentTestAttempt> tests = getTestsBySubject(subjectName);
        
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalTests", tests.size());
        
        double avgScore = tests.stream()
            .mapToInt(StudentTestAttempt::getScore)
            .average()
            .orElse(0.0);
        stats.put("avgScore", Math.round(avgScore));
        
        long passCount = tests.stream()
            .filter(t -> t.getPercentage() >= 50)
            .count();
        stats.put("passCount", passCount);
        
        long failCount = tests.stream()
            .filter(t -> t.getPercentage() < 50)
            .count();
        stats.put("failCount", failCount);
        
        stats.put("passRate", tests.size() > 0 ? Math.round((passCount * 100.0) / tests.size()) : 0);
        
        return stats;
    }
    
    @Override
    public List<StudentTestAttempt> getTeacherResults(Long teacherId) {
        // Get all content IDs created by this teacher
        List<Long> contentIds = mcqQuestionRepository.findDistinctContentIdsByTeacher(teacherId);
        
        if (contentIds.isEmpty()) {
            return new ArrayList<>();
        }
        
        List<StudentTestAttempt> results = testAttemptRepository.findByContentIds(contentIds);
        return filterResultsByExistingStudents(results);
    }
    
    @Override
    public Map<String, Object> getTeacherStatistics(Long teacherId) {
        List<StudentTestAttempt> results = getTeacherResults(teacherId);
        
        Map<String, Object> stats = new HashMap<>();
        
        // Unique students
        Set<String> uniqueStudents = results.stream()
            .map(StudentTestAttempt::getStudentId)
            .collect(Collectors.toSet());
        stats.put("totalStudents", uniqueStudents.size());
        
        stats.put("totalTests", results.size());
        
        double avgScore = results.stream()
            .mapToDouble(StudentTestAttempt::getPercentage)
            .average()
            .orElse(0.0);
        stats.put("avgScore", Math.round(avgScore));
        
        long passCount = results.stream()
            .filter(t -> t.getPercentage() >= 50)
            .count();
        
        stats.put("passRate", results.size() > 0 ? Math.round((passCount * 100.0) / results.size()) : 0);
        
        return stats;
    }
    
    // ==================== CERTIFICATE GENERATION ====================
    
    @Override
    public boolean generateCertificate(String studentId, String courseName) {
        if (!studentExists(studentId)) {
            return false;
        }
        
        // Check if already exists
        if (certificateRepository.existsByStudentIdAndCourseName(studentId, courseName)) {
            return false;
        }
        
        // Check eligibility
        if (!isEligibleForCertificate(studentId, courseName)) {
            return false;
        }
        
        List<StudentTestAttempt> allTests = testAttemptRepository.findByStudentId(studentId);
        
        List<StudentTestAttempt> unitTests = allTests.stream()
            .filter(t -> courseName.equals(t.getSubjectName()) && "UNIT".equals(t.getTestType()))
            .collect(Collectors.toList());
        
        StudentTestAttempt finalTest = allTests.stream()
            .filter(t -> courseName.equals(t.getSubjectName()) && "FINAL".equals(t.getTestType()))
            .findFirst().orElse(null);
        
        double avgPercentage = unitTests.stream()
            .mapToDouble(StudentTestAttempt::getPercentage)
            .average()
            .orElse(0.0);
        
        int totalMarks = unitTests.stream()
            .mapToInt(StudentTestAttempt::getScore)
            .sum() + (finalTest != null ? finalTest.getScore() : 0);
        
        // Calculate grade
        String grade;
        double overallPercentage = (avgPercentage + (finalTest != null ? finalTest.getPercentage() : 0)) / 2;
        
        if (overallPercentage >= 90) grade = "A+";
        else if (overallPercentage >= 80) grade = "A";
        else if (overallPercentage >= 70) grade = "B";
        else if (overallPercentage >= 60) grade = "C";
        else grade = "D";
        
        StudentCertificate certificate = new StudentCertificate();
        certificate.setCertificateId(generateCertificateId());
        certificate.setStudentId(studentId);
        certificate.setStudentName(unitTests.get(0).getStudentName());
        certificate.setCourseName(courseName);
        certificate.setUnitTestAvg(avgPercentage);
        certificate.setFinalTestScore(finalTest != null ? finalTest.getScore() : 0);
        certificate.setTotalMarks(totalMarks);
        certificate.setGrade(grade);
        
        certificateRepository.save(certificate);
        return true;
    }
    
    @Override
    public Map<String, Object> getCertificateData(String studentId, String courseName) {
        if (!studentExists(studentId)) {
            throw new RuntimeException("Student not found");
        }
        
        StudentCertificate certificate = certificateRepository
            .findByStudentIdAndCourseName(studentId, courseName)
            .orElseThrow(() -> new RuntimeException("Certificate not found"));
        
        Map<String, Object> data = new HashMap<>();
        
        data.put("certificateId", certificate.getCertificateId());
        data.put("studentName", certificate.getStudentName());
        data.put("studentId", certificate.getStudentId());
        data.put("courseName", certificate.getCourseName());
        data.put("issueDate", certificate.getIssueDate());
        data.put("unitTestAvg", certificate.getUnitTestAvg());
        data.put("finalTestScore", certificate.getFinalTestScore());
        data.put("totalMarks", certificate.getTotalMarks());
        data.put("grade", certificate.getGrade());
        
        return data;
    }
    
    // ==================== HELPER METHODS ====================
    
    private String generateQuestionId() {
        return "Q" + System.currentTimeMillis() + String.format("%03d", new Random().nextInt(1000));
    }
    
    private String generateAttemptId() {
        return "ATT" + System.currentTimeMillis() + String.format("%03d", new Random().nextInt(1000));
    }
    
    private String generateCertificateId() {
        return "CERT" + System.currentTimeMillis() + String.format("%03d", new Random().nextInt(1000));
    }

    @Override
    public Set<String> getAllExistingStudentIds() {
        return getExistingStudentIds();
    }
}