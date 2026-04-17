package com.islington.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.islington.service.IncidentService;

@WebServlet("/admin/deleteIncident")
public class DeleteIncidentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !"COUNSELOR".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idParam = req.getParameter("incidentId");

        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            IncidentService incidentService = new IncidentService();
            incidentService.deleteIncident(id);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }
}
