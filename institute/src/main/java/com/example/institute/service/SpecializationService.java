package com.example.institute.service;

import com.example.institute.model.Specialization;
import java.util.List;
import java.util.Map;

public interface SpecializationService {
    List<Specialization> getAllSpecializations();
    List<String> getAllCategories();
    Map<String, List<Specialization>> getSpecializationsByCategory();
    Specialization addSpecialization(String category, String name);
    void deleteSpecialization(Long id);
    Specialization updateSpecialization(Long id, String category, String name);
}