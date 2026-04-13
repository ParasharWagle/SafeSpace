<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.islington.model.IncidentModel" %>

<%-- Include the shared header with navbar and CSS design system --%>
<%@ include file="../header.jsp" %>

<%
    // Retrieve the data passed from AdminDashboardServlet
    List<IncidentModel> allIncidents = (List<IncidentModel>) request.getAttribute("allIncidents");
    Integer pendingCount  = (Integer) request.getAttribute("pendingCount");
    Integer criticalCount = (Integer) request.getAttribute("criticalCount");

    // Default to 0 if null (safety check)
    if (pendingCount == null) pendingCount = 0;
    if (criticalCount == null) criticalCount = 0;
%>

<style>
    /* ============================================================
       ADMIN DASHBOARD
       ============================================================ */
    .admin-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 40px 24px 80px;
    }

    /* ---- Page Header ---- */
    .admin-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 32px;
        flex-wrap: wrap;
        gap: 16px;
    }

    .admin-header-left h1 {
        font-size: 1.8rem;
        color: var(--on-surface);
        margin-bottom: 4px;
    }

    .admin-header-left p {
        font-size: 0.9rem;
        color: var(--on-surface-muted);
    }

    .admin-header-actions {
        display: flex;
        gap: 12px;
    }

    .btn-export {
        padding: 10px 22px;
        border-radius: 9999px;
        background: transparent;
        color: var(--on-surface-muted);
        font-family: 'Public Sans', sans-serif;
        font-weight: 600;
        font-size: 0.85rem;
        border: 1.5px solid var(--outline-variant);
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: border-color 0.2s ease, background 0.2s ease;
    }

    .btn-export:hover {
        border-color: var(--on-surface-hint);
        background: var(--surface-low);
    }

    .btn-export .material-symbols-outlined {
        font-size: 18px;
    }

    .btn-new-report {
        padding: 10px 22px;
        border-radius: 9999px;
        background: var(--primary);
        color: var(--on-primary);
        font-family: 'Public Sans', sans-serif;
        font-weight: 600;
        font-size: 0.85rem;
        border: none;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: background 0.2s ease, transform 0.15s ease;
        text-decoration: none;
    }

    .btn-new-report:hover {
        background: var(--primary-dark);
        transform: translateY(-1px);
    }

    .btn-new-report .material-symbols-outlined {
        font-size: 18px;
    }

    /* ---- Stat Cards ---- */
    .stat-cards {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
        margin-bottom: 36px;
    }

    .stat-card {
        background: var(--surface-lowest);
        border-radius: 16px;
        padding: 24px;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .stat-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 24px rgba(0,0,0,0.05);
    }

    .stat-card-label {
        font-size: 0.8rem;
        font-weight: 500;
        color: var(--on-surface-hint);
        margin-bottom: 8px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .stat-card-label .material-symbols-outlined {
        font-size: 18px;
    }

    .stat-card-value {
        font-family: 'Manrope', sans-serif;
        font-weight: 800;
        font-size: 2rem;
        color: var(--on-surface);
    }

    .stat-card-value.highlight-amber {
        color: #e65100;
    }

    .stat-card-value.highlight-red {
        color: #c62828;
    }

    .stat-card-value.highlight-teal {
        color: var(--primary);
    }

    /* ---- Search Box ---- */
    .search-section {
        margin-bottom: 20px;
    }

    .search-box {
        position: relative;
        max-width: 360px;
    }

    .search-box .material-symbols-outlined {
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 20px;
        color: var(--on-surface-hint);
        pointer-events: none;
    }

    .search-input {
        width: 100%;
        padding: 12px 16px 12px 44px;
        border-radius: 10px;
        border: 1.5px solid var(--outline-variant);
        background: var(--surface-lowest);
        font-family: 'Public Sans', sans-serif;
        font-size: 0.9rem;
        color: var(--on-surface);
        outline: none;
        transition: border-color 0.2s ease, box-shadow 0.2s ease;
    }

    .search-input:focus {
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(52,102,109,0.12);
    }

    .search-input::placeholder {
        color: var(--on-surface-hint);
    }

    /* ---- Reports Table ---- */
    .reports-table-container {
        background: var(--surface-lowest);
        border-radius: 16px;
        overflow: hidden;
    }

    .reports-table {
        width: 100%;
        border-collapse: collapse;
    }

    .reports-table thead {
        background: var(--surface-low);
    }

    .reports-table th {
        text-align: left;
        padding: 14px 20px;
        font-family: 'Public Sans', sans-serif;
        font-weight: 600;
        font-size: 0.8rem;
        color: var(--on-surface-hint);
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .reports-table td {
        padding: 16px 20px;
        font-size: 0.9rem;
        color: var(--on-surface);
        vertical-align: top;
    }

    .reports-table tbody tr {
        transition: background 0.15s ease;
    }

    .reports-table tbody tr:hover {
        background: var(--surface-low);
    }

    .reports-table tbody tr:not(:last-child) td {
        border-bottom: 1px solid var(--surface-high);
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

    /* ---- View Details Button ---- */
    .btn-view-details {
        padding: 7px 16px;
        border-radius: 8px;
        background: var(--surface-low);
        color: var(--primary);
        font-family: 'Public Sans', sans-serif;
        font-weight: 600;
        font-size: 0.8rem;
        border: none;
        cursor: pointer;
        transition: background 0.2s ease;
    }

    .btn-view-details:hover {
        background: var(--primary-container);
    }
    /* ---- Status Dropdown ---- */
    .status-form {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .status-select {
        padding: 6px 10px;
        border-radius: 8px;
        border: 1.5px solid var(--outline-variant);
        background: var(--surface-lowest);
        font-family: 'Public Sans', sans-serif;
        font-size: 0.8rem;
        color: var(--on-surface);
        cursor: pointer;
        outline: none;
        transition: border-color 0.2s ease;
    }

    .status-select:focus {
        border-color: var(--primary);
    }

    .btn-update-status {
        padding: 6px 14px;
        border-radius: 8px;
        background: var(--primary);
        color: var(--on-primary);
        font-family: 'Public Sans', sans-serif;
        font-weight: 600;
        font-size: 0.8rem;
        border: none;
        cursor: pointer;
        transition: background 0.2s ease, transform 0.15s ease;
    }

    .btn-update-status:hover {
        background: var(--primary-dark);
        transform: translateY(-1px);
    }

    /* ---- Expandable Description ---- */
    .detail-row {
        display: none;
    }

    .detail-row.visible {
        display: table-row;
    }

    .detail-content {
        background: var(--surface-low);
        padding: 20px 24px;
        border-radius: 12px;
        font-size: 0.85rem;
        color: var(--on-surface-muted);
        line-height: 1.7;
    }

    /* ---- Empty State ---- */
    .empty-state {
        text-align: center;
        padding: 60px 24px;
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

    /* ---- Responsive ---- */
    @media (max-width: 1024px) {
        .stat-cards {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 768px) {
        .stat-cards {
            grid-template-columns: 1fr;
        }

        .admin-header {
            flex-direction: column;
        }

        .reports-table-container {
            overflow-x: auto;
        }

        .reports-table {
            min-width: 700px;
        }
    }
</style>

<div class="admin-container">

    <!-- Page Header -->
    <div class="admin-header">
        <div class="admin-header-left">
            <h1>Counselor Dashboard</h1>
            <p>Overview of active student reports and system statistics</p>
        </div>
        <div class="admin-header-actions">
            <button class="btn-export">
                <span class="material-symbols-outlined">download</span>
                Export PDF
            </button>
            <a href="#" class="btn-new-report">
                <span class="material-symbols-outlined">add</span>
                New Report
            </a>
        </div>
    </div>

    <!-- Stat Cards -->
    <div class="stat-cards">
        <div class="stat-card">
            <div class="stat-card-label">
                <span class="material-symbols-outlined">pending_actions</span>
                Pending Reports
            </div>
            <div class="stat-card-value highlight-amber"><%= pendingCount %></div>
        </div>
        <div class="stat-card">
            <div class="stat-card-label">
                <span class="material-symbols-outlined">warning</span>
                Critical Alerts
            </div>
            <div class="stat-card-value highlight-red"><%= criticalCount %></div>
        </div>
        <div class="stat-card">
            <div class="stat-card-label">
                <span class="material-symbols-outlined">schedule</span>
                Avg. Resolution Time
            </div>
            <div class="stat-card-value highlight-teal">4.2h</div>
        </div>
        <div class="stat-card">
            <div class="stat-card-label">
                <span class="material-symbols-outlined">share</span>
                Resources Shared
            </div>
            <div class="stat-card-value">142</div>
        </div>
    </div>

    <!-- Client-side search -->
    <div class="search-section">
        <div class="search-box">
            <span class="material-symbols-outlined">search</span>
            <input type="text"
                   class="search-input"
                   id="searchInput"
                   placeholder="Search reports by type, ID, or status..."
                   oninput="filterTable()">
        </div>
    </div>

    <!-- Reports Table -->
    <div class="reports-table-container">
        <% if (allIncidents != null && !allIncidents.isEmpty()) { %>
            <table class="reports-table" id="reportsTable">
                <thead>
                    <tr>
                        <th>Case ID</th>
                        <th>Report Type</th>
                        <th>Submission Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (IncidentModel inc : allIncidents) { %>
                        <%
                            // Determine the CSS class for the status badge
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
                        <tr class="report-row">
                            <td><strong>#SF-<%= inc.getId() %></strong></td>
                            <td><%= inc.getCategory() %></td>
                            <td><%= inc.getSubmittedAt() %></td>
                            <td><span class="badge <%= badgeClass %>"><%= displayStatus %></span></td>
                            <td>
                            <div style="display:flex; flex-direction:column; gap:8px; align-items:flex-start;">

                                <!-- View Details toggle (unchanged) -->
                                <button class="btn-view-details" onclick="toggleDetail(<%= inc.getId() %>)">
                                    View Details
                                </button>

                                <!-- Status change dropdown form -->
                                <form class="status-form"
                                      action="${pageContext.request.contextPath}/admin/updateStatus"
                                      method="post">
                                    <input type="hidden" name="incidentId" value="<%= inc.getId() %>">
                                    <select class="status-select" name="newStatus">
                                        <option value="PENDING"   <%= "PENDING".equals(inc.getStatus())   ? "selected" : "" %>>Pending</option>
                                        <option value="IN_REVIEW" <%= "IN_REVIEW".equals(inc.getStatus()) ? "selected" : "" %>>In Review</option>
                                        <option value="RESOLVED"  <%= "RESOLVED".equals(inc.getStatus())  ? "selected" : "" %>>Resolved</option>
                                        <option value="CRITICAL"  <%= "CRITICAL".equals(inc.getStatus())  ? "selected" : "" %>>Critical</option>
                                    </select>
                                    <button type="submit" class="btn-update-status">Update</button>
                                </form>

                            </div>
                        </td>
                        </tr>
                        <!-- Hidden expandable detail row -->
                        <tr class="detail-row" id="detail-<%= inc.getId() %>">
                            <td colspan="5">
                                <div class="detail-content">
                                    <strong>Description:</strong><br>
                                    <%= inc.getDescription() %>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="empty-state">
                <span class="material-symbols-outlined">inbox</span>
                <h3>No reports found</h3>
                <p>When students submit incident reports, they will appear here for review.</p>
            </div>
        <% } %>
    </div>

</div>

<!-- Client-side JavaScript for search and toggle -->
<script>
    /**
     * filterTable — filters the reports table rows based on the search input.
     * Checks each visible row's text content against the search query.
     */
    function filterTable() {
        var input = document.getElementById('searchInput');
        var filter = input.value.toLowerCase();
        var table = document.getElementById('reportsTable');

        if (!table) return; // No table if no incidents

        var rows = table.querySelectorAll('tbody tr.report-row');

        for (var i = 0; i < rows.length; i++) {
            var text = rows[i].textContent.toLowerCase();
            var detailRow = rows[i].nextElementSibling;

            if (text.indexOf(filter) > -1) {
                rows[i].style.display = '';
                // Keep the detail row hidden unless explicitly expanded
            } else {
                rows[i].style.display = 'none';
                // Also hide corresponding detail row
                if (detailRow && detailRow.classList.contains('detail-row')) {
                    detailRow.classList.remove('visible');
                }
            }
        }
    }

    /**
     * toggleDetail — shows or hides the description detail row
     * for a specific incident when the View Details button is clicked.
     *
     * @param id the incident ID used to find the detail row
     */
    function toggleDetail(id) {
        var detailRow = document.getElementById('detail-' + id);
        if (detailRow) {
            detailRow.classList.toggle('visible');
        }
    }
</script>

<%-- Include the shared footer with emergency exit button --%>
<%@ include file="../footer.jsp" %>
