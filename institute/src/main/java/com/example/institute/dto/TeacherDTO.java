package com.example.institute.dto;

import com.example.institute.model.Teacher;
import java.util.List;
import java.util.stream.Collectors;

public class TeacherDTO {
    private Long id;
    private String teacherId;
    private String fullName;
    private String email;
    private String specialization;
    private List<String> specializations;
    private String status;
    
    public TeacherDTO(Teacher teacher) {
        this.id = teacher.getId();
        this.teacherId = teacher.getTeacherId();
        this.fullName = teacher.getFullName();
        this.email = teacher.getEmail();
        this.specializations = teacher.getSpecializations().stream()
                .map(spec -> spec.getName())
                .collect(Collectors.toList());
        this.specialization = teacher.getSpecializationNames();
        this.status = teacher.getStatus().toString();
    }
    
    // Getters
    public Long getId() { return id; }
    public String getTeacherId() { return teacherId; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getSpecialization() { return specialization; }
    public List<String> getSpecializations() { return specializations; }
    public String getStatus() { return status; }
}