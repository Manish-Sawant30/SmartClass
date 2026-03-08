package com.example.institute.service.impl;

import com.example.institute.model.Student;
import com.example.institute.model.StudentCertificate;
import com.example.institute.model.StudentFinalEligibility;
import com.example.institute.model.StudentTestAttempt;
import com.example.institute.repository.StudentCertificateRepository;
import com.example.institute.repository.StudentFinalEligibilityRepository;
import com.example.institute.repository.StudentRepository;
import com.example.institute.repository.StudentTestAttemptRepository;
import com.example.institute.repository.StudentTestAnswerRepository;
import com.example.institute.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Transactional
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private StudentCertificateRepository certificateRepository;
    
    @Autowired
    private StudentFinalEligibilityRepository eligibilityRepository;
    
    @Autowired
    private StudentTestAttemptRepository testAttemptRepository;
    
    @Autowired
    private StudentTestAnswerRepository testAnswerRepository;
    
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Override
    public Student saveStudent(Student student) {
        // Check if email already exists
        if (emailExists(student.getEmail())) {
            throw new RuntimeException("Email already registered: " + student.getEmail());
        }
        
        // Check if mobile already exists
        if (mobileExists(student.getMobile())) {
            throw new RuntimeException("Mobile number already registered: " + student.getMobile());
        }
        
        // Check if at least one course is selected
        if (student.getCourses() == null || student.getCourses().isEmpty()) {
            throw new RuntimeException("Please select at least one course");
        }
        
        // Generate unique student ID
        String studentId = generateStudentId();
        student.setStudentId(studentId);
        
        // Hash password
        student.setPassword(passwordEncoder.encode(student.getPassword()));
        
        // Set status to Pending by default
        student.setStatus("Pending");
        student.setCreatedAt(LocalDateTime.now());
        student.setUpdatedAt(LocalDateTime.now());
        
        return studentRepository.save(student);
    }

    @Override
    public Student login(String identifier, String password) {
        // Find student by email or student ID
        Student student = studentRepository.findByEmail(identifier);
        if (student == null) {
            student = studentRepository.findByStudentId(identifier);
        }
        
        if (student == null) {
            throw new RuntimeException("Invalid credentials");
        }
        
        // Verify password
        if (!passwordEncoder.matches(password, student.getPassword())) {
            throw new RuntimeException("Invalid credentials");
        }
        
        // Check account status
        String status = student.getStatus();
        
        if ("Pending".equals(status)) {
            throw new RuntimeException("Your account is pending approval. Please wait for admin approval.");
        }
        
        if ("Rejected".equals(status)) {
            throw new RuntimeException("Your account has been rejected by admin. Please contact support.");
        }
        
        if ("Inactive".equals(status)) {
            throw new RuntimeException("Your account is inactive. Please contact admin to activate.");
        }
        
        if (!"Active".equals(status)) {
            throw new RuntimeException("Account status unknown: " + status);
        }
        
        return student;
    }

    @Override
    public Student approveStudent(Long id) {
        Student student = getStudentById(id);
        student.setStatus("Active");
        student.setUpdatedAt(LocalDateTime.now());
        return studentRepository.save(student);
    }
    
    @Override
    public Student rejectStudent(Long id) {
        Student student = getStudentById(id);
        student.setStatus("Rejected");
        student.setUpdatedAt(LocalDateTime.now());
        return studentRepository.save(student);
    }
    
    @Override
    public Student updateStudentStatus(Long id, String status) {
        Student student = getStudentById(id);
        student.setStatus(status);
        student.setUpdatedAt(LocalDateTime.now());
        return studentRepository.save(student);
    }

    @Override
    public Student getStudentById(Long id) {
        return studentRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Student not found with id: " + id));
    }
    
    @Override
    public Student getStudentByStudentId(String studentId) {
        try {
            return studentRepository.findByStudentId(studentId);
        } catch (Exception e) {
            System.err.println("Error finding student by ID: " + studentId + " - " + e.getMessage());
            return null;
        }
    }

    @Override
    public boolean studentIdExists(String studentId) {
        return studentRepository.existsByStudentId(studentId);
    }

    @Override
    public String generateStudentId() {
        try {
            // Get the maximum existing student ID
            String maxStudentId = studentRepository.findMaxStudentId();
            int nextNumber = 1001; // Default starting number
            
            if (maxStudentId != null && maxStudentId.startsWith("STU")) {
                try {
                    String numberStr = maxStudentId.substring(3);
                    nextNumber = Integer.parseInt(numberStr) + 1;
                } catch (NumberFormatException e) {
                    // If parsing fails, start from 1001
                }
            }
            
            return String.format("STU%04d", nextNumber);
        } catch (Exception e) {
            // Fallback if any error occurs
            long timestamp = System.currentTimeMillis() % 10000;
            return String.format("STU%04d", timestamp);
        }
    }

    @Override
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    @Override
    public Student updateStudent(Long id, Student studentDetails) {
        Student student = getStudentById(id);
        
        // Check if new email is different and already exists
        if (!student.getEmail().equals(studentDetails.getEmail()) && 
            emailExists(studentDetails.getEmail())) {
            throw new RuntimeException("Email already exists: " + studentDetails.getEmail());
        }
        
        // Check if new mobile is different and already exists
        if (!student.getMobile().equals(studentDetails.getMobile()) && 
            mobileExists(studentDetails.getMobile())) {
            throw new RuntimeException("Mobile number already exists: " + studentDetails.getMobile());
        }
        
        student.setFullName(studentDetails.getFullName());
        student.setEmail(studentDetails.getEmail());
        student.setMobile(studentDetails.getMobile());
        student.setCourses(studentDetails.getCourses());
        student.setStatus(studentDetails.getStatus());
        student.setUpdatedAt(LocalDateTime.now());
        
        // Update student ID if provided and not empty
        if (studentDetails.getStudentId() != null && 
            !studentDetails.getStudentId().isEmpty() &&
            !studentDetails.getStudentId().equals(student.getStudentId())) {
            
            if (studentRepository.existsByStudentId(studentDetails.getStudentId())) {
                throw new RuntimeException("Student ID already exists: " + studentDetails.getStudentId());
            }
            student.setStudentId(studentDetails.getStudentId());
        }
        
        // Update password if provided
        if (studentDetails.getPassword() != null && !studentDetails.getPassword().isEmpty()) {
            student.setPassword(passwordEncoder.encode(studentDetails.getPassword()));
        }
        
        return studentRepository.save(student);
    }

    @Override
    @Transactional
    public void deleteStudent(Long id) {
        try {
            System.out.println("=== DELETING STUDENT ID: " + id + " ===");
            
            Student student = getStudentById(id);
            String studentId = student.getStudentId();
            System.out.println("Student ID: " + studentId + ", Name: " + student.getFullName());
            
            // 1. Delete all test answers for this student
            try {
                // Get all test attempts for this student
                List<StudentTestAttempt> attempts = testAttemptRepository.findByStudentId(studentId);
                System.out.println("Found " + attempts.size() + " test attempts for student");
                
                for (StudentTestAttempt attempt : attempts) {
                    // Delete answers for each attempt
                    testAnswerRepository.deleteByAttemptId(attempt.getAttemptId());
                    System.out.println("  Deleted answers for attempt: " + attempt.getAttemptId());
                }
                
                // 2. Delete all test attempts
                if (!attempts.isEmpty()) {
                    for (StudentTestAttempt attempt : attempts) {
                        testAttemptRepository.delete(attempt);
                    }
                    System.out.println("Deleted " + attempts.size() + " test attempts");
                }
            } catch (Exception e) {
                System.err.println("Error deleting test data: " + e.getMessage());
                e.printStackTrace();
            }
            
            // 3. Delete eligibility records
            try {
                List<StudentFinalEligibility> eligibilities = eligibilityRepository.findAllByStudentId(studentId);
                if (!eligibilities.isEmpty()) {
                    eligibilityRepository.deleteAll(eligibilities);
                    System.out.println("Deleted " + eligibilities.size() + " eligibility records");
                }
            } catch (Exception e) {
                System.err.println("Error deleting eligibility records: " + e.getMessage());
                e.printStackTrace();
            }
            
            // 4. Delete certificates
            try {
                List<StudentCertificate> certificates = certificateRepository.findByStudentId(studentId);
                if (!certificates.isEmpty()) {
                    certificateRepository.deleteAll(certificates);
                    System.out.println("Deleted " + certificates.size() + " certificates");
                }
            } catch (Exception e) {
                System.err.println("Error deleting certificates: " + e.getMessage());
                e.printStackTrace();
            }
            
            // 5. Finally delete the student
            studentRepository.delete(student);
            System.out.println("Student deleted successfully");
            
        } catch (Exception e) {
            System.err.println("Error deleting student: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to delete student: " + e.getMessage());
        }
    }

    @Override
    public List<Student> searchStudents(String searchTerm) {
        return studentRepository.searchStudents(searchTerm);
    }

    @Override
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        
        long totalStudents = studentRepository.count();
        long activeStudents = studentRepository.countByStatus("Active");
        long pendingStudents = studentRepository.countByStatus("Pending");
        long rejectedStudents = studentRepository.countByStatus("Rejected");
        long inactiveStudents = studentRepository.countByStatus("Inactive");
        List<String> courses = studentRepository.findDistinctCourses();
        int uniqueCourses = courses.size();
        
        stats.put("totalStudents", totalStudents);
        stats.put("activeStudents", activeStudents);
        stats.put("pendingStudents", pendingStudents);
        stats.put("rejectedStudents", rejectedStudents);
        stats.put("inactiveStudents", inactiveStudents);
        stats.put("uniqueCourses", uniqueCourses);
        
        return stats;
    }

    @Override
    public boolean emailExists(String email) {
        return studentRepository.existsByEmail(email);
    }

    @Override
    public boolean mobileExists(String mobile) {
        return studentRepository.existsByMobile(mobile);
    }

    @Override
    public List<String> getAllCourses() {
        return studentRepository.findDistinctCourses();
    }
    
    @Override
    public Student loginByEmail(String email, String password) {
        return login(email, password);
    }

    @Override
    public Set<String> getAllStudentIds() {
        List<Student> students = studentRepository.findAll();
        return students.stream()
            .map(Student::getStudentId)
            .collect(Collectors.toSet());
    }
}