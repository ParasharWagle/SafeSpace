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
 * IncidentActionServlet — handles status updates and deletions of
 * incident reports from the counselor's admin dashboard.
 *
 * Mapped to /admin/incident/action — protected by AuthFilter since it
 * lives under /admin/*.
 *
 * Two actions are supported, chosen by a hidden "action" form field:
 *   - "update" : reads "status" and calls IncidentService.updateStatus()
 *   - "delete" : calls IncidentService.deleteIncident() (evidence is removed
 *                automatically by the ON DELETE CASCADE foreign key)
 *
 * After either action, the servlet redirects back to /admin/dashboard
 * with a flash message. Using POST + redirect follows the PRG (Post-
 * Redirect-Get) pattern to prevent duplicate actions on refresh.
 */
@WebServlet("/admin/incident/action")
public class IncidentActionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // -------- Step 1: Authorisation — counselors only --------
        HttpSession session = req.getSession(false);
        String role = session != null ? (String) session.getAttribute("role") : null;
        if (!"COUNSELOR".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // -------- Step 2: Parse the incident id --------
        String idParam = req.getParameter("incidentId");
        int incidentId;
        try {
            incidentId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid incident id.");
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        // -------- Step 3: Dispatch on action --------
        String action = req.getParameter("action");
        IncidentService incidentService = new IncidentService();

        if ("update".equals(action)) {
            // Update the status. Accepted values: PENDING, IN_REVIEW, RESOLVED, CRITICAL
            String newStatus = req.getParameter("status");
            if (newStatus == null || newStatus.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Please choose a status.");
            } else if (!isValidStatus(newStatus)) {
                session.setAttribute("errorMessage", "Invalid status value.");
            } else {
                boolean ok = incidentService.updateStatus(incidentId, newStatus);
                if (ok) {
                    session.setAttribute("successMessage",
                        "Report #SF-" + incidentId + " marked as " + displayStatus(newStatus) + ".");
                } else {
                    session.setAttribute("errorMessage",
                        "Could not update report #SF-" + incidentId + ". Please try again.");
                }
            }

        } else if ("delete".equals(action)) {
            boolean ok = incidentService.deleteIncident(incidentId);
            if (ok) {
                session.setAttribute("successMessage",
                    "Report #SF-" + incidentId + " has been permanently deleted.");
            } else {
                session.setAttribute("errorMessage",
                    "Could not delete report #SF-" + incidentId + ". Please try again.");
            }

        } else {
            session.setAttribute("errorMessage", "Unknown action.");
        }

        // -------- Step 4: Redirect back to the dashboard (PRG pattern) --------
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }

    /** Whitelist of accepted status codes to prevent arbitrary writes. */
    private boolean isValidStatus(String status) {
        return "PENDING".equals(status)   ||
               "IN_REVIEW".equals(status) ||
               "RESOLVED".equals(status)  ||
               "CRITICAL".equals(status);
    }

    /** Returns a friendlier label for the flash message. */
    private String displayStatus(String status) {
        switch (status) {
            case "PENDING":   return "Pending";
            case "IN_REVIEW": return "In Review";
            case "RESOLVED":  return "Resolved";
            case "CRITICAL":  return "Critical";
            default:          return status;
        }
    }
}
