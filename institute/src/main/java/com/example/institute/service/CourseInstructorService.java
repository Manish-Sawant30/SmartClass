package com.example.institute.service;

import com.example.institute.model.CourseInstructor;
import java.util.List;

public interface CourseInstructorService {
    
    CourseInstructor createInstructor(CourseInstructor instructor);
    
    CourseInstructor updateInstructor(Long instructorId, CourseInstructor instructor);
    
    CourseInstructor getInstructorById(Long instructorId);
    
    CourseInstructor getInstructorByUsername(String username);
    
    List<CourseInstructor> getAllInstructors();
    
    void deleteInstructor(Long instructorId);
    
    boolean validateInstructorCredentials(String username, String password);
    
    void updateLastLogin(Long instructorId);
}