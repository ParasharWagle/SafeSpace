<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Include the shared header with navbar and CSS design system --%>
<%@ include file="header.jsp" %>

<style>
    /* ============================================================
       HOME PAGE — Hero Section
       ============================================================ */
    .hero {
        padding: 100px 0 80px;
        position: relative;
        overflow: hidden;
    }

    .hero-inner {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 24px;
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
    }

    .hero-badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 20px;
        border-radius: 9999px;
        background: var(--primary-container);
        color: var(--on-primary-container);
        font-size: 0.8rem;
        font-weight: 600;
        margin-bottom: 32px;
        animation: fadeInDown 0.6s ease;
    }

    .hero-badge .material-symbols-outlined {
        font-size: 16px;
    }

    .hero h1 {
        font-family: 'Manrope', sans-serif;
        font-weight: 800;
        font-size: 3.5rem;
        color: var(--on-surface);
        line-height: 1.15;
        margin-bottom: 20px;
        max-width: 720px;
        animation: fadeInUp 0.7s ease;
    }

    .hero h1 .highlight {
        color: var(--primary);
        position: relative;
    }

    .hero-subtitle {
        font-size: 1.15rem;
        color: var(--on-surface-muted);
        max-width: 560px;
        margin-bottom: 40px;
        line-height: 1.8;
        animation: fadeInUp 0.8s ease;
    }

    .hero-buttons {
        display: flex;
        gap: 16px;
        animation: fadeInUp 0.9s ease;
    }

    /* Background decorative blobs */
    .hero::before {
        content: '';
        position: absolute;
        top: -100px;
        right: -80px;
        width: 400px;
        height: 400px;
        background: radial-gradient(circle, rgba(184,235,244,0.4) 0%, transparent 70%);
        border-radius: 50%;
        pointer-events: none;
    }

    .hero::after {
        content: '';
        position: absolute;
        bottom: -60px;
        left: -100px;
        width: 300px;
        height: 300px;
        background: radial-gradient(circle, rgba(52,102,109,0.08) 0%, transparent 70%);
        border-radius: 50%;
        pointer-events: none;
    }

    /* ============================================================
       ETHICAL SHIELD Section
       ============================================================ */
    .ethical-section {
        background: var(--surface-low);
        padding: 80px 0;
    }

    .ethical-inner {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 24px;
        display: flex;
        align-items: center;
        gap: 80px;
    }

    .ethical-content {
        flex: 1;
    }

    .ethical-content h2 {
        font-size: 2.2rem;
        color: var(--on-surface);
        margin-bottom: 16px;
    }

    .ethical-content > p {
        font-size: 1rem;
        color: var(--on-surface-muted);
        line-height: 1.8;
        margin-bottom: 32px;
        max-width: 500px;
    }

    .ethical-checklist {
        list-style: none;
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .ethical-checklist li {
        display: flex;
        align-items: center;
        gap: 14px;
        font-size: 1rem;
        font-weight: 500;
        color: var(--on-surface);
    }

    .ethical-checklist .check-icon {
        width: 36px;
        height: 36px;
        border-radius: 10px;
        background: var(--primary-container);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .ethical-checklist .check-icon .material-symbols-outlined {
        font-size: 20px;
        color: var(--primary);
    }

    .ethical-visual {
        flex: 1;
        display: flex;
        justify-content: center;
    }

    .shield-graphic {
        width: 280px;
        height: 280px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary-container) 0%, rgba(52,102,109,0.15) 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        animation: float 4s ease-in-out infinite;
    }

    .shield-graphic .material-symbols-outlined {
        font-size: 100px;
        color: var(--primary);
    }

    @keyframes float {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-12px); }
    }

    /* ============================================================
       HOW IT WORKS Section
       ============================================================ */
    .how-section {
        padding: 80px 0;
    }

    .how-inner {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 24px;
        text-align: center;
    }

    .how-inner h2 {
        font-size: 2.2rem;
        color: var(--on-surface);
        margin-bottom: 12px;
    }

    .how-inner > p {
        font-size: 1rem;
        color: var(--on-surface-muted);
        margin-bottom: 52px;
    }

    .how-cards {
        display: flex;
        gap: 28px;
        justify-content: center;
        flex-wrap: wrap;
    }

    .how-card {
        background: var(--surface-lowest);
        border-radius: 20px;
        padding: 40px 28px;
        flex: 1;
        min-width: 250px;
        max-width: 340px;
        text-align: center;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .how-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 12px 40px rgba(0,0,0,0.07);
    }

    .how-card-icon {
        width: 64px;
        height: 64px;
        border-radius: 16px;
        background: var(--primary-container);
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
    }

    .how-card-icon .material-symbols-outlined {
        font-size: 30px;
        color: var(--primary);
    }

    .how-card-step {
        font-family: 'Manrope', sans-serif;
        font-weight: 800;
        font-size: 0.75rem;
        color: var(--primary);
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 8px;
    }

    .how-card h3 {
        font-size: 1.2rem;
        color: var(--on-surface);
        margin-bottom: 10px;
    }

    .how-card p {
        font-size: 0.9rem;
        color: var(--on-surface-muted);
        line-height: 1.7;
    }

    /* ============================================================
       ANIMATIONS
       ============================================================ */
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(24px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @keyframes fadeInDown {
        from { opacity: 0; transform: translateY(-16px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* ============================================================
       RESPONSIVE
       ============================================================ */
    @media (max-width: 768px) {
        .hero h1 {
            font-size: 2.2rem;
        }

        .hero-subtitle {
            font-size: 1rem;
        }

        .hero-buttons {
            flex-direction: column;
            width: 100%;
            max-width: 320px;
        }

        .ethical-inner {
            flex-direction: column;
            text-align: center;
            gap: 40px;
        }

        .ethical-content > p {
            max-width: 100%;
        }

        .ethical-checklist {
            align-items: center;
        }

        .how-cards {
            flex-direction: column;
            align-items: center;
        }

        .how-card {
            max-width: 100%;
        }
    }
</style>

<!-- ============================================================
     HERO SECTION
     ============================================================ -->
<section class="hero">
    <div class="hero-inner">
        <!-- Floating trust badge -->
        <div class="hero-badge">
            <span class="material-symbols-outlined">verified_user</span>
            100% Anonymous &mdash; protected by military-grade encryption
        </div>

        <!-- Hero headline with highlighted keyword -->
        <h1>Your safety is our <span class="highlight">priority.</span></h1>

        <!-- Hero subtitle / description -->
        <p class="hero-subtitle">
            A confidential, encrypted platform that empowers you to report incidents 
            and access support — without revealing your identity.
        </p>

        <!-- Call-to-action buttons -->
        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/login" class="btn-primary">
                <span class="material-symbols-outlined">support</span>
                Get Help Now
            </a>
            <a href="#how-it-works" class="btn-outline">
                Learn More
                <span class="material-symbols-outlined">arrow_downward</span>
            </a>
        </div>
    </div>
</section>

<!-- ============================================================
     ETHICAL SHIELD SECTION
     ============================================================ -->
<section class="ethical-section">
    <div class="ethical-inner">
        <div class="ethical-content">
            <h2>An Ethical Shield for<br>Your Education</h2>
            <p>
                SafeSpace is built on the principle that every student deserves a secure 
                channel to raise concerns. Our platform is designed with privacy at its 
                core, ensuring your voice is heard without compromising your safety.
            </p>

            <!-- Checklist items with check icons -->
            <ul class="ethical-checklist">
                <li>
                    <div class="check-icon">
                        <span class="material-symbols-outlined">check</span>
                    </div>
                    Privacy First Architecture
                </li>
                <li>
                    <div class="check-icon">
                        <span class="material-symbols-outlined">check</span>
                    </div>
                    Verified Support Paths
                </li>
                <li>
                    <div class="check-icon">
                        <span class="material-symbols-outlined">check</span>
                    </div>
                    Instant Response
                </li>
            </ul>
        </div>

        <!-- Decorative shield visual -->
        <div class="ethical-visual">
            <div class="shield-graphic">
                <span class="material-symbols-outlined">shield_with_heart</span>
            </div>
        </div>
    </div>
</section>

<!-- ============================================================
     HOW SAFESPACE WORKS SECTION
     ============================================================ -->
<section class="how-section" id="how-it-works">
    <div class="how-inner">
        <h2>How SafeSpace Works</h2>
        <p>Three simple steps to get the support you need, completely anonymously.</p>

        <div class="how-cards">
            <!-- Step 1 -->
            <div class="how-card">
                <div class="how-card-icon">
                    <span class="material-symbols-outlined">edit_document</span>
                </div>
                <div class="how-card-step">Step 1</div>
                <h3>Share Your Story</h3>
                <p>Fill out a secure, anonymous report describing your experience. No personal details required.</p>
            </div>

            <!-- Step 2 -->
            <div class="how-card">
                <div class="how-card-icon">
                    <span class="material-symbols-outlined">encrypted</span>
                </div>
                <div class="how-card-step">Step 2</div>
                <h3>Total Anonymity</h3>
                <p>Your report is encrypted and stripped of identifying information before reaching counselors.</p>
            </div>

            <!-- Step 3 -->
            <div class="how-card">
                <div class="how-card-icon">
                    <span class="material-symbols-outlined">forum</span>
                </div>
                <div class="how-card-step">Step 3</div>
                <h3>Get Support</h3>
                <p>Trained counselors review your case and provide resources, all while protecting your identity.</p>
            </div>
        </div>
    </div>
</section>

<%-- Include the shared footer with emergency exit button --%>
<%@ include file="footer.jsp" %>
