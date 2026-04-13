<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Include the shared header with navbar and CSS design system --%>
<%@ include file="header.jsp" %>

<style>
    /* ============================================================
       CONTACT PAGE
       ============================================================ */
    .contact-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 60px 24px 80px;
    }

    .contact-heading {
        text-align: center;
        margin-bottom: 52px;
    }

    .contact-heading h1 {
        font-size: 2.4rem;
        color: var(--on-surface);
        margin-bottom: 12px;
    }

    .contact-heading p {
        font-size: 1.05rem;
        color: var(--on-surface-muted);
        max-width: 520px;
        margin: 0 auto;
        line-height: 1.7;
    }

    /* ---- Two Column Layout ---- */
    .contact-grid {
        display: flex;
        gap: 48px;
        align-items: flex-start;
    }

    /* ---- Left Form Column (60%) ---- */
    .contact-form-col {
        flex: 3;
    }

    .contact-form-card {
        background: var(--surface-lowest);
        border-radius: 20px;
        padding: 36px;
    }

    .form-group {
        margin-bottom: 22px;
    }

    .form-label {
        display: block;
        font-weight: 500;
        font-size: 0.875rem;
        color: var(--on-surface);
        margin-bottom: 6px;
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
        min-height: 150px;
        resize: vertical;
        line-height: 1.7;
    }

    .btn-submit-contact {
        padding: 13px 32px;
        border-radius: 9999px;
        background: var(--primary);
        color: var(--on-primary);
        font-family: 'Public Sans', sans-serif;
        font-weight: 600;
        font-size: 0.95rem;
        border: none;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: background 0.2s ease, transform 0.15s ease, box-shadow 0.2s ease;
    }

    .btn-submit-contact:hover {
        background: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 4px 16px rgba(52,102,109,0.25);
    }

    .form-privacy-note {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-top: 20px;
        font-size: 0.8rem;
        color: var(--on-surface-hint);
    }

    .form-privacy-note .material-symbols-outlined {
        font-size: 18px;
        color: var(--primary);
    }

    /* ---- Right Sidebar (40%) ---- */
    .contact-sidebar {
        flex: 2;
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .contact-card {
        background: var(--surface-lowest);
        border-radius: 16px;
        padding: 24px;
        display: flex;
        align-items: flex-start;
        gap: 16px;
        transition: transform 0.25s ease, box-shadow 0.25s ease;
    }

    .contact-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 24px rgba(0,0,0,0.05);
    }

    .contact-card-icon {
        width: 48px;
        height: 48px;
        border-radius: 12px;
        background: var(--primary-container);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .contact-card-icon .material-symbols-outlined {
        font-size: 24px;
        color: var(--primary);
    }

    .contact-card-info h3 {
        font-size: 0.95rem;
        color: var(--on-surface);
        margin-bottom: 4px;
    }

    .contact-card-info p {
        font-size: 0.85rem;
        color: var(--on-surface-muted);
        line-height: 1.5;
    }

    .contact-card-info .contact-detail {
        font-weight: 600;
        color: var(--primary);
        font-size: 0.9rem;
        margin-top: 4px;
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
        .contact-grid {
            flex-direction: column;
        }

        .contact-heading h1 {
            font-size: 1.8rem;
        }

        .contact-form-card {
            padding: 24px;
        }
    }
</style>

<div class="contact-container">

    <!-- Page heading -->
    <div class="contact-heading">
        <h1>We're here to listen.</h1>
        <p>Whether you need technical help, a referral, or just someone to talk to — we're ready to support you.</p>
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

    <!-- Two column layout -->
    <div class="contact-grid">

        <!-- Left: Contact Form (60%) -->
        <div class="contact-form-col">
            <div class="contact-form-card">
                <form action="${pageContext.request.contextPath}/contact" method="post" id="contactForm">

                    <!-- Preferred Name -->
                    <div class="form-group">
                        <label class="form-label" for="name">Preferred Name</label>
                        <input type="text" class="form-input" id="name" name="name"
                               placeholder="How should we address you?" required>
                    </div>

                    <!-- Email (Optional) -->
                    <div class="form-group">
                        <label class="form-label" for="email">Email <span style="color: var(--on-surface-hint); font-weight: 400;">(Optional)</span></label>
                        <input type="email" class="form-input" id="email" name="email"
                               placeholder="your.email@example.com">
                    </div>

                    <!-- Support Category -->
                    <div class="form-group">
                        <label class="form-label" for="category">Support Category</label>
                        <select class="form-select" id="category" name="category">
                            <option value="" disabled selected>What can we help with?</option>
                            <option value="Technical Issue">Technical Issue</option>
                            <option value="Anonymous Reporting Help">Anonymous Reporting Help</option>
                            <option value="Mental Health Referral">Mental Health Referral</option>
                            <option value="Policy Clarification">Policy Clarification</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <!-- Message -->
                    <div class="form-group">
                        <label class="form-label" for="message">Message</label>
                        <textarea class="form-textarea" id="message" name="message"
                                  placeholder="Tell us how we can support you..." required></textarea>
                    </div>

                    <!-- Submit button -->
                    <button type="submit" class="btn-submit-contact" id="contact-submit-btn">
                        <span class="material-symbols-outlined">send</span>
                        Submit Request
                    </button>

                    <!-- Privacy note -->
                    <div class="form-privacy-note">
                        <span class="material-symbols-outlined">lock</span>
                        Your inquiry can be processed anonymously if no email is provided.
                    </div>
                </form>
            </div>
        </div>

        <!-- Right: Contact Info Sidebar (40%) -->
        <div class="contact-sidebar">

            <!-- 24/7 Crisis Hotline -->
            <!-- ✅ CHANGED: number updated to Nepali helpline -->
            <div class="contact-card">
                <div class="contact-card-icon">
                    <span class="material-symbols-outlined">call</span>
                </div>
                <div class="contact-card-info">
                    <h3>24/7 Crisis Hotline</h3>
                    <p>Speak with a trained crisis counselor anytime.</p>
                    <div class="contact-detail">1660-01-11116 (Nepali Helpline)</div>
                </div>
            </div>

            <!-- Text Support -->
            <!-- ✅ CHANGED: number updated to NTC SMS -->
            <div class="contact-card">
                <div class="contact-card-icon">
                    <span class="material-symbols-outlined">chat</span>
                </div>
                <div class="contact-card-info">
                    <h3>Text Support</h3>
                    <p>Prefer texting? Reach our support team by SMS.</p>
                    <div class="contact-detail">Text HELP to 1600 (NTC)</div>
                </div>
            </div>

            <!-- Dean of Students -->
            <div class="contact-card">
                <div class="contact-card-icon">
                    <span class="material-symbols-outlined">person</span>
                </div>
                <div class="contact-card-info">
                    <h3>Dean of Students</h3>
                    <p>Visit during office hours for in-person support.</p>
                    <div class="contact-detail">Administration Building Room 204</div>
                </div>
            </div>

            <!-- Campus Security -->
            <!-- ✅ CHANGED: updated to Nepal Police number -->
            <div class="contact-card">
                <div class="contact-card-icon">
                    <span class="material-symbols-outlined">security</span>
                </div>
                <div class="contact-card-info">
                    <h3>Campus Security</h3>
                    <p>For immediate safety concerns on campus.</p>
                    <div class="contact-detail">100 (Nepal Police) · Available 24/7</div>
                </div>
            </div>

        </div>
    </div>

</div>

<%-- Include the shared footer with emergency exit button --%>
<%@ include file="footer.jsp" %>