<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.islington.model.IncidentModel" %>

<%-- Include the shared header with navbar and CSS design system --%>
<%@ include file="../header.jsp" %>

<%
    // Retrieve the incident list passed from StudentDashboardServlet
    List<IncidentModel> incidentList = (List<IncidentModel>) request.getAttribute("incidentList");

    // Retrieve full name from session for welcome greeting
    String fullName = (String) session.getAttribute("fullName");
    if (fullName == null) fullName = "Student";

    // Check for success message (from report submission redirect)
    String successMsg = (String) session.getAttribute("successMessage");
    if (successMsg != null) {
        // Clear the session message after reading it (flash message pattern)
        session.removeAttribute("successMessage");
    }
%>

<style>
    /* ============================================================
       STUDENT DASHBOARD
       ============================================================ */
    .dashboard-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 40px 24px 80px;
    }

    /* ---- Welcome Header ---- */
    .dash-welcome {
        margin-bottom: 32px;
    }

    .dash-welcome h1 {
        font-size: 1.8rem;
        color: var(--on-surface);
        margin-bottom: 4px;
    }

    .dash-welcome p {
        font-size: 0.9rem;
        color: var(--on-surface-muted);
    }

    /* ---- Alert ---- */
    .alert {
        padding: 14px 20px;
        border-radius: 12px;
        font-size: 0.875rem;
        font-weight: 500;
        margin-bottom: 24px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .alert-success {
        background: var(--primary-container);
        color: var(--on-primary-container);
    }

    /* ---- Quick Action Cards ---- */
    .quick-actions {
        display: flex;
        gap: 20px;
        margin-bottom: 40px;
        flex-wrap: wrap;
    }

    .action-card {
        flex: 1;
        min-width: 220px;
        background: var(--surface-lowest);
        border-radius: 16px;
        padding: 28px;
        display: flex;
        flex-direction: column;
        gap: 12px;
        transition: transform 0.25s ease, box-shadow 0.25s ease;
        cursor: pointer;
        text-decoration: none;
        color: inherit;
    }

    .action-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 30px rgba(0,0,0,0.06);
    }

    .action-card-icon {
        width: 48px;
        height: 48px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .action-card-icon .material-symbols-outlined {
        font-size: 26px;
    }

    .action-card-icon.primary {
        background: var(--primary-container);
        color: var(--primary);
    }

    .action-card-icon.primary .material-symbols-outlined {
        color: var(--primary);
    }

    .action-card-icon.amber {
        background: #fff3e0;
        color: #e65100;
    }

    .action-card-icon.amber .material-symbols-outlined {
        color: #e65100;
    }

    .action-card-icon.blue {
        background: #e3f2fd;
        color: #1565c0;
    }

    .action-card-icon.blue .material-symbols-outlined {
        color: #1565c0;
    }

    .action-card h3 {
        font-size: 1rem;
        color: var(--on-surface);
    }

    .action-card p {
        font-size: 0.82rem;
        color: var(--on-surface-muted);
        line-height: 1.6;
    }

    /* ---- Reports Section ---- */
    .reports-section {
        margin-bottom: 40px;
    }

    .reports-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .reports-header h2 {
        font-size: 1.3rem;
        color: var(--on-surface);
    }

    .reports-count {
        font-size: 0.85rem;
        color: var(--on-surface-hint);
        font-weight: 500;
    }

    /* ---- Report Cards ---- */
    .report-card {
        background: var(--surface-lowest);
        border-radius: 16px;
        padding: 24px 28px;
        margin-bottom: 14px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .report-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 24px rgba(0,0,0,0.05);
    }

    .report-card-left {
        display: flex;
        flex-direction: column;
        gap: 6px;
    }

    .report-card-title {
        font-family: 'Manrope', sans-serif;
        font-weight: 700;
        font-size: 1rem;
        color: var(--on-surface);
    }

    .report-card-meta {
        display: flex;
        align-items: center;
        gap: 16px;
        font-size: 0.8rem;
        color: var(--on-surface-hint);
    }

    .report-card-meta span {
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .report-card-meta .material-symbols-outlined {
        font-size: 16px;
    }

    .report-card-right {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    /* ---- Status Badges ---- */
    .badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 5px 14px;
        border-radius: 9999px;
        font-size: 0.75rem;
        font-weight: 600;
    }

    .badge-pending {
        background: #fff3e0;
        color: #e65100;
    }

    .badge-resolved {
        background: var(--primary-container);
        color: var(--on-primary-container);
    }

    .badge-in-review {
        background: #e3f2fd;
        color: #1565c0;
    }

    .badge-critical {
        background: #fce4ec;
        color: #c62828;
    }

    /* ---- Empty State ---- */
    .empty-state {
        text-align: center;
        padding: 60px 24px;
        background: var(--surface-lowest);
        border-radius: 16px;
    }

    .empty-state .material-symbols-outlined {
        font-size: 56px;
        color: var(--outline-variant);
        margin-bottom: 16px;
    }

    .empty-state h3 {
        font-size: 1.1rem;
        color: var(--on-surface);
        margin-bottom: 8px;
    }

    .empty-state p {
        font-size: 0.85rem;
        color: var(--on-surface-muted);
    }

    /* ---- Emergency Banner ---- */
    .emergency-banner {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        border-radius: 16px;
        padding: 28px 32px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 24px;
        margin-top: 12px;
    }

    .emergency-banner-content h3 {
        color: var(--on-primary);
        font-size: 1.1rem;
        margin-bottom: 6px;
    }

    .emergency-banner-content p {
        color: rgba(231,251,255,0.7);
        font-size: 0.85rem;
    }

    .btn-emergency {
        padding: 12px 28px;
        border-radius: 9999px;
        background: var(--on-primary);
        color: var(--primary);
        font-family: 'Public Sans', sans-serif;
        font-weight: 600;
        font-size: 0.875rem;
        border: none;
        cursor: pointer;
        white-space: nowrap;
        transition: transform 0.15s ease, box-shadow 0.2s ease;
        text-decoration: none;
    }

    .btn-emergency:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 16px rgba(0,0,0,0.15);
    }

    /* ---- Responsive ---- */
    @media (max-width: 768px) {
        .quick-actions {
            flex-direction: column;
        }

        .report-card {
            flex-direction: column;
            align-items: flex-start;
            gap: 12px;
        }

        .emergency-banner {
            flex-direction: column;
            text-align: center;
        }
    }
</style>

<div class="dashboard-container">

    <!-- Welcome heading -->
    <div class="dash-welcome">
        <h1>Welcome back, <%= fullName %></h1>
        <p>Here is an overview of your submitted reports and available actions.</p>
    </div>

    <%-- Success message from report submission --%>
    <% if (successMsg != null) { %>
        <div class="alert alert-success">
            <span class="material-symbols-outlined">check_circle</span>
            <%= successMsg %>
        </div>
    <% } %>

    <!-- Quick Action Cards -->
    <div class="quick-actions">

        <!-- File a New Report -->
        <a href="${pageContext.request.contextPath}/student/report" class="action-card">
            <div class="action-card-icon primary">
                <span class="material-symbols-outlined">edit_note</span>
            </div>
            <h3>File a New Report</h3>
            <p>Submit an anonymous incident report to our counseling team.</p>
        </a>

        <!-- ✅ CHANGED: was a <div>, now an <a> linking to /contact -->
        <a href="${pageContext.request.contextPath}/contact" class="action-card">
            <div class="action-card-icon amber">
                <span class="material-symbols-outlined">psychology</span>
            </div>
            <h3>Counseling Support</h3>
            <p>Connect with a trained counselor for confidential guidance.</p>
        </a>

        <!-- ✅ CHANGED: was a <div>, now an <a> linking to /resources -->
        <a href="${pageContext.request.contextPath}/resources" class="action-card">
            <div class="action-card-icon blue">
                <span class="material-symbols-outlined">menu_book</span>
            </div>
            <h3>Resource Library</h3>
            <p>Access guides, articles, and support materials curated for students.</p>
        </a>

    </div>

    <!-- Recent Reports Section -->
    <div class="reports-section">
        <div class="reports-header">
            <h2>Recent Reports</h2>
            <% if (incidentList != null) { %>
                <span class="reports-count"><%= incidentList.size() %> report(s) found</span>
            <% } %>
        </div>

        <% if (incidentList != null && !incidentList.isEmpty()) { %>
            <%-- Loop through each incident and display as a card --%>
            <% for (IncidentModel inc : incidentList) { %>
                <div class="report-card">
                    <div class="report-card-left">
                        <div class="report-card-title"><%= inc.getCategory() %></div>
                        <div class="report-card-meta">
                            <span>
                                <span class="material-symbols-outlined">tag</span>
                                #SF-<%= inc.getId() %>
                            </span>
                            <span>
                                <span class="material-symbols-outlined">calendar_today</span>
                                <%= inc.getSubmittedAt() %>
                            </span>
                        </div>
                    </div>
                    <div class="report-card-right">
                        <%
                            String status = inc.getStatus();
                            String badgeClass = "badge-pending";
                            String displayStatus = "Pending";

                            if ("RESOLVED".equals(status)) {
                                badgeClass = "badge-resolved";
                                displayStatus = "Resolved";
                            } else if ("IN_REVIEW".equals(status)) {
                                badgeClass = "badge-in-review";
                                displayStatus = "In Review";
                            } else if ("CRITICAL".equals(status)) {
                                badgeClass = "badge-critical";
                                displayStatus = "Critical";
                            }
                        %>
                        <span class="badge <%= badgeClass %>"><%= displayStatus %></span>
                    </div>
                </div>
            <% } %>
        <% } else { %>
            <!-- Empty state when no reports exist -->
            <div class="empty-state">
                <span class="material-symbols-outlined">description</span>
                <h3>No reports yet</h3>
                <p>When you submit an incident report, it will appear here for tracking.</p>
            </div>
        <% } %>
    </div>

    <!-- Emergency Assistance Banner -->
    <div class="emergency-banner">
        <div class="emergency-banner-content">
            <h3>Need Immediate Assistance?</h3>
            <p>If you are in immediate danger, please contact campus security or call emergency services.</p>
        </div>
        <a href="${pageContext.request.contextPath}/contact" class="btn-emergency">Get Help Now</a>
    </div>

</div>

<%-- Include the shared footer with emergency exit button --%>
<%@ include file="../footer.jsp" %>