package com.example.institute.repository;

import com.example.institute.model.CourseParticipant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CourseParticipantRepository extends JpaRepository<CourseParticipant, Long> {
    
    Optional<CourseParticipant> findByParticipantUsername(String participantUsername);
    
    Optional<CourseParticipant> findByParticipantEmail(String participantEmail);
    
    Optional<CourseParticipant> findByEnrollmentNumber(String enrollmentNumber);
    
    boolean existsByParticipantUsername(String participantUsername);
    
    boolean existsByParticipantEmail(String participantEmail);
    
    @Query("SELECT cp FROM CourseParticipant cp WHERE cp.accountStatus = 'ACTIVE'")
    List<CourseParticipant> findAllActive();
}