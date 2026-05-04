package com.islington.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.islington.config.FileUploadUtil;
import com.islington.model.EvidenceModel;
import com.islington.service.EvidenceService;

@WebServlet("/evidence/download")
public class EvidenceDownloadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idParam = req.getParameter("id");
        int id;
        try { id = Integer.parseInt(idParam); }
        catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid evidence id.");
            return;
        }

        EvidenceService evidenceService = new EvidenceService();
        EvidenceModel ev = evidenceService.getEvidenceById(id);
        if (ev == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Evidence not found.");
            return;
        }
        if (!ev.isFile()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "This evidence is a link, not a file.");
            return;
        }

        String role  = (String) session.getAttribute("role");
        String token = (String) session.getAttribute("token");

        if ("STUDENT".equals(role)) {
            if (!isOwnedByToken(ev.getIncidentId(), token)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "You can't access this evidence.");
                return;
            }
        } else if (!"COUNSELOR".equals(role)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied.");
            return;
        }

        File file = FileUploadUtil.getStoredFile(ev.getStoredFilename());
        if (file == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Evidence file missing on server.");
            return;
        }

        resp.setContentType(ev.getMimeType() != null ? ev.getMimeType() : "application/octet-stream");
        resp.setContentLengthLong(file.length());
        resp.setHeader("Content-Disposition",
            "inline; filename=\"" + sanitise(ev.getOriginalFilename()) + "\"");

        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = resp.getOutputStream()) {
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            out.flush();
        }
    }

    private boolean isOwnedByToken(int incidentId, String token) {
        if (token == null) return false;
        try (java.sql.Connection conn = com.islington.config.DBConfig.getConnection();
             java.sql.PreparedStatement stmt = conn.prepareStatement(
                 "SELECT 1 FROM incidents WHERE id = ? AND anonymous_token = ? LIMIT 1")) {
            stmt.setInt(1, incidentId);
            stmt.setString(2, token);
            try (java.sql.ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private String sanitise(String name) {
        if (name == null) return "evidence";
        return name.replaceAll("[\"\\r\\n]", "_");
    }
}