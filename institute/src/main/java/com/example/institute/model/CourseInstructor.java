package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "course_instructors")
public class CourseInstructor {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "instructor_id")
    private Long instructorId;
    
    @Column(name = "instructor_username", nullable = false, unique = true, length = 50)
    private String instructorUsername;
    
    @Column(name = "instructor_password", nullable = false)
    private String instructorPassword;
    
    @Column(name = "instructor_fullname", nullable = false, length = 100)
    private String instructorFullname;
    
    @Column(name = "instructor_email", nullable = false, unique = true, length = 100)
    private String instructorEmail;
    
    @Column(name = "academic_department", length = 100)
    private String academicDepartment;
    
    @Column(name = "account_created")
    private LocalDateTime accountCreated;
    
    @Column(name = "last_login")
    private LocalDateTime lastLogin;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "account_status")
    private AccountStatus accountStatus = AccountStatus.ACTIVE;
    
    // REMOVED the problematic relationship with EducationalContent
    
    // Constructors
    public CourseInstructor() {
        this.accountCreated = LocalDateTime.now();
    }
    
    public CourseInstructor(String instructorUsername, String instructorPassword, 
                           String instructorFullname, String instructorEmail) {
        this();
        this.instructorUsername = instructorUsername;
        this.instructorPassword = instructorPassword;
        this.instructorFullname = instructorFullname;
        this.instructorEmail = instructorEmail;
    }
    
    // Getters and Setters
    public Long getInstructorId() { return instructorId; }
    public void setInstructorId(Long instructorId) { this.instructorId = instructorId; }
    
    public String getInstructorUsername() { return instructorUsername; }
    public void setInstructorUsername(String instructorUsername) { this.instructorUsername = instructorUsername; }
    
    public String getInstructorPassword() { return instructorPassword; }
    public void setInstructorPassword(String instructorPassword) { this.instructorPassword = instructorPassword; }
    
    public String getInstructorFullname() { return instructorFullname; }
    public void setInstructorFullname(String instructorFullname) { this.instructorFullname = instructorFullname; }
    
    public String getInstructorEmail() { return instructorEmail; }
    public void setInstructorEmail(String instructorEmail) { this.instructorEmail = instructorEmail; }
    
    public String getAcademicDepartment() { return academicDepartment; }
    public void setAcademicDepartment(String academicDepartment) { this.academicDepartment = academicDepartment; }
    
    public LocalDateTime getAccountCreated() { return accountCreated; }
    public void setAccountCreated(LocalDateTime accountCreated) { this.accountCreated = accountCreated; }
    
    public LocalDateTime getLastLogin() { return lastLogin; }
    public void setLastLogin(LocalDateTime lastLogin) { this.lastLogin = lastLogin; }
    
    public AccountStatus getAccountStatus() { return accountStatus; }
    public void setAccountStatus(AccountStatus accountStatus) { this.accountStatus = accountStatus; }
}