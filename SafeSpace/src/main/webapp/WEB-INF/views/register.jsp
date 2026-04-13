<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="SafeSpace Registration — Create your secure anonymous reporting account.">
    <title>SafeSpace — Create Account</title>

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

        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Public Sans', sans-serif;
            font-weight: 400;
            color: var(--on-surface);
            background: var(--surface-lowest);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
        }

        h1, h2, h3, h4 { font-family: 'Manrope', sans-serif; font-weight: 700; }
        a { text-decoration: none; color: inherit; }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        /* ============================================================
           SPLIT LAYOUT
           ============================================================ */
        .register-wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* ---- LEFT PANEL (45%) ---- */
        .register-left {
            width: 45%;
            background: linear-gradient(160deg, #2c5a61 0%, #3a7a82 50%, #2c5a61 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px 40px;
            position: relative;
            overflow: hidden;
        }

        .register-left::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: radial-gradient(circle at 30% 20%, rgba(184,235,244,0.1) 0%, transparent 50%),
                        radial-gradient(circle at 70% 80%, rgba(184,235,244,0.06) 0%, transparent 50%);
            pointer-events: none;
        }

        .left-features {
            position: relative;
            z-index: 1;
            display: flex;
            flex-direction: column;
            gap: 24px;
            max-width: 340px;
        }

        .feature-card {
            background: rgba(255,255,255,0.08);
            backdrop-filter: blur(12px);
            border-radius: 16px;
            padding: 24px;
            display: flex;
            align-items: flex-start;
            gap: 16px;
            transition: transform 0.3s ease, background 0.3s ease;
        }

        .feature-card:hover {
            transform: translateX(6px);
            background: rgba(255,255,255,0.12);
        }

        .feature-card-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: rgba(184,235,244,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .feature-card-icon .material-symbols-outlined {
            font-size: 24px;
            color: var(--primary-container);
        }

        .feature-card h3 {
            font-size: 1rem;
            color: var(--on-primary);
            margin-bottom: 4px;
        }

        .feature-card p {
            font-size: 0.82rem;
            color: rgba(231,251,255,0.6);
            line-height: 1.6;
        }

        /* ---- RIGHT PANEL (55%) ---- */
        .register-right {
            width: 55%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 48px;
            background: var(--surface-lowest);
        }

        .register-form-container {
            width: 100%;
            max-width: 440px;
            animation: fadeIn 0.5s ease;
        }

        .register-form-container h1 {
            font-size: 1.8rem;
            color: var(--on-surface);
            margin-bottom: 8px;
        }

        .register-form-subtitle {
            font-size: 0.9rem;
            color: var(--on-surface-muted);
            margin-bottom: 32px;
        }

        /* ---- FORM INPUTS ---- */
        .form-group { margin-bottom: 18px; }

        .form-label {
            display: block;
            font-weight: 500;
            font-size: 0.85rem;
            color: var(--on-surface);
            margin-bottom: 6px;
        }

        .form-input {
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

        .form-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(52,102,109,0.12);
        }

        .form-input::placeholder { color: var(--on-surface-hint); }

        .form-hint {
            font-size: 0.78rem;
            color: var(--on-surface-hint);
            margin-top: 4px;
        }

        /* ---- SUBMIT BUTTON ---- */
        .btn-register {
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
            margin-top: 8px;
            transition: background 0.2s ease, transform 0.15s ease, box-shadow 0.2s ease;
        }

        .btn-register:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(52,102,109,0.25);
        }

        /* ---- LINKS & NOTES ---- */
        .login-link {
            text-align: center;
            margin-top: 24px;
            font-size: 0.875rem;
            color: var(--on-surface-muted);
        }

        .login-link a {
            color: var(--primary);
            font-weight: 600;
            transition: color 0.2s ease;
        }

        .login-link a:hover { color: var(--primary-dark); }

        .privacy-note {
            text-align: center;
            margin-top: 16px;
            font-size: 0.78rem;
            color: var(--on-surface-hint);
        }

        .privacy-note a {
            color: var(--primary);
            font-weight: 500;
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

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .register-wrapper { flex-direction: column; }
            .register-left { width: 100%; padding: 40px 24px; }
            .register-right { width: 100%; padding: 32px 24px; }
        }
    </style>
</head>
<body>

<div class="register-wrapper">
    <!-- ============================================================
         LEFT PANEL — Feature Cards
         ============================================================ -->
    <div class="register-left">
        <div class="left-features">
            <!-- Feature 1: Privacy -->
            <div class="feature-card">
                <div class="feature-card-icon">
                    <span class="material-symbols-outlined">lock</span>
                </div>
                <div>
                    <h3>End-to-End Privacy</h3>
                    <p>Your reports are encrypted and anonymised before they reach any counselor.</p>
                </div>
            </div>

            <!-- Feature 2: Access -->
            <div class="feature-card">
                <div class="feature-card-icon">
                    <span class="material-symbols-outlined">bolt</span>
                </div>
                <div>
                    <h3>Instant Access</h3>
                    <p>Create your account in seconds and start submitting reports immediately.</p>
                </div>
            </div>

            <!-- Feature 3: Security -->
            <div class="feature-card">
                <div class="feature-card-icon">
                    <span class="material-symbols-outlined">shield</span>
                </div>
                <div>
                    <h3>Secure Campus</h3>
                    <p>Help build a safer campus community through anonymous incident reporting.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- ============================================================
         RIGHT PANEL — Registration Form
         ============================================================ -->
    <div class="register-right">
        <div class="register-form-container">
            <h1>Create your account</h1>
            <p class="register-form-subtitle">Join SafeSpace and start reporting anonymously</p>

            <%-- Error message alert --%>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error">
                    <span class="material-symbols-outlined">error</span>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <!-- Registration form -->
            <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">

                <!-- Full Name -->
                <div class="form-group">
                    <label class="form-label" for="fullName">Full Name</label>
                    <input type="text" class="form-input" id="fullName" name="fullName"
                           placeholder="Enter your full name" required>
                </div>

                <!-- Username -->
                <div class="form-group">
                    <label class="form-label" for="username">Username</label>
                    <input type="text" class="form-input" id="username" name="username"
                           placeholder="Choose a username" required>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <input type="password" class="form-input" id="password" name="password"
                           placeholder="Create a password" required>
                </div>

                <!-- Student ID -->
                <div class="form-group">
                    <label class="form-label" for="studentId">Student ID</label>
                    <input type="text" class="form-input" id="studentId" name="studentId"
                           placeholder="e.g. STU-2024-0042" required>
                    <div class="form-hint">Must be the official ID issued by your registrar</div>
                </div>

                <!-- Phone Number -->
                <div class="form-group">
                    <label class="form-label" for="phone">Phone Number</label>
                    <input type="tel" class="form-input" id="phone" name="phone"
                           placeholder="Enter your phone number" required>
                </div>

                <!-- Create Account button -->
                <button type="submit" class="btn-register" id="register-submit-btn">Create Account</button>
            </form>

            <!-- Login link -->
            <div class="login-link">
                Already have an account? <a href="${pageContext.request.contextPath}/login">Log in</a>
            </div>

            <!-- Privacy note -->
            <div class="privacy-note">
                By clicking Create Account you agree to our <a href="#">Terms of Service</a>
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
