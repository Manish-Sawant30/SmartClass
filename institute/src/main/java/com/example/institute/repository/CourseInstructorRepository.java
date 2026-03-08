package com.example.institute.repository;

import com.example.institute.model.CourseInstructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CourseInstructorRepository extends JpaRepository<CourseInstructor, Long> {
    
    Optional<CourseInstructor> findByInstructorUsername(String instructorUsername);
    
    Optional<CourseInstructor> findByInstructorEmail(String instructorEmail);
    
    boolean existsByInstructorUsername(String instructorUsername);
    
    boolean existsByInstructorEmail(String instructorEmail);
    
    @Query("SELECT ci FROM CourseInstructor ci WHERE ci.accountStatus = 'ACTIVE'")
    List<CourseInstructor> findAllActive();
}