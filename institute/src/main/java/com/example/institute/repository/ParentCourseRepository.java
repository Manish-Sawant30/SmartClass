package com.example.institute.repository;

import com.example.institute.model.ParentCourse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ParentCourseRepository extends JpaRepository<ParentCourse, Long> {
    List<ParentCourse> findByParentId(Long parentId);
    void deleteByParentId(Long parentId);
    void deleteByParentIdAndCourseName(Long parentId, String courseName);
}