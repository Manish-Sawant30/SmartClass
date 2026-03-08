package com.example.institute.service;

import com.example.institute.model.Parent;
import com.example.institute.model.Suggestion;

import java.util.List;
import java.util.Map;

public interface SuggestionService {
    
    // Create suggestion (by parent)
    Suggestion createSuggestion(Parent parent, String studentId, String studentName, 
                               String courseName, String subject, String message);
    
    // Get suggestions
    List<Suggestion> getAllSuggestions();
    Suggestion getSuggestionById(Long id);
    Suggestion getSuggestionBySuggestionId(String suggestionId);
    List<Suggestion> getSuggestionsByParent(Long parentId);
    List<Suggestion> getSuggestionsByStudent(String studentId);
    List<Suggestion> getSuggestionsByStatus(Suggestion.SuggestionStatus status);
    
    // Respond to suggestion (by admin)
    Suggestion respondToSuggestion(Long id, String response, String adminName);
    Suggestion updateSuggestionStatus(Long id, Suggestion.SuggestionStatus status);
    
    // Statistics
    Map<String, Object> getSuggestionStatistics();
    
    // Delete
    void deleteSuggestion(Long id);
    
    // ID generation
    String generateSuggestionId();
}