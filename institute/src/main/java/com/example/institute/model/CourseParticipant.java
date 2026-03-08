package com.example.institute.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "course_participants")
public class CourseParticipant {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "participant_id")
    private Long participantId;
    
    @Column(name = "participant_username", nullable = false, unique = true, length = 50)
    private String participantUsername;
    
    @Column(name = "participant_password", nullable = false)
    private String participantPassword;
    
    @Column(name = "participant_fullname", nullable = false, length = 100)
    private String participantFullname;
    
    @Column(name = "participant_email", nullable = false, unique = true, length = 100)
    private String participantEmail;
    
    @Column(name = "enrollment_number", nullable = false, unique = true, length = 20)
    private String enrollmentNumber;
    
    @Column(name = "current_semester", length = 20)
    private String currentSemester;
    
    @Column(name = "registered_subjects", columnDefinition = "TEXT")
    private String registeredSubjects;
    
    @Column(name = "enrollment_date")
    private LocalDateTime enrollmentDate;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "account_status")
    private AccountStatus accountStatus = AccountStatus.ACTIVE; // Fixed: Using AccountStatus enum
    
    // Constructors
    public CourseParticipant() {
        this.enrollmentDate = LocalDateTime.now();
    }
    
    public CourseParticipant(String participantUsername, String participantPassword, 
                            String participantFullname, String participantEmail, String enrollmentNumber) {
        this();
        this.participantUsername = participantUsername;
        this.participantPassword = participantPassword;
        this.participantFullname = participantFullname;
        this.participantEmail = participantEmail;
        this.enrollmentNumber = enrollmentNumber;
    }
    
    // Getters and Setters
    public Long getParticipantId() { return participantId; }
    public void setParticipantId(Long participantId) { this.participantId = participantId; }
    
    public String getParticipantUsername() { return participantUsername; }
    public void setParticipantUsername(String participantUsername) { this.participantUsername = participantUsername; }
    
    public String getParticipantPassword() { return participantPassword; }
    public void setParticipantPassword(String participantPassword) { this.participantPassword = participantPassword; }
    
    public String getParticipantFullname() { return participantFullname; }
    public void setParticipantFullname(String participantFullname) { this.participantFullname = participantFullname; }
    
    public String getParticipantEmail() { return participantEmail; }
    public void setParticipantEmail(String participantEmail) { this.participantEmail = participantEmail; }
    
    public String getEnrollmentNumber() { return enrollmentNumber; }
    public void setEnrollmentNumber(String enrollmentNumber) { this.enrollmentNumber = enrollmentNumber; }
    
    public String getCurrentSemester() { return currentSemester; }
    public void setCurrentSemester(String currentSemester) { this.currentSemester = currentSemester; }
    
    public String getRegisteredSubjects() { return registeredSubjects; }
    public void setRegisteredSubjects(String registeredSubjects) { this.registeredSubjects = registeredSubjects; }
    
    public LocalDateTime getEnrollmentDate() { return enrollmentDate; }
    public void setEnrollmentDate(LocalDateTime enrollmentDate) { this.enrollmentDate = enrollmentDate; }
    
    public AccountStatus getAccountStatus() { return accountStatus; }
    public void setAccountStatus(AccountStatus accountStatus) { this.accountStatus = accountStatus; }
}