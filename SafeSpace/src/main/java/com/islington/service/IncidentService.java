package com.islington.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.islington.config.DBConfig;
import com.islington.model.IncidentModel;

/**
 * IncidentService — data access layer for incident operations.
 * Every method follows the JDBC 6-step workflow (Week 6).
 * Uses PreparedStatement exclusively to prevent SQL injection.
 */
public class IncidentService {

    /**
     * getAllIncidents — retrieves every incident from the database,
     * ordered by submission date descending (newest first).
     * Used by the admin dashboard to display all reports.
     *
     * @return a List of IncidentModel objects, or an empty list if none found
     */
    public List<IncidentModel> getAllIncidents() {
        // Initialise variables for JDBC 6-step pattern
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<IncidentModel> incidents = new ArrayList<>();

        try {
            // Step 1 & 2: Load driver and get connection via DBConfig
            conn = DBConfig.getConnection();

            // Step 3: Prepare the SQL statement — fetch all incidents newest first
            String sql = "SELECT id, anonymous_token, category, description, severity, status, submitted_at, updated_at FROM incidents ORDER BY submitted_at DESC";
            stmt = conn.prepareStatement(sql);

            // Step 4: Execute the query
            rs = stmt.executeQuery();

            // Step 5: Process the ResultSet — map each row to an IncidentModel
            while (rs.next()) {
                IncidentModel inc = new IncidentModel();
                inc.setId(rs.getInt("id"));
                inc.setAnonymousToken(rs.getString("anonymous_token"));
                inc.setCategory(rs.getString("category"));
                inc.setDescription(rs.getString("description"));
                inc.setSeverity(rs.getString("severity"));
                inc.setStatus(rs.getString("status"));
                inc.setSubmittedAt(rs.getString("submitted_at"));
                inc.setUpdatedAt(rs.getString("updated_at"));
                incidents.add(inc);
            }

        } catch (SQLException e) {
            // Log the error — do not expose raw exception to users
            e.printStackTrace();
        } finally {
            // Step 6: Close all resources in reverse order to prevent leaks
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return incidents;
    }

    /**
     * getIncidentsByToken — retrieves all incidents filed by a specific
     * anonymous token. Used by the student dashboard to show only their reports.
     *
     * @param token the anonymous token from the student's session
     * @return a List of IncidentModel objects belonging to that token
     */
    public List<IncidentModel> getIncidentsByToken(String token) {
        // Initialise variables for JDBC 6-step pattern
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<IncidentModel> incidents = new ArrayList<>();

        try {
            // Step 1 & 2: Load driver and get connection via DBConfig
            conn = DBConfig.getConnection();

            // Step 3: Prepare the SQL statement with parameterised token filter
            String sql = "SELECT id, anonymous_token, category, description, severity, status, submitted_at, updated_at FROM incidents WHERE anonymous_token = ? ORDER BY submitted_at DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, token); // Bind the token parameter safely

            // Step 4: Execute the query
            rs = stmt.executeQuery();

            // Step 5: Process the ResultSet — map each row to an IncidentModel
            while (rs.next()) {
                IncidentModel inc = new IncidentModel();
                inc.setId(rs.getInt("id"));
                inc.setAnonymousToken(rs.getString("anonymous_token"));
                inc.setCategory(rs.getString("category"));
                inc.setDescription(rs.getString("description"));
                inc.setSeverity(rs.getString("severity"));
                inc.setStatus(rs.getString("status"));
                inc.setSubmittedAt(rs.getString("submitted_at"));
                inc.setUpdatedAt(rs.getString("updated_at"));
                incidents.add(inc);
            }

        } catch (SQLException e) {
            // Log the error — do not expose raw exception to users
            e.printStackTrace();
        } finally {
            // Step 6: Close all resources in reverse order to prevent leaks
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return incidents;
    }

    /**
     * createIncident — inserts a new anonymous incident report into the database.
     * Used by SubmitReportServlet when a student files a new report.
     *
     * @param inc the IncidentModel containing the report data to insert
     * @return true if the insert succeeded, false otherwise
     */
    public boolean createIncident(IncidentModel inc) {
        // Initialise variables for JDBC 6-step pattern
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            // Step 1 & 2: Load driver and get connection via DBConfig
            conn = DBConfig.getConnection();

            // Step 3: Prepare the INSERT statement with parameterised values
            String sql = "INSERT INTO incidents (anonymous_token, category, description, severity, status) VALUES (?, ?, ?, ?, 'PENDING')";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, inc.getAnonymousToken()); // Bind anonymous token
            stmt.setString(2, inc.getCategory());        // Bind incident category
            stmt.setString(3, inc.getDescription());     // Bind incident description
            stmt.setString(4, inc.getSeverity());        // Bind severity level

            // Step 4: Execute the update and check rows affected
            int rowsAffected = stmt.executeUpdate();

            // Step 5: Process result — success if at least one row inserted
            success = (rowsAffected > 0);

        } catch (SQLException e) {
            // Log the error — do not expose raw exception to users
            e.printStackTrace();
        } finally {
            // Step 6: Close all resources in reverse order to prevent leaks
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return success;
    }

    /**
     * updateStatus — changes the status of an existing incident by its ID.
     * Used by the admin dashboard when a counselor reviews a report.
     *
     * @param id        the incident ID to update
     * @param newStatus the new status value (e.g. RESOLVED, IN_REVIEW)
     * @return true if the update succeeded, false otherwise
     */
    public boolean updateStatus(int id, String newStatus) {
        // Initialise variables for JDBC 6-step pattern
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            // Step 1 & 2: Load driver and get connection via DBConfig
            conn = DBConfig.getConnection();

            // Step 3: Prepare the UPDATE statement with parameterised values
            String sql = "UPDATE incidents SET status = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, newStatus); // Bind the new status
            stmt.setInt(2, id);           // Bind the incident ID

            // Step 4: Execute the update and check rows affected
            int rowsAffected = stmt.executeUpdate();

            // Step 5: Process result — success if at least one row updated
            success = (rowsAffected > 0);

        } catch (SQLException e) {
            // Log the error — do not expose raw exception to users
            e.printStackTrace();
        } finally {
            // Step 6: Close all resources in reverse order to prevent leaks
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return success;
    }

    /**
     * countByStatus — counts the number of incidents matching a given status.
     * Used by the admin dashboard to display stat cards (e.g. PENDING count).
     *
     * @param status the status to count (e.g. "PENDING", "RESOLVED")
     * @return the count of matching incidents, or 0 on error
     */
    public int countByStatus(String status) {
        // Initialise variables for JDBC 6-step pattern
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;

        try {
            // Step 1 & 2: Load driver and get connection via DBConfig
            conn = DBConfig.getConnection();

            // Step 3: Prepare the COUNT query with parameterised status filter
            String sql = "SELECT COUNT(*) AS total FROM incidents WHERE status = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status); // Bind the status parameter

            // Step 4: Execute the query
            rs = stmt.executeQuery();

            // Step 5: Process the ResultSet — extract the count value
            if (rs.next()) {
                count = rs.getInt("total");
            }

        } catch (SQLException e) {
            // Log the error — do not expose raw exception to users
            e.printStackTrace();
        } finally {
            // Step 6: Close all resources in reverse order to prevent leaks
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return count;
    }

    /**
     * countBySeverity — counts the number of incidents matching a given severity.
     * Used by the admin dashboard to display the Critical Alerts stat card.
     *
     * @param severity the severity to count (e.g. "HIGH", "LOW")
     * @return the count of matching incidents, or 0 on error
     */
    public int countBySeverity(String severity) {
        // Initialise variables for JDBC 6-step pattern
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;

        try {
            // Step 1 & 2: Load driver and get connection via DBConfig
            conn = DBConfig.getConnection();

            // Step 3: Prepare the COUNT query with parameterised severity filter
            String sql = "SELECT COUNT(*) AS total FROM incidents WHERE severity = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, severity); // Bind the severity parameter

            // Step 4: Execute the query
            rs = stmt.executeQuery();

            // Step 5: Process the ResultSet — extract the count value
            if (rs.next()) {
                count = rs.getInt("total");
            }

        } catch (SQLException e) {
            // Log the error — do not expose raw exception to users
            e.printStackTrace();
        } finally {
            // Step 6: Close all resources in reverse order to prevent leaks
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return count;
    }
}
