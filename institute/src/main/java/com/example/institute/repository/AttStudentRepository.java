package com.example.institute.repository;

import com.example.institute.model.AttStudent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;
import java.util.List;  // Add this import

@Repository
public interface AttStudentRepository extends JpaRepository<AttStudent, String> {
    Optional<AttStudent> findByStudentId(String studentId);
    List<AttStudent> findByStudentNameContainingIgnoreCase(String name);
}