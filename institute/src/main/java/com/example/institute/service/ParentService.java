package com.example.institute.service;

import com.example.institute.model.Parent;
import java.util.List;

public interface ParentService {
    Parent registerParent(Parent parent);
    Parent authenticateParent(String loginId, String password);
    List<Parent> getAllParents();
    Parent getParentById(Long id);
    Parent getParentByParentId(String parentId);
    Parent getParentByEmail(String email);
    Parent updateParent(Long id, Parent parent);
    Parent updateParentStatus(Long id, Parent.ParentStatus status, String rejectionReason);
    void deleteParent(Long id);
    List<Parent> searchParents(String keyword);
    List<Parent> getParentsByStatus(Parent.ParentStatus status);
    String generateParentId();
    void reorderParentIds();
    boolean isParentApproved(String parentId);
    boolean validateParentCredentials(String loginId, String password);
}