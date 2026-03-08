package com.example.institute.service.impl;

import com.example.institute.model.Specialization;
import com.example.institute.repository.SpecializationRepository;
import com.example.institute.service.SpecializationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class SpecializationServiceImpl implements SpecializationService {
    
    @Autowired
    private SpecializationRepository specializationRepository;
    
    @Override
    public List<Specialization> getAllSpecializations() {
        return specializationRepository.findByIsActiveTrue();
    }
    
    @Override
    public List<String> getAllCategories() {
        return specializationRepository.findDistinctCategories();
    }
    
    @Override
    public Map<String, List<Specialization>> getSpecializationsByCategory() {
        Map<String, List<Specialization>> result = new HashMap<>();
        List<String> categories = getAllCategories();
        
        for (String category : categories) {
            result.put(category, specializationRepository.findByCategory(category));
        }
        
        return result;
    }
    
    @Override
    public Specialization addSpecialization(String category, String name) {
        // Check if specialization already exists
        Optional<Specialization> existing = specializationRepository.findByCategoryAndName(category, name);
        if (existing.isPresent()) {
            Specialization spec = existing.get();
            if (!spec.isActive()) {
                spec.setActive(true);
                return specializationRepository.save(spec);
            }
            return spec; // Already exists and active
        }
        
        // Create new specialization
        Specialization specialization = new Specialization(category, name);
        return specializationRepository.save(specialization);
    }
    
    @Override
    public void deleteSpecialization(Long id) {
        specializationRepository.softDelete(id);
    }
    
    @Override
    public Specialization updateSpecialization(Long id, String category, String name) {
        Optional<Specialization> optional = specializationRepository.findById(id);
        if (optional.isPresent()) {
            Specialization specialization = optional.get();
            specialization.setCategory(category);
            specialization.setName(name);
            return specializationRepository.save(specialization);
        }
        return null;
    }
}