package com.example.institute.repository;

import com.example.institute.model.AttAttendance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface AttAttendanceRepository extends JpaRepository<AttAttendance, Integer> {
    
    List<AttAttendance> findByStudentId(String studentId);
    
    List<AttAttendance> findByCourseId(Integer courseId);
    
    List<AttAttendance> findByAttendanceDate(LocalDate date);
    
    @Query("SELECT a FROM AttAttendance a WHERE a.studentId = :studentId AND a.courseId = :courseId")
    List<AttAttendance> findByStudentAndCourse(@Param("studentId") String studentId, @Param("courseId") Integer courseId);
    
    @Query("SELECT a FROM AttAttendance a WHERE a.studentId = :studentId AND a.attendanceDate = :date")
    List<AttAttendance> findByStudentAndDate(@Param("studentId") String studentId, @Param("date") LocalDate date);
    
    @Query("SELECT a FROM AttAttendance a WHERE a.studentId = :studentId AND a.courseId = :courseId AND a.attendanceDate = :date")
    AttAttendance findByStudentCourseAndDate(@Param("studentId") String studentId, 
                                           @Param("courseId") Integer courseId, 
                                           @Param("date") LocalDate date);
    
    @Query("SELECT a FROM AttAttendance a WHERE a.studentId = :studentId ORDER BY a.attendanceDate DESC")
    List<AttAttendance> findRecentByStudent(@Param("studentId") String studentId);
    
    @Query("SELECT COUNT(a) FROM AttAttendance a WHERE a.studentId = :studentId AND a.status = 'PRESENT'")
    Long countPresentByStudent(@Param("studentId") String studentId);
    
    @Query("SELECT COUNT(a) FROM AttAttendance a WHERE a.studentId = :studentId")
    Long countTotalByStudent(@Param("studentId") String studentId);
}