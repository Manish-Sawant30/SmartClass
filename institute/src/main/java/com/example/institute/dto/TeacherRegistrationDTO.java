package com.example.institute.dto;

import java.util.List;

public class TeacherRegistrationDTO {
    private String fullName;
    private String email;
    private List<Long> specializationIds;
    private String password;
    private String confirmPassword;
    
    // Getters and Setters
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public List<Long> getSpecializationIds() { return specializationIds; }
    public void setSpecializationIds(List<Long> specializationIds) { this.specializationIds = specializationIds; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getConfirmPassword() { return confirmPassword; }
    public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }
}