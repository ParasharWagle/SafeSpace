package com.islington.model;

/**
 * IncidentModel — JavaBean representing an anonymous incident report.
 * Holds data only (no business logic) as per MVC architecture.
 * Used with jsp:useBean, jsp:setProperty, jsp:getProperty (Week 5).
 */
public class IncidentModel {

    // Unique database identifier for the incident (auto-incremented primary key)
    private int id;

    // Anonymous token linking this report to a user without revealing identity
    private String anonymousToken;

    // Category of the incident (e.g. Harassment or Bullying, Safety Concern)
    private String category;

    // Detailed description of the incident provided by the reporter
    private String description;

    // Severity level of the incident: LOW or HIGH
    private String severity;

    // Current status of the incident: PENDING, IN_REVIEW, RESOLVED, CRITICAL
    private String status;

    // Timestamp when the incident was originally submitted
    private String submittedAt;

    // Timestamp when the incident was last updated
    private String updatedAt;

    // ----- Getters and Setters for every field -----

    /** Returns the unique database ID of this incident */
    public int getId() {
        return id;
    }

    /** Sets the unique database ID of this incident */
    public void setId(int id) {
        this.id = id;
    }

    /** Returns the anonymous token linking this report to a user */
    public String getAnonymousToken() {
        return anonymousToken;
    }

    /** Sets the anonymous token linking this report to a user */
    public void setAnonymousToken(String anonymousToken) {
        this.anonymousToken = anonymousToken;
    }

    /** Returns the category of the incident */
    public String getCategory() {
        return category;
    }

    /** Sets the category of the incident */
    public void setCategory(String category) {
        this.category = category;
    }

    /** Returns the detailed description of the incident */
    public String getDescription() {
        return description;
    }

    /** Sets the detailed description of the incident */
    public void setDescription(String description) {
        this.description = description;
    }

    /** Returns the severity level (LOW or HIGH) */
    public String getSeverity() {
        return severity;
    }

    /** Sets the severity level (LOW or HIGH) */
    public void setSeverity(String severity) {
        this.severity = severity;
    }

    /** Returns the current status of the incident */
    public String getStatus() {
        return status;
    }

    /** Sets the current status of the incident */
    public void setStatus(String status) {
        this.status = status;
    }

    /** Returns the submission timestamp */
    public String getSubmittedAt() {
        return submittedAt;
    }

    /** Sets the submission timestamp */
    public void setSubmittedAt(String submittedAt) {
        this.submittedAt = submittedAt;
    }

    /** Returns the last-updated timestamp */
    public String getUpdatedAt() {
        return updatedAt;
    }

    /** Sets the last-updated timestamp */
    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }
}
