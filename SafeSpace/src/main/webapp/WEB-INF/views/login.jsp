<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="SafeSpace Login — Access your anonymous reporting dashboard securely.">
    <title>SafeSpace — Sign In</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@600;700;800&family=Public+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet">

    <style>
        /* ============================================================
           CSS VARIABLES
           ============================================================ */
        :root {
            --primary:              #34666d;
            --primary-dark:         #275961;
            --primary-container:    #b8ebf4;
            --on-primary:           #e7fbff;
            --on-primary-container: #265960;
            --background:           #f8fafa;
            --surface-low:          #f0f4f5;
            --surface-lowest:       #ffffff;
            --surface-high:         #e1eaeb;
            --on-surface:           #2a3435;
            --on-surface-muted:     #566162;
            --on-surface-hint:      #727d7e;
            --error-container:      #fe8983;
            --outline-variant:      #a9b4b5;
        }

        *, *::before, *::after {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Public Sans', sans-serif;
            font-weight: 400;
            color: var(--on-surface);
            background: var(--surface-lowest);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Manrope', sans-serif;
            font-weight: 700;
        }

        a { text-decoration: none; color: inherit; }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        /* ============================================================
           SPLIT LAYOUT
           ============================================================ */
        .login-wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* ---- LEFT PANEL (45%) ---- */
        .login-left {
            width: 45%;
            background: linear-gradient(160deg, #2c5a61 0%, #3a7a82 50%, #2c5a61 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px 48px;
            position: relative;
            overflow: hidden;
        }

        /* Subtle pattern overlay */
        .login-left::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: radial-gradient(circle at 20% 30%, rgba(184,235,244,0.12) 0%, transparent 50%),
                        radial-gradient(circle at 80% 70%, rgba(184,235,244,0.08) 0%, transparent 50%);
            pointer-events: none;
        }

        .login-left-content {
            position: relative;
            z-index: 1;
            text-align: center;
            max-width: 360px;
        }

        .left-icon {
            font-size: 56px;
            color: var(--primary-container);
            margin-bottom: 20px;
            display: block;
        }

        .left-brand {
            font-family: 'Manrope', sans-serif;
            font-weight: 800;
            font-size: 2rem;
            color: var(--on-primary);
            margin-bottom: 12px;
        }

        .left-tagline {
            font-size: 1.1rem;
            color: rgba(231,251,255,0.85);
            font-style: italic;
            margin-bottom: 20px;
        }

        .left-description {
            font-size: 0.9rem;
            color: rgba(231,251,255,0.65);
            line-height: 1.8;
            margin-bottom: 40px;
        }

        .left-stat-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 12px;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            color: var(--primary-container);
            font-weight: 600;
            font-size: 0.85rem;
        }

        .left-stat-badge .material-symbols-outlined {
            font-size: 18px;
        }

        /* ---- RIGHT PANEL (55%) ---- */
        .login-right {
            width: 55%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 48px;
            background: var(--surface-lowest);
        }

        .login-form-container {
            width: 100%;
            max-width: 420px;
            animation: fadeIn 0.5s ease;
        }

        .login-form-container h1 {
            font-size: 1.8rem;
            color: var(--on-surface);
            margin-bottom: 8px;
        }

        .login-form-subtitle {
            font-size: 0.9rem;
            color: var(--on-surface-muted);
            margin-bottom: 36px;
        }

        /* ---- FORM INPUTS ---- */
        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-weight: 500;
            font-size: 0.85rem;
            color: var(--on-surface);
            margin-bottom: 6px;
        }

        .input-with-icon {
            position: relative;
        }

        .input-with-icon .material-symbols-outlined {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
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
            font-size: 0.9rem;
            color: var(--on-surface);
            outline: none;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        .form-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(52,102,109,0.12);
        }

        .form-input::placeholder {
            color: var(--on-surface-hint);
        }

        /* ---- REMEMBER ME & FORGOT ---- */
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.85rem;
            color: var(--on-surface-muted);
            cursor: pointer;
        }

        .remember-me input[type="checkbox"] {
            width: 18px;
            height: 18px;
            border-radius: 4px;
            border: 1.5px solid var(--outline-variant);
            accent-color: var(--primary);
            cursor: pointer;
        }

        .forgot-link {
            font-size: 0.85rem;
            color: var(--primary);
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .forgot-link:hover {
            color: var(--primary-dark);
        }

        /* ---- SUBMIT BUTTON ---- */
        .btn-login {
            width: 100%;
            padding: 14px;
            border-radius: 9999px;
            background: var(--primary);
            color: var(--on-primary);
            font-family: 'Public Sans', sans-serif;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            transition: background 0.2s ease, transform 0.15s ease, box-shadow 0.2s ease;
        }

        .btn-login:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(52,102,109,0.25);
        }

        /* ---- REGISTER LINK ---- */
        .register-link {
            text-align: center;
            margin-top: 24px;
            font-size: 0.875rem;
            color: var(--on-surface-muted);
        }

        .register-link a {
            color: var(--primary);
            font-weight: 600;
            transition: color 0.2s ease;
        }

        .register-link a:hover {
            color: var(--primary-dark);
        }

        /* ---- ALERTS ---- */
        .alert {
            padding: 14px 18px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-error {
            background: #fce4ec;
            color: #c62828;
        }

        .alert-warning {
            background: #fff8e1;
            color: #e65100;
        }

        .alert-success {
            background: #e8f5e9;
            color: #2e7d32;
        }

        /* ---- EMERGENCY EXIT ---- */
        .emergency-exit {
            position: fixed;
            bottom: 28px;
            right: 28px;
            z-index: 9999;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border-radius: 9999px;
            background: var(--error-container);
            color: #fff;
            font-family: 'Public Sans', sans-serif;
            font-weight: 600;
            font-size: 0.875rem;
            box-shadow: 0 4px 20px rgba(254,137,131,0.4);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .emergency-exit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 28px rgba(254,137,131,0.55);
        }

        /* ---- ANIMATIONS ---- */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* ---- RESPONSIVE ---- */
        @media (max-width: 768px) {
            .login-wrapper {
                flex-direction: column;
            }
            .login-left {
                width: 100%;
                padding: 40px 24px;
                min-height: auto;
            }
            .login-right {
                width: 100%;
                padding: 32px 24px;
            }
        }
    </style>
</head>
<body>

<div class="login-wrapper">
    <!-- ============================================================
         LEFT PANEL — Brand & Trust Indicators
         ============================================================ -->
    <div class="login-left">
        <div class="login-left-content">
            <span class="material-symbols-outlined left-icon">shield_with_heart</span>
            <div class="left-brand">SafeSpace</div>
            <div class="left-tagline">A sanctuary for your voice.</div>
            <p class="left-description">
                Report incidents anonymously. Access verified support resources. 
                Your identity remains protected at every step of the process.
            </p>
            <div class="left-stat-badge">
                <span class="material-symbols-outlined">groups</span>
                Trusted by 10,000+ students
            </div>
        </div>
    </div>

    <!-- ============================================================
         RIGHT PANEL — Login Form
         ============================================================ -->
    <div class="login-right">
        <div class="login-form-container">
            <h1>Welcome Back</h1>
            <p class="login-form-subtitle">Sign in to access your secure dashboard</p>

            <%-- Account locked alert — show only when accountLocked attribute is set --%>
            <% if (request.getAttribute("accountLocked") != null && (Boolean) request.getAttribute("accountLocked")) { %>
                <div class="alert alert-warning">
                    <span class="material-symbols-outlined">lock</span>
                    Your account has been temporarily locked due to multiple failed login attempts. 
                    Please contact your administrator or try again later.
                </div>
            <% } %>

            <%-- Error message alert — show only when errorMessage attribute is set --%>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error">
                    <span class="material-symbols-outlined">error</span>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <%-- Success message from registration redirect --%>
            <% if (request.getParameter("registered") != null) { %>
                <div class="alert alert-success">
                    <span class="material-symbols-outlined">check_circle</span>
                    Account created successfully! Please sign in with your credentials.
                </div>
            <% } %>

            <!-- Login form -->
            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">

                <!-- Username field -->
                <div class="form-group">
                    <label class="form-label" for="username">Username</label>
                    <div class="input-with-icon">
                        <span class="material-symbols-outlined">person</span>
                        <input type="text"
                               class="form-input"
                               id="username"
                               name="username"
                               placeholder="Enter your username"
                               required
                               autocomplete="username">
                    </div>
                </div>

                <!-- Password field -->
                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <div class="input-with-icon">
                        <span class="material-symbols-outlined">lock</span>
                        <input type="password"
                               class="form-input"
                               id="password"
                               name="password"
                               placeholder="Enter your password"
                               required
                               autocomplete="current-password">
                    </div>
                </div>

                <!-- Remember me and Forgot Password -->
                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" name="remember"> Remember me
                    </label>
                    <a href="#" class="forgot-link">Forgot Password?</a>
                </div>

                <!-- Sign In button -->
                <button type="submit" class="btn-login" id="login-submit-btn">Sign In</button>
            </form>

            <!-- Link to register -->
            <div class="register-link">
                Don't have an account? <a href="${pageContext.request.contextPath}/register">Create one</a>
            </div>
        </div>
    </div>
</div>

<!-- Emergency exit button -->
<a href="https://www.google.com"
   class="emergency-exit"
   id="quick-exit-btn"
   onclick="window.open('https://www.google.com','_self'); return false;">
    <span class="material-symbols-outlined">close</span>
    Quick Exit
</a>

</body>
</html>
