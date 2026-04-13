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
 * AdminDashboardServlet — handles the counselor's admin dashboard.
 * Mapped to /admin/dashboard — protected by AuthFilter (COUNSELOR role only).
 * Fetches all incident reports and provides aggregate statistics.
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    /**
     * doGet — loads the admin dashboard with all reports and statistics.
     * Checks the session role, retrieves all incidents and counts,
     * and forwards data to the admin dashboard JSP.
     *
     * @param req  the HTTP request object
     * @param resp the HTTP response object
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Retrieve the current session (AuthFilter guarantees it exists)
        HttpSession session = req.getSession(false);

        // Double-check role as a safety measure — redirect if not COUNSELOR
        String role = (String) session.getAttribute("role");
        if (!"COUNSELOR".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Use IncidentService to fetch all incidents for the reports table
        IncidentService incidentService = new IncidentService();
        List<IncidentModel> allIncidents = incidentService.getAllIncidents();

        // Get aggregate counts for the stat cards
        int pendingCount  = incidentService.countByStatus("PENDING");
        int criticalCount = incidentService.countBySeverity("HIGH");

        // Pass all data to the JSP via request attributes
        req.setAttribute("allIncidents", allIncidents);
        req.setAttribute("pendingCount", pendingCount);
        req.setAttribute("criticalCount", criticalCount);

        // Forward to the admin dashboard view — JSP handles presentation
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
    }
}
