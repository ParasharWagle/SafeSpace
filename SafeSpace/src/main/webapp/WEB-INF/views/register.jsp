<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="SafeSpace Registration — Create your secure anonymous reporting account.">
    <title>SafeSpace — Create Account</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@500;600;700;800&family=Public+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet">

    <style>
        :root {
            --primary:              #10b981;
            --primary-dark:         #059669;
            --primary-darker:       #047857;
            --primary-light:        #34d399;
            --primary-container:    #d1fae5;
            --primary-container-2:  #ecfdf5;
            --on-primary:           #ffffff;
            --on-primary-container: #065f46;
            --accent-deep:          #0f3d36;
            --background:           #f8fafa;
            --surface-low:          #f1f5f9;
            --surface-lowest:       #ffffff;
            --surface-high:         #e2e8f0;
            --on-surface:           #0f172a;
            --on-surface-muted:     #475569;
            --on-surface-hint:      #94a3b8;
            --outline-variant:      #cbd5e1;
            --accent-red-fg:        #ef4444;
            --accent-red-bg:        #fee2e2;
        }
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
        html, body { height: 100%; }
        body {
            font-family: 'Public Sans', sans-serif;
            color: var(--on-surface);
            background: var(--background);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
        }
        h1, h2, h3 { font-family: 'Manrope', sans-serif; line-height: 1.2; letter-spacing: -0.01em; }
        a { text-decoration: none; color: inherit; }

        .auth-layout {
            display: grid;
            grid-template-columns: 1fr 1.1fr;
            min-height: 100vh;
        }

        /* ---- LEFT: brand panel ---- */
        .auth-brand {
            position: relative; overflow: hidden;
            background: linear-gradient(135deg, #0a2e2a 0%, #0f3d36 55%, #134e47 100%);
            color: #fff;
            display: flex; flex-direction: column;
            padding: 48px;
        }
        .auth-brand::before {
            content: ''; position: absolute; inset: 0;
            background:
                radial-gradient(circle at 20% 10%, rgba(16,185,129,0.25) 0%, transparent 45%),
                radial-gradient(circle at 80% 90%, rgba(52,211,153,0.15) 0%, transparent 50%);
            pointer-events: none;
        }
        .auth-brand-logo {
            position: relative; z-index: 2;
            display: flex; align-items: center; gap: 10px;
            font-family: 'Manrope', sans-serif;
            font-weight: 800; font-size: 1.3rem;
        }
        .auth-brand-logo .logo-chip {
            width: 36px; height: 36px;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-darker) 100%);
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 4px 12px rgba(16,185,129,0.35);
        }
        .auth-brand-logo .logo-chip .material-symbols-outlined {
            font-size: 20px; color: #fff;
            font-variation-settings: 'FILL' 1;
        }
        .auth-brand-content {
            position: relative; z-index: 2;
            margin-top: auto;
            max-width: 480px;
        }
        .auth-brand-badge {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 6px 14px;
            border-radius: 9999px;
            background: rgba(0,0,0,0.35);
            border: 1px solid rgba(255,255,255,0.12);
            backdrop-filter: blur(10px);
            font-size: 0.78rem; font-weight: 500;
            margin-bottom: 24px;
        }
        .auth-brand-badge .badge-dot {
            width: 8px; height: 8px; border-radius: 50%;
            background: var(--primary);
        }
        .auth-brand h1 {
            font-size: clamp(2rem, 3.6vw, 2.8rem);
            font-weight: 800;
            margin-bottom: 18px;
        }
        .auth-brand h1 .highlight { color: var(--primary-light); }
        .auth-brand p {
            font-size: 1rem;
            color: rgba(255,255,255,0.78);
            line-height: 1.7;
            margin-bottom: 32px;
            max-width: 420px;
        }
        .benefits-list {
            list-style: none;
            margin-bottom: 32px;
        }
        .benefits-list li {
            display: flex; align-items: flex-start; gap: 12px;
            padding: 10px 0;
            font-size: 0.92rem;
            color: rgba(255,255,255,0.85);
        }
        .benefits-list li .check-icon {
            width: 22px; height: 22px;
            border-radius: 6px;
            background: rgba(16,185,129,0.2);
            color: var(--primary-light);
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .benefits-list li .check-icon .material-symbols-outlined {
            font-size: 14px;
            font-variation-settings: 'FILL' 1, 'wght' 700;
        }

        /* ---- RIGHT: form panel ---- */
        .auth-form-panel {
            display: flex; align-items: center; justify-content: center;
            padding: 48px 40px;
            background: var(--surface-lowest);
        }
        .auth-form-wrap {
            width: 100%;
            max-width: 480px;
        }
        .auth-form-header { margin-bottom: 28px; }
        .auth-form-header h2 {
            font-size: 1.9rem;
            font-weight: 800;
            color: var(--on-surface);
            margin-bottom: 8px;
        }
        .auth-form-header p {
            font-size: 0.95rem;
            color: var(--on-surface-muted);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }
        .form-group { margin-bottom: 16px; }
        .form-label {
            display: block;
            font-weight: 500; font-size: 0.875rem;
            color: var(--on-surface);
            margin-bottom: 8px;
        }
        .input-with-icon { position: relative; }
        .input-with-icon .material-symbols-outlined {
            position: absolute;
            left: 14px; top: 50%; transform: translateY(-50%);
            font-size: 20px;
            color: var(--on-surface-hint);
            pointer-events: none;
        }
        .form-input {
            width: 100%;
            padding: 12px 16px 12px 44px;
            border-radius: 10px;
            border: 1.5px solid var(--outline-variant);
            background: var(--surface-lowest);
            font-family: 'Public Sans', sans-serif;
            font-size: 0.92rem;
            color: var(--on-surface);
            outline: none;
            transition: all 0.2s ease;
        }
        .form-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(16,185,129,0.15);
        }
        .form-input::placeholder { color: var(--on-surface-hint); }

        .toggle-password {
            position: absolute;
            right: 14px; top: 50%; transform: translateY(-50%);
            background: transparent;
            border: none;
            cursor: pointer;
            color: var(--on-surface-hint);
            padding: 4px;
            display: flex;
        }
        .toggle-password:hover { color: var(--primary); }

        .password-hint {
            font-size: 0.75rem;
            color: var(--on-surface-hint);
            margin-top: 6px;
        }

        .btn-primary {
            width: 100%;
            padding: 13px 24px;
            margin-top: 6px;
            border-radius: 10px;
            background: var(--primary);
            color: #fff;
            font-weight: 600; font-size: 0.95rem;
            border: none;
            cursor: pointer;
            display: inline-flex; align-items: center; justify-content: center;
            gap: 8px;
            transition: all 0.2s ease;
            box-shadow: 0 4px 14px rgba(16,185,129,0.3);
            font-family: 'Public Sans', sans-serif;
        }
        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 8px 22px rgba(16,185,129,0.4);
        }

        .terms-agree {
            display: flex; align-items: flex-start; gap: 10px;
            margin: 18px 0 8px;
            font-size: 0.82rem;
            color: var(--on-surface-muted);
            line-height: 1.5;
        }
        .terms-agree input[type="checkbox"] {
            width: 16px; height: 16px;
            margin-top: 2px;
            accent-color: var(--primary);
            flex-shrink: 0;
        }
        .terms-agree a { color: var(--primary); font-weight: 600; }
        .terms-agree a:hover { text-decoration: underline; }

        .auth-footer {
            text-align: center;
            margin-top: 24px;
            font-size: 0.9rem;
            color: var(--on-surface-muted);
        }
        .auth-footer a {
            color: var(--primary);
            font-weight: 600;
        }
        .auth-footer a:hover { text-decoration: underline; }

        .back-home-link {
            position: absolute;
            top: 24px; left: 24px;
            z-index: 3;
            font-size: 0.85rem;
            color: rgba(255,255,255,0.75);
            display: inline-flex; align-items: center; gap: 4px;
        }
        .back-home-link:hover { color: #fff; }
        .back-home-link .material-symbols-outlined { font-size: 18px; }

        .alert {
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 0.85rem;
            margin-bottom: 20px;
            display: flex; align-items: center; gap: 10px;
        }
        .alert-error { background: var(--accent-red-bg); color: #991b1b; }
        .alert .material-symbols-outlined { font-size: 20px; flex-shrink: 0; }

        .emergency-exit {
            position: fixed;
            bottom: 24px; right: 24px;
            z-index: 9999;
            padding: 10px 20px;
            border-radius: 9999px;
            background: var(--accent-red-fg);
            color: #fff;
            font-weight: 600;
            font-size: 0.82rem;
            display: inline-flex; align-items: center; gap: 6px;
            box-shadow: 0 4px 20px rgba(239,68,68,0.4);
            transition: all 0.2s ease;
        }
        .emergency-exit:hover { transform: translateY(-2px); box-shadow: 0 6px 28px rgba(239,68,68,0.55); }
        .emergency-exit .material-symbols-outlined { font-size: 18px; }

        @media (max-width: 960px) {
            .auth-layout { grid-template-columns: 1fr; }
            .auth-brand { min-height: 220px; padding: 48px 32px 32px; }
            .auth-brand-content { margin-top: 16px; }
            .benefits-list { display: none; }
            .auth-form-panel { padding: 40px 24px; }
            .form-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<div class="auth-layout">

    <!-- LEFT: brand -->
    <section class="auth-brand">
        <a href="${pageContext.request.contextPath}/home" class="back-home-link">
            <span class="material-symbols-outlined">arrow_back</span> Back to home
        </a>
        <div class="auth-brand-logo">
            <div class="logo-chip"><span class="material-symbols-outlined">shield_person</span></div>
            SafeSpace
        </div>

        <div class="auth-brand-content">
            <div class="auth-brand-badge">
                <span class="badge-dot"></span>
                100% Anonymous &amp; Encrypted
            </div>
            <h1>Join <span class="highlight">SafeSpace</span> &mdash; your voice matters.</h1>
            <p>Create an account to access anonymous reporting, on-demand counseling,
               and a safer school environment for everyone.</p>

            <ul class="benefits-list">
                <li>
                    <span class="check-icon"><span class="material-symbols-outlined">check</span></span>
                    End-to-end encrypted reports &mdash; identity never revealed
                </li>
                <li>
                    <span class="check-icon"><span class="material-symbols-outlined">check</span></span>
                    Attach photos, screenshots, or links as evidence
                </li>
                <li>
                    <span class="check-icon"><span class="material-symbols-outlined">check</span></span>
                    Direct access to trained counselors &mdash; 24/7
                </li>
                <li>
                    <span class="check-icon"><span class="material-symbols-outlined">check</span></span>
                    FERPA compliant. SOC 2 certified infrastructure.
                </li>
            </ul>
        </div>
    </section>

    <!-- RIGHT: form -->
    <section class="auth-form-panel">
        <div class="auth-form-wrap">
            <div class="auth-form-header">
                <h2>Create your account</h2>
                <p>It takes less than a minute. Your identity stays anonymous.</p>
            </div>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error">
                    <span class="material-symbols-outlined">error</span>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <%-- ACTION and FIELD NAMES preserved exactly as RegisterServlet expects --%>
            <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">

                <div class="form-group">
                    <label class="form-label" for="fullName">Full Name</label>
                    <div class="input-with-icon">
                        <span class="material-symbols-outlined">badge</span>
                        <input type="text" class="form-input" id="fullName" name="fullName"
                               placeholder="Your full name" autocomplete="name" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="studentId">Student ID</label>
                        <div class="input-with-icon">
                            <span class="material-symbols-outlined">tag</span>
                            <input type="text" class="form-input" id="studentId" name="studentId"
                                   placeholder="e.g. IC12345" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="phone">Phone</label>
                        <div class="input-with-icon">
                            <span class="material-symbols-outlined">call</span>
                            <input type="tel" class="form-input" id="phone" name="phone"
                                   placeholder="98XXXXXXXX" autocomplete="tel" required>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="username">Username</label>
                    <div class="input-with-icon">
                        <span class="material-symbols-outlined">person</span>
                        <input type="text" class="form-input" id="username" name="username"
                               placeholder="Choose a username" autocomplete="username" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <div class="input-with-icon">
                        <span class="material-symbols-outlined">lock</span>
                        <input type="password" class="form-input" id="password" name="password"
                               placeholder="Create a strong password" autocomplete="new-password" required>
                        <button type="button" class="toggle-password" onclick="togglePassword()">
                            <span class="material-symbols-outlined" id="toggleIcon">visibility</span>
                        </button>
                    </div>
                    <p class="password-hint">Use 8+ characters with a mix of letters, numbers &amp; symbols.</p>
                </div>

                <label class="terms-agree">
                    <input type="checkbox" required>
                    <span>I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>.
                          I understand my reports remain anonymous.</span>
                </label>

                <button type="submit" class="btn-primary">
                    Create My Account
                    <span class="material-symbols-outlined">arrow_forward</span>
                </button>
            </form>

            <div class="auth-footer">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login">Sign in instead</a>
            </div>
        </div>
    </section>
</div>

<a href="https://www.google.com" class="emergency-exit">
    <span class="material-symbols-outlined">exit_to_app</span>
    Exit
</a>

<script>
    function togglePassword() {
        var input = document.getElementById('password');
        var icon  = document.getElementById('toggleIcon');
        if (input.type === 'password') { input.type = 'text'; icon.textContent = 'visibility_off'; }
        else                           { input.type = 'password'; icon.textContent = 'visibility'; }
    }
</script>
</body>
</html>
