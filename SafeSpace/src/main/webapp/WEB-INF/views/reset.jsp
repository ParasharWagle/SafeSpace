<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SafeSpace — Reset Password</title>

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
        .username-chip {
            display: inline-flex; align-items: center; gap: 6px;
            background: var(--primary-container-2);
            color: var(--primary-darker);
            padding: 4px 12px;
            border-radius: 9999px;
            font-size: 0.82rem;
            font-weight: 600;
            margin-bottom: 18px;
        }
        .username-chip .material-symbols-outlined { font-size: 16px; }

        .banner {
            display: flex; gap: 10px; align-items: flex-start;
            padding: 14px 16px; border-radius: 12px;
            font-size: 0.9rem; margin-bottom: 20px;
        }
        .banner.error { background: var(--accent-red-bg); color: #991b1b; }
        .banner.success { background: var(--primary-container-2); color: var(--primary-darker); }
        .banner .material-symbols-outlined { font-size: 20px; flex-shrink: 0; }

        .form-group { margin-bottom: 18px; }
        .form-label {
            display: block; font-size: 0.85rem; font-weight: 600;
            color: var(--on-surface); margin-bottom: 8px;
        }
        .input-wrap {
            position: relative;
            display: flex; align-items: center;
        }
        .input-wrap > .material-symbols-outlined.left-icon {
            position: absolute; left: 14px;
            color: var(--on-surface-hint);
            font-size: 20px;
        }
        .form-input {
            width: 100%;
            padding: 12px 44px 12px 44px;
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
        .toggle-password {
            position: absolute; right: 10px;
            background: none; border: none;
            cursor: pointer; color: var(--on-surface-hint);
            display: flex; align-items: center; justify-content: center;
            padding: 6px;
        }
        .toggle-password:hover { color: var(--primary-darker); }

        .password-hint {
            font-size: 0.78rem;
            color: var(--on-surface-hint);
            margin-top: 6px;
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
    </style>
</head>
<body>
    <div class="panel">
        <div class="brand">
            <div class="logo-chip"><span class="material-symbols-outlined">key</span></div>
            SafeSpace
        </div>

        <%
            String token = (String) request.getAttribute("token");
            String username = (String) request.getAttribute("username");
            String errorMessage = (String) request.getAttribute("errorMessage");
            boolean tokenValid = (token != null);
        %>

        <% if (!tokenValid && errorMessage != null) { %>
            <%-- Token invalid / expired — show error and a link back --%>
            <h1>Link expired</h1>
            <p class="subtitle">This password reset link is no longer valid.</p>

            <div class="banner error">
                <span class="material-symbols-outlined">error</span>
                <span><%= errorMessage %></span>
            </div>

            <a class="btn-primary" href="${pageContext.request.contextPath}/forgot-password"
               style="text-decoration:none; color:#fff;">
                Request a new link
                <span class="material-symbols-outlined">arrow_forward</span>
            </a>

            <div class="footer-link">
                <a href="${pageContext.request.contextPath}/login">Back to sign in</a>
            </div>
        <% } else { %>
            <%-- Token valid — show the new password form --%>
            <h1>Choose a new password</h1>
            <p class="subtitle">
                Pick a password you have not used before. The link will expire in
                30 minutes from when it was generated.
            </p>

            <% if (username != null) { %>
                <div class="username-chip">
                    <span class="material-symbols-outlined">person</span>
                    <%= username %>
                </div>
            <% } %>

            <% if (errorMessage != null) { %>
                <div class="banner error">
                    <span class="material-symbols-outlined">error</span>
                    <span><%= errorMessage %></span>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/reset-password" method="post">
                <input type="hidden" name="token" value="<%= token %>">

                <div class="form-group">
                    <label class="form-label" for="password">New password</label>
                    <div class="input-wrap">
                        <span class="material-symbols-outlined left-icon">lock</span>
                        <input type="password"
                               class="form-input"
                               id="password"
                               name="password"
                               placeholder="At least 6 characters"
                               minlength="6"
                               autocomplete="new-password"
                               required
                               autofocus>
                        <button type="button" class="toggle-password" onclick="togglePassword('password','toggleIcon1')">
                            <span class="material-symbols-outlined" id="toggleIcon1">visibility</span>
                        </button>
                    </div>
                    <p class="password-hint">Use at least 6 characters. Mix letters and numbers for extra security.</p>
                </div>

                <div class="form-group">
                    <label class="form-label" for="confirmPassword">Confirm new password</label>
                    <div class="input-wrap">
                        <span class="material-symbols-outlined left-icon">lock</span>
                        <input type="password"
                               class="form-input"
                               id="confirmPassword"
                               name="confirmPassword"
                               placeholder="Type it again"
                               minlength="6"
                               autocomplete="new-password"
                               required>
                        <button type="button" class="toggle-password" onclick="togglePassword('confirmPassword','toggleIcon2')">
                            <span class="material-symbols-outlined" id="toggleIcon2">visibility</span>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-primary">
                    Update password
                    <span class="material-symbols-outlined">check</span>
                </button>
            </form>

            <div class="footer-link">
                <a href="${pageContext.request.contextPath}/login">Cancel and go back</a>
            </div>
        <% } %>
    </div>

    <script>
        function togglePassword(inputId, iconId) {
            var input = document.getElementById(inputId);
            var icon  = document.getElementById(iconId);
            if (input.type === 'password') {
                input.type = 'text';
                icon.textContent = 'visibility_off';
            } else {
                input.type = 'password';
                icon.textContent = 'visibility';
            }
        }
    </script>
</body>
</html>
