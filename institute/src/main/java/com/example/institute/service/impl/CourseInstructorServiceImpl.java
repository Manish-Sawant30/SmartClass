package com.example.institute.service.impl;

import com.example.institute.model.CourseInstructor;
import com.example.institute.model.AccountStatus;
import com.example.institute.repository.CourseInstructorRepository;
import com.example.institute.service.CourseInstructorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CourseInstructorServiceImpl implements CourseInstructorService {
    
    @Autowired
    private CourseInstructorRepository courseInstructorRepository;
    
    @Override
    public CourseInstructor createInstructor(CourseInstructor instructor) {
        return courseInstructorRepository.save(instructor);
    }
    
    @Override
    public CourseInstructor updateInstructor(Long instructorId, CourseInstructor instructor) {
        CourseInstructor existingInstructor = getInstructorById(instructorId);
        
        existingInstructor.setInstructorFullname(instructor.getInstructorFullname());
        existingInstructor.setInstructorEmail(instructor.getInstructorEmail());
        existingInstructor.setAcademicDepartment(instructor.getAcademicDepartment());
        existingInstructor.setAccountStatus(instructor.getAccountStatus());
        
        if (instructor.getInstructorPassword() != null && !instructor.getInstructorPassword().isEmpty()) {
            existingInstructor.setInstructorPassword(instructor.getInstructorPassword());
        }
        
        return courseInstructorRepository.save(existingInstructor);
    }
    
    @Override
    public CourseInstructor getInstructorById(Long instructorId) {
        return courseInstructorRepository.findById(instructorId)
            .orElseThrow(() -> new RuntimeException("Course instructor not found with ID: " + instructorId));
    }
    
    @Override
    public CourseInstructor getInstructorByUsername(String username) {
        return courseInstructorRepository.findByInstructorUsername(username)
            .orElseThrow(() -> new RuntimeException("Course instructor not found with username: " + username));
    }
    
    @Override
    public List<CourseInstructor> getAllInstructors() {
        return courseInstructorRepository.findAllActive();
    }
    
    @Override
    public void deleteInstructor(Long instructorId) {
        CourseInstructor instructor = getInstructorById(instructorId);
        instructor.setAccountStatus(AccountStatus.INACTIVE); // Fixed: Removed full package reference
        courseInstructorRepository.save(instructor);
    }
    
    @Override
    public boolean validateInstructorCredentials(String username, String password) {
        try {
            CourseInstructor instructor = getInstructorByUsername(username);
            return instructor.getInstructorPassword().equals(password) && 
                   instructor.getAccountStatus() == AccountStatus.ACTIVE; // Fixed: Removed full package reference
        } catch (Exception e) {
            return false;
        }
    }
    
    @Override
    public void updateLastLogin(Long instructorId) {
        CourseInstructor instructor = getInstructorById(instructorId);
        instructor.setLastLogin(LocalDateTime.now());
        courseInstructorRepository.save(instructor);
    }
}