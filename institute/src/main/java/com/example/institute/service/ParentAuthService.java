package com.example.institute.service;

import com.example.institute.model.Parent;

public interface ParentAuthService {
    Parent authenticate(String loginId, String password);
    void createParentSession(Parent parent);
    void invalidateParentSession();
    boolean isParentLoggedIn();
    Parent getCurrentParent();
}