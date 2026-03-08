package com.example.institute.service;

import com.example.institute.model.CourseParticipant;
import java.util.List;

public interface CourseParticipantService {
    
    CourseParticipant createParticipant(CourseParticipant participant);
    
    CourseParticipant updateParticipant(Long participantId, CourseParticipant participant);
    
    CourseParticipant getParticipantById(Long participantId);
    
    CourseParticipant getParticipantByUsername(String username);
    
    CourseParticipant getParticipantByEnrollmentNumber(String enrollmentNumber);
    
    List<CourseParticipant> getAllParticipants();
    
    void deleteParticipant(Long participantId);
    
    boolean validateParticipantCredentials(String username, String password);
    
    void updateEnrolledSubjects(Long participantId, String subjects);
}