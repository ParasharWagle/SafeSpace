<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% request.setAttribute("navMode",   "solid"); %>
<% request.setAttribute("activeNav", "dashboard"); %>
<%@ include file="../header.jsp" %>

<style>
    .report-wrap {
        max-width: 820px;
        margin: 0 auto;
        padding: 48px 24px 80px;
    }

    /* Page title block */
    .rp-header {
        display: flex; justify-content: space-between; align-items: flex-start;
        gap: 16px; flex-wrap: wrap;
        margin-bottom: 20px;
    }
    .rp-header h1 {
        font-family: 'Manrope', sans-serif;
        font-weight: 800;
        font-size: 1.9rem;
        color: var(--on-surface);
    }
    .rp-header p {
        font-size: 0.95rem;
        color: var(--on-surface-muted);
        margin-top: 6px;
    }
    .secure-badge {
        display: inline-flex; align-items: center; gap: 6px;
        padding: 8px 16px;
        border-radius: 9999px;
        background: var(--primary-container);
        color: var(--on-primary-container);
        font-size: 0.8rem; font-weight: 600;
    }
    .secure-badge .material-symbols-outlined { font-size: 16px; }

    /* Privacy info strip */
    .privacy-strip {
        background: var(--primary-container-2);
        border: 1px solid var(--primary-container);
        border-radius: 12px;
        padding: 14px 20px;
        display: flex; align-items: center; gap: 12px;
        font-size: 0.88rem;
        color: var(--on-primary-container);
        margin-bottom: 28px;
    }
    .privacy-strip .material-symbols-outlined { font-size: 20px; color: var(--primary); flex-shrink: 0; }

    /* Form card */
    .report-form-card {
        background: var(--surface-lowest);
        border-radius: 20px;
        padding: 36px;
        border: 1px solid var(--surface-high);
    }

    /* Section groupings within the form */
    .form-section {
        padding-bottom: 28px;
        border-bottom: 1px solid var(--surface-high);
        margin-bottom: 28px;
    }
    .form-section:last-of-type {
        padding-bottom: 0;
        margin-bottom: 0;
        border-bottom: none;
    }
    .form-section-title {
        font-family: 'Manrope', sans-serif;
        font-weight: 700;
        font-size: 1rem;
        color: var(--on-surface);
        margin-bottom: 4px;
    }
    .form-section-hint {
        font-size: 0.85rem;
        color: var(--on-surface-muted);
        margin-bottom: 20px;
    }

    /* Urgency pill toggles */
    .urgency-group {
        display: flex; gap: 0;
        border-radius: 9999px;
        overflow: hidden;
        border: 1.5px solid var(--outline-variant);
        width: fit-content;
    }
    .urgency-option input[type="radio"] { display: none; }
    .urgency-option label {
        padding: 11px 28px;
        font-weight: 500; font-size: 0.875rem;
        color: var(--on-surface-muted);
        cursor: pointer;
        transition: all 0.2s ease;
        user-select: none;
        display: block;
    }
    .urgency-option input[type="radio"]:checked + label {
        background: var(--primary);
        color: #fff;
    }
    .urgency-option:not(:last-child) label { border-right: 1.5px solid var(--outline-variant); }

    /* Character counter */
    .char-counter {
        text-align: right;
        font-size: 0.78rem;
        color: var(--on-surface-hint);
        margin-top: 6px;
    }
    .char-counter.over-limit { color: #c62828; font-weight: 600; }

    /* ============================================================
       EVIDENCE UPLOAD AREA (drag & drop)
       ============================================================ */
    .evidence-tabs {
        display: flex; gap: 8px;
        margin-bottom: 20px;
        border-bottom: 1.5px solid var(--surface-high);
    }
    .evidence-tab {
        padding: 10px 18px;
        font-weight: 600; font-size: 0.88rem;
        color: var(--on-surface-muted);
        cursor: pointer;
        border-bottom: 2px solid transparent;
        margin-bottom: -1.5px;
        transition: all 0.2s ease;
        display: inline-flex; align-items: center; gap: 6px;
    }
    .evidence-tab .material-symbols-outlined { font-size: 18px; }
    .evidence-tab.active {
        color: var(--primary);
        border-bottom-color: var(--primary);
    }
    .evidence-tab:hover { color: var(--primary-dark); }

    .evidence-panel { display: none; }
    .evidence-panel.active { display: block; }

    /* Dropzone */
    .dropzone {
        position: relative;
        border: 2px dashed var(--outline-variant);
        border-radius: 14px;
        padding: 36px 24px;
        text-align: center;
        transition: all 0.2s ease;
        background: var(--surface-highest);
        cursor: pointer;
    }
    .dropzone:hover,
    .dropzone.is-dragging {
        border-color: var(--primary);
        background: var(--primary-container-2);
    }
    .dropzone input[type="file"] {
        position: absolute;
        inset: 0;
        opacity: 0;
        cursor: pointer;
    }
    .dropzone-icon {
        width: 56px; height: 56px;
        border-radius: 14px;
        background: var(--primary-container);
        display: flex; align-items: center; justify-content: center;
        margin: 0 auto 14px;
    }
    .dropzone-icon .material-symbols-outlined {
        font-size: 28px;
        color: var(--primary-dark);
    }
    .dropzone p { font-size: 0.95rem; font-weight: 600; color: var(--on-surface); margin-bottom: 4px; }
    .dropzone small { font-size: 0.78rem; color: var(--on-surface-muted); }

    /* File preview list */
    .file-preview-list {
        margin-top: 16px;
        display: flex; flex-direction: column; gap: 8px;
    }
    .file-preview {
        display: flex; align-items: center; gap: 12px;
        padding: 10px 14px;
        background: var(--surface-low);
        border-radius: 10px;
        border: 1px solid var(--surface-high);
        font-size: 0.85rem;
    }
    .file-preview-icon {
        width: 32px; height: 32px;
        border-radius: 8px;
        background: var(--accent-teal-bg);
        display: flex; align-items: center; justify-content: center;
        flex-shrink: 0;
    }
    .file-preview-icon .material-symbols-outlined {
        font-size: 18px; color: var(--accent-teal-fg);
    }
    .file-preview-info { flex: 1; min-width: 0; }
    .file-preview-name {
        font-weight: 600; color: var(--on-surface);
        overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
    }
    .file-preview-size { font-size: 0.75rem; color: var(--on-surface-hint); }

    /* Form actions */
    .form-actions {
        display: flex; justify-content: flex-end; gap: 14px;
        margin-top: 32px;
    }
    .btn-cancel {
        padding: 12px 28px;
        border-radius: 10px;
        background: transparent;
        color: var(--on-surface-muted);
        font-weight: 600; font-size: 0.9rem;
        border: 1.5px solid var(--outline-variant);
        transition: all 0.2s ease;
    }
    .btn-cancel:hover { background: var(--surface-low); border-color: var(--on-surface-hint); }

    .btn-submit-report {
        padding: 12px 32px;
        border-radius: 10px;
        background: var(--primary);
        color: #fff;
        font-weight: 600; font-size: 0.9rem;
        border: none;
        cursor: pointer;
        display: inline-flex; align-items: center; gap: 8px;
        transition: all 0.2s ease;
        box-shadow: 0 4px 14px rgba(16,185,129,0.3);
    }
    .btn-submit-report:hover {
        background: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 8px 22px rgba(16,185,129,0.4);
    }

    @media (max-width: 640px) {
        .report-form-card { padding: 24px; }
        .form-actions { flex-direction: column; }
        .btn-cancel, .btn-submit-report { width: 100%; justify-content: center; }
    }
</style>

<div class="report-wrap">

    <div class="rp-header">
        <div>
            <h1>Create an Anonymous Report</h1>
            <p>Your identity stays hidden. Only trained counselors review this information.</p>
        </div>
        <div class="secure-badge">
            <span class="material-symbols-outlined">lock</span>
            Encrypted Connection
        </div>
    </div>

    <div class="privacy-strip">
        <span class="material-symbols-outlined">visibility_off</span>
        Your IP address and identity are hidden from our administrative team. All reports are processed anonymously.
    </div>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-error">
            <span class="material-symbols-outlined">error</span>
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>

    <div class="report-form-card">
        <%-- IMPORTANT: enctype="multipart/form-data" enables file uploads.
             The @MultipartConfig annotation on SubmitReportServlet handles parsing. --%>
        <form action="${pageContext.request.contextPath}/student/report"
              method="post"
              enctype="multipart/form-data"
              id="reportForm">

            <!-- Section 1: Incident details -->
            <div class="form-section">
                <div class="form-section-title">Incident Details</div>
                <div class="form-section-hint">Tell us what happened, when, and how urgent this is.</div>

                <div class="form-group">
                    <label class="form-label" for="category">Incident Category</label>
                    <select class="form-select" id="category" name="category" required>
                        <option value="" disabled selected>Select a category</option>
                        <option value="Academic Integrity">Academic Integrity</option>
                        <option value="Harassment or Bullying">Harassment or Bullying</option>
                        <option value="Cyberbullying">Cyberbullying</option>
                        <option value="Mental Health Concern">Mental Health Concern</option>
                        <option value="Safety Concern">Safety Concern</option>
                        <option value="Substance Abuse">Substance Abuse</option>
                        <option value="Wellness Check Request">Wellness Check Request</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

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
            </div>

            <!-- ============================================================
                 Section 2: Evidence upload (NEW)
                 ============================================================ -->
            <div class="form-section">
                <div class="form-section-title">Evidence (Optional)</div>
                <div class="form-section-hint">
                    Attach screenshots, photos, documents, or links to online posts
                    (Instagram, TikTok, Facebook, etc.) that support your report.
                    Each file up to 25&nbsp;MB. All evidence is stored securely.
                </div>

                <!-- Tabs: Files / Social Media Links -->
                <div class="evidence-tabs">
                    <div class="evidence-tab active" data-target="panel-files">
                        <span class="material-symbols-outlined">attach_file</span>
                        Upload Files
                    </div>
                    <div class="evidence-tab" data-target="panel-links">
                        <span class="material-symbols-outlined">link</span>
                        Social Media Links
                    </div>
                </div>

                <!-- Panel 1: file dropzone -->
                <div class="evidence-panel active" id="panel-files">
                    <div class="dropzone" id="dropzone">
                        <input type="file"
                               name="evidenceFile"
                               id="evidenceFile"
                               multiple
                               accept="image/*,video/*,.pdf,.doc,.docx,.txt">
                        <div class="dropzone-icon">
                            <span class="material-symbols-outlined">cloud_upload</span>
                        </div>
                        <p>Drag &amp; drop files here, or click to browse</p>
                        <small>Accepts images, videos, PDFs, and documents &bull; 25 MB per file</small>
                    </div>
                    <div class="file-preview-list" id="filePreviewList"></div>
                </div>

                <!-- Panel 2: URL textarea -->
                <div class="evidence-panel" id="panel-links">
                    <div class="form-group" style="margin-bottom: 0;">
                        <label class="form-label" for="evidenceLinks">
                            Paste evidence URLs &mdash; one per line
                        </label>
                        <textarea class="form-textarea"
                                  id="evidenceLinks"
                                  name="evidenceLinks"
                                  placeholder="https://instagram.com/p/...&#10;https://tiktok.com/@user/video/...&#10;https://twitter.com/..."
                                  rows="5"></textarea>
                        <small style="display:block;margin-top:6px;font-size:0.78rem;color:var(--on-surface-hint);">
                            Each line must start with http:// or https://. Maximum 1,000 characters per link.
                        </small>
                    </div>
                </div>

                <!-- Shared caption for all evidence -->
                <div class="form-group" style="margin-top: 20px;">
                    <label class="form-label" for="evidenceCaption">Evidence Note (Optional)</label>
                    <input type="text"
                           class="form-input"
                           id="evidenceCaption"
                           name="evidenceCaption"
                           placeholder="A brief note about this evidence (e.g. 'Screenshot of the message')"
                           maxlength="500">
                </div>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/student/dashboard" class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-submit-report">
                    <span class="material-symbols-outlined">send</span>
                    Submit Report
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    // ---- Character counter ----
    function updateCharCount() {
        var textarea = document.getElementById('description');
        var counter  = document.getElementById('charCounter');
        var remaining = 2000 - textarea.value.length;
        counter.textContent = remaining + ' characters remaining';
        if (remaining < 0) counter.classList.add('over-limit');
        else counter.classList.remove('over-limit');
    }

    // ---- Evidence tab switching ----
    document.querySelectorAll('.evidence-tab').forEach(function(tab) {
        tab.addEventListener('click', function() {
            document.querySelectorAll('.evidence-tab').forEach(function(t){ t.classList.remove('active'); });
            document.querySelectorAll('.evidence-panel').forEach(function(p){ p.classList.remove('active'); });
            tab.classList.add('active');
            document.getElementById(tab.dataset.target).classList.add('active');
        });
    });

    // ---- Dropzone: drag/drop + file preview ----
    var dropzone = document.getElementById('dropzone');
    var fileInput = document.getElementById('evidenceFile');
    var previewList = document.getElementById('filePreviewList');

    ['dragenter','dragover'].forEach(function(ev){
        dropzone.addEventListener(ev, function(e){
            e.preventDefault(); e.stopPropagation();
            dropzone.classList.add('is-dragging');
        });
    });
    ['dragleave','drop'].forEach(function(ev){
        dropzone.addEventListener(ev, function(e){
            e.preventDefault(); e.stopPropagation();
            dropzone.classList.remove('is-dragging');
        });
    });
    dropzone.addEventListener('drop', function(e){
        // Assign dropped files to the input so they post with the form
        if (e.dataTransfer && e.dataTransfer.files.length > 0) {
            fileInput.files = e.dataTransfer.files;
            renderPreview();
        }
    });
    fileInput.addEventListener('change', renderPreview);

    function renderPreview() {
        previewList.innerHTML = '';
        if (!fileInput.files || fileInput.files.length === 0) return;
        Array.prototype.forEach.call(fileInput.files, function(file) {
            var item = document.createElement('div');
            item.className = 'file-preview';
            var iconName = 'description';
            if (file.type.startsWith('image/')) iconName = 'image';
            else if (file.type.startsWith('video/')) iconName = 'videocam';
            else if (file.type === 'application/pdf') iconName = 'picture_as_pdf';
            item.innerHTML =
                '<div class="file-preview-icon"><span class="material-symbols-outlined">' + iconName + '</span></div>' +
                '<div class="file-preview-info">' +
                    '<div class="file-preview-name">' + file.name + '</div>' +
                    '<div class="file-preview-size">' + formatSize(file.size) + '</div>' +
                '</div>';
            previewList.appendChild(item);
        });
    }
    function formatSize(bytes) {
        if (bytes < 1024) return bytes + ' B';
        if (bytes < 1024*1024) return (bytes/1024).toFixed(1) + ' KB';
        return (bytes/(1024*1024)).toFixed(1) + ' MB';
    }
</script>

<%@ include file="../footer.jsp" %>
