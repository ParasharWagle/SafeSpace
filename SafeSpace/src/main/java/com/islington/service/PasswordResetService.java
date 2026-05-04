package com.islington.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.UUID;

import com.islington.config.AESUtil;
import com.islington.config.DBConfig;

/**
 * PasswordResetService — encapsulates the database operations
 * for the forgotten password workflow.
 *
 * Three methods drive the workflow:
 *   1. createResetToken(username)  — generates a token, saves it, returns it
 *   2. findUsernameByToken(token)  — validates a token and returns whose it is
 *   3. updatePassword(username, ...)— writes a new password and clears the token
 *
 * Tokens are random UUIDs and expire after 30 minutes.
 */
public class PasswordResetService {

    /** How long a reset token remains valid, in minutes. */
    private static final int TOKEN_LIFETIME_MINUTES = 30;

    /**
     * Generates a fresh reset token for the given username and saves it
     * to the database with an expiry 30 minutes in the future.
     *
     * @param username the username (or student identifier) entered in
     *                 the forgot password form
     * @return the generated token, or null if the username does not exist
     */
    public String createResetToken(String username) {
        if (username == null || username.trim().isEmpty()) return null;

        // 1) Confirm the user exists
        if (!userExists(username)) return null;

        // 2) Generate a random token and compute the expiry
        String token = UUID.randomUUID().toString().replace("-", "");
        LocalDateTime expires = LocalDateTime.now().plusMinutes(TOKEN_LIFETIME_MINUTES);

        // 3) Persist the token and expiry
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBConfig.getConnection();
            stmt = conn.prepareStatement(
                "UPDATE users SET reset_token = ?, reset_token_expires = ? "
              + "WHERE username = ? OR student_id = ?");
            stmt.setString(1, token);
            stmt.setTimestamp(2, Timestamp.valueOf(expires));
            stmt.setString(3, username.trim());
            stmt.setString(4, username.trim());
            int rows = stmt.executeUpdate();
            if (rows <= 0) return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return token;
    }

    /**
     * Looks up a reset token. Returns the matching username if the token
     * exists AND has not expired. Returns null otherwise.
     */
    public String findUsernameByToken(String token) {
        if (token == null || token.trim().isEmpty()) return null;

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConfig.getConnection();
            stmt = conn.prepareStatement(
                "SELECT username, reset_token_expires FROM users WHERE reset_token = ?");
            stmt.setString(1, token.trim());
            rs = stmt.executeQuery();
            if (!rs.next()) return null;

            // Reject expired tokens
            Timestamp expires = rs.getTimestamp("reset_token_expires");
            if (expires == null) return null;
            if (expires.toLocalDateTime().isBefore(LocalDateTime.now())) return null;

            return rs.getString("username");
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    /**
     * Writes a new (encrypted) password for the user and clears the reset
     * token in the same statement so the link cannot be reused.
     *
     * @param username    the username whose password should change
     * @param newPassword the new plaintext password (will be AES encrypted)
     * @return true on success
     */
    public boolean updatePassword(String username, String newPassword) {
        if (username == null || newPassword == null || newPassword.length() < 6) {
            return false;
        }
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBConfig.getConnection();
            stmt = conn.prepareStatement(
                "UPDATE users SET password_hash = ?, "
              + "reset_token = NULL, reset_token_expires = NULL, "
              + "failed_attempts = 0 "                     // also clears any lockout
              + "WHERE username = ?");
            stmt.setString(1, AESUtil.encrypt(newPassword));
            stmt.setString(2, username.trim());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    /** Returns true if a user exists with the given username or student_id. */
    private boolean userExists(String usernameOrStudentId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConfig.getConnection();
            stmt = conn.prepareStatement(
                "SELECT id FROM users WHERE username = ? OR student_id = ? LIMIT 1");
            stmt.setString(1, usernameOrStudentId.trim());
            stmt.setString(2, usernameOrStudentId.trim());
            rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
