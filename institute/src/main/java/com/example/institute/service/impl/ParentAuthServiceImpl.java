package com.example.institute.service.impl;

import com.example.institute.model.Parent;
import com.example.institute.repository.ParentRepository;
import com.example.institute.service.ParentAuthService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class ParentAuthServiceImpl implements ParentAuthService {
    
    @Autowired
    private ParentRepository parentRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private HttpSession session;
    
    @Override
    public Parent authenticate(String loginId, String password) {
        // Try to find parent by email or parentId
        Parent parent = parentRepository.findByEmail(loginId)
                .orElseGet(() -> parentRepository.findByParentId(loginId).orElse(null));
        
        if (parent == null) {
            throw new RuntimeException("Invalid login credentials");
        }
        
        // Check if password matches
        if (!passwordEncoder.matches(password, parent.getPassword())) {
            throw new RuntimeException("Invalid login credentials");
        }
        
        // Check parent status
        switch (parent.getStatus()) {
            case PENDING:
                throw new RuntimeException("Your account is pending approval. Please wait for admin approval.");
            case REJECTED:
                String reason = parent.getRejectionReason() != null ? 
                    " Reason: " + parent.getRejectionReason() : "";
                throw new RuntimeException("Your account has been rejected." + reason);
            case APPROVED:
            case ACTIVE:
                // All good, return parent
                return parent;
            case INACTIVE:
                throw new RuntimeException("Your account is inactive. Please contact administrator.");
            default:
                throw new RuntimeException("Account status unknown. Please contact administrator.");
        }
    }
    
    @Override
    public void createParentSession(Parent parent) {
        session.setAttribute("parent", parent);
        session.setAttribute("parentId", parent.getParentId());
        session.setAttribute("parentName", parent.getFullName());
        session.setAttribute("parentEmail", parent.getEmail());
        session.setAttribute("parentStatus", parent.getStatus().toString());
        session.setMaxInactiveInterval(30 * 60); // 30 minutes session timeout
    }
    
    @Override
    public void invalidateParentSession() {
        session.invalidate();
    }
    
    @Override
    public boolean isParentLoggedIn() {
        return session.getAttribute("parent") != null;
    }
    
    @Override
    public Parent getCurrentParent() {
        return (Parent) session.getAttribute("parent");
    }
}