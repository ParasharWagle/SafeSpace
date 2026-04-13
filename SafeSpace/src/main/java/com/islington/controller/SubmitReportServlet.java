package com.islington.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.islington.model.IncidentModel;
import com.islington.service.IncidentService;

/**
 * SubmitReportServlet — handles anonymous incident report submission.
 * Mapped to /student/report — protected by AuthFilter (STUDENT role only).
 * Validates form input and creates a new incident record in the database.
 */
@WebServlet("/student/report")
public class SubmitReportServlet extends HttpServlet {

    /**
     * doGet — displays the incident report submission form.
     * Simply forwards to the report.jsp view.
     *
     * @param req  the HTTP request object
     * @param resp the HTTP response object
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Forward to the report form view — JSP handles presentation
        req.getRequestDispatcher("/WEB-INF/views/student/report.jsp").forward(req, resp);
    }

    /**
     * doPost — processes the submitted incident report.
     * Validates that category and description are not empty,
     * determines severity from urgency radio selection,
     * creates an IncidentModel and saves it via IncidentService.
     *
     * @param req  the HTTP request object containing form data
     * @param resp the HTTP response object
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Retrieve form inputs
        String category    = req.getParameter("category");
        String description = req.getParameter("description");
        String urgency     = req.getParameter("urgency");

        // Input validation — category and description are required
        if (category == null    || category.trim().isEmpty() ||
            description == null || description.trim().isEmpty()) {

            // Set error message and forward back to report form
            req.setAttribute("errorMessage", "Please select a category and provide a description.");
            req.getRequestDispatcher("/WEB-INF/views/student/report.jsp").forward(req, resp);
            return;
        }

        // Trim whitespace from inputs
        category    = category.trim();
        description = description.trim();

        // Validate description length does not exceed 2000 characters
        if (description.length() > 2000) {
            req.setAttribute("errorMessage", "Description must not exceed 2000 characters.");
            req.getRequestDispatcher("/WEB-INF/views/student/report.jsp").forward(req, resp);
            return;
        }

        // Retrieve the anonymous token from the session
        HttpSession session = req.getSession(false);
        String token = (String) session.getAttribute("token");

        // Determine severity level based on urgency radio selection
        String severity = "LOW"; // Default to standard priority
        if ("high".equals(urgency)) {
            severity = "HIGH"; // High priority selected
        }

        // Create an IncidentModel and populate it with form data
        IncidentModel incident = new IncidentModel();
        incident.setAnonymousToken(token);
        incident.setCategory(category);
        incident.setDescription(description);
        incident.setSeverity(severity);

        // Use IncidentService to save the incident to the database
        IncidentService incidentService = new IncidentService();
        boolean success = incidentService.createIncident(incident);

        if (success) {
            // Report submitted successfully — redirect to dashboard with success message
            // Using session attribute since we're doing a redirect (PRG pattern)
            session.setAttribute("successMessage", "Your anonymous report has been submitted successfully.");
            resp.sendRedirect(req.getContextPath() + "/student/dashboard");
        } else {
            // Insert failed — show error on the form
            req.setAttribute("errorMessage", "Failed to submit your report. Please try again.");
            req.getRequestDispatcher("/WEB-INF/views/student/report.jsp").forward(req, resp);
        }
    }
}
