package com.islington.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.islington.model.IncidentModel;
import com.islington.service.IncidentService;

/**
 * StudentDashboardServlet — handles the student's personal dashboard.
 * Mapped to /student/dashboard — protected by AuthFilter (STUDENT role only).
 * Fetches the student's own incident reports using their anonymous token.
 */
@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {

    /**
     * doGet — loads the student dashboard with their submitted reports.
     * Checks the session role, retrieves incidents by token,
     * and forwards data to the student dashboard JSP.
     *
     * @param req  the HTTP request object
     * @param resp the HTTP response object
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Retrieve the current session (AuthFilter guarantees it exists)
        HttpSession session = req.getSession(false);

        // Double-check role as a safety measure — redirect if not STUDENT
        String role = (String) session.getAttribute("role");
        if (!"STUDENT".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Get the anonymous token from the session to fetch this student's reports
        String token = (String) session.getAttribute("token");

        // Use IncidentService to fetch incidents belonging to this token
        IncidentService incidentService = new IncidentService();
        List<IncidentModel> incidentList = incidentService.getIncidentsByToken(token);

        // Pass the incident list to the JSP via request attribute
        req.setAttribute("incidentList", incidentList);

        // Forward to the student dashboard view — JSP handles presentation
        req.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(req, resp);
    }
}
