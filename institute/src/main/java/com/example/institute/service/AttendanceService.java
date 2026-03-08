package com.example.institute.service;

import com.example.institute.model.AttAttendance;
import com.example.institute.model.AttCourse;
import com.example.institute.model.AttStudent;
import com.example.institute.repository.AttAttendanceRepository;
import com.example.institute.repository.AttCourseRepository;
import com.example.institute.repository.AttStudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class AttendanceService {
    
    @Autowired
    private AttAttendanceRepository attendanceRepository;
    
    @Autowired
    private AttStudentRepository studentRepository;
    
    @Autowired
    private AttCourseRepository courseRepository;
    
    // Get all courses
    public List<AttCourse> getAllCourses() {
        return courseRepository.findAllByOrderByCourseNameAsc();
    }
    
    // Get student by ID
    public Optional<AttStudent> getStudentById(String studentId) {
        return studentRepository.findByStudentId(studentId);
    }
    
    // Mark attendance
    public AttAttendance markAttendance(String studentId, Integer courseId, 
                                      AttAttendance.AttendanceStatus status, 
                                      String markedBy, String remarks) {
        
        // Check if attendance already marked for today
        LocalDate today = LocalDate.now();
        AttAttendance existing = attendanceRepository.findByStudentCourseAndDate(studentId, courseId, today);
        
        if (existing != null) {
            // Update existing attendance
            existing.setStatus(status);
            existing.setRemarks(remarks);
            existing.setMarkedAt(java.time.LocalDateTime.now());
            return attendanceRepository.save(existing);
        } else {
            // Create new attendance
            AttAttendance attendance = new AttAttendance();
            attendance.setStudentId(studentId);
            attendance.setCourseId(courseId);
            attendance.setAttendanceDate(today);
            attendance.setStatus(status);
            attendance.setMarkedBy(markedBy);
            attendance.setRemarks(remarks);
            
            // Get student and course names for response
            Optional<AttStudent> student = studentRepository.findByStudentId(studentId);
            Optional<AttCourse> course = courseRepository.findById(courseId);
            
            if (student.isPresent()) {
                attendance.setStudentName(student.get().getStudentName());
            }
            if (course.isPresent()) {
                attendance.setCourseName(course.get().getCourseName());
            }
            
            return attendanceRepository.save(attendance);
        }
    }
    
    // Get attendance for a student
    public List<AttAttendance> getStudentAttendance(String studentId) {
        List<AttAttendance> attendanceList = attendanceRepository.findByStudentId(studentId);
        
        // Populate student and course names
        for (AttAttendance attendance : attendanceList) {
            Optional<AttStudent> student = studentRepository.findByStudentId(attendance.getStudentId());
            Optional<AttCourse> course = courseRepository.findById(attendance.getCourseId());
            
            if (student.isPresent()) {
                attendance.setStudentName(student.get().getStudentName());
            }
            if (course.isPresent()) {
                attendance.setCourseName(course.get().getCourseName());
            }
        }
        
        return attendanceList;
    }
    
    // Get attendance statistics for a student
    public Map<String, Object> getStudentAttendanceStats(String studentId) {
        Map<String, Object> stats = new HashMap<>();
        
        List<AttAttendance> allAttendance = attendanceRepository.findByStudentId(studentId);
        Long presentCount = attendanceRepository.countPresentByStudent(studentId);
        Long totalCount = attendanceRepository.countTotalByStudent(studentId);
        
        // Group by course
        Map<String, Map<String, Integer>> courseStats = new HashMap<>();
        for (AttAttendance att : allAttendance) {
            String courseName = att.getCourseName();
            if (courseName == null) {
                Optional<AttCourse> course = courseRepository.findById(att.getCourseId());
                courseName = course.isPresent() ? course.get().getCourseName() : "Unknown Course";
            }
            
            if (!courseStats.containsKey(courseName)) {
                Map<String, Integer> courseData = new HashMap<>();
                courseData.put("total", 0);
                courseData.put("present", 0);
                courseData.put("absent", 0);
                courseData.put("late", 0);
                courseStats.put(courseName, courseData);
            }
            
            Map<String, Integer> courseData = courseStats.get(courseName);
            courseData.put("total", courseData.get("total") + 1);
            
            switch (att.getStatus()) {
                case PRESENT:
                    courseData.put("present", courseData.get("present") + 1);
                    break;
                case ABSENT:
                    courseData.put("absent", courseData.get("absent") + 1);
                    break;
                case LATE:
                    courseData.put("late", courseData.get("late") + 1);
                    break;
            }
        }
        
        // Calculate percentages
        Map<String, Map<String, Object>> detailedStats = new HashMap<>();
        for (Map.Entry<String, Map<String, Integer>> entry : courseStats.entrySet()) {
            String courseName = entry.getKey();
            Map<String, Integer> data = entry.getValue();
            Map<String, Object> courseDetail = new HashMap<>();
            
            courseDetail.put("total", data.get("total"));
            courseDetail.put("present", data.get("present"));
            courseDetail.put("absent", data.get("absent"));
            courseDetail.put("late", data.get("late"));
            
            if (data.get("total") > 0) {
                double attendancePercentage = (data.get("present") * 100.0) / data.get("total");
                courseDetail.put("percentage", Math.round(attendancePercentage * 100.0) / 100.0);
                
                // Determine status
                if (attendancePercentage >= 90) {
                    courseDetail.put("status", "Excellent");
                } else if (attendancePercentage >= 75) {
                    courseDetail.put("status", "Good");
                } else {
                    courseDetail.put("status", "Needs Attention");
                }
            }
            
            detailedStats.put(courseName, courseDetail);
        }
        
        // Overall statistics
        if (totalCount > 0) {
            double overallPercentage = (presentCount * 100.0) / totalCount;
            stats.put("overallPercentage", Math.round(overallPercentage * 100.0) / 100.0);
        } else {
            stats.put("overallPercentage", 0.0);
        }
        
        stats.put("presentCount", presentCount);
        stats.put("totalCount", totalCount);
        stats.put("courseStats", detailedStats);
        stats.put("recentAttendance", attendanceRepository.findRecentByStudent(studentId));
        
        return stats;
    }
    
    // Get today's attendance for a course
    public List<Map<String, Object>> getTodayAttendanceByCourse(Integer courseId) {
        List<Map<String, Object>> result = new ArrayList<>();
        LocalDate today = LocalDate.now();
        
        List<AttAttendance> todayAttendance = attendanceRepository.findByAttendanceDate(today);
        
        for (AttAttendance att : todayAttendance) {
            if (att.getCourseId().equals(courseId)) {
                Map<String, Object> attendanceData = new HashMap<>();
                attendanceData.put("studentId", att.getStudentId());
                attendanceData.put("status", att.getStatus());
                attendanceData.put("remarks", att.getRemarks());
                attendanceData.put("markedAt", att.getMarkedAt());
                
                // Get student name
                Optional<AttStudent> student = studentRepository.findByStudentId(att.getStudentId());
                if (student.isPresent()) {
                    attendanceData.put("studentName", student.get().getStudentName());
                }
                
                result.add(attendanceData);
            }
        }
        
        return result;
    }
    
    // Add new student
    public AttStudent addStudent(String studentId, String studentName, String parentName, String parentEmail) {
        AttStudent student = new AttStudent(studentId, studentName, parentName, parentEmail);
        return studentRepository.save(student);
    }
    
    // Get all students
    public List<AttStudent> getAllStudents() {
        return studentRepository.findAll();
    }
}