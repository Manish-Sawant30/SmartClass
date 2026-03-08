package com.example.institute.service;

import com.example.institute.model.TestScore;
import com.example.institute.repository.TestScoreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class TestScoreService {
    
    @Autowired
    private TestScoreRepository testScoreRepository;
    
    // Get all test scores
    public List<TestScore> getAllTestScores() {
        return testScoreRepository.findAll();
    }
    
    // Get test score by ID
    public TestScore getTestScoreById(Long id) {
        return testScoreRepository.findById(id).orElse(null);
    }
    
    // Save test score (both create and update)
    public TestScore saveTestScore(TestScore testScore) {
        return testScoreRepository.save(testScore);
    }
    
    // Delete test score
    public void deleteTestScore(Long id) {
        testScoreRepository.deleteById(id);
    }
    
    // Get scores by student ID - This should return ALL subjects for a student
    public List<TestScore> getScoresByStudentId(String studentId) {
        return testScoreRepository.findByStudentId(studentId);
    }
    
    // Check if score exists for student and course
    public boolean scoreExists(String studentId, String course) {
        return testScoreRepository.existsByStudentIdAndCourse(studentId, course);
    }
    
    // Get student statistics
    public Map<String, Object> getStudentStatistics(String studentId) {
        List<TestScore> scores = testScoreRepository.findByStudentId(studentId);
        Double average = testScoreRepository.findAverageScoreByStudentId(studentId);
        Integer highest = testScoreRepository.findHighestScoreByStudentId(studentId);
        Integer lowest = testScoreRepository.findLowestScoreByStudentId(studentId);
        
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalScores", scores.size());
        stats.put("averageScore", average != null ? Math.round(average) : 0);
        stats.put("highestScore", highest != null ? highest : 0);
        stats.put("lowestScore", lowest != null ? lowest : 0);
        
        // Calculate grade distribution
        Map<String, Integer> gradeDistribution = new HashMap<>();
        gradeDistribution.put("A", 0);
        gradeDistribution.put("B", 0);
        gradeDistribution.put("C", 0);
        gradeDistribution.put("D", 0);
        gradeDistribution.put("F", 0);
        
        for (TestScore score : scores) {
            String grade = getGrade(score.getTestScore());
            gradeDistribution.put(grade, gradeDistribution.get(grade) + 1);
        }
        stats.put("gradeDistribution", gradeDistribution);
        
        return stats;
    }
    
    // Get grade based on score
    private String getGrade(int score) {
        if (score >= 90) return "A";
        if (score >= 80) return "B";
        if (score >= 70) return "C";
        if (score >= 60) return "D";
        return "F";
    }
    
    // Get all unique student IDs
    public List<String> getAllStudentIds() {
        return testScoreRepository.findAllDistinctStudentIds();
    }
    
    // Get all unique courses
    public List<String> getAllCourses() {
        return testScoreRepository.findAllDistinctCourses();
    }
    
    // Search scores
    public List<TestScore> searchScores(String query) {
        return testScoreRepository.searchScores(query);
    }
    
    // Get dashboard statistics
    public Map<String, Object> getDashboardStats() {
        List<TestScore> allScores = testScoreRepository.findAll();
        List<String> allStudents = testScoreRepository.findAllDistinctStudentIds();
        List<String> allCourses = testScoreRepository.findAllDistinctCourses();
        
        // Calculate overall average
        double overallAverage = allScores.stream()
            .mapToInt(TestScore::getTestScore)
            .average()
            .orElse(0.0);
        
        // Find top score
        int topScore = allScores.stream()
            .mapToInt(TestScore::getTestScore)
            .max()
            .orElse(0);
        
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalStudents", allStudents.size());
        stats.put("totalCourses", allCourses.size());
        stats.put("averageScore", Math.round(overallAverage));
        stats.put("topScore", topScore);
        
        return stats;
    }
}