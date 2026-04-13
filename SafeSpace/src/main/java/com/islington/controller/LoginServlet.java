package com.islington.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.islington.config.AESUtil;
import com.islington.config.DBConfig;

/**
 * LoginServlet — handles user authentication for SafeSpace.
 * Mapped to /login — supports both GET (show form) and POST (process login).
 * Implements account lockout after 3 consecutive failed attempts.
 * Passwords are verified by decrypting the stored AES hash and comparing.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    /**
     * doGet — displays the login page.
     * If the user already has an active session, redirects them
     * to the appropriate dashboard based on their role.
     *
     * @param req  the HTTP request object
     * @param resp the HTTP response object
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check if user already has an active session
        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("username") != null) {
            // User is already logged in — redirect by role
            String role = (String) session.getAttribute("role");

            if ("COUNSELOR".equals(role)) {
                // Counselors go to admin dashboard
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                // Students go to student dashboard
                resp.sendRedirect(req.getContextPath() + "/student/dashboard");
            }
            return; // Stop further processing
        }

        // No active session — show the login page
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }

    /**
     * doPost — processes the login form submission.
     * Validates input fields, queries the database for the user,
     * decrypts the stored password and compares it, tracks failed
     * attempts in the session, and locks the account after 3 failures.
     *
     * @param req  the HTTP request object containing form data
     * @param resp the HTTP response object
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Retrieve and trim form inputs to remove accidental whitespace
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Input validation — check that fields are not empty
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            // Set error message and forward back to login page
            req.setAttribute("errorMessage", "Please enter both username and password.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        // Trim whitespace from inputs
        username = username.trim();
        password = password.trim();

        // Get or create session for tracking failed attempts
        HttpSession session = req.getSession(true);

        // Retrieve the current failed attempt count from session (default 0)
        Integer failedAttempts = (Integer) session.getAttribute("failedAttempts");
        if (failedAttempts == null) {
            failedAttempts = 0;
        }

        // Check if the account is already locked (3 or more failed attempts)
        if (failedAttempts >= 3) {
            req.setAttribute("accountLocked", Boolean.TRUE);
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        // JDBC 6-step pattern to query the users table
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Step 1 & 2: Load driver and get connection via DBConfig
            conn = DBConfig.getConnection();

            // Step 3: Prepare the SELECT statement with parameterised username
            String sql = "SELECT id, username, password_hash, role, full_name, student_id, phone, anonymous_token FROM users WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username); // Bind the username parameter safely

            // Step 4: Execute the query
            rs = stmt.executeQuery();

            // Step 5: Process the ResultSet
            if (rs.next()) {
                // User found — retrieve the stored encrypted password
                String storedHash = rs.getString("password_hash");

             // Encrypt the entered password and compare with stored hash
             // This avoids decryption issues across different JVM environments
             String encryptedInput = AESUtil.encrypt(password);
             if (encryptedInput.equals(storedHash)) {
                    // Password matches — login successful

                    // Reset failed attempts counter on successful login
                    session.setAttribute("failedAttempts", 0);

                    // Set all session attributes for the logged-in user
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("username", rs.getString("username"));
                    session.setAttribute("fullName", rs.getString("full_name"));
                    session.setAttribute("role", rs.getString("role"));
                    session.setAttribute("token", rs.getString("anonymous_token"));

                    // Redirect based on user role
                    String role = rs.getString("role");
                    if ("COUNSELOR".equals(role)) {
                        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/student/dashboard");
                    }
                    return; // Stop further processing

                } else {
                    // Password does not match — increment failed attempts
                    failedAttempts++;
                    session.setAttribute("failedAttempts", failedAttempts);

                    // Check if account should now be locked
                    if (failedAttempts >= 3) {
                        req.setAttribute("accountLocked", Boolean.TRUE);
                    } else {
                        req.setAttribute("errorMessage", "Invalid credentials. You have " + (3 - failedAttempts) + " attempt(s) remaining.");
                    }
                }

            } else {
                // No user found with that username
                failedAttempts++;
                session.setAttribute("failedAttempts", failedAttempts);

                if (failedAttempts >= 3) {
                    req.setAttribute("accountLocked", Boolean.TRUE);
                } else {
                    req.setAttribute("errorMessage", "Invalid credentials. You have " + (3 - failedAttempts) + " attempt(s) remaining.");
                }
            }

        } catch (Exception e) {
            // Catch all exceptions — never show raw Java errors to users
            e.printStackTrace();
            req.setAttribute("errorMessage", "An unexpected error occurred. Please try again later.");

        } finally {
            // Step 6: Close all resources in reverse order to prevent leaks
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        // Forward back to login page with error/lockout message
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }
}
