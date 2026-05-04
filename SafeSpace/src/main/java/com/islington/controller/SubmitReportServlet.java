package com.islington.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.islington.config.DBConfig;
import com.islington.config.FileUploadUtil;
import com.islington.model.EvidenceModel;
import com.islington.model.IncidentModel;
import com.islington.service.EvidenceService;
import com.islington.service.IncidentService;

@WebServlet("/student/report")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 25L * 1024L * 1024L,
    maxRequestSize    = 100L * 1024L * 1024L
)
public class SubmitReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/student/report.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String category    = req.getParameter("category");
        String description = req.getParameter("description");
        String urgency     = req.getParameter("urgency");

        if (category == null    || category.trim().isEmpty() ||
            description == null || description.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Please select a category and provide a description.");
            req.getRequestDispatcher("/WEB-INF/views/student/report.jsp").forward(req, resp);
            return;
        }
        category    = category.trim();
        description = description.trim();
        if (description.length() > 2000) {
            req.setAttribute("errorMessage", "Description must not exceed 2000 characters.");
            req.getRequestDispatcher("/WEB-INF/views/student/report.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(false);
        String token = (String) session.getAttribute("token");
        String severity = "high".equals(urgency) ? "HIGH" : "LOW";

        IncidentModel incident = new IncidentModel();
        incident.setAnonymousToken(token);
        incident.setCategory(category);
        incident.setDescription(description);
        incident.setSeverity(severity);

        IncidentService incidentService = new IncidentService();
        boolean success = incidentService.createIncident(incident);

        if (!success) {
            req.setAttribute("errorMessage", "Failed to submit your report. Please try again.");
            req.getRequestDispatcher("/WEB-INF/views/student/report.jsp").forward(req, resp);
            return;
        }

        int newIncidentId = lookupLatestIncidentId(token);
        int evidenceCount = 0;
        if (newIncidentId > 0) {
            evidenceCount += saveUploadedFiles(req, newIncidentId);
            evidenceCount += saveEvidenceLinks(req, newIncidentId);
        }

        String msg = "Your anonymous report has been submitted successfully.";
        if (evidenceCount > 0) {
            msg += " " + evidenceCount + " piece"
                 + (evidenceCount == 1 ? "" : "s") + " of evidence attached.";
        }
        session.setAttribute("successMessage", msg);
        resp.sendRedirect(req.getContextPath() + "/student/dashboard");
    }

    private int lookupLatestIncidentId(String token) {
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "SELECT id FROM incidents WHERE anonymous_token = ? ORDER BY id DESC LIMIT 1")) {
            stmt.setString(1, token);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt("id");
            }
        } catch (Exception e) { e.printStackTrace(); }
        return -1;
    }

    private int saveUploadedFiles(HttpServletRequest req, int incidentId) {
        int savedCount = 0;
        try {
            Collection<Part> parts = req.getParts();
            EvidenceService evidenceService = new EvidenceService();
            for (Part part : parts) {
                if (!"evidenceFile".equals(part.getName())) continue;
                String originalFilename = FileUploadUtil.extractFilename(part);
                if (originalFilename == null || originalFilename.trim().isEmpty()) continue;
                if (part.getSize() <= 0) continue;
                if (part.getSize() > FileUploadUtil.MAX_FILE_SIZE) continue;
                String mimeType = part.getContentType();
                if (!FileUploadUtil.isAllowedMimeType(mimeType)) continue;
                String storedFilename = FileUploadUtil.saveUploadedFile(part, originalFilename);
                EvidenceModel ev = new EvidenceModel();
                ev.setIncidentId(incidentId);
                ev.setEvidenceType("FILE");
                ev.setStoredFilename(storedFilename);
                ev.setOriginalFilename(originalFilename);
                ev.setMimeType(mimeType);
                ev.setFileSize(part.getSize());
                ev.setCaption(req.getParameter("evidenceCaption"));
                if (evidenceService.createEvidence(ev)) savedCount++;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return savedCount;
    }

    private int saveEvidenceLinks(HttpServletRequest req, int incidentId) {
        int savedCount = 0;
        String raw = req.getParameter("evidenceLinks");
        if (raw == null || raw.trim().isEmpty()) return 0;
        EvidenceService evidenceService = new EvidenceService();
        for (String line : raw.split("\\r?\\n")) {
            line = line.trim();
            if (line.isEmpty()) continue;
            if (!line.toLowerCase().startsWith("http://") &&
                !line.toLowerCase().startsWith("https://")) continue;
            if (line.length() > 1000) line = line.substring(0, 1000);
            EvidenceModel ev = new EvidenceModel();
            ev.setIncidentId(incidentId);
            ev.setEvidenceType("LINK");
            ev.setLinkUrl(line);
            ev.setCaption(req.getParameter("evidenceCaption"));
            if (evidenceService.createEvidence(ev)) savedCount++;
        }
        return savedCount;
    }
}