<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SafeSpace — Forgot Password</title>

    <!-- Same fonts as the rest of the app, so visual style matches login.jsp -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@500;600;700;800&family=Public+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet">

    <style>
        :root {
            --primary:              #10b981;
            --primary-dark:         #059669;
            --primary-darker:       #047857;
            --primary-container-2:  #ecfdf5;
            --background:           #f8fafa;
            --surface-lowest:       #ffffff;
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
            background: linear-gradient(135deg, #ecfdf5 0%, #f8fafa 60%, #e6f7f1 100%);
            line-height: 1.6;
            display: flex; align-items: center; justify-content: center;
            padding: 24px;
            min-height: 100vh;
        }
        h1, h2 { font-family: 'Manrope', sans-serif; line-height: 1.2; }

        .panel {
            background: var(--surface-lowest);
            border-radius: 20px;
            padding: 40px 36px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.08);
            max-width: 460px; width: 100%;
        }
        .brand {
            display: flex; align-items: center; gap: 10px;
            margin-bottom: 24px;
            font-family: 'Manrope', sans-serif;
            font-weight: 800; font-size: 1.2rem;
            color: var(--primary-darker);
        }
        .brand .logo-chip {
            width: 36px; height: 36px;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-darker) 100%);
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 4px 12px rgba(16,185,129,0.35);
        }
        .brand .logo-chip .material-symbols-outlined {
            font-size: 20px; color: #fff;
            font-variation-settings: 'FILL' 1;
        }

        h1 { font-size: 1.6rem; font-weight: 700; margin-bottom: 8px; }
        .subtitle { color: var(--on-surface-muted); font-size: 0.95rem; margin-bottom: 28px; }

        /* Banners */
        .banner {
            display: flex; gap: 10px; align-items: flex-start;
            padding: 14px 16px; border-radius: 12px;
            font-size: 0.9rem; margin-bottom: 20px;
        }
        .banner.error  { background: var(--accent-red-bg); color: #991b1b; }
        .banner.success{ background: var(--primary-container-2); color: var(--primary-darker); }
        .banner .material-symbols-outlined { font-size: 20px; flex-shrink: 0; }

        /* Form */
        .form-group { margin-bottom: 18px; }
        .form-label {
            display: block; font-size: 0.85rem; font-weight: 600;
            color: var(--on-surface); margin-bottom: 8px;
        }
        .input-wrap {
            position: relative;
            display: flex; align-items: center;
        }
        .input-wrap > .material-symbols-outlined {
            position: absolute; left: 14px;
            color: var(--on-surface-hint);
            font-size: 20px;
        }
        .form-input {
            width: 100%;
            padding: 12px 14px 12px 44px;
            border: 1.5px solid var(--outline-variant);
            border-radius: 12px;
            font-family: 'Public Sans', sans-serif;
            font-size: 0.95rem;
            background: var(--surface-lowest);
            color: var(--on-surface);
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }
        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(16,185,129,0.18);
        }

        .btn-primary {
            width: 100%;
            padding: 13px 18px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-darker) 100%);
            color: #fff;
            font-family: 'Manrope', sans-serif;
            font-weight: 700; font-size: 0.95rem;
            cursor: pointer;
            display: flex; align-items: center; justify-content: center; gap: 8px;
            transition: transform 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 4px 14px rgba(16,185,129,0.35);
        }
        .btn-primary:hover { transform: translateY(-1px); box-shadow: 0 6px 18px rgba(16,185,129,0.45); }
        .btn-primary .material-symbols-outlined { font-size: 18px; }

        .footer-link {
            margin-top: 24px;
            text-align: center;
            font-size: 0.9rem;
            color: var(--on-surface-muted);
        }
        .footer-link a { color: var(--primary-darker); font-weight: 600; }
        .footer-link a:hover { text-decoration: underline; }

        /* Reset link panel shown after a successful POST */
        .reset-link-panel {
            background: var(--primary-container-2);
            border: 1px dashed var(--primary);
            border-radius: 12px;
            padding: 14px;
            margin: 16px 0;
            font-size: 0.85rem;
            word-break: break-all;
        }
        .reset-link-panel .reset-link-label {
            display: block;
            font-weight: 600;
            color: var(--primary-darker);
            margin-bottom: 6px;
            font-size: 0.78rem;
            letter-spacing: 0.4px;
            text-transform: uppercase;
        }
        .reset-link-panel a {
            color: var(--primary-darker);
            font-weight: 600;
        }
        .reset-link-panel a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="panel">
        <div class="brand">
            <div class="logo-chip"><span class="material-symbols-outlined">shield</span></div>
            SafeSpace
        </div>

        <h1>Forgot your password?</h1>
        <p class="subtitle">
            Enter your username or student identifier and we will generate a
            secure reset link.
        </p>

        <%-- Error banner --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="banner error">
                <span class="material-symbols-outlined">error</span>
                <span><%= request.getAttribute("errorMessage") %></span>
            </div>
        <% } %>

        <%-- Success banner --%>
        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="banner success">
                <span class="material-symbols-outlined">check_circle</span>
                <span><%= request.getAttribute("successMessage") %></span>
            </div>
        <% } %>

        <%-- Reset link panel (only shown when token was generated)
             In production this would be e mailed instead. --%>
        <% if (request.getAttribute("resetUrl") != null) {
              String url = (String) request.getAttribute("resetUrl"); %>
            <div class="reset-link-panel">
                <span class="reset-link-label">Your reset link</span>
                <a href="<%= url %>"><%= url %></a>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-group">
                <label class="form-label" for="identifier">Username or Student ID</label>
                <div class="input-wrap">
                    <span class="material-symbols-outlined">person</span>
                    <input type="text"
                           class="form-input"
                           id="identifier"
                           name="identifier"
                           placeholder="e.g. student1 or NP01CP4A2400XX"
                           autocomplete="username"
                           required
                           autofocus>
                </div>
            </div>

            <button type="submit" class="btn-primary">
                Send reset link
                <span class="material-symbols-outlined">arrow_forward</span>
            </button>
        </form>

        <div class="footer-link">
            Remembered your password?
            <a href="${pageContext.request.contextPath}/login">Back to sign in</a>
        </div>
    </div>
</body>
</html>
