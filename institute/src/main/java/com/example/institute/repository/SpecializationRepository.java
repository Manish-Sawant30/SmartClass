package com.example.institute.repository;

import com.example.institute.model.Specialization;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface SpecializationRepository extends JpaRepository<Specialization, Long> {
    List<Specialization> findByIsActiveTrue();
    List<Specialization> findByCategory(String category);
    Optional<Specialization> findByCategoryAndName(String category, String name);
    
    @Query("SELECT DISTINCT s.category FROM Specialization s WHERE s.isActive = true ORDER BY s.category")
    List<String> findDistinctCategories();
    
    @Modifying
    @Query("UPDATE Specialization s SET s.isActive = false WHERE s.id = ?1")
    void softDelete(Long id);
}