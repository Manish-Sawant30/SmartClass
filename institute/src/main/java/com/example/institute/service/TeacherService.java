package com.example.institute.service;

import com.example.institute.model.Teacher;
import com.example.institute.model.Teacher.TeacherStatus;

import java.util.List;

public interface TeacherService {
    Teacher registerTeacher(Teacher teacher);
    Teacher login(String userId, String password);
    List<Teacher> getAllTeachers();
    Teacher getTeacherById(Long id);
    Teacher getTeacherByTeacherId(String teacherId);
    Teacher updateTeacher(Long id, Teacher teacher);
    Teacher approveTeacher(Long id);
    Teacher rejectTeacher(Long id);
    void deleteTeacher(Long id);
    List<Teacher> searchTeachers(String keyword);
    String generateTeacherId();
    void reorderTeacherIds();
    long countTotalTeachers();
    long countByStatus(Teacher.TeacherStatus status);
	Teacher forceUpdateStatus(Long id, TeacherStatus newStatus);
}