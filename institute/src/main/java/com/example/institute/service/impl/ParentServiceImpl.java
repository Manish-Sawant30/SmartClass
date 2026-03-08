package com.example.institute.service.impl;

import com.example.institute.model.Parent;
import com.example.institute.model.ParentCourse;
import com.example.institute.repository.ParentCourseRepository;
import com.example.institute.repository.ParentRepository;
import com.example.institute.service.ParentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ParentServiceImpl implements ParentService {
    
    @Autowired
    private ParentRepository parentRepository;
    
    @Autowired
    private ParentCourseRepository parentCourseRepository;
    
    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    
    @Override
    public Parent registerParent(Parent parent) {
        System.out.println("=== Starting parent registration ===");
        
        // Check if email already exists
        if (parentRepository.existsByEmail(parent.getEmail())) {
            throw new RuntimeException("Email already exists. Please use a different email.");
        }
        
        // Generate parent ID
        String parentId = generateParentId();
        parent.setParentId(parentId);
        System.out.println("Generated Parent ID: " + parentId);
        
        // Hash password
        if (parent.getPassword() == null || parent.getPassword().isEmpty()) {
            throw new RuntimeException("Password cannot be empty");
        }
        String hashedPassword = passwordEncoder.encode(parent.getPassword());
        parent.setPassword(hashedPassword);
        
        // Set default values
        parent.setStatus(Parent.ParentStatus.PENDING);
        parent.setEmailVerified(false);
        parent.setMobileVerified(false);
        
        // Set timestamps
        LocalDateTime now = LocalDateTime.now();
        parent.setCreatedAt(now);
        parent.setUpdatedAt(now);
        
        try {
            // Save parent first
            Parent savedParent = parentRepository.save(parent);
            System.out.println("Parent saved successfully with ID: " + savedParent.getId());
            
            // Save courses if any
            if (parent.getCourses() != null && !parent.getCourses().isEmpty()) {
                for (ParentCourse course : parent.getCourses()) {
                    course.setParent(savedParent);
                    parentCourseRepository.save(course);
                }
                System.out.println("Saved " + parent.getCourses().size() + " course(s)");
            }
            
            // Refresh to get courses
            return parentRepository.findById(savedParent.getId()).orElse(savedParent);
            
        } catch (Exception e) {
            System.err.println("Error saving parent: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to register parent: " + e.getMessage(), e);
        }
    }
    
    @Override
    public Parent authenticateParent(String loginId, String password) {
        System.out.println("=== Authenticating parent with loginId: " + loginId);
        
        Parent parent = null;
        
        if (loginId.contains("@")) {
            parent = parentRepository.findByEmail(loginId).orElse(null);
        } else {
            parent = parentRepository.findByParentId(loginId).orElse(null);
        }
        
        if (parent == null) {
            System.out.println("Parent not found with loginId: " + loginId);
            throw new RuntimeException("Invalid Parent ID or Email");
        }
        
        System.out.println("Parent found: " + parent.getEmail());
        System.out.println("Parent status: " + parent.getStatus());
        
        if (!passwordEncoder.matches(password, parent.getPassword())) {
            System.out.println("Password mismatch");
            throw new RuntimeException("Invalid password");
        }
        
        if (!parent.canLogin()) {
            String message = "";
            switch (parent.getStatus()) {
                case PENDING:
                    message = "Your account is pending approval. Please wait for admin approval.";
                    break;
                case REJECTED:
                    message = "Your account has been rejected." + 
                             (parent.getRejectionReason() != null ? 
                              " Reason: " + parent.getRejectionReason() : "");
                    break;
                case INACTIVE:
                    message = "Your account is inactive. Please contact administrator.";
                    break;
                default:
                    message = "Your account cannot login at this time.";
            }
            throw new RuntimeException(message);
        }
        
        System.out.println("Authentication successful");
        return parent;
    }
    
    @Override
    public List<Parent> getAllParents() {
        List<Parent> parents = parentRepository.findAll();
        // Load courses for each parent separately to avoid collection issues
        for (Parent parent : parents) {
            List<ParentCourse> courses = parentCourseRepository.findByParentId(parent.getId());
            parent.setCourses(courses);
        }
        return parents;
    }
    
    @Override
    public Parent getParentById(Long id) {
        Optional<Parent> optional = parentRepository.findById(id);
        if (optional.isPresent()) {
            Parent parent = optional.get();
            List<ParentCourse> courses = parentCourseRepository.findByParentId(parent.getId());
            parent.setCourses(courses);
            return parent;
        }
        return null;
    }
    
    @Override
    public Parent getParentByParentId(String parentId) {
        Optional<Parent> optional = parentRepository.findByParentId(parentId);
        if (optional.isPresent()) {
            Parent parent = optional.get();
            List<ParentCourse> courses = parentCourseRepository.findByParentId(parent.getId());
            parent.setCourses(courses);
            return parent;
        }
        return null;
    }
    
    @Override
    public Parent getParentByEmail(String email) {
        Optional<Parent> optional = parentRepository.findByEmail(email);
        if (optional.isPresent()) {
            Parent parent = optional.get();
            List<ParentCourse> courses = parentCourseRepository.findByParentId(parent.getId());
            parent.setCourses(courses);
            return parent;
        }
        return null;
    }
    
    @Override
    @Transactional
    public Parent updateParent(Long id, Parent parentDetails) {
        Optional<Parent> optional = parentRepository.findById(id);
        if (optional.isPresent()) {
            Parent parent = optional.get();
            
            parent.setFullName(parentDetails.getFullName());
            parent.setEmail(parentDetails.getEmail());
            parent.setMobileNumber(parentDetails.getMobileNumber());
            parent.setStudentId(parentDetails.getStudentId());
            parent.setStatus(parentDetails.getStatus());
            parent.setRejectionReason(parentDetails.getRejectionReason());
            parent.setUpdatedAt(LocalDateTime.now());
            
            return parentRepository.save(parent);
        }
        return null;
    }
    
    @Override
    @Transactional
    public Parent updateParentStatus(Long id, Parent.ParentStatus status, String rejectionReason) {
        Optional<Parent> optional = parentRepository.findById(id);
        if (optional.isPresent()) {
            Parent parent = optional.get();
            parent.setStatus(status);
            parent.setUpdatedAt(LocalDateTime.now());
            
            if (status == Parent.ParentStatus.REJECTED) {
                parent.setRejectionReason(rejectionReason);
            } else {
                parent.setRejectionReason(null);
            }
            
            return parentRepository.save(parent);
        }
        return null;
    }
    
    @Override
    @Transactional
    public void deleteParent(Long id) {
        Optional<Parent> optional = parentRepository.findById(id);
        if (optional.isPresent()) {
            Parent parent = optional.get();
            
            // Delete courses first
            parentCourseRepository.deleteByParentId(id);
            
            // Delete parent
            parentRepository.deleteById(id);
            
            // Reorder parent IDs
            reorderParentIds();
        }
    }
    
    @Override
    public List<Parent> searchParents(String keyword) {
        List<Parent> parents = parentRepository.searchParents(keyword);
        // Load courses for each parent
        for (Parent parent : parents) {
            List<ParentCourse> courses = parentCourseRepository.findByParentId(parent.getId());
            parent.setCourses(courses);
        }
        return parents;
    }
    
    @Override
    public List<Parent> getParentsByStatus(Parent.ParentStatus status) {
        List<Parent> parents = parentRepository.findByStatus(status);
        // Load courses for each parent
        for (Parent parent : parents) {
            List<ParentCourse> courses = parentCourseRepository.findByParentId(parent.getId());
            parent.setCourses(courses);
        }
        return parents;
    }
    
    @Override
    public String generateParentId() {
        Integer maxIdNumber = parentRepository.findMaxParentIdNumber();
        if (maxIdNumber == null) {
            maxIdNumber = 0;
        }
        int newIdNumber = maxIdNumber + 1;
        return String.format("P%03d", newIdNumber);
    }
    
    @Override
    @Transactional
    public void reorderParentIds() {
        List<Parent> allParents = parentRepository.findAll();
        
        for (int i = 0; i < allParents.size(); i++) {
            Parent parent = allParents.get(i);
            String newParentId = String.format("P%03d", i + 1);
            
            if (!parent.getParentId().equals(newParentId)) {
                parent.setParentId(newParentId);
                parent.setUpdatedAt(LocalDateTime.now());
                parentRepository.save(parent);
            }
        }
    }
    
    @Override
    public boolean isParentApproved(String parentId) {
        Parent parent = getParentByParentId(parentId);
        if (parent != null) {
            return parent.getStatus() == Parent.ParentStatus.APPROVED || 
                   parent.getStatus() == Parent.ParentStatus.ACTIVE;
        }
        return false;
    }
    
    @Override
    public boolean validateParentCredentials(String loginId, String password) {
        try {
            Parent parent = authenticateParent(loginId, password);
            return parent != null;
        } catch (Exception e) {
            return false;
        }
    }
}