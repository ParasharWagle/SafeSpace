<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Include the shared header with navbar and CSS design system --%>
<%@ include file="../header.jsp" %>

<style>
    /* ============================================================
       REPORT PAGE
       ============================================================ */
    .report-container {
        max-width: 760px;
        margin: 0 auto;
        padding: 40px 24px 80px;
    }

    /* ---- Page Header ---- */
    .report-page-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 28px;
        flex-wrap: wrap;
        gap: 16px;
    }

    .report-page-header h1 {
        font-size: 1.7rem;
        color: var(--on-surface);
    }

    .secure-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 8px 16px;
        border-radius: 9999px;
        background: var(--primary-container);
        color: var(--on-primary-container);
        font-size: 0.8rem;
        font-weight: 600;
    }

    .secure-badge .material-symbols-outlined {
        font-size: 16px;
    }

    /* ---- Info Box ---- */
    .info-box {
        background: var(--surface-low);
        border-radius: 14px;
        padding: 18px 22px;
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 32px;
        font-size: 0.875rem;
        color: var(--on-surface-muted);
    }

    .info-box .material-symbols-outlined {
        font-size: 22px;
        color: var(--primary);
        flex-shrink: 0;
    }

    /* ---- Form Card ---- */
    .report-form-card {
        background: var(--surface-lowest);
        border-radius: 20px;
        padding: 36px;
    }

    /* ---- Form Groups ---- */
    .form-group {
        margin-bottom: 24px;
    }

    .form-label {
        display: block;
        font-weight: 500;
        font-size: 0.875rem;
        color: var(--on-surface);
        margin-bottom: 8px;
    }

    .form-input,
    .form-select,
    .form-textarea {
        width: 100%;
        padding: 13px 16px;
        border-radius: 10px;
        border: 1.5px solid var(--outline-variant);
        background: var(--surface-lowest);
        font-family: 'Public Sans', sans-serif;
        font-size: 0.9rem;
        color: var(--on-surface);
        outline: none;
        transition: border-color 0.2s ease, box-shadow 0.2s ease;
    }

    .form-input:focus,
    .form-select:focus,
    .form-textarea:focus {
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(52,102,109,0.12);
    }

    .form-input::placeholder,
    .form-textarea::placeholder {
        color: var(--on-surface-hint);
    }

    .form-select {
        cursor: pointer;
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23727d7e' d='M6 8.825L.35 3.175l.825-.825L6 7.175l4.825-4.825.825.825z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 14px center;
        padding-right: 36px;
    }

    .form-textarea {
        min-height: 180px;
        resize: vertical;
        line-height: 1.7;
    }

    /* ---- Character Counter ---- */
    .char-counter {
        text-align: right;
        font-size: 0.78rem;
        color: var(--on-surface-hint);
        margin-top: 6px;
    }

    .char-counter.over-limit {
        color: #c62828;
        font-weight: 600;
    }

    /* ---- Urgency Toggle Pills ---- */
    .urgency-group {
        display: flex;
        gap: 0;
        border-radius: 9999px;
        overflow: hidden;
        border: 1.5px solid var(--outline-variant);
        width: fit-content;
    }

    .urgency-option {
        display: flex;
    }

    .urgency-option input[type="radio"] {
        display: none;
    }

    .urgency-option label {
        padding: 11px 28px;
        font-family: 'Public Sans', sans-serif;
        font-weight: 500;
        font-size: 0.875rem;
        color: var(--on-surface-muted);
        cursor: pointer;
        transition: background 0.2s ease, color 0.2s ease;
        user-select: none;
    }

    .urgency-option input[type="radio"]:checked + label {
        background: var(--primary);
        color: var(--on-primary);
    }

    .urgency-option:not(:last-child) label {
        border-right: 1.5px solid var(--outline-variant);
    }

    /* ---- Form Actions ---- */
    .form-actions {
        display: flex;
        justify-content: flex-end;
        gap: 14px;
        margin-top: 32px;
    }

    .btn-cancel {
        padding: 12px 28px;
        border-radius: 9999px;
        background: transparent;
        color: var(--on-surface-muted);
        font-family: 'Public Sans', sans-serif;
        font-weight: 600;
        font-size: 0.9rem;
        border: 1.5px solid var(--outline-variant);
        cursor: pointer;
        transition: background 0.2s ease, border-color 0.2s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
    }

    .btn-cancel:hover {
        background: var(--surface-low);
        border-color: var(--on-surface-hint);
    }

    .btn-submit-report {
        padding: 12px 32px;
        border-radius: 9999px;
        background: var(--primary);
        color: var(--on-primary);
        font-family: 'Public Sans', sans-serif;
        font-weight: 600;
        font-size: 0.9rem;
        border: none;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: background 0.2s ease, transform 0.15s ease, box-shadow 0.2s ease;
    }

    .btn-submit-report:hover {
        background: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 4px 16px rgba(52,102,109,0.25);
    }

    /* ---- Alerts ---- */
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

    .alert-error {
        background: #fce4ec;
        color: #c62828;
    }

    /* ---- Responsive ---- */
    @media (max-width: 768px) {
        .report-form-card {
            padding: 24px;
        }

        .form-actions {
            flex-direction: column;
        }

        .btn-cancel, .btn-submit-report {
            width: 100%;
            justify-content: center;
        }
    }
</style>

<div class="report-container">

    <!-- Page header with secure badge -->
    <div class="report-page-header">
        <h1>Create an Anonymous Report</h1>
        <div class="secure-badge">
            <span class="material-symbols-outlined">lock</span>
            Encrypted Connection
        </div>
    </div>

    <!-- Privacy info box -->
    <div class="info-box">
        <span class="material-symbols-outlined">visibility_off</span>
        Your IP address and identity are hidden from our administrative team. All reports are processed anonymously.
    </div>

    <%-- Success message --%>
    <% if (request.getAttribute("successMessage") != null) { %>
        <div class="alert alert-success">
            <span class="material-symbols-outlined">check_circle</span>
            <%= request.getAttribute("successMessage") %>
        </div>
    <% } %>

    <%-- Error message --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-error">
            <span class="material-symbols-outlined">error</span>
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>

    <!-- Report form card -->
    <div class="report-form-card">
        <form action="${pageContext.request.contextPath}/student/report" method="post" id="reportForm">

            <!-- Incident Category -->
            <div class="form-group">
                <label class="form-label" for="category">Incident Category</label>
                <select class="form-select" id="category" name="category" required>
                    <option value="" disabled selected>Select a category</option>
                    <option value="Academic Integrity">Academic Integrity</option>
                    <option value="Harassment or Bullying">Harassment or Bullying</option>
                    <option value="Safety Concern">Safety Concern</option>
                    <option value="Wellness Check Request">Wellness Check Request</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <!-- Urgency Level -->
            <div class="form-group">
                <label class="form-label">Urgency Level</label>
                <div class="urgency-group">
                    <div class="urgency-option">
                        <input type="radio" id="urgency-standard" name="urgency" value="standard" checked>
                        <label for="urgency-standard">Standard</label>
                    </div>
                    <div class="urgency-option">
                        <input type="radio" id="urgency-high" name="urgency" value="high">
                        <label for="urgency-high">High Priority</label>
                    </div>
                </div>
            </div>

            <!-- Description -->
            <div class="form-group">
                <label class="form-label" for="description">Description</label>
                <textarea class="form-textarea"
                          id="description"
                          name="description"
                          placeholder="Please describe the incident in detail. Include dates, times, and locations if possible."
                          maxlength="2000"
                          required
                          oninput="updateCharCount()"></textarea>
                <div class="char-counter" id="charCounter">2000 characters remaining</div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/student/dashboard" class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-submit-report" id="submit-report-btn">
                    <span class="material-symbols-outlined">send</span>
                    Submit Report
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Character counter script -->
<script>
    // Updates the character counter below the description textarea
    function updateCharCount() {
        var textarea = document.getElementById('description');
        var counter = document.getElementById('charCounter');
        var remaining = 2000 - textarea.value.length;

        counter.textContent = remaining + ' characters remaining';

        // Add warning style when over limit
        if (remaining < 0) {
            counter.classList.add('over-limit');
        } else {
            counter.classList.remove('over-limit');
        }
    }
</script>

<%-- Include the shared footer with emergency exit button --%>
<%@ include file="../footer.jsp" %>
