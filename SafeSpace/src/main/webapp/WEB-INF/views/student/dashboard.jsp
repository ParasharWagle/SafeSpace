<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.islington.model.IncidentModel" %>
<%@ page import="com.islington.model.EvidenceModel" %>

<% request.setAttribute("navMode",   "solid"); %>
<% request.setAttribute("activeNav", "dashboard"); %>
<%@ include file="../header.jsp" %>

<%
    // ---- Read data set by StudentDashboardServlet ----
    List<IncidentModel> incidentList = (List<IncidentModel>) request.getAttribute("incidentList");
    Map<Integer, List<EvidenceModel>> evidenceMap =
        (Map<Integer, List<EvidenceModel>>) request.getAttribute("evidenceMap");
    Integer total    = (Integer) request.getAttribute("totalReports");
    Integer pending  = (Integer) request.getAttribute("pendingReports");
    Integer review   = (Integer) request.getAttribute("inReviewReports");
    Integer resolved = (Integer) request.getAttribute("resolvedReports");

    if (total == null)    total = 0;
    if (pending == null)  pending = 0;
    if (review == null)   review = 0;
    if (resolved == null) resolved = 0;

    String fullName = (String) session.getAttribute("fullName");
    if (fullName == null) fullName = "Student";

    // Flash message from PRG pattern after submitting a report
    String successMsg = (String) session.getAttribute("successMessage");
    if (successMsg != null) session.removeAttribute("successMessage");

    // Resolution rate % (0 if no reports yet)
    int rate = total > 0 ? (int) Math.round((resolved * 100.0) / total) : 0;
%>

<style>
    .student-dash {
        max-width: 1200px;
        margin: 0 auto;
        padding: 48px 24px 80px;
    }

    /* ---- Page header ---- */
    .sd-header { margin-bottom: 40px; text-align: center; }
    .sd-eyebrow {
        font-size: 0.78rem; font-weight: 700;
        color: var(--primary);
        text-transform: uppercase;
        letter-spacing: 1.5px;
        margin-bottom: 12px;
    }
    .sd-header h1 {
        font-family: 'Manrope', sans-serif;
        font-size: clamp(1.8rem, 3.4vw, 2.6rem);
        font-weight: 800;
        color: var(--on-surface);
        margin-bottom: 10px;
    }
    .sd-header p {
        font-size: 1rem;
        color: var(--on-surface-muted);
        max-width: 620px;
        margin: 0 auto;
    }

    /* ---- Success alert ---- */
    .alert-success {
        background: var(--primary-container);
        color: var(--on-primary-container);
        padding: 14px 20px;
        border-radius: 12px;
        font-size: 0.9rem; font-weight: 500;
        margin-bottom: 24px;
        display: flex; align-items: center; gap: 10px;
    }

    /* ---- Quick action row ---- */
    .sd-actions {
        display: flex; justify-content: center; gap: 14px;
        flex-wrap: wrap;
        margin-bottom: 32px;
    }
    .sd-action-primary {
        display: inline-flex; align-items: center; gap: 8px;
        padding: 13px 28px;
        border-radius: 12px;
        background: var(--primary);
        color: #fff;
        font-weight: 600; font-size: 0.92rem;
        box-shadow: 0 4px 14px rgba(16,185,129,0.3);
        transition: all 0.2s ease;
    }
    .sd-action-primary:hover {
        background: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 8px 22px rgba(16,185,129,0.4);
    }
    .sd-action-outline {
        display: inline-flex; align-items: center; gap: 8px;
        padding: 13px 28px;
        border-radius: 12px;
        background: var(--surface-lowest);
        color: var(--on-surface);
        border: 1.5px solid var(--outline-variant);
        font-weight: 600; font-size: 0.92rem;
        transition: all 0.2s ease;
    }
    .sd-action-outline:hover { border-color: var(--primary); color: var(--primary); }

    /* ---- Stat cards (4-up grid, coloured left edges) ---- */
    .sd-stat-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 18px;
        margin-bottom: 36px;
    }
    .sd-stat-card {
        position: relative;
        background: var(--surface-lowest);
        border-radius: 14px;
        padding: 22px 22px 22px 30px;
        overflow: hidden;
        border: 1px solid var(--surface-high);
    }
    .sd-stat-card::before {
        content: '';
        position: absolute;
        left: 0; top: 0; bottom: 0;
        width: 4px;
    }
    .sd-stat-card.green::before { background: var(--accent-green-fg); }
    .sd-stat-card.amber::before { background: var(--accent-amber-fg); }
    .sd-stat-card.blue::before  { background: var(--accent-blue-fg); }
    .sd-stat-card.teal::before  { background: var(--accent-teal-fg); }

    .sd-stat-header {
        display: flex; justify-content: space-between; align-items: center;
        margin-bottom: 14px;
    }
    .sd-stat-icon {
        width: 40px; height: 40px;
        border-radius: 10px;
        display: flex; align-items: center; justify-content: center;
    }
    .sd-stat-icon .material-symbols-outlined { font-size: 22px; }
    .sd-stat-card.green .sd-stat-icon { background: var(--accent-green-bg); color: var(--accent-green-fg); }
    .sd-stat-card.amber .sd-stat-icon { background: var(--accent-amber-bg); color: var(--accent-amber-fg); }
    .sd-stat-card.blue  .sd-stat-icon { background: var(--accent-blue-bg);  color: var(--accent-blue-fg); }
    .sd-stat-card.teal  .sd-stat-icon { background: var(--accent-teal-bg);  color: var(--accent-teal-fg); }
    .sd-stat-value {
        font-family: 'Manrope', sans-serif;
        font-weight: 800; font-size: 2rem;
        color: var(--on-surface);
        line-height: 1;
        margin-bottom: 4px;
    }
    .sd-stat-label {
        font-size: 0.88rem;
        color: var(--on-surface-muted);
    }

    /* ---- Reports table ---- */
    .sd-table-card {
        background: var(--surface-lowest);
        border-radius: 16px;
        border: 1px solid var(--surface-high);
        overflow: hidden;
    }
    .sd-table-head {
        padding: 20px 28px;
        display: flex; justify-content: space-between; align-items: center;
        border-bottom: 1px solid var(--surface-high);
    }
    .sd-table-head h3 { font-size: 1rem; font-weight: 700; }
    .sd-table-head span { font-size: 0.78rem; color: var(--on-surface-hint); }

    .sd-table { width: 100%; border-collapse: collapse; }
    .sd-table th {
        text-align: left;
        padding: 14px 28px;
        font-size: 0.7rem; font-weight: 700;
        color: var(--on-surface-hint);
        text-transform: uppercase; letter-spacing: 0.5px;
        background: var(--surface-highest);
        border-bottom: 1px solid var(--surface-high);
    }
    .sd-table td {
        padding: 18px 28px;
        font-size: 0.88rem;
        color: var(--on-surface);
        border-bottom: 1px solid var(--surface-high);
        vertical-align: middle;
    }
    .sd-table tr:last-child td { border-bottom: none; }
    .sd-table tr:hover td { background: var(--surface-highest); }
    .sd-table .report-id { font-weight: 700; }

    /* Evidence chips inside the table */
    .evidence-chips {
        display: flex; flex-wrap: wrap; gap: 6px;
    }
    .ev-chip {
        display: inline-flex; align-items: center; gap: 4px;
        padding: 4px 10px;
        border-radius: 9999px;
        font-size: 0.72rem;
        font-weight: 600;
        background: var(--surface-high);
        color: var(--on-surface-muted);
        text-decoration: none;
        transition: all 0.2s ease;
        border: none;
        cursor: pointer;
        font-family: inherit;
    }
    .ev-chip:hover { background: var(--primary-container); color: var(--on-primary-container); }
    .ev-chip .material-symbols-outlined { font-size: 14px; }
    .ev-chip.link-chip { background: var(--accent-blue-bg); color: #1e40af; }
    .ev-chip.link-chip:hover { background: var(--accent-blue-fg); color: #fff; }
    .ev-chip.file-chip { background: var(--accent-teal-bg); color: #115e59; }
    .ev-chip.file-chip:hover { background: var(--accent-teal-fg); color: #fff; }

    /* Severity dot */
    .sev-dot {
        display: inline-flex; align-items: center; gap: 8px;
        text-transform: capitalize;
    }
    .sev-dot::before {
        content: '';
        display: inline-block;
        width: 8px; height: 8px;
        border-radius: 50%;
    }
    .sev-dot.high::before { background: var(--accent-red-fg); }
    .sev-dot.low::before  { background: var(--accent-green-fg); }

    /* Empty state */
    .sd-empty {
        text-align: center;
        padding: 80px 24px;
    }
    .sd-empty .material-symbols-outlined {
        font-size: 64px;
        color: var(--outline-variant);
        margin-bottom: 16px;
    }
    .sd-empty h3 {
        font-size: 1.15rem; color: var(--on-surface);
        margin-bottom: 8px;
    }
    .sd-empty p {
        font-size: 0.9rem;
        color: var(--on-surface-muted);
        margin-bottom: 24px;
    }

    /* ---- Emergency banner ---- */
    .sd-emergency {
        margin-top: 32px;
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-darker) 100%);
        border-radius: 20px;
        padding: 28px 36px;
        display: flex; justify-content: space-between; align-items: center;
        gap: 24px;
        color: #fff;
        box-shadow: 0 8px 24px rgba(16,185,129,0.25);
    }
    .sd-emergency h3 { font-size: 1.1rem; margin-bottom: 4px; }
    .sd-emergency p { font-size: 0.88rem; opacity: 0.9; }
    .sd-emergency a {
        padding: 12px 26px;
        border-radius: 10px;
        background: #fff;
        color: var(--primary-dark);
        font-weight: 700; font-size: 0.88rem;
        white-space: nowrap;
        transition: transform 0.15s ease;
    }
    .sd-emergency a:hover { transform: translateY(-2px); }

    @media (max-width: 1024px) {
        .sd-stat-grid { grid-template-columns: repeat(2, 1fr); }
    }
    @media (max-width: 640px) {
        .sd-stat-grid { grid-template-columns: 1fr; }
        .sd-table th, .sd-table td { padding: 12px 16px; }
        .sd-emergency { flex-direction: column; text-align: center; }
    }
</style>

<div class="student-dash">

    <!-- Page header -->
    <div class="sd-header">
        <div class="sd-eyebrow">My Dashboard</div>
        <h1>Welcome back, <%= fullName %></h1>
        <p>Track your submitted reports, attach evidence securely, and connect with support whenever you need it.</p>
    </div>

    <% if (successMsg != null) { %>
        <div class="alert-success">
            <span class="material-symbols-outlined">check_circle</span>
            <%= successMsg %>
        </div>
    <% } %>

    <!-- Quick actions -->
    <div class="sd-actions">
        <a href="${pageContext.request.contextPath}/student/report" class="sd-action-primary">
            <span class="material-symbols-outlined">add_circle</span>
            File a New Report
        </a>
        <a href="${pageContext.request.contextPath}/contact" class="sd-action-outline">
            <span class="material-symbols-outlined">psychology</span>
            Counseling Support
        </a>
    </div>

    <!-- 4-up stat cards (real data from servlet) -->
    <div class="sd-stat-grid">
        <div class="sd-stat-card blue">
            <div class="sd-stat-header">
                <div class="sd-stat-icon"><span class="material-symbols-outlined">description</span></div>
            </div>
            <div class="sd-stat-value"><%= total %></div>
            <div class="sd-stat-label">Total Reports</div>
        </div>
        <div class="sd-stat-card amber">
            <div class="sd-stat-header">
                <div class="sd-stat-icon"><span class="material-symbols-outlined">pending</span></div>
            </div>
            <div class="sd-stat-value"><%= pending %></div>
            <div class="sd-stat-label">Pending</div>
        </div>
        <div class="sd-stat-card teal">
            <div class="sd-stat-header">
                <div class="sd-stat-icon"><span class="material-symbols-outlined">progress_activity</span></div>
            </div>
            <div class="sd-stat-value"><%= review %></div>
            <div class="sd-stat-label">In Review</div>
        </div>
        <div class="sd-stat-card green">
            <div class="sd-stat-header">
                <div class="sd-stat-icon"><span class="material-symbols-outlined">check_circle</span></div>
                <span class="change-pill up"><%= rate %>%</span>
            </div>
            <div class="sd-stat-value"><%= resolved %></div>
            <div class="sd-stat-label">Resolved</div>
        </div>
    </div>

    <!-- Reports table -->
    <div class="sd-table-card">
        <div class="sd-table-head">
            <h3>Your Recent Reports</h3>
            <span><%= total %> total <%= total == 1 ? "report" : "reports" %></span>
        </div>

        <% if (incidentList != null && !incidentList.isEmpty()) { %>
            <table class="sd-table">
                <thead>
                    <tr>
                        <th>Report ID</th>
                        <th>Category</th>
                        <th>Submitted</th>
                        <th>Evidence</th>
                        <th>Severity</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (IncidentModel inc : incidentList) {
                        // Status → badge class & display text
                        String status = inc.getStatus();
                        String badgeClass = "badge-pending";
                        String displayStatus = "Pending";
                        if      ("RESOLVED".equals(status))  { badgeClass = "badge-resolved";  displayStatus = "Resolved"; }
                        else if ("IN_REVIEW".equals(status)) { badgeClass = "badge-in-review"; displayStatus = "In Review"; }
                        else if ("CRITICAL".equals(status))  { badgeClass = "badge-critical";  displayStatus = "Critical"; }

                        // Severity → dot class
                        String sev = inc.getSeverity();
                        String sevClass = "low";
                        if ("HIGH".equals(sev)) sevClass = "high";

                        // Evidence list for this incident
                        List<EvidenceModel> evList = evidenceMap != null ? evidenceMap.get(inc.getId()) : null;
                    %>
                        <tr>
                            <td class="report-id">#SF-<%= inc.getId() %></td>
                            <td><%= inc.getCategory() %></td>
                            <td><%= inc.getSubmittedAt() != null ? inc.getSubmittedAt() : "—" %></td>
                            <td>
                                <% if (evList != null && !evList.isEmpty()) { %>
                                    <div class="evidence-chips">
                                        <% for (EvidenceModel ev : evList) {
                                            if (ev.isFile()) {
                                                String fnRaw = ev.getOriginalFilename() != null ? ev.getOriginalFilename() : "file";
                                                String fnAttr = fnRaw.replace("\\", "\\\\").replace("'", "\\'").replace("\"", "&quot;");
                                                String mimeAttr = ev.getMimeType() != null ? ev.getMimeType().replace("'", "") : "";
                                                String dlUrl = request.getContextPath() + "/evidence/download?id=" + ev.getId();
                                                String shortName = fnRaw.length() > 18 ? fnRaw.substring(0, 15) + "..." : fnRaw;
                                        %>
                                                <button type="button" class="ev-chip file-chip"
                                                        title="<%= fnAttr %>"
                                                        onclick="openPreview('<%= dlUrl %>','<%= fnAttr %>','<%= mimeAttr %>')">
                                                    <span class="material-symbols-outlined">attach_file</span>
                                                    <%= shortName %>
                                                </button>
                                            <% } else if (ev.isLink()) { %>
                                                <a href="<%= ev.getLinkUrl() %>" target="_blank" rel="noopener noreferrer"
                                                   class="ev-chip link-chip" title="<%= ev.getLinkUrl() %>">
                                                    <span class="material-symbols-outlined">link</span>
                                                    External
                                                </a>
                                        <%  }
                                        } %>
                                    </div>
                                <% } else { %>
                                    <span style="color: var(--on-surface-hint); font-size: 0.8rem;">None</span>
                                <% } %>
                            </td>
                            <td><span class="sev-dot <%= sevClass %>"><%= sev != null ? sev.toLowerCase() : "low" %></span></td>
                            <td><span class="badge <%= badgeClass %>"><%= displayStatus %></span></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="sd-empty">
                <span class="material-symbols-outlined">description</span>
                <h3>No reports yet</h3>
                <p>When you submit an incident report, it will appear here for tracking.</p>
                <a href="${pageContext.request.contextPath}/student/report" class="sd-action-primary"
                   style="display: inline-flex;">
                    <span class="material-symbols-outlined">add_circle</span>
                    File Your First Report
                </a>
            </div>
        <% } %>
    </div>

    <!-- Emergency banner -->
    <div class="sd-emergency">
        <div>
            <h3>Need Immediate Assistance?</h3>
            <p>If you're in danger, contact campus security or call emergency services right away.</p>
        </div>
        <a href="${pageContext.request.contextPath}/contact">Get Help Now</a>
    </div>
</div>

<!-- ============================================================
     EVIDENCE PREVIEW LIGHTBOX
     Shown when a student clicks a file chip on their dashboard.
     Renders images / videos / audio / PDFs inline; falls back to a
     download card for unsupported types.
     ============================================================ -->
<style>
    .preview-backdrop {
        display: none;
        position: fixed; inset: 0;
        background: rgba(0, 0, 0, 0.85);
        z-index: 6000;
        align-items: center; justify-content: center;
        padding: 24px;
    }
    .preview-backdrop.active {
        display: flex;
        animation: previewFadeIn 0.18s ease;
    }
    @keyframes previewFadeIn { from { opacity: 0; } to { opacity: 1; } }
    .preview-stage {
        position: relative;
        max-width: 92vw; max-height: 90vh;
        display: flex; flex-direction: column;
        align-items: center; gap: 14px;
    }
    .preview-content {
        display: flex; align-items: center; justify-content: center;
        background: #000;
        border-radius: 14px;
        overflow: hidden;
        box-shadow: 0 24px 80px rgba(0,0,0,0.5);
        min-width: 200px; min-height: 200px;
    }
    .preview-content img,
    .preview-content video {
        max-width: 92vw; max-height: 76vh;
        display: block;
    }
    .preview-content iframe {
        width: 92vw; height: 80vh;
        max-width: 1000px;
        border: none; background: #fff;
    }
    .preview-content audio { width: min(92vw, 480px); margin: 24px; }
    .preview-fallback {
        background: var(--surface-lowest);
        border-radius: 14px;
        padding: 36px 32px;
        text-align: center;
        max-width: 420px;
    }
    .preview-fallback .material-symbols-outlined {
        font-size: 48px; color: var(--primary); margin-bottom: 12px;
    }
    .preview-fallback h3 { font-size: 1.05rem; margin-bottom: 6px; color: var(--on-surface); }
    .preview-fallback p {
        font-size: 0.88rem; color: var(--on-surface-muted);
        margin-bottom: 18px; word-break: break-all;
    }
    .preview-fallback a {
        display: inline-flex; align-items: center; gap: 8px;
        padding: 10px 22px;
        border-radius: 10px;
        background: var(--primary);
        color: #fff; font-weight: 600; font-size: 0.9rem;
        text-decoration: none;
        transition: background 0.15s ease;
    }
    .preview-fallback a:hover { background: var(--primary-dark); }
    .preview-toolbar {
        display: flex; align-items: center; gap: 10px;
        background: rgba(0,0,0,0.5);
        backdrop-filter: blur(10px);
        padding: 10px 16px;
        border-radius: 9999px;
        color: #fff; font-size: 0.85rem;
    }
    .preview-toolbar .preview-filename {
        max-width: 360px;
        overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
    }
    .preview-toolbar a, .preview-toolbar button {
        background: transparent; border: none; color: #fff;
        cursor: pointer;
        display: inline-flex; align-items: center; gap: 4px;
        padding: 4px 10px;
        border-radius: 8px;
        font-size: 0.82rem; font-weight: 500;
        transition: background 0.15s ease;
        text-decoration: none;
        font-family: inherit;
    }
    .preview-toolbar a:hover, .preview-toolbar button:hover {
        background: rgba(255,255,255,0.15);
    }
    .preview-toolbar .material-symbols-outlined { font-size: 18px; }
    .preview-close-x {
        position: absolute;
        top: -6px; right: -6px;
        width: 38px; height: 38px;
        border-radius: 50%;
        background: rgba(255,255,255,0.15);
        backdrop-filter: blur(10px);
        border: none; color: #fff; cursor: pointer;
        display: flex; align-items: center; justify-content: center;
        transition: background 0.15s ease;
    }
    .preview-close-x:hover { background: rgba(255,255,255,0.3); }
</style>

<div class="preview-backdrop" id="previewModal"
     onclick="if(event.target===this) closePreview();">
    <div class="preview-stage">
        <button class="preview-close-x" type="button"
                onclick="closePreview()" aria-label="Close preview">
            <span class="material-symbols-outlined">close</span>
        </button>
        <div class="preview-content" id="previewContent"></div>
        <div class="preview-toolbar">
            <span class="material-symbols-outlined">visibility</span>
            <span class="preview-filename" id="previewFilename">file</span>
            <a id="previewDownloadLink" href="#" download>
                <span class="material-symbols-outlined">download</span>
                Download
            </a>
            <button type="button" onclick="closePreview()">
                <span class="material-symbols-outlined">close</span>
                Close
            </button>
        </div>
    </div>
</div>

<script>
    function openPreview(url, filename, mimeType) {
        var content = document.getElementById('previewContent');
        var dl = document.getElementById('previewDownloadLink');
        document.getElementById('previewFilename').textContent = filename || 'file';
        dl.href = url;
        if (filename) dl.setAttribute('download', filename);

        mimeType = (mimeType || '').toLowerCase();
        var html;

        if (mimeType.indexOf('image/') === 0) {
            html = '<img alt="' + escapeAttr(filename) + '" src="' + url + '">';
        } else if (mimeType.indexOf('video/') === 0) {
            html = '<video controls autoplay>'
                 + '<source src="' + url + '" type="' + mimeType + '">'
                 + 'Your browser cannot play this video.'
                 + '</video>';
        } else if (mimeType.indexOf('audio/') === 0) {
            html = '<audio controls autoplay>'
                 + '<source src="' + url + '" type="' + mimeType + '">'
                 + 'Your browser cannot play this audio.'
                 + '</audio>';
        } else if (mimeType === 'application/pdf') {
            html = '<iframe src="' + url + '" title="PDF preview"></iframe>';
        } else {
            html = '<div class="preview-fallback">'
                 +   '<span class="material-symbols-outlined">description</span>'
                 +   '<h3>This file type can\u2019t be previewed in the browser.</h3>'
                 +   '<p>' + escapeText(filename) + '</p>'
                 +   '<a href="' + url + '" download="' + escapeAttr(filename) + '">'
                 +     '<span class="material-symbols-outlined">download</span>'
                 +     'Download to view'
                 +   '</a>'
                 + '</div>';
        }
        content.innerHTML = html;
        document.getElementById('previewModal').classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closePreview() {
        document.getElementById('previewModal').classList.remove('active');
        // Wipe embedded media so audio/video stops playing
        document.getElementById('previewContent').innerHTML = '';
        document.body.style.overflow = '';
    }

    function escapeAttr(s) {
        if (!s) return '';
        return String(s).replace(/&/g,'&amp;').replace(/"/g,'&quot;')
            .replace(/'/g,'&#39;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
    }
    function escapeText(s) {
        if (!s) return '';
        return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
    }

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' &&
            document.getElementById('previewModal').classList.contains('active')) {
            closePreview();
        }
    });
</script>

<%@ include file="../footer.jsp" %>
