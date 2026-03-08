package com.example.institute.repository;

import com.example.institute.model.AttCourse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface AttCourseRepository extends JpaRepository<AttCourse, Integer> {
    List<AttCourse> findAllByOrderByCourseNameAsc();
    AttCourse findByCourseName(String courseName);
}