<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% request.setAttribute("navMode",   "solid"); %>
<% request.setAttribute("activeNav", "home"); %>
<%@ include file="header.jsp" %>

<style>
    .contact-hero {
        background: linear-gradient(135deg, var(--primary-container-2) 0%, var(--surface-lowest) 100%);
        padding: 60px 24px 40px;
    }
    .contact-hero-inner {
        max-width: 1200px; margin: 0 auto;
        text-align: center;
    }
    .contact-hero .section-eyebrow {
        display: inline-block;
        font-size: 0.78rem; font-weight: 700;
        color: var(--primary);
        text-transform: uppercase;
        letter-spacing: 1.5px;
        margin-bottom: 12px;
    }
    .contact-hero h1 {
        font-family: 'Manrope', sans-serif;
        font-size: clamp(2rem, 4vw, 3rem);
        font-weight: 800;
        margin-bottom: 14px;
    }
    .contact-hero p {
        font-size: 1.02rem;
        color: var(--on-surface-muted);
        max-width: 640px;
        margin: 0 auto;
    }

    .contact-wrap {
        max-width: 1200px;
        margin: 0 auto;
        padding: 60px 24px 100px;
        display: grid;
        grid-template-columns: 1fr 1.4fr;
        gap: 32px;
    }

    /* ---- Left: contact info cards ---- */
    .contact-info-col {
        display: flex; flex-direction: column; gap: 14px;
    }
    .info-card {
        background: var(--surface-lowest);
        border-radius: 16px;
        padding: 22px 24px;
        border: 1px solid var(--surface-high);
        display: flex; gap: 16px; align-items: flex-start;
        transition: all 0.2s ease;
    }
    .info-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 22px rgba(16,185,129,0.08);
        border-color: var(--primary-container);
    }
    .info-icon {
        width: 44px; height: 44px;
        border-radius: 12px;
        display: flex; align-items: center; justify-content: center;
        flex-shrink: 0;
    }
    .info-icon .material-symbols-outlined { font-size: 22px; }
    .info-card.green  .info-icon { background: var(--accent-green-bg); color: var(--accent-green-fg); }
    .info-card.blue   .info-icon { background: var(--accent-blue-bg);  color: var(--accent-blue-fg); }
    .info-card.amber  .info-icon { background: var(--accent-amber-bg); color: var(--accent-amber-fg); }
    .info-card.red    .info-icon { background: var(--accent-red-bg);   color: var(--accent-red-fg); }

    .info-card h3 {
        font-size: 0.98rem;
        font-weight: 700;
        color: var(--on-surface);
        margin-bottom: 4px;
    }
    .info-card p {
        font-size: 0.85rem;
        color: var(--on-surface-muted);
        margin-bottom: 6px;
    }
    .info-card a {
        display: inline-block;
        font-size: 0.88rem;
        color: var(--primary);
        font-weight: 600;
    }
    .info-card a:hover { text-decoration: underline; }

    /* Campus help strip (gradient bottom card) */
    .campus-help {
        margin-top: 8px;
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-darker) 100%);
        color: #fff;
        border-radius: 16px;
        padding: 24px;
        box-shadow: 0 8px 24px rgba(16,185,129,0.25);
    }
    .campus-help h3 { font-size: 1.05rem; margin-bottom: 8px; }
    .campus-help p { font-size: 0.85rem; opacity: 0.9; line-height: 1.6; margin-bottom: 14px; }
    .campus-help .helpline {
        display: inline-flex; align-items: center; gap: 8px;
        padding: 8px 16px;
        border-radius: 9999px;
        background: rgba(255,255,255,0.15);
        backdrop-filter: blur(10px);
        font-weight: 700; font-size: 0.9rem;
    }

    /* ---- Right: form card ---- */
    .contact-form-card {
        background: var(--surface-lowest);
        border-radius: 20px;
        padding: 36px;
        border: 1px solid var(--surface-high);
    }
    .contact-form-card h2 {
        font-size: 1.4rem;
        font-weight: 800;
        color: var(--on-surface);
        margin-bottom: 6px;
    }
    .contact-form-card .sub {
        font-size: 0.92rem;
        color: var(--on-surface-muted);
        margin-bottom: 24px;
    }

    .form-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 14px;
    }

    .form-actions {
        margin-top: 8px;
    }
    .btn-primary {
        padding: 13px 28px;
        border-radius: 10px;
        background: var(--primary);
        color: #fff;
        font-weight: 600; font-size: 0.92rem;
        border: none;
        cursor: pointer;
        display: inline-flex; align-items: center; gap: 8px;
        transition: all 0.2s ease;
        box-shadow: 0 4px 14px rgba(16,185,129,0.3);
    }
    .btn-primary:hover {
        background: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 8px 22px rgba(16,185,129,0.4);
    }

    @media (max-width: 900px) {
        .contact-wrap { grid-template-columns: 1fr; }
        .form-row { grid-template-columns: 1fr; }
    }
</style>

<section class="contact-hero">
    <div class="contact-hero-inner">
        <div class="section-eyebrow">Contact Us</div>
        <h1>We're Here When You Need Us</h1>
        <p>Reach out for support, share feedback, or ask a question. Your message reaches our
           trained team directly &mdash; and everything stays confidential.</p>
    </div>
</section>

<div class="contact-wrap">

    <!-- Left: info cards -->
    <div class="contact-info-col">
        <div class="info-card green">
            <div class="info-icon"><span class="material-symbols-outlined">mail</span></div>
            <div>
                <h3>Email Support</h3>
                <p>For non-urgent inquiries &mdash; reply within 24 hours.</p>
                <a href="mailto:support@safespace.edu.np">support@safespace.edu.np</a>
            </div>
        </div>
        <div class="info-card blue">
            <div class="info-icon"><span class="material-symbols-outlined">chat</span></div>
            <div>
                <h3>Live Chat</h3>
                <p>Talk to a counselor instantly during school hours.</p>
                <a href="#">Start Chat &rarr;</a>
            </div>
        </div>
        <div class="info-card amber">
            <div class="info-icon"><span class="material-symbols-outlined">schedule</span></div>
            <div>
                <h3>Office Hours</h3>
                <p>Sun &ndash; Fri &bull; 9:00 AM &ndash; 5:00 PM (NPT)</p>
                <a href="#">View Calendar &rarr;</a>
            </div>
        </div>
        <div class="info-card red">
            <div class="info-icon"><span class="material-symbols-outlined">emergency</span></div>
            <div>
                <h3>Emergency Line</h3>
                <p>For urgent safety issues &mdash; available 24/7.</p>
                <a href="tel:100">Call Nepal Police: 100</a>
            </div>
        </div>

        <div class="campus-help">
            <h3>On-Campus Crisis Support</h3>
            <p>Islington College has trained counselors on site. If you need immediate help,
               walk-ins are welcome at the Student Wellness Office.</p>
            <span class="helpline">
                <span class="material-symbols-outlined">phone_in_talk</span>
                +977 1-5555555
            </span>
        </div>
    </div>

    <!-- Right: form -->
    <div class="contact-form-card">
        <h2>Send us a message</h2>
        <p class="sub">Whether it's feedback, questions, or concerns &mdash; we read every one.</p>

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

        <%-- ACTION and FIELD NAMES preserved exactly as ContactServlet expects --%>
        <form action="${pageContext.request.contextPath}/contact" method="post" id="contactForm">

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label" for="name">Your Name</label>
                    <input type="text" class="form-input" id="name" name="name"
                           placeholder="Full name" required
                           style="padding-left: 16px;">
                </div>
                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input type="email" class="form-input" id="email" name="email"
                           placeholder="you@example.com" required
                           style="padding-left: 16px;">
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="category">Reason for contact</label>
                <select class="form-select" id="category" name="category">
                    <option value="General Inquiry">General Inquiry</option>
                    <option value="Technical Support">Technical Support</option>
                    <option value="Counseling Request">Counseling Request</option>
                    <option value="Feedback">Feedback</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label" for="message">Message</label>
                <textarea class="form-textarea" id="message" name="message"
                          placeholder="How can we help you today?"
                          rows="6" required></textarea>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-primary">
                    <span class="material-symbols-outlined">send</span>
                    Send Message
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>
