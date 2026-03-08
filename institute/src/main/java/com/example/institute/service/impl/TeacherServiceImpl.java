package com.example.institute.service.impl;

import com.example.institute.model.Specialization;
import com.example.institute.model.Teacher;
import com.example.institute.model.EducationalContent;
import com.example.institute.model.MCQQuestion;
import com.example.institute.repository.SpecializationRepository;
import com.example.institute.repository.TeacherRepository;
import com.example.institute.repository.EducationalContentRepository;
import com.example.institute.repository.MCQQuestionRepository;
import com.example.institute.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TeacherServiceImpl implements TeacherService {
    
    @Autowired
    private TeacherRepository teacherRepository;
    
    @Autowired
    private SpecializationRepository specializationRepository;
    
    @Autowired
    private EducationalContentRepository educationalContentRepository;
    
    @Autowired
    private MCQQuestionRepository mcqQuestionRepository;
    
    @Value("${content.upload.dir:content-uploads}")
    private String contentUploadDir;
    
    private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    
    @Override
    @Transactional
    public Teacher registerTeacher(Teacher teacher) {
        if (teacherRepository.existsByEmail(teacher.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        
        String teacherId = generateTeacherId();
        teacher.setTeacherId(teacherId);
        teacher.setPassword(passwordEncoder.encode(teacher.getPassword()));
        teacher.setStatus(Teacher.TeacherStatus.PENDING);
        
        if (teacher.getSpecializations() != null && !teacher.getSpecializations().isEmpty()) {
            List<Specialization> loadedSpecializations = new ArrayList<>();
            for (Specialization spec : teacher.getSpecializations()) {
                if (spec.getId() != null) {
                    Optional<Specialization> specialization = specializationRepository.findById(spec.getId());
                    specialization.ifPresent(loadedSpecializations::add);
                }
            }
            teacher.setSpecializations(loadedSpecializations);
        }
        
        Teacher savedTeacher = teacherRepository.save(teacher);
        teacherRepository.flush();
        
        System.out.println("=== TEACHER REGISTERED ===");
        System.out.println("Teacher ID: " + savedTeacher.getTeacherId());
        
        return savedTeacher;
    }
    
    @Override
    public Teacher login(String userId, String password) {
        Teacher teacher;
        
        if (userId.contains("@")) {
            teacher = teacherRepository.findByEmail(userId)
                    .orElseThrow(() -> new RuntimeException("Email not found"));
        } else {
            teacher = teacherRepository.findByTeacherId(userId)
                    .orElseThrow(() -> new RuntimeException("Teacher ID not found"));
        }
        
        if (!passwordEncoder.matches(password, teacher.getPassword())) {
            throw new RuntimeException("Invalid password");
        }
        
        switch (teacher.getStatus()) {
            case PENDING:
                throw new RuntimeException("Your account is pending approval. Please wait for admin approval.");
            case REJECTED:
                throw new RuntimeException("Your account has been rejected by admin. Please contact support.");
            case INACTIVE:
                throw new RuntimeException("Your account is inactive. Please contact admin.");
            case ACTIVE:
                System.out.println("=== LOGIN SUCCESS ===");
                break;
            default:
                throw new RuntimeException("Account status unknown. Please contact support.");
        }
        
        return teacher;
    }
    
    @Override
    public List<Teacher> getAllTeachers() {
        return teacherRepository.findAll();
    }
    
    @Override
    public Teacher getTeacherById(Long id) {
        return teacherRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Teacher not found with ID: " + id));
    }
    
    @Override
    public Teacher getTeacherByTeacherId(String teacherId) {
        return teacherRepository.findByTeacherId(teacherId)
                .orElseThrow(() -> new RuntimeException("Teacher not found with ID: " + teacherId));
    }
    
    @Override
    @Transactional
    public Teacher updateTeacher(Long id, Teacher teacherDetails) {
        Teacher teacher = getTeacherById(id);
        
        teacher.setFullName(teacherDetails.getFullName());
        teacher.setEmail(teacherDetails.getEmail());
        
        if (teacherDetails.getSpecializations() != null && !teacherDetails.getSpecializations().isEmpty()) {
            List<Specialization> loadedSpecializations = new ArrayList<>();
            for (Specialization spec : teacherDetails.getSpecializations()) {
                if (spec.getId() != null) {
                    Optional<Specialization> specialization = specializationRepository.findById(spec.getId());
                    specialization.ifPresent(loadedSpecializations::add);
                }
            }
            teacher.setSpecializations(loadedSpecializations);
        }
        
        teacher.setStatus(teacherDetails.getStatus());
        
        if (teacherDetails.getPassword() != null && !teacherDetails.getPassword().isEmpty()) {
            teacher.setPassword(passwordEncoder.encode(teacherDetails.getPassword()));
        }
        
        Teacher savedTeacher = teacherRepository.save(teacher);
        teacherRepository.flush();
        
        return savedTeacher;
    }
    
    @Override
    @Transactional
    public Teacher approveTeacher(Long id) {
        Teacher teacher = getTeacherById(id);
        teacher.setStatus(Teacher.TeacherStatus.ACTIVE);
        teacher.setUpdatedAt(LocalDateTime.now());
        
        Teacher savedTeacher = teacherRepository.save(teacher);
        teacherRepository.flush();
        
        return savedTeacher;
    }
    
    @Override
    @Transactional
    public Teacher rejectTeacher(Long id) {
        Teacher teacher = getTeacherById(id);
        teacher.setStatus(Teacher.TeacherStatus.REJECTED);
        teacher.setUpdatedAt(LocalDateTime.now());
        
        Teacher savedTeacher = teacherRepository.save(teacher);
        teacherRepository.flush();
        
        return savedTeacher;
    }
    
    @Override
    @Transactional
    public void deleteTeacher(Long id) {
        try {
            System.out.println("=== DELETING TEACHER ID: " + id + " ===");
            
            Teacher teacher = getTeacherById(id);
            System.out.println("Teacher Name: " + teacher.getFullName());
            
            // FIXED: Use findByTeacherId instead of findByEducator_InstructorId
            List<EducationalContent> contents = educationalContentRepository.findByTeacherId(teacher.getId());
            System.out.println("Found " + contents.size() + " content items uploaded by this teacher");
            
            for (EducationalContent content : contents) {
                System.out.println("  Processing content ID: " + content.getContentId() + " - " + content.getContentTitle());
                
                try {
                    List<MCQQuestion> mcqQuestions = mcqQuestionRepository.findByContentId(content.getContentId());
                    if (!mcqQuestions.isEmpty()) {
                        mcqQuestionRepository.deleteByContentId(content.getContentId());
                        System.out.println("    - Deleted " + mcqQuestions.size() + " MCQ questions");
                    }
                } catch (Exception e) {
                    System.err.println("    - Error deleting MCQ questions: " + e.getMessage());
                }
                
                if (content.getFileLocation() != null && !content.getFileLocation().isEmpty()) {
                    try {
                        Path filePath = Paths.get(contentUploadDir).resolve(content.getFileLocation());
                        boolean deleted = Files.deleteIfExists(filePath);
                        if (deleted) {
                            System.out.println("    - Deleted physical file: " + content.getFileLocation());
                        }
                    } catch (Exception e) {
                        System.err.println("    - Error deleting file: " + e.getMessage());
                    }
                }
            }
            
            if (!contents.isEmpty()) {
                educationalContentRepository.deleteAll(contents);
                educationalContentRepository.flush();
                System.out.println("Deleted " + contents.size() + " educational content items");
            }
            
            try {
                List<MCQQuestion> teacherQuestions = mcqQuestionRepository.findByCreatedBy(teacher.getId());
                if (!teacherQuestions.isEmpty()) {
                    mcqQuestionRepository.deleteByCreatedBy(teacher.getId());
                    System.out.println("Deleted " + teacherQuestions.size() + " additional MCQ questions");
                }
            } catch (Exception e) {
                System.err.println("Error deleting teacher's MCQ questions: " + e.getMessage());
            }
            
            if (teacher.getSpecializations() != null && !teacher.getSpecializations().isEmpty()) {
                teacher.setSpecializations(new ArrayList<>());
                teacherRepository.save(teacher);
                teacherRepository.flush();
                System.out.println("Cleared teacher specializations");
            }
            
            teacherRepository.delete(teacher);
            teacherRepository.flush();
            System.out.println("Teacher deleted from database");
            
            try {
                reorderTeacherIds();
                System.out.println("Teacher IDs reordered successfully");
            } catch (Exception e) {
                System.err.println("Error reordering teacher IDs: " + e.getMessage());
            }
            
            System.out.println("=== TEACHER DELETION COMPLETE ===");
            
        } catch (Exception e) {
            System.err.println("ERROR deleting teacher: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to delete teacher: " + e.getMessage(), e);
        }
    }
    
    @Override
    public List<Teacher> searchTeachers(String keyword) {
        return teacherRepository.searchTeachers(keyword);
    }
    
    @Override
    public String generateTeacherId() {
        Integer maxIdNumber = teacherRepository.findMaxTeacherIdNumber();
        if (maxIdNumber == null) {
            maxIdNumber = 0;
        }
        int newIdNumber = maxIdNumber + 1;
        return String.format("T%03d", newIdNumber);
    }
    
    @Override
    @Transactional
    public void reorderTeacherIds() {
        try {
            List<Teacher> allTeachers = teacherRepository.findAll();
            allTeachers.sort((t1, t2) -> t1.getId().compareTo(t2.getId()));
            
            for (int i = 0; i < allTeachers.size(); i++) {
                Teacher teacher = allTeachers.get(i);
                String newTeacherId = String.format("T%03d", i + 1);
                
                if (!teacher.getTeacherId().equals(newTeacherId)) {
                    teacher.setTeacherId(newTeacherId);
                    teacherRepository.save(teacher);
                }
            }
            teacherRepository.flush();
            System.out.println("Teacher IDs reordered successfully");
        } catch (Exception e) {
            System.err.println("Error reordering teacher IDs: " + e.getMessage());
        }
    }
    
    @Override
    public long countTotalTeachers() {
        return teacherRepository.count();
    }
    
    @Override
    public long countByStatus(Teacher.TeacherStatus status) {
        return teacherRepository.countByStatus(status);
    }
    
    @Transactional
    public Teacher forceUpdateStatus(Long teacherId, Teacher.TeacherStatus newStatus) {
        Teacher teacher = getTeacherById(teacherId);
        System.out.println("Force updating teacher " + teacher.getTeacherId() + 
                         " from " + teacher.getStatus() + " to " + newStatus);
        
        teacher.setStatus(newStatus);
        teacher.setUpdatedAt(LocalDateTime.now());
        
        Teacher savedTeacher = teacherRepository.save(teacher);
        teacherRepository.flush();
        
        return savedTeacher;
    }
    
    public List<String> getTeacherSpecializationNames(Long teacherId) {
        Teacher teacher = getTeacherById(teacherId);
        return teacher.getSpecializations().stream()
                .map(Specialization::getName)
                .toList();
    }
}