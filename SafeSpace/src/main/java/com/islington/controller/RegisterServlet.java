package com.islington.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.islington.config.AESUtil;
import com.islington.config.DBConfig;

/**
 * RegisterServlet — handles new user registration for SafeSpace.
 * Mapped to /register — supports GET (show form) and POST (process registration).
 * Generates a UUID anonymous token and encrypts the password with AES.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    /**
     * doGet — displays the registration page.
     * Simply forwards to the register.jsp view.
     *
     * @param req  the HTTP request object
     * @param resp the HTTP response object
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Forward to the registration view — JSP handles presentation only
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
    }

    /**
     * doPost — processes the registration form submission.
     * Validates all input fields, checks for duplicate Student ID,
     * generates a UUID anonymous token, encrypts the password,
     * and inserts the new user into the database.
     *
     * @param req  the HTTP request object containing form data
     * @param resp the HTTP response object
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Retrieve form inputs
        String fullName  = req.getParameter("fullName");
        String studentId = req.getParameter("studentId");
        String phone     = req.getParameter("phone");
        String username  = req.getParameter("username");
        String password  = req.getParameter("password");

        // Input validation — check that all fields are not empty
        if (fullName == null  || fullName.trim().isEmpty()  ||
            studentId == null || studentId.trim().isEmpty() ||
            phone == null     || phone.trim().isEmpty()     ||
            username == null  || username.trim().isEmpty()   ||
            password == null  || password.trim().isEmpty()) {

            // Set error message and forward back to registration page
            req.setAttribute("errorMessage", "All fields are required. Please fill in every field.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }

        // Trim whitespace from all inputs
        fullName  = fullName.trim();
        studentId = studentId.trim();
        phone     = phone.trim();
        username  = username.trim();
        password  = password.trim();

        // JDBC 6-step pattern to check for duplicates and insert new user
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            // Step 1 & 2: Load driver and get connection via DBConfig
            conn = DBConfig.getConnection();

            // Step 3a: Check if Student ID already exists in the database
            String checkSql = "SELECT id FROM users WHERE student_id = ?";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, studentId); // Bind Student ID parameter

            // Step 4a: Execute the check query
            rs = checkStmt.executeQuery();

            // Step 5a: If a row is found, the Student ID is already registered
            if (rs.next()) {
                req.setAttribute("errorMessage", "This Student ID is already registered. Please log in instead.");
                req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
                return;
            }

            // Generate a unique anonymous token using UUID for anonymity
            String anonymousToken = UUID.randomUUID().toString();

            // Encrypt the password using AES before storing in the database
            String encryptedPassword = AESUtil.encrypt(password);

            // Step 3b: Prepare the INSERT statement with parameterised values
            String insertSql = "INSERT INTO users (username, password_hash, role, full_name, student_id, phone, anonymous_token, failed_attempts) VALUES (?, ?, 'STUDENT', ?, ?, ?, ?, 0)";
            insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setString(1, username);          // Bind username
            insertStmt.setString(2, encryptedPassword); // Bind encrypted password
            insertStmt.setString(3, fullName);           // Bind full name
            insertStmt.setString(4, studentId);          // Bind student ID
            insertStmt.setString(5, phone);              // Bind phone number
            insertStmt.setString(6, anonymousToken);     // Bind anonymous token

            // Step 4b: Execute the insert
            int rowsAffected = insertStmt.executeUpdate();

            // Step 5b: Check if insert succeeded
            if (rowsAffected > 0) {
                // Registration successful — redirect to login with success message
                resp.sendRedirect(req.getContextPath() + "/login?registered=true");
            } else {
                // Insert failed for an unknown reason
                req.setAttribute("errorMessage", "Registration failed. Please try again.");
                req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            // Catch all exceptions — never show raw Java errors to users
            e.printStackTrace();
            req.setAttribute("errorMessage", "An unexpected error occurred. Please try again later.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);

        } finally {
            // Step 6: Close all resources in reverse order to prevent leaks
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (checkStmt != null) checkStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (insertStmt != null) insertStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
