package com.islington.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.islington.config.DBConfig;
import com.islington.model.EvidenceModel;

public class EvidenceService {

    public boolean createEvidence(EvidenceModel ev) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        try {
            conn = DBConfig.getConnection();
            String sql = "INSERT INTO evidence "
                       + "(incident_id, evidence_type, stored_filename, original_filename, "
                       + " mime_type, file_size, link_url, caption) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, ev.getIncidentId());
            stmt.setString(2, ev.getEvidenceType());
            stmt.setString(3, ev.getStoredFilename());
            stmt.setString(4, ev.getOriginalFilename());
            stmt.setString(5, ev.getMimeType());
            stmt.setLong(6, ev.getFileSize());
            stmt.setString(7, ev.getLinkUrl());
            stmt.setString(8, ev.getCaption());
            success = (stmt.executeUpdate() > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return success;
    }

    public List<EvidenceModel> getEvidenceByIncidentId(int incidentId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<EvidenceModel> list = new ArrayList<>();
        try {
            conn = DBConfig.getConnection();
            String sql = "SELECT id, incident_id, evidence_type, stored_filename, "
                       + "original_filename, mime_type, file_size, link_url, caption, uploaded_at "
                       + "FROM evidence WHERE incident_id = ? ORDER BY uploaded_at ASC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, incidentId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                EvidenceModel ev = new EvidenceModel();
                ev.setId(rs.getInt("id"));
                ev.setIncidentId(rs.getInt("incident_id"));
                ev.setEvidenceType(rs.getString("evidence_type"));
                ev.setStoredFilename(rs.getString("stored_filename"));
                ev.setOriginalFilename(rs.getString("original_filename"));
                ev.setMimeType(rs.getString("mime_type"));
                ev.setFileSize(rs.getLong("file_size"));
                ev.setLinkUrl(rs.getString("link_url"));
                ev.setCaption(rs.getString("caption"));
                ev.setUploadedAt(rs.getString("uploaded_at"));
                list.add(ev);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return list;
    }

    public EvidenceModel getEvidenceById(int id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        EvidenceModel ev = null;
        try {
            conn = DBConfig.getConnection();
            String sql = "SELECT id, incident_id, evidence_type, stored_filename, "
                       + "original_filename, mime_type, file_size, link_url, caption, uploaded_at "
                       + "FROM evidence WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                ev = new EvidenceModel();
                ev.setId(rs.getInt("id"));
                ev.setIncidentId(rs.getInt("incident_id"));
                ev.setEvidenceType(rs.getString("evidence_type"));
                ev.setStoredFilename(rs.getString("stored_filename"));
                ev.setOriginalFilename(rs.getString("original_filename"));
                ev.setMimeType(rs.getString("mime_type"));
                ev.setFileSize(rs.getLong("file_size"));
                ev.setLinkUrl(rs.getString("link_url"));
                ev.setCaption(rs.getString("caption"));
                ev.setUploadedAt(rs.getString("uploaded_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return ev;
    }
}