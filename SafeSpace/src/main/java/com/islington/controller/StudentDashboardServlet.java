package com.islington.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.islington.model.EvidenceModel;
import com.islington.model.IncidentModel;
import com.islington.service.EvidenceService;
import com.islington.service.IncidentService;

@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        String role = (String) session.getAttribute("role");
        if (!"STUDENT".equals(role)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String token = (String) session.getAttribute("token");

        IncidentService incidentService = new IncidentService();
        List<IncidentModel> incidentList = incidentService.getIncidentsByToken(token);

        EvidenceService evidenceService = new EvidenceService();
        Map<Integer, List<EvidenceModel>> evidenceMap = new HashMap<>();
        for (IncidentModel inc : incidentList) {
            evidenceMap.put(inc.getId(), evidenceService.getEvidenceByIncidentId(inc.getId()));
        }

        int totalReports    = incidentList.size();
        int pendingReports  = 0, inReviewReports = 0, resolvedReports = 0;
        for (IncidentModel inc : incidentList) {
            String status = inc.getStatus();
            if      ("PENDING".equals(status))   pendingReports++;
            else if ("IN_REVIEW".equals(status)) inReviewReports++;
            else if ("RESOLVED".equals(status))  resolvedReports++;
        }

        req.setAttribute("incidentList",    incidentList);
        req.setAttribute("evidenceMap",     evidenceMap);
        req.setAttribute("totalReports",    totalReports);
        req.setAttribute("pendingReports",  pendingReports);
        req.setAttribute("inReviewReports", inReviewReports);
        req.setAttribute("resolvedReports", resolvedReports);

        req.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(req, resp);
    }
}