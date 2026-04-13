package com.islington.model;

/**
 * UserModel — JavaBean representing a user in the SafeSpace system.
 * Holds data only (no business logic) as per MVC architecture.
 * Used with jsp:useBean, jsp:setProperty, jsp:getProperty (Week 5).
 */
public class UserModel {

    // Unique database identifier for the user (auto-incremented primary key)
    private int id;

    // Login username — must be unique across all users
    private String username;

    // AES-encrypted password hash stored in the database
    private String passwordHash;

    // Role determines access level: STUDENT or COUNSELOR
    private String role;

    // Full display name of the user (e.g. "Alex Johnson")
    private String fullName;

    // Official student ID issued by the registrar (unique identifier)
    private String studentId;

    // Contact phone number for the user
    private String phone;

    // Anonymous token used to link incident reports without revealing identity
    private String anonymousToken;

    // Tracks consecutive failed login attempts for account lockout
    private int failedAttempts;

    // ----- Getters and Setters for every field -----

    /** Returns the unique database ID of this user */
    public int getId() {
        return id;
    }

    /** Sets the unique database ID of this user */
    public void setId(int id) {
        this.id = id;
    }

    /** Returns the login username */
    public String getUsername() {
        return username;
    }

    /** Sets the login username */
    public void setUsername(String username) {
        this.username = username;
    }

    /** Returns the AES-encrypted password hash */
    public String getPasswordHash() {
        return passwordHash;
    }

    /** Sets the AES-encrypted password hash */
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    /** Returns the user role (STUDENT or COUNSELOR) */
    public String getRole() {
        return role;
    }

    /** Sets the user role (STUDENT or COUNSELOR) */
    public void setRole(String role) {
        this.role = role;
    }

    /** Returns the full display name of the user */
    public String getFullName() {
        return fullName;
    }

    /** Sets the full display name of the user */
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    /** Returns the official student ID */
    public String getStudentId() {
        return studentId;
    }

    /** Sets the official student ID */
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    /** Returns the contact phone number */
    public String getPhone() {
        return phone;
    }

    /** Sets the contact phone number */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /** Returns the anonymous token used for incident linking */
    public String getAnonymousToken() {
        return anonymousToken;
    }

    /** Sets the anonymous token used for incident linking */
    public void setAnonymousToken(String anonymousToken) {
        this.anonymousToken = anonymousToken;
    }

    /** Returns the count of consecutive failed login attempts */
    public int getFailedAttempts() {
        return failedAttempts;
    }

    /** Sets the count of consecutive failed login attempts */
    public void setFailedAttempts(int failedAttempts) {
        this.failedAttempts = failedAttempts;
    }
}
