<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.islington.model.IncidentModel" %>
<%@ page import="com.islington.model.EvidenceModel" %>

<%!
    // ---- JSP page-level helpers ----------------------------------
    // Escape a string so it's safe to embed inside a JSON string literal.
    // Used when building the per-incident evidence array attached to each
    // table row.
    private String jsonEscape(String s) {
        if (s == null) return "";
        StringBuilder sb = new StringBuilder(s.length() + 8);
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '\\': sb.append("\\\\"); break;
                case '"':  sb.append("\\\""); break;
                case '\b': sb.append("\\b");  break;
                case '\f': sb.append("\\f");  break;
                case '\n': sb.append("\\n");  break;
                case '\r': sb.append("\\r");  break;
                case '\t': sb.append("\\t");  break;
                case '/':  sb.append("\\/");  break; // protect </script>
                default:
                    if (c < 0x20) sb.append(String.format("\\u%04x", (int) c));
                    else          sb.append(c);
            }
        }
        return sb.toString();
    }
%>

<% request.setAttribute("navMode",   "solid"); %>
<% request.setAttribute("activeNav", "dashboard"); %>
<%@ include file="../header.jsp" %>

<%
    List<IncidentModel> allIncidents = (List<IncidentModel>) request.getAttribute("allIncidents");
    Map<Integer, List<EvidenceModel>> evidenceMap =
        (Map<Integer, List<EvidenceModel>>) request.getAttribute("evidenceMap");
    Map<String, Integer> categoryBreakdown =
        (Map<String, Integer>) request.getAttribute("categoryBreakdown");

    Integer totalCount    = (Integer) request.getAttribute("totalCount");
    Integer pendingCount  = (Integer) request.getAttribute("pendingCount");
    Integer inReviewCount = (Integer) request.getAttribute("inReviewCount");
    Integer resolvedCount = (Integer) request.getAttribute("resolvedCount");
    Integer criticalCount = (Integer) request.getAttribute("criticalCount");
    Integer activeCount   = (Integer) request.getAttribute("activeCount");
    if (totalCount    == null) totalCount = 0;
    if (pendingCount  == null) pendingCount = 0;
    if (inReviewCount == null) inReviewCount = 0;
    if (resolvedCount == null) resolvedCount = 0;
    if (criticalCount == null) criticalCount = 0;
    if (activeCount   == null) activeCount = 0;

    int rate = totalCount > 0 ? (int) Math.round((resolvedCount * 100.0) / totalCount) : 0;
%>

<style>
    .admin-dash {
        max-width: 1200px;
        margin: 0 auto;
        padding: 48px 24px 80px;
    }
    .ad-header { margin-bottom: 36px; text-align: center; }
    .ad-eyebrow {
        font-size: 0.78rem; font-weight: 700;
        color: var(--primary);
        text-transform: uppercase;
        letter-spacing: 1.5px;
        margin-bottom: 12px;
    }
    .ad-header h1 {
        font-family: 'Manrope', sans-serif;
        font-size: clamp(1.8rem, 3.4vw, 2.6rem);
        font-weight: 800;
        margin-bottom: 10px;
    }
    .ad-header p {
        font-size: 1rem; color: var(--on-surface-muted);
        max-width: 680px; margin: 0 auto;
    }

    /* Stat grid */
    .ad-stat-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 18px;
        margin-bottom: 36px;
    }
    .ad-stat-card {
        position: relative;
        background: var(--surface-lowest);
        border-radius: 14px;
        padding: 22px 22px 22px 30px;
        overflow: hidden;
        border: 1px solid var(--surface-high);
    }
    .ad-stat-card::before {
        content: ''; position: absolute;
        left: 0; top: 0; bottom: 0; width: 4px;
    }
    .ad-stat-card.green::before { background: var(--accent-green-fg); }
    .ad-stat-card.amber::before { background: var(--accent-amber-fg); }
    .ad-stat-card.teal::before  { background: var(--accent-teal-fg); }
    .ad-stat-card.red::before   { background: var(--accent-red-fg); }
    .ad-stat-header {
        display: flex; justify-content: space-between; align-items: center;
        margin-bottom: 14px;
    }
    .ad-stat-icon {
        width: 40px; height: 40px;
        border-radius: 10px;
        display: flex; align-items: center; justify-content: center;
    }
    .ad-stat-icon .material-symbols-outlined { font-size: 22px; }
    .ad-stat-card.green .ad-stat-icon { background: var(--accent-green-bg); color: var(--accent-green-fg); }
    .ad-stat-card.amber .ad-stat-icon { background: var(--accent-amber-bg); color: var(--accent-amber-fg); }
    .ad-stat-card.teal  .ad-stat-icon { background: var(--accent-teal-bg);  color: var(--accent-teal-fg); }
    .ad-stat-card.red   .ad-stat-icon { background: var(--accent-red-bg);   color: var(--accent-red-fg); }
    .ad-stat-value {
        font-family: 'Manrope', sans-serif;
        font-weight: 800; font-size: 2rem;
        color: var(--on-surface); line-height: 1;
        margin-bottom: 4px;
    }
    .ad-stat-label { font-size: 0.88rem; color: var(--on-surface-muted); }

    /* Insights row */
    .ad-insights {
        display: grid;
        grid-template-columns: 1.2fr 1fr;
        gap: 18px;
        margin-bottom: 36px;
    }
    .insight-card {
        background: var(--surface-lowest);
        border-radius: 16px;
        padding: 28px;
        border: 1px solid var(--surface-high);
    }
    .insight-card h3 { font-size: 1rem; color: var(--on-surface); margin-bottom: 4px; }
    .insight-card .subtitle {
        font-size: 0.82rem; color: var(--on-surface-muted); margin-bottom: 20px;
    }
    .category-list { display: flex; flex-direction: column; gap: 14px; }
    .category-row {
        display: grid;
        grid-template-columns: 1fr auto;
        align-items: center;
        gap: 10px;
    }
    .category-row .label { font-size: 0.88rem; color: var(--on-surface); }
    .category-row .count { font-size: 0.88rem; font-weight: 700; color: var(--on-surface); }
    .category-row .bar-track {
        grid-column: 1 / 3;
        height: 6px;
        background: var(--surface-high);
        border-radius: 4px;
        overflow: hidden;
    }
    .category-row .bar-fill { height: 100%; border-radius: 4px; background: var(--chart-1); }

    .resolution-donut {
        display: flex; flex-direction: column; align-items: center;
        justify-content: center; height: 100%;
    }
    .rd-svg { transform: rotate(-90deg); }
    .rd-wrap { position: relative; width: 160px; height: 160px; margin: 0 auto 16px; }
    .rd-center {
        position: absolute; inset: 0;
        display: flex; flex-direction: column; align-items: center; justify-content: center;
    }
    .rd-value {
        font-family: 'Manrope', sans-serif;
        font-weight: 800; font-size: 2rem;
        color: var(--on-surface); line-height: 1;
    }
    .rd-label { font-size: 0.78rem; color: var(--on-surface-muted); }
    .rd-stats { display: flex; gap: 24px; margin-top: 8px; }
    .rd-stat-item { text-align: center; }
    .rd-stat-item .num {
        font-family: 'Manrope', sans-serif;
        font-weight: 700; font-size: 1.1rem;
        color: var(--on-surface);
    }
    .rd-stat-item .lbl {
        font-size: 0.72rem; color: var(--on-surface-hint);
        text-transform: uppercase; letter-spacing: 0.5px;
    }

    /* Reports table */
    .ad-table-card {
        background: var(--surface-lowest);
        border-radius: 16px;
        border: 1px solid var(--surface-high);
        overflow: hidden;
    }
    .ad-table-head {
        padding: 20px 28px;
        display: flex; justify-content: space-between; align-items: center;
        border-bottom: 1px solid var(--surface-high);
    }
    .ad-table-head h3 { font-size: 1rem; font-weight: 700; }
    .ad-table-head span { font-size: 0.78rem; color: var(--on-surface-hint); }
    .ad-table { width: 100%; border-collapse: collapse; }
    .ad-table th {
        text-align: left;
        padding: 14px 20px;
        font-size: 0.7rem; font-weight: 700;
        color: var(--on-surface-hint);
        text-transform: uppercase; letter-spacing: 0.5px;
        background: var(--surface-highest);
        border-bottom: 1px solid var(--surface-high);
    }
    .ad-table td {
        padding: 16px 20px;
        font-size: 0.88rem;
        color: var(--on-surface);
        border-bottom: 1px solid var(--surface-high);
        vertical-align: middle;
    }
    .ad-table tr:last-child td { border-bottom: none; }
    /* Rows are clickable — show pointer & gentle hover highlight */
    .ad-table tbody tr.clickable-row { cursor: pointer; transition: background 0.15s ease; }
    .ad-table tbody tr.clickable-row:hover td { background: var(--primary-container-2); }
    .ad-table .report-id { font-weight: 700; }
    .ad-table .desc-cell {
        max-width: 280px;
        color: var(--on-surface-muted);
        font-size: 0.82rem;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    /* Actions column */
    .action-cell { white-space: nowrap; }
    .action-form { display: inline-flex; gap: 6px; align-items: center; }
    .status-select {
        padding: 6px 26px 6px 10px;
        border-radius: 8px;
        border: 1.5px solid var(--outline-variant);
        background: var(--surface-lowest);
        font-family: 'Public Sans', sans-serif;
        font-size: 0.78rem; font-weight: 600;
        color: var(--on-surface);
        cursor: pointer;
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 12 12'%3E%3Cpath fill='%2394a3b8' d='M6 8.825L.35 3.175l.825-.825L6 7.175l4.825-4.825.825.825z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 8px center;
        transition: border-color 0.15s ease;
    }
    .status-select:hover { border-color: var(--primary); }
    .status-select:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 3px rgba(16,185,129,0.15); }

    .btn-icon {
        width: 32px; height: 32px;
        border: 1.5px solid var(--outline-variant);
        background: var(--surface-lowest);
        border-radius: 8px;
        display: inline-flex; align-items: center; justify-content: center;
        cursor: pointer;
        transition: all 0.15s ease;
        padding: 0;
    }
    .btn-icon .material-symbols-outlined { font-size: 18px; }
    .btn-icon.save-btn { color: var(--primary); }
    .btn-icon.save-btn:hover { background: var(--primary); color: #fff; border-color: var(--primary); }
    .btn-icon.delete-btn { color: var(--accent-red-fg); }
    .btn-icon.delete-btn:hover { background: var(--accent-red-fg); color: #fff; border-color: var(--accent-red-fg); }
    .btn-icon.view-btn { color: var(--accent-blue-fg); }
    .btn-icon.view-btn:hover { background: var(--accent-blue-fg); color: #fff; border-color: var(--accent-blue-fg); }

    /* Evidence chips */
    .evidence-chips { display: flex; flex-wrap: wrap; gap: 6px; }
    .ev-chip {
        display: inline-flex; align-items: center; gap: 4px;
        padding: 4px 10px;
        border-radius: 9999px;
        font-size: 0.72rem; font-weight: 600;
        text-decoration: none;
    }
    .ev-chip .material-symbols-outlined { font-size: 14px; }
    .ev-chip.file-chip { background: var(--accent-teal-bg); color: #115e59; }
    .ev-chip.file-chip:hover { background: var(--accent-teal-fg); color: #fff; }
    .ev-chip.link-chip { background: var(--accent-blue-bg); color: #1e40af; }
    .ev-chip.link-chip:hover { background: var(--accent-blue-fg); color: #fff; }

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

    .ad-empty { text-align: center; padding: 80px 24px; }
    .ad-empty .material-symbols-outlined {
        font-size: 64px; color: var(--outline-variant); margin-bottom: 16px;
    }
    .ad-empty h3 { font-size: 1.15rem; margin-bottom: 8px; }
    .ad-empty p { font-size: 0.9rem; color: var(--on-surface-muted); }

    /* ============================================================
       MODAL — report detail dialog
       ============================================================ */
    .modal-backdrop {
        display: none;
        position: fixed; inset: 0;
        background: rgba(15, 23, 42, 0.55);
        backdrop-filter: blur(4px);
        z-index: 5000;
        align-items: center; justify-content: center;
        padding: 24px;
    }
    .modal-backdrop.active {
        display: flex;
        animation: fadeIn 0.18s ease;
    }
    @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    .modal-dialog {
        background: var(--surface-lowest);
        border-radius: 20px;
        max-width: 640px; width: 100%;
        max-height: 90vh;
        overflow: hidden;
        display: flex; flex-direction: column;
        box-shadow: 0 24px 80px rgba(0,0,0,0.28);
        animation: slideUp 0.2s ease;
    }
    @keyframes slideUp {
        from { transform: translateY(16px); opacity: 0; }
        to   { transform: translateY(0); opacity: 1; }
    }

    .modal-header {
        padding: 20px 24px;
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-darker) 100%);
        color: #fff;
        display: flex; justify-content: space-between; align-items: center;
    }
    .modal-header h2 {
        font-size: 1.2rem; font-weight: 700;
        display: flex; align-items: center; gap: 10px;
    }
    .modal-close {
        width: 34px; height: 34px;
        border-radius: 50%;
        background: rgba(255,255,255,0.15);
        border: none;
        color: #fff;
        cursor: pointer;
        display: flex; align-items: center; justify-content: center;
        transition: background 0.15s ease;
    }
    .modal-close:hover { background: rgba(255,255,255,0.3); }

    .modal-body {
        padding: 24px;
        overflow-y: auto;
        flex: 1;
    }
    .modal-meta-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 14px;
        margin-bottom: 20px;
        padding-bottom: 20px;
        border-bottom: 1px solid var(--surface-high);
    }
    .modal-meta-item .meta-label {
        font-size: 0.7rem;
        font-weight: 700;
        color: var(--on-surface-hint);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 4px;
    }
    .modal-meta-item .meta-value {
        font-size: 0.92rem;
        color: var(--on-surface);
        font-weight: 500;
    }

    .modal-section-title {
        font-size: 0.7rem;
        font-weight: 700;
        color: var(--on-surface-hint);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 10px;
    }
    .modal-description {
        background: var(--surface-low);
        border-radius: 12px;
        padding: 16px 18px;
        font-size: 0.92rem;
        color: var(--on-surface);
        line-height: 1.7;
        white-space: pre-wrap;
        word-break: break-word;
        margin-bottom: 24px;
        max-height: 280px;
        overflow-y: auto;
    }

    .modal-evidence { margin-bottom: 24px; }
    .modal-evidence .evidence-chips { margin-top: 4px; }
    .modal-evidence .no-evidence {
        font-size: 0.88rem;
        color: var(--on-surface-hint);
        font-style: italic;
    }

    .modal-footer {
        padding: 18px 24px;
        background: var(--surface-highest);
        border-top: 1px solid var(--surface-high);
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        flex-wrap: wrap;
    }
    .modal-footer .action-form { gap: 8px; }
    .modal-footer .status-select { padding: 9px 32px 9px 14px; font-size: 0.85rem; }
    .modal-footer .btn-icon { width: 38px; height: 38px; }
    .modal-footer .btn-icon .material-symbols-outlined { font-size: 20px; }

    @media (max-width: 1024px) {
        .ad-stat-grid { grid-template-columns: repeat(2, 1fr); }
        .ad-insights { grid-template-columns: 1fr; }
    }
    @media (max-width: 640px) {
        .ad-stat-grid { grid-template-columns: 1fr; }
        .ad-table th, .ad-table td { padding: 12px 14px; }
        .ad-table .desc-cell { max-width: 140px; }
        .modal-meta-grid { grid-template-columns: 1fr; }
        .modal-footer { flex-direction: column; align-items: stretch; }
        .modal-footer .action-form { justify-content: center; }
    }

    /* ============================================================
       EVIDENCE PREVIEW LIGHTBOX — pops up on top of the report modal
       Renders images, video, audio, and PDF inline. Falls back to a
       download button for any unsupported type.
       ============================================================ */
    .preview-backdrop {
        display: none;
        position: fixed; inset: 0;
        background: rgba(0, 0, 0, 0.85);
        z-index: 6000;            /* above the report modal (5000) */
        align-items: center; justify-content: center;
        padding: 24px;
    }
    .preview-backdrop.active {
        display: flex;
        animation: fadeIn 0.18s ease;
    }
    .preview-stage {
        position: relative;
        max-width: 92vw;
        max-height: 90vh;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 14px;
    }
    .preview-content {
        display: flex; align-items: center; justify-content: center;
        background: #000;
        border-radius: 14px;
        overflow: hidden;
        box-shadow: 0 24px 80px rgba(0,0,0,0.5);
        min-width: 200px;
        min-height: 200px;
    }
    .preview-content img,
    .preview-content video {
        max-width: 92vw;
        max-height: 76vh;
        display: block;
    }
    .preview-content iframe {
        width: 92vw;
        height: 80vh;
        max-width: 1000px;
        border: none;
        background: #fff;
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
        font-size: 48px;
        color: var(--primary);
        margin-bottom: 12px;
    }
    .preview-fallback h3 {
        font-size: 1.05rem;
        margin-bottom: 6px;
        color: var(--on-surface);
    }
    .preview-fallback p {
        font-size: 0.88rem;
        color: var(--on-surface-muted);
        margin-bottom: 18px;
        word-break: break-all;
    }
    .preview-fallback a {
        display: inline-flex; align-items: center; gap: 8px;
        padding: 10px 22px;
        border-radius: 10px;
        background: var(--primary);
        color: #fff;
        font-weight: 600; font-size: 0.9rem;
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
        color: #fff;
        font-size: 0.85rem;
    }
    .preview-toolbar .preview-filename {
        max-width: 360px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
    .preview-toolbar a, .preview-toolbar button {
        background: transparent;
        border: none;
        color: #fff;
        cursor: pointer;
        display: inline-flex; align-items: center; gap: 4px;
        padding: 4px 10px;
        border-radius: 8px;
        font-size: 0.82rem;
        font-weight: 500;
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
        border: none;
        color: #fff;
        cursor: pointer;
        display: flex; align-items: center; justify-content: center;
        transition: background 0.15s ease;
    }
    .preview-close-x:hover { background: rgba(255,255,255,0.3); }
</style>

<div class="admin-dash">

    <div class="ad-header">
        <div class="ad-eyebrow">Admin Dashboard</div>
        <h1>Data-Driven Safety Insights</h1>
        <p>Real-time visibility into every incident, case status, and response metric &mdash;
           giving administrators the tools to act fast.</p>
    </div>

    <%-- Flash messages from IncidentActionServlet --%>
    <% if (request.getAttribute("successMessage") != null) { %>
        <div class="alert alert-success">
            <span class="material-symbols-outlined">check_circle</span>
            <%= request.getAttribute("successMessage") %>
        </div>
    <% } %>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-error">
            <span class="material-symbols-outlined">error</span>
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>

    <div class="ad-stat-grid">
        <div class="ad-stat-card green">
            <div class="ad-stat-header">
                <div class="ad-stat-icon"><span class="material-symbols-outlined">description</span></div>
            </div>
            <div class="ad-stat-value"><%= totalCount %></div>
            <div class="ad-stat-label">Total Reports</div>
        </div>
        <div class="ad-stat-card amber">
            <div class="ad-stat-header">
                <div class="ad-stat-icon"><span class="material-symbols-outlined">warning</span></div>
            </div>
            <div class="ad-stat-value"><%= activeCount %></div>
            <div class="ad-stat-label">Active Cases</div>
        </div>
        <div class="ad-stat-card teal">
            <div class="ad-stat-header">
                <div class="ad-stat-icon"><span class="material-symbols-outlined">check_circle</span></div>
                <span class="change-pill up"><%= rate %>%</span>
            </div>
            <div class="ad-stat-value"><%= resolvedCount %></div>
            <div class="ad-stat-label">Resolved</div>
        </div>
        <div class="ad-stat-card red">
            <div class="ad-stat-header">
                <div class="ad-stat-icon"><span class="material-symbols-outlined">priority_high</span></div>
            </div>
            <div class="ad-stat-value"><%= criticalCount %></div>
            <div class="ad-stat-label">Critical Alerts</div>
        </div>
    </div>

    <div class="ad-insights">
        <div class="insight-card">
            <h3>Reports by Category</h3>
            <p class="subtitle">Distribution of incident types filed so far</p>
            <div class="category-list">
                <% if (categoryBreakdown != null && !categoryBreakdown.isEmpty()) {
                    int max = 0;
                    for (Integer v : categoryBreakdown.values()) max = Math.max(max, v);
                    if (max == 0) max = 1;
                    int colorIdx = 0;
                    String[] colors = { "var(--chart-1)", "var(--chart-2)", "var(--chart-3)",
                                        "var(--chart-4)", "var(--chart-5)", "var(--chart-6)" };
                    for (Map.Entry<String, Integer> entry : categoryBreakdown.entrySet()) {
                        int pct = (int) Math.round((entry.getValue() * 100.0) / max);
                        String color = colors[colorIdx % colors.length];
                        colorIdx++;
                %>
                    <div class="category-row">
                        <span class="label"><%= entry.getKey() %></span>
                        <span class="count"><%= entry.getValue() %></span>
                        <div class="bar-track">
                            <div class="bar-fill" style="width: <%= pct %>%; background: <%= color %>;"></div>
                        </div>
                    </div>
                <%  }
                } else { %>
                    <p style="color: var(--on-surface-hint); font-size: 0.88rem; text-align: center; padding: 20px;">
                        No data yet.
                    </p>
                <% } %>
            </div>
        </div>

        <div class="insight-card">
            <h3>Overall Resolution Rate</h3>
            <p class="subtitle">Percentage of incidents marked resolved</p>
            <div class="resolution-donut">
                <div class="rd-wrap">
                    <svg class="rd-svg" width="160" height="160" viewBox="0 0 42 42">
                        <circle cx="21" cy="21" r="15.915" fill="transparent"
                                stroke="var(--surface-high)" stroke-width="4"/>
                        <circle cx="21" cy="21" r="15.915" fill="transparent"
                                stroke="var(--primary)" stroke-width="4"
                                stroke-dasharray="<%= rate %> <%= 100 - rate %>"
                                stroke-dashoffset="0"
                                stroke-linecap="round"/>
                    </svg>
                    <div class="rd-center">
                        <div class="rd-value"><%= rate %>%</div>
                        <div class="rd-label">Resolved</div>
                    </div>
                </div>
                <div class="rd-stats">
                    <div class="rd-stat-item"><div class="num"><%= pendingCount %></div><div class="lbl">Pending</div></div>
                    <div class="rd-stat-item"><div class="num"><%= inReviewCount %></div><div class="lbl">In Review</div></div>
                    <div class="rd-stat-item"><div class="num"><%= resolvedCount %></div><div class="lbl">Resolved</div></div>
                </div>
            </div>
        </div>
    </div>

    <div class="ad-table-card">
        <div class="ad-table-head">
            <h3>Recent Reports</h3>
            <span><%= totalCount %> total <%= totalCount == 1 ? "report" : "reports" %> &middot; click a row to view details</span>
        </div>

        <% if (allIncidents != null && !allIncidents.isEmpty()) { %>
            <table class="ad-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Category</th>
                        <th>Description</th>
                        <th>Evidence</th>
                        <th>Submitted</th>
                        <th>Severity</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (IncidentModel inc : allIncidents) {
                        String status = inc.getStatus();
                        String badgeClass = "badge-pending";
                        String displayStatus = "Pending";
                        if      ("RESOLVED".equals(status))  { badgeClass = "badge-resolved";    displayStatus = "Resolved"; }
                        else if ("IN_REVIEW".equals(status)) { badgeClass = "badge-in-progress"; displayStatus = "In Review"; }
                        else if ("CRITICAL".equals(status))  { badgeClass = "badge-critical";   displayStatus = "Critical"; }
                        String sev = inc.getSeverity();
                        String sevClass = "HIGH".equals(sev) ? "high" : "low";
                        List<EvidenceModel> evList = evidenceMap != null ? evidenceMap.get(inc.getId()) : null;

                        // JSON-safe escape of the description for data attribute
                        String safeDesc = inc.getDescription() == null ? "" :
                            inc.getDescription()
                               .replace("\\", "\\\\")
                               .replace("\"", "&quot;")
                               .replace("<",  "&lt;")
                               .replace(">",  "&gt;");

                        // Build a JSON array describing the evidence for this incident.
                        // The dashboard JS reads it with JSON.parse(row.dataset.evidence)
                        // and constructs the chip elements in the DOM using
                        // addEventListener — no inline-onclick string concatenation, so
                        // there's no chance of broken escaping.
                        StringBuilder evJson = new StringBuilder("[");
                        if (evList != null && !evList.isEmpty()) {
                            boolean firstEv = true;
                            for (EvidenceModel ev : evList) {
                                if (!firstEv) evJson.append(",");
                                firstEv = false;
                                evJson.append("{");
                                if (ev.isFile()) {
                                    evJson.append("\"type\":\"file\",");
                                    evJson.append("\"url\":\"")
                                          .append(jsonEscape(request.getContextPath()
                                              + "/evidence/download?id=" + ev.getId()))
                                          .append("\",");
                                    evJson.append("\"name\":\"")
                                          .append(jsonEscape(ev.getOriginalFilename()))
                                          .append("\",");
                                    evJson.append("\"mime\":\"")
                                          .append(jsonEscape(ev.getMimeType()))
                                          .append("\",");
                                    evJson.append("\"size\":\"")
                                          .append(jsonEscape(ev.getHumanFileSize()))
                                          .append("\"");
                                } else if (ev.isLink()) {
                                    evJson.append("\"type\":\"link\",");
                                    evJson.append("\"url\":\"")
                                          .append(jsonEscape(ev.getLinkUrl()))
                                          .append("\"");
                                }
                                evJson.append("}");
                            }
                        }
                        evJson.append("]");
                        // Encode the JSON for safe placement in an HTML attribute
                        String evJsonAttr = evJson.toString()
                            .replace("&", "&amp;")
                            .replace("<", "&lt;")
                            .replace(">", "&gt;")
                            .replace("\"", "&quot;");

                        String submittedAt = inc.getSubmittedAt() != null ? inc.getSubmittedAt() : "—";
                    %>
                        <tr class="clickable-row"
                            onclick="openReportModal(this)"
                            data-id="<%= inc.getId() %>"
                            data-category="<%= inc.getCategory() %>"
                            data-submitted="<%= submittedAt %>"
                            data-severity="<%= sev != null ? sev : "LOW" %>"
                            data-status="<%= status %>"
                            data-status-label="<%= displayStatus %>"
                            data-badge-class="<%= badgeClass %>"
                            data-description="<%= safeDesc %>"
                            data-evidence="<%= evJsonAttr %>">
                            <td class="report-id">#SF-<%= inc.getId() %></td>
                            <td><%= inc.getCategory() %></td>
                            <td class="desc-cell" title="Click the row to see full description">
                                <%= inc.getDescription() %>
                            </td>
                            <td>
                                <% if (evList != null && !evList.isEmpty()) { %>
                                    <div class="evidence-chips">
                                        <% int fileCount = 0, linkCount = 0;
                                           for (EvidenceModel ev : evList) {
                                               if (ev.isFile()) fileCount++;
                                               else if (ev.isLink()) linkCount++;
                                           }
                                           if (fileCount > 0) { %>
                                            <span class="ev-chip file-chip">
                                                <span class="material-symbols-outlined">attach_file</span>
                                                <%= fileCount %> <%= fileCount == 1 ? "file" : "files" %>
                                            </span>
                                        <% } if (linkCount > 0) { %>
                                            <span class="ev-chip link-chip">
                                                <span class="material-symbols-outlined">link</span>
                                                <%= linkCount %> <%= linkCount == 1 ? "link" : "links" %>
                                            </span>
                                        <% } %>
                                    </div>
                                <% } else { %>
                                    <span style="color: var(--on-surface-hint); font-size: 0.8rem;">—</span>
                                <% } %>
                            </td>
                            <td><%= submittedAt %></td>
                            <td><span class="sev-dot <%= sevClass %>"><%= sev != null ? sev.toLowerCase() : "low" %></span></td>
                            <td><span class="badge <%= badgeClass %>"><%= displayStatus %></span></td>
                            <td class="action-cell" onclick="event.stopPropagation();">
                                <%-- View row details --%>
                                <button type="button" class="btn-icon view-btn"
                                        title="View details"
                                        onclick="event.stopPropagation(); openReportModal(this.closest('tr'));">
                                    <span class="material-symbols-outlined">visibility</span>
                                </button>

                                <%-- Update status form --%>
                                <form class="action-form"
                                      action="${pageContext.request.contextPath}/admin/incident/action"
                                      method="post"
                                      onclick="event.stopPropagation();">
                                    <input type="hidden" name="action"     value="update">
                                    <input type="hidden" name="incidentId" value="<%= inc.getId() %>">
                                    <select class="status-select" name="status" title="Change status">
                                        <option value="PENDING"   <%= "PENDING".equals(status)   ? "selected" : "" %>>Pending</option>
                                        <option value="IN_REVIEW" <%= "IN_REVIEW".equals(status) ? "selected" : "" %>>In Review</option>
                                        <option value="RESOLVED"  <%= "RESOLVED".equals(status)  ? "selected" : "" %>>Resolved</option>
                                        <option value="CRITICAL"  <%= "CRITICAL".equals(status)  ? "selected" : "" %>>Critical</option>
                                    </select>
                                    <button type="submit" class="btn-icon save-btn" title="Save status">
                                        <span class="material-symbols-outlined">check</span>
                                    </button>
                                </form>

                                <%-- Delete form with JS confirm --%>
                                <form class="action-form"
                                      action="${pageContext.request.contextPath}/admin/incident/action"
                                      method="post"
                                      onclick="event.stopPropagation();"
                                      onsubmit="return confirm('Permanently delete report #SF-<%= inc.getId() %>? This cannot be undone.');"
                                      style="margin-left: 4px;">
                                    <input type="hidden" name="action"     value="delete">
                                    <input type="hidden" name="incidentId" value="<%= inc.getId() %>">
                                    <button type="submit" class="btn-icon delete-btn" title="Delete report">
                                        <span class="material-symbols-outlined">delete</span>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="ad-empty">
                <span class="material-symbols-outlined">inbox</span>
                <h3>No reports yet</h3>
                <p>When students submit incident reports, they'll appear here for review.</p>
            </div>
        <% } %>
    </div>
</div>

<!-- ============================================================
     MODAL — report detail dialog (populated by JS)
     ============================================================ -->
<div class="modal-backdrop" id="reportModal" onclick="if(event.target===this) closeReportModal();">
    <div class="modal-dialog" role="dialog" aria-modal="true" aria-labelledby="modalTitle">

        <div class="modal-header">
            <h2 id="modalTitle">
                <span class="material-symbols-outlined">description</span>
                Report <span id="modalId">#SF-0</span>
            </h2>
            <button class="modal-close" type="button" onclick="closeReportModal()" aria-label="Close">
                <span class="material-symbols-outlined">close</span>
            </button>
        </div>

        <div class="modal-body">
            <div class="modal-meta-grid">
                <div class="modal-meta-item">
                    <div class="meta-label">Category</div>
                    <div class="meta-value" id="modalCategory">—</div>
                </div>
                <div class="modal-meta-item">
                    <div class="meta-label">Submitted</div>
                    <div class="meta-value" id="modalSubmitted">—</div>
                </div>
                <div class="modal-meta-item">
                    <div class="meta-label">Severity</div>
                    <div class="meta-value"><span class="sev-dot" id="modalSeverity">—</span></div>
                </div>
                <div class="modal-meta-item">
                    <div class="meta-label">Status</div>
                    <div class="meta-value"><span class="badge" id="modalStatus">—</span></div>
                </div>
            </div>

            <div class="modal-section-title">Full Description</div>
            <div class="modal-description" id="modalDescription">—</div>

            <div class="modal-evidence">
                <div class="modal-section-title">Attached Evidence</div>
                <div id="modalEvidence"><span class="no-evidence">No evidence attached.</span></div>
            </div>
        </div>

        <div class="modal-footer">
            <!-- Update status directly from the modal -->
            <form class="action-form"
                  action="${pageContext.request.contextPath}/admin/incident/action"
                  method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="incidentId" id="modalUpdateId">
                <select class="status-select" name="status" id="modalStatusSelect">
                    <option value="PENDING">Pending</option>
                    <option value="IN_REVIEW">In Review</option>
                    <option value="RESOLVED">Resolved</option>
                    <option value="CRITICAL">Critical</option>
                </select>
                <button type="submit" class="btn-icon save-btn" title="Save status">
                    <span class="material-symbols-outlined">check</span>
                </button>
            </form>

            <!-- Delete from inside the modal -->
            <form class="action-form"
                  action="${pageContext.request.contextPath}/admin/incident/action"
                  method="post"
                  onsubmit="return confirm('Permanently delete this report? This cannot be undone.');">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="incidentId" id="modalDeleteId">
                <button type="submit" class="btn-icon delete-btn" title="Delete report">
                    <span class="material-symbols-outlined">delete</span>
                </button>
            </form>
        </div>
    </div>
</div>

<!-- ============================================================
     EVIDENCE PREVIEW LIGHTBOX — populated by openPreview() in JS
     ============================================================ -->
<div class="preview-backdrop" id="previewModal"
     onclick="if(event.target===this) closePreview();">
    <div class="preview-stage">
        <button class="preview-close-x" type="button"
                onclick="closePreview()" aria-label="Close preview">
            <span class="material-symbols-outlined">close</span>
        </button>
        <div class="preview-content" id="previewContent">
            <!-- innerHTML replaced by openPreview() -->
        </div>
        <div class="preview-toolbar">
            <span class="material-symbols-outlined">visibility</span>
            <span class="preview-filename" id="previewFilename">file</span>
            <a id="previewDownloadLink" href="#" download
               title="Download original file">
                <span class="material-symbols-outlined">download</span>
                Download
            </a>
            <button type="button" onclick="closePreview()" title="Close">
                <span class="material-symbols-outlined">close</span>
                Close
            </button>
        </div>
    </div>
</div>

<script>
    // Open modal and populate fields from the clicked row's data-* attributes
    function openReportModal(row) {
        if (!row) return;
        var id         = row.dataset.id;
        var category   = row.dataset.category;
        var submitted  = row.dataset.submitted;
        var severity   = row.dataset.severity;
        var status     = row.dataset.status;
        var statusLbl  = row.dataset.statusLabel;
        var badgeClass = row.dataset.badgeClass;
        var desc       = row.dataset.description || "No description provided.";
        var evidence   = row.dataset.evidence;

        document.getElementById('modalId').textContent         = '#SF-' + id;
        document.getElementById('modalCategory').textContent   = category;
        document.getElementById('modalSubmitted').textContent  = submitted;

        // Severity dot
        var sevEl = document.getElementById('modalSeverity');
        sevEl.className = 'sev-dot ' + (severity === 'HIGH' ? 'high' : 'low');
        sevEl.textContent = severity.charAt(0) + severity.slice(1).toLowerCase();

        // Status badge
        var statEl = document.getElementById('modalStatus');
        statEl.className = 'badge ' + badgeClass;
        statEl.textContent = statusLbl;

        // Description (may contain newlines — preserved by CSS white-space: pre-wrap)
        document.getElementById('modalDescription').textContent = desc;

        // Evidence block — parse the JSON array and build chip elements
        // in code so we can attach proper click listeners (no inline onclick
        // strings that have to survive HTML attribute escaping).
        var evEl = document.getElementById('modalEvidence');
        evEl.innerHTML = ''; // clear previous content
        var evidenceItems = [];
        if (evidence && evidence.trim().length > 0) {
            try { evidenceItems = JSON.parse(evidence); }
            catch (e) {
                console.error('Failed to parse evidence JSON:', e, evidence);
                evidenceItems = [];
            }
        }
        if (evidenceItems.length === 0) {
            var blank = document.createElement('span');
            blank.className = 'no-evidence';
            blank.textContent = 'No evidence attached.';
            evEl.appendChild(blank);
        } else {
            var chipsWrap = document.createElement('div');
            chipsWrap.className = 'evidence-chips';
            evidenceItems.forEach(function (item) {
                if (item.type === 'file') {
                    // Build <button class="ev-chip file-chip">
                    var btn = document.createElement('button');
                    btn.type = 'button';
                    btn.className = 'ev-chip file-chip';
                    btn.title = item.name || 'file';
                    btn.innerHTML = '<span class="material-symbols-outlined">attach_file</span>';
                    btn.appendChild(document.createTextNode(
                        ' ' + (item.name || 'file') + ' (' + (item.size || '') + ')'));
                    // Capture per-iteration values so the listener uses the right one
                    btn.addEventListener('click', function () {
                        openPreview(item.url, item.name, item.mime);
                    });
                    chipsWrap.appendChild(btn);
                } else if (item.type === 'link') {
                    var a = document.createElement('a');
                    a.className = 'ev-chip link-chip';
                    a.href = item.url;
                    a.target = '_blank';
                    a.rel = 'noopener noreferrer';
                    a.innerHTML = '<span class="material-symbols-outlined">link</span>';
                    a.appendChild(document.createTextNode(' External link'));
                    chipsWrap.appendChild(a);
                }
            });
            evEl.appendChild(chipsWrap);
        }

        // Wire the footer forms to this incident
        document.getElementById('modalUpdateId').value = id;
        document.getElementById('modalDeleteId').value = id;
        document.getElementById('modalStatusSelect').value = status;

        // Show
        document.getElementById('reportModal').classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeReportModal() {
        document.getElementById('reportModal').classList.remove('active');
        if (!document.getElementById('previewModal').classList.contains('active')) {
            document.body.style.overflow = '';
        }
    }

    // ============================================================
    //  Evidence preview lightbox
    //  Called by file-chips inside the report modal:
    //    openPreview(url, filename, mimeType)
    //  Picks the right viewer based on the MIME type:
    //    image/*    -> <img>
    //    video/*    -> <video controls>
    //    audio/*    -> <audio controls>
    //    pdf        -> <iframe>
    //    other      -> download fallback card
    // ============================================================
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
            // Documents (Word, txt, anything else) — show a download card
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
        var pm = document.getElementById('previewModal');
        pm.classList.remove('active');
        // Wipe the embedded media so audio/video stops playing
        document.getElementById('previewContent').innerHTML = '';
        // Only release body scroll if the report modal is also closed
        if (!document.getElementById('reportModal').classList.contains('active')) {
            document.body.style.overflow = '';
        }
    }

    // Tiny attribute/text escapers used when building the fallback card
    function escapeAttr(s) {
        if (!s) return '';
        return String(s)
            .replace(/&/g, '&amp;').replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    }
    function escapeText(s) {
        if (!s) return '';
        return String(s)
            .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    }

    // ESC closes whichever overlay is open (preview first, then report modal)
    document.addEventListener('keydown', function (e) {
        if (e.key !== 'Escape') return;
        if (document.getElementById('previewModal').classList.contains('active')) {
            closePreview();
        } else {
            closeReportModal();
        }
    });
</script>

<%@ include file="../footer.jsp" %>
