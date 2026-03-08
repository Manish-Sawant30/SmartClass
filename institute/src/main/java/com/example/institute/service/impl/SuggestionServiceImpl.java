package com.example.institute.service.impl;

import com.example.institute.model.Parent;
import com.example.institute.model.Suggestion;
import com.example.institute.repository.SuggestionRepository;
import com.example.institute.service.SuggestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class SuggestionServiceImpl implements SuggestionService {
    
    @Autowired
    private SuggestionRepository suggestionRepository;
    
    @Override
    public Suggestion createSuggestion(Parent parent, String studentId, String studentName,
                                       String courseName, String subject, String message) {
        
        System.out.println("=== Creating Suggestion ===");
        System.out.println("Parent: " + parent.getFullName());
        System.out.println("Parent ID: " + parent.getId());
        System.out.println("Student ID: " + studentId);
        System.out.println("Subject: " + subject);
        
        try {
            // Create suggestion
            Suggestion suggestion = new Suggestion();
            suggestion.setParent(parent);
            suggestion.setParentName(parent.getFullName());
            suggestion.setParentEmail(parent.getEmail());
            suggestion.setStudentId(studentId);
            suggestion.setStudentName(studentName);
            suggestion.setCourseName(courseName);
            suggestion.setSubject(subject);
            suggestion.setMessage(message);
            suggestion.setSuggestionId(generateSuggestionId());
            suggestion.setStatus(Suggestion.SuggestionStatus.PENDING);
            suggestion.setCreatedAt(LocalDateTime.now());
            suggestion.setUpdatedAt(LocalDateTime.now());
            
            Suggestion savedSuggestion = suggestionRepository.save(suggestion);
            
            System.out.println("Suggestion created with ID: " + savedSuggestion.getSuggestionId());
            System.out.println("Suggestion DB ID: " + savedSuggestion.getId());
            
            return savedSuggestion;
            
        } catch (Exception e) {
            System.err.println("Error creating suggestion: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to create suggestion: " + e.getMessage());
        }
    }
    
    @Override
    public List<Suggestion> getAllSuggestions() {
        List<Suggestion> suggestions = suggestionRepository.findAllOrderByCreatedAtDesc();
        System.out.println("Total suggestions in database: " + suggestions.size());
        return suggestions;
    }
    
    @Override
    public Suggestion getSuggestionById(Long id) {
        return suggestionRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Suggestion not found with id: " + id));
    }
    
    @Override
    public Suggestion getSuggestionBySuggestionId(String suggestionId) {
        return suggestionRepository.findBySuggestionId(suggestionId)
            .orElseThrow(() -> new RuntimeException("Suggestion not found with ID: " + suggestionId));
    }
    
    @Override
    public List<Suggestion> getSuggestionsByParent(Long parentId) {
        List<Suggestion> suggestions = suggestionRepository.findByParentIdOrderByCreatedAtDesc(parentId);
        System.out.println("Found " + suggestions.size() + " suggestions for parent ID: " + parentId);
        return suggestions;
    }
    
    @Override
    public List<Suggestion> getSuggestionsByStudent(String studentId) {
        return suggestionRepository.findByStudentId(studentId);
    }
    
    @Override
    public List<Suggestion> getSuggestionsByStatus(Suggestion.SuggestionStatus status) {
        return suggestionRepository.findByStatusOrderByCreatedAtDesc(status);
    }
    
    @Override
    public Suggestion respondToSuggestion(Long id, String response, String adminName) {
        Suggestion suggestion = getSuggestionById(id);
        
        suggestion.setAdminResponse(response);
        suggestion.setRespondedBy(adminName);
        suggestion.setStatus(Suggestion.SuggestionStatus.RESPONDED);
        suggestion.setRespondedAt(LocalDateTime.now());
        suggestion.setUpdatedAt(LocalDateTime.now());
        
        Suggestion updatedSuggestion = suggestionRepository.save(suggestion);
        System.out.println("Responded to suggestion ID: " + id);
        
        return updatedSuggestion;
    }
    
    @Override
    public Suggestion updateSuggestionStatus(Long id, Suggestion.SuggestionStatus status) {
        Suggestion suggestion = getSuggestionById(id);
        suggestion.setStatus(status);
        suggestion.setUpdatedAt(LocalDateTime.now());
        
        if (status == Suggestion.SuggestionStatus.RESPONDED && suggestion.getRespondedAt() == null) {
            suggestion.setRespondedAt(LocalDateTime.now());
        }
        
        return suggestionRepository.save(suggestion);
    }
    
    @Override
    public Map<String, Object> getSuggestionStatistics() {
        Map<String, Object> stats = new HashMap<>();
        
        long totalSuggestions = suggestionRepository.count();
        long pendingCount = suggestionRepository.countByStatus(Suggestion.SuggestionStatus.PENDING);
        long readCount = suggestionRepository.countByStatus(Suggestion.SuggestionStatus.READ);
        long respondedCount = suggestionRepository.countByStatus(Suggestion.SuggestionStatus.RESPONDED);
        long closedCount = suggestionRepository.countByStatus(Suggestion.SuggestionStatus.CLOSED);
        
        stats.put("totalSuggestions", totalSuggestions);
        stats.put("pendingCount", pendingCount);
        stats.put("readCount", readCount);
        stats.put("respondedCount", respondedCount);
        stats.put("closedCount", closedCount);
        
        System.out.println("Suggestion Stats - Total: " + totalSuggestions + 
                         ", Pending: " + pendingCount + 
                         ", Responded: " + respondedCount);
        
        return stats;
    }
    
    @Override
    public void deleteSuggestion(Long id) {
        Suggestion suggestion = getSuggestionById(id);
        suggestionRepository.delete(suggestion);
        System.out.println("Deleted suggestion ID: " + id);
    }
    
    @Override
    public String generateSuggestionId() {
        Integer maxIdNumber = suggestionRepository.findMaxSuggestionIdNumber();
        if (maxIdNumber == null) {
            maxIdNumber = 0;
        }
        int newIdNumber = maxIdNumber + 1;
        return String.format("SUG%03d", newIdNumber);
    }
}