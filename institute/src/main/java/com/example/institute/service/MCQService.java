package com.example.institute.service;

import com.example.institute.model.MCQQuestion;
import com.example.institute.model.StudentTestAttempt;
import com.example.institute.model.StudentTestAnswer;
import java.util.List;
import java.util.Map;
import java.util.Set;

public interface MCQService {
    
    // ==================== QUESTION MANAGEMENT ====================
    
    List<MCQQuestion> addQuestions(List<MCQQuestion> questions);
    
    List<MCQQuestion> getQuestionsByContentId(Long contentId);
    
    MCQQuestion getQuestionById(Long id);
    
    MCQQuestion updateQuestion(Long id, MCQQuestion question);
    
    void deleteQuestion(Long id);
    
    void deleteQuestionsByContentId(Long contentId);
    
    Long getQuestionCountByContentId(Long contentId);
    
    Long getQuestionCountByTeacher(Long teacherId);
    
    // ==================== FINAL TEST MANAGEMENT ====================
    
    MCQQuestion createFinalTest(String course, String title, String description, 
                                Integer passingPercentage, List<MCQQuestion> questions, Long teacherId);
    
    List<MCQQuestion> getFinalTestsByCourse(String course);
    
    List<MCQQuestion> getAllFinalTests();
    
    // ==================== TEST TAKING ====================
    
    StudentTestAttempt startTest(String studentId, String studentName, Long contentId, String testType);
    
    StudentTestAttempt submitTest(String attemptId, Map<Long, String> answers);
    
    StudentTestAttempt getTestAttempt(String attemptId);
    
    List<StudentTestAnswer> getTestAnswers(String attemptId);
    
    // ==================== RESULTS AND ELIGIBILITY ====================
    
    List<StudentTestAttempt> getStudentResults(String studentId);
    
    List<StudentTestAttempt> getStudentUnitTests(String studentId);
    
    StudentTestAttempt getStudentFinalTest(String studentId);
    
    StudentTestAttempt getTestResult(String studentId, Long contentId);
    
    boolean hasAttemptedTest(String studentId, Long contentId);
    
    boolean checkFinalEligibility(String studentId, String courseName);
    
    Map<String, Object> getStudentStatistics(String studentId);
    
    Map<String, Object> getStudentEligibility(String studentId);
    
    void updateFinalEligibility(String studentId, String courseName);
    
    // ==================== TEACHER VIEW ====================
    
    List<StudentTestAttempt> getTestsByContentId(Long contentId);
    
    List<StudentTestAttempt> getTestsBySubject(String subjectName);
    
    Map<String, Object> getSubjectStatistics(String subjectName);
    
    List<StudentTestAttempt> getTeacherResults(Long teacherId);
    
    Map<String, Object> getTeacherStatistics(Long teacherId);
    
    // ==================== ALL RESULTS FOR TEACHER ====================
    
    List<StudentTestAttempt> getAllTestResults();
    
    // ==================== STUDENT EXISTENCE CHECK ====================
    
    Set<String> getAllExistingStudentIds();
    
    // ==================== CERTIFICATE GENERATION ====================
    
    boolean generateCertificate(String studentId, String courseName);
    
    boolean isEligibleForCertificate(String studentId, String courseName);
    
    Map<String, Object> getCertificateData(String studentId, String courseName);
}