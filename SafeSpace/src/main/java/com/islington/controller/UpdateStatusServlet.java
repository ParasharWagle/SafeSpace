package com.islington.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.islington.service.IncidentService;

/**
 * UpdateStatusServlet — handles POST requests from the admin dashboard
 * to change the status of an incident report.
 * Mapped to /admin/updateStatus — protected by AuthFilter (COUNSELOR only).
 */
@WebServlet("/admin/updateStatus")
public class UpdateStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Safety check — only COUNSELORs can update status
        HttpSession session = req.getSession(false);
        if (session == null || !"COUNSELOR".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Read parameters sent from the dropdown form
        String idParam     = req.getParameter("incidentId");
        String newStatus   = req.getParameter("newStatus");

        // Validate — only allow known status values to prevent injection
        boolean validStatus = "PENDING".equals(newStatus)
                           || "IN_REVIEW".equals(newStatus)
                           || "RESOLVED".equals(newStatus)
                           || "CRITICAL".equals(newStatus);

        if (idParam != null && newStatus != null && validStatus) {
            int id = Integer.parseInt(idParam);
            IncidentService incidentService = new IncidentService();
            incidentService.updateStatus(id, newStatus);
        }

        // Redirect back to dashboard after update
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }
}