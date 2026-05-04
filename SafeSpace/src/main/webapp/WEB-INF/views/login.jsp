<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="SafeSpace Login — Access your anonymous reporting dashboard securely.">
    <title>SafeSpace — Sign In</title>

    <!-- Fonts -->
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
            --accent-mid:           #1a5b52;

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

        /* ============================================================
           LAYOUT — split screen
           ============================================================ */
        .auth-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            min-height: 100vh;
        }

        /* ---- LEFT: brand / marketing panel ---- */
        .auth-brand {
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, #0a2e2a 0%, #0f3d36 55%, #134e47 100%);
            color: #fff;
            display: flex; flex-direction: column;
            padding: 48px;
        }
        .auth-brand::before {
            content: '';
            position: absolute; inset: 0;
            background:
                radial-gradient(circle at 20% 10%, rgba(16,185,129,0.25) 0%, transparent 45%),
                radial-gradient(circle at 80% 90%, rgba(52,211,153,0.15) 0%, transparent 50%);
            pointer-events: none;
        }
        .auth-brand-logo {
            position: relative; z-index: 2;
            display: flex; align-items: center; gap: 10px;
            font-family: 'Manrope', sans-serif;
            font-weight: 800;
            font-size: 1.3rem;
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
            animation: pulse-dot 2s infinite;
        }
        @keyframes pulse-dot {
            0%   { box-shadow: 0 0 0 0 rgba(16,185,129,0.7); }
            70%  { box-shadow: 0 0 0 8px rgba(16,185,129,0); }
            100% { box-shadow: 0 0 0 0 rgba(16,185,129,0); }
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

        .brand-stats {
            display: flex; gap: 40px;
            padding-top: 24px;
            border-top: 1px solid rgba(255,255,255,0.1);
        }
        .brand-stat-value {
            font-family: 'Manrope', sans-serif;
            font-weight: 800;
            font-size: 1.6rem;
            color: var(--primary-light);
            line-height: 1;
            margin-bottom: 4px;
        }
        .brand-stat-label { font-size: 0.78rem; color: rgba(255,255,255,0.65); }

        /* ---- RIGHT: form panel ---- */
        .auth-form-panel {
            display: flex; align-items: center; justify-content: center;
            padding: 48px 40px;
            background: var(--surface-lowest);
        }
        .auth-form-wrap {
            width: 100%;
            max-width: 420px;
        }
        .auth-form-header { margin-bottom: 32px; }
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

        .form-group { margin-bottom: 18px; }
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
            padding: 13px 16px 13px 44px;
            border-radius: 10px;
            border: 1.5px solid var(--outline-variant);
            background: var(--surface-lowest);
            font-family: 'Public Sans', sans-serif;
            font-size: 0.92rem;
            color: var(--on-surface);
            outline: none;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
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
            display: flex; align-items: center;
        }
        .toggle-password:hover { color: var(--primary); }

        .form-row-between {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 24px;
            font-size: 0.85rem;
        }
        .form-row-between label {
            display: inline-flex; align-items: center; gap: 8px;
            color: var(--on-surface-muted);
            cursor: pointer;
        }
        .form-row-between label input[type="checkbox"] {
            width: 15px; height: 15px;
            accent-color: var(--primary);
        }
        .form-row-between a { color: var(--primary); font-weight: 600; }
        .form-row-between a:hover { text-decoration: underline; }

        .btn-primary {
            width: 100%;
            padding: 13px 24px;
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

        .auth-divider {
            display: flex; align-items: center; gap: 14px;
            margin: 28px 0;
            font-size: 0.78rem;
            color: var(--on-surface-hint);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .auth-divider::before, .auth-divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: var(--surface-high);
        }

        .auth-footer {
            text-align: center;
            font-size: 0.9rem;
            color: var(--on-surface-muted);
        }
        .auth-footer a {
            color: var(--primary);
            font-weight: 600;
        }
        .auth-footer a:hover { text-decoration: underline; }

        /* Top-bar back-to-home link (visible on mobile) */
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

        /* Alerts */
        .alert {
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 0.85rem;
            margin-bottom: 20px;
            display: flex; align-items: center; gap: 10px;
        }
        .alert-error { background: var(--accent-red-bg); color: #991b1b; }
        .alert-success { background: var(--primary-container); color: var(--on-primary-container); }
        .alert .material-symbols-outlined { font-size: 20px; flex-shrink: 0; }

        /* Emergency Exit */
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
        .emergency-exit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 28px rgba(239,68,68,0.55);
        }
        .emergency-exit .material-symbols-outlined { font-size: 18px; }

        /* Responsive */
        @media (max-width: 960px) {
            .auth-layout { grid-template-columns: 1fr; }
            .auth-brand { min-height: 200px; padding: 48px 32px 32px; }
            .auth-brand-content { margin-top: 16px; }
            .brand-stats { display: none; }
            .auth-form-panel { padding: 40px 24px; }
        }
        @media (max-width: 640px) {
            .auth-brand h1 { font-size: 1.5rem; }
            .auth-brand p { display: none; }
            .auth-brand { min-height: 140px; }
        }
    </style>
</head>
<body>

<div class="auth-layout">

    <!-- LEFT: brand panel -->
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
                Trusted by 500+ Schools
            </div>
            <h1>Welcome back.<br><span class="highlight">Report safely.</span> Get help instantly.</h1>
            <p>Log in to submit anonymous reports, attach evidence securely,
               and stay connected with trained counselors at your school.</p>

            <div class="brand-stats">
                <div><div class="brand-stat-value">10K+</div><div class="brand-stat-label">Students Protected</div></div>
                <div><div class="brand-stat-value">94%</div><div class="brand-stat-label">Resolution Rate</div></div>
                <div><div class="brand-stat-value">24/7</div><div class="brand-stat-label">Counselor Access</div></div>
            </div>
        </div>
    </section>

    <!-- RIGHT: form panel -->
    <section class="auth-form-panel">
        <div class="auth-form-wrap">
            <div class="auth-form-header">
                <h2>Sign in to your account</h2>
                <p>Enter your credentials to continue.</p>
            </div>

            <%-- "Just registered" flash (RegisterServlet redirects with ?registered=true) --%>
            <% if ("true".equals(request.getParameter("registered"))) { %>
                <div class="alert alert-success">
                    <span class="material-symbols-outlined">check_circle</span>
                    Registration successful! You can now sign in with your credentials.
                </div>
            <% } %>

            <%-- "Just reset password" flash (ResetPasswordServlet redirects with ?reset=true) --%>
            <% if ("true".equals(request.getParameter("reset"))) { %>
                <div class="alert alert-success">
                    <span class="material-symbols-outlined">check_circle</span>
                    Your password has been updated. Please sign in with your new password.
                </div>
            <% } %>

            <%-- Locked-account message (set by LoginServlet after 3 failed attempts) --%>
            <% if (request.getAttribute("accountLocked") != null && (Boolean) request.getAttribute("accountLocked")) { %>
                <div class="alert alert-error">
                    <span class="material-symbols-outlined">lock</span>
                    Your account has been temporarily locked due to failed login attempts. Please try again later.
                </div>
            <% } %>

            <%-- Standard error message --%>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error">
                    <span class="material-symbols-outlined">error</span>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <%-- Login form — ACTION & FIELD NAMES UNCHANGED --%>
            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">

                <div class="form-group">
                    <label class="form-label" for="username">Username</label>
                    <div class="input-with-icon">
                        <span class="material-symbols-outlined">person</span>
                        <input type="text"
                               class="form-input"
                               id="username"
                               name="username"
                               placeholder="your.username"
                               autocomplete="username"
                               required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <div class="input-with-icon">
                        <span class="material-symbols-outlined">lock</span>
                        <input type="password"
                               class="form-input"
                               id="password"
                               name="password"
                               placeholder="Enter your password"
                               autocomplete="current-password"
                               required>
                        <button type="button" class="toggle-password" onclick="togglePassword()">
                            <span class="material-symbols-outlined" id="toggleIcon">visibility</span>
                        </button>
                    </div>
                </div>

                <div class="form-row-between">
                    <label>
                        <input type="checkbox" name="remember"> Remember me
                    </label>
                    <a href="${pageContext.request.contextPath}/forgot-password">Forgot password?</a>
                </div>

                <button type="submit" class="btn-primary">
                    Sign In
                    <span class="material-symbols-outlined">arrow_forward</span>
                </button>
            </form>

            <div class="auth-divider">New to SafeSpace?</div>

            <div class="auth-footer">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/register">Create one here</a>
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
        else                          { input.type = 'password'; icon.textContent = 'visibility'; }
    }
</script>
</body>
</html>
