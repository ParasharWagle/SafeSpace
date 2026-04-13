<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="SafeSpace — Anonymous incident reporting platform for students. Report safely, get support confidentially.">
    <title>SafeSpace — Your Safety Matters</title>

    <!-- Google Fonts: Manrope (headings), Public Sans (body), Material Symbols -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@600;700;800&family=Public+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet">

    <style>
        /* ============================================================
           CSS VARIABLES — SafeSpace Design System
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

        /* ============================================================
           RESET & BASE
           ============================================================ */
        *, *::before, *::after {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: 'Public Sans', sans-serif;
            font-weight: 400;
            color: var(--on-surface);
            background-color: var(--background);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Manrope', sans-serif;
            font-weight: 700;
            line-height: 1.25;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        img {
            max-width: 100%;
            display: block;
        }

        /* ============================================================
           NAVBAR
           ============================================================ */
        .navbar {
            position: sticky;
            top: 0;
            z-index: 1000;
            background: rgba(255, 255, 255, 0.82);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 0 40px;
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: box-shadow 0.3s ease;
        }

        .navbar.scrolled {
            box-shadow: 0 1px 12px rgba(0,0,0,0.06);
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-family: 'Manrope', sans-serif;
            font-weight: 800;
            font-size: 1.25rem;
            color: var(--primary);
        }

        .navbar-brand .material-symbols-outlined {
            font-size: 28px;
            color: var(--primary);
        }

        .navbar-links {
            display: flex;
            align-items: center;
            gap: 32px;
            list-style: none;
        }

        .navbar-links a {
            font-family: 'Public Sans', sans-serif;
            font-weight: 500;
            font-size: 0.9rem;
            color: var(--on-surface-muted);
            transition: color 0.2s ease;
            position: relative;
        }

        .navbar-links a:hover {
            color: var(--primary);
        }

        .navbar-links a::after {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary);
            transition: width 0.25s ease;
            border-radius: 1px;
        }

        .navbar-links a:hover::after {
            width: 100%;
        }

        .navbar-actions {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        /* ---- Icon Buttons with Dropdown Wrapper ---- */
        .navbar-dropdown-wrapper {
            position: relative;
        }

        .navbar-icon-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: none;
            background: transparent;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: var(--on-surface-muted);
            transition: background 0.2s ease, color 0.2s ease;
            position: relative;
        }

        .navbar-icon-btn:hover {
            background: var(--surface-low);
            color: var(--primary);
        }

        /* Notification badge dot */
        .notif-badge {
            position: absolute;
            top: 8px;
            right: 8px;
            width: 9px;
            height: 9px;
            border-radius: 50%;
            background: var(--error-container);
            border: 2px solid #fff;
        }

        /* ---- Dropdown Panels ---- */
        .dropdown-panel {
            position: absolute;
            top: calc(100% + 8px);
            right: 0;
            background: var(--surface-lowest);
            border-radius: 16px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.1), 0 1px 4px rgba(0,0,0,0.05);
            opacity: 0;
            visibility: hidden;
            transform: translateY(-8px);
            transition: opacity 0.2s ease, transform 0.2s ease, visibility 0.2s ease;
            z-index: 2000;
            overflow: hidden;
        }

        .dropdown-panel.open {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        /* ---- Notification Dropdown ---- */
        .notif-dropdown {
            width: 340px;
        }

        .dropdown-header {
            padding: 16px 20px 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .dropdown-header h3 {
            font-size: 0.95rem;
            color: var(--on-surface);
        }

        .dropdown-header a {
            font-size: 0.78rem;
            color: var(--primary);
            font-weight: 600;
        }

        .notif-list {
            list-style: none;
            max-height: 300px;
            overflow-y: auto;
        }

        .notif-item {
            padding: 14px 20px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
            cursor: pointer;
            transition: background 0.15s ease;
        }

        .notif-item:hover {
            background: var(--surface-low);
        }

        .notif-item.unread {
            background: rgba(184,235,244,0.15);
        }

        .notif-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            background: var(--primary-container);
        }

        .notif-icon .material-symbols-outlined {
            font-size: 18px;
            color: var(--primary);
        }

        .notif-content {
            flex: 1;
        }

        .notif-content p {
            font-size: 0.82rem;
            color: var(--on-surface);
            line-height: 1.5;
            margin-bottom: 2px;
        }

        .notif-content .notif-time {
            font-size: 0.72rem;
            color: var(--on-surface-hint);
        }

        .notif-empty {
            padding: 32px 20px;
            text-align: center;
            color: var(--on-surface-hint);
            font-size: 0.85rem;
        }

        /* ---- Settings Dropdown ---- */
        .settings-dropdown {
            width: 260px;
        }

        .settings-list {
            list-style: none;
            padding: 8px 0;
        }

        .settings-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 20px;
            font-size: 0.85rem;
            color: var(--on-surface);
            cursor: pointer;
            transition: background 0.15s ease;
        }

        .settings-item:hover {
            background: var(--surface-low);
        }

        .settings-item .material-symbols-outlined {
            font-size: 20px;
            color: var(--on-surface-hint);
        }

        .settings-divider {
            height: 1px;
            background: var(--surface-high);
            margin: 4px 0;
        }

        /* ---- Account Dropdown ---- */
        .account-dropdown-wrapper {
            position: relative;
            margin-left: 4px;
        }

        .account-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 6px 14px 6px 8px;
            border-radius: 9999px;
            border: none;
            background: transparent;
            cursor: pointer;
            font-family: 'Public Sans', sans-serif;
            font-weight: 500;
            font-size: 0.9rem;
            color: var(--primary);
            transition: background 0.2s ease;
        }

        .account-btn:hover {
            background: var(--surface-low);
        }

        .account-btn .material-symbols-outlined {
            font-size: 24px;
        }

        .account-btn .chevron {
            font-size: 18px;
            color: var(--on-surface-hint);
            transition: transform 0.2s ease;
        }

        .account-btn.open .chevron {
            transform: rotate(180deg);
        }

        .account-dropdown {
            width: 260px;
        }

        .account-dropdown-header {
            padding: 20px 20px 16px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .account-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: var(--primary-container);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .account-avatar .material-symbols-outlined {
            font-size: 24px;
            color: var(--primary);
        }

        .account-info h4 {
            font-size: 0.9rem;
            color: var(--on-surface);
            font-weight: 600;
            margin-bottom: 2px;
        }

        .account-info p {
            font-size: 0.75rem;
            color: var(--on-surface-hint);
        }

        .account-menu {
            list-style: none;
            padding: 4px 0 8px;
        }

        .account-menu-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 20px;
            font-size: 0.85rem;
            color: var(--on-surface);
            cursor: pointer;
            transition: background 0.15s ease;
            text-decoration: none;
        }

        .account-menu-item:hover {
            background: var(--surface-low);
        }

        .account-menu-item .material-symbols-outlined {
            font-size: 20px;
            color: var(--on-surface-hint);
        }

        .account-menu-item.logout {
            color: #c62828;
        }

        .account-menu-item.logout .material-symbols-outlined {
            color: #c62828;
        }

        .account-divider {
            height: 1px;
            background: var(--surface-high);
            margin: 4px 0;
        }

        .btn-signin {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 22px;
            border-radius: 9999px;
            background: var(--primary);
            color: var(--on-primary);
            font-family: 'Public Sans', sans-serif;
            font-weight: 600;
            font-size: 0.875rem;
            border: none;
            cursor: pointer;
            transition: background 0.2s ease, transform 0.15s ease;
        }

        .btn-signin:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
        }

        /* ============================================================
           BUTTONS (shared)
           ============================================================ */
        .btn-primary {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 12px 32px;
            border-radius: 9999px;
            background: var(--primary);
            color: var(--on-primary);
            font-family: 'Public Sans', sans-serif;
            font-weight: 600;
            font-size: 0.95rem;
            border: none;
            cursor: pointer;
            transition: background 0.2s ease, transform 0.15s ease, box-shadow 0.2s ease;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(52,102,109,0.25);
        }

        .btn-outline {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 12px 32px;
            border-radius: 9999px;
            background: transparent;
            color: var(--primary);
            font-family: 'Public Sans', sans-serif;
            font-weight: 600;
            font-size: 0.95rem;
            border: 1.5px solid var(--outline-variant);
            cursor: pointer;
            transition: border-color 0.2s ease, background 0.2s ease, transform 0.15s ease;
        }

        .btn-outline:hover {
            border-color: var(--primary);
            background: var(--primary-container);
            transform: translateY(-2px);
        }

        .btn-ghost {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 12px 32px;
            border-radius: 9999px;
            background: transparent;
            color: var(--on-surface-muted);
            font-family: 'Public Sans', sans-serif;
            font-weight: 600;
            font-size: 0.95rem;
            border: 1.5px solid var(--outline-variant);
            cursor: pointer;
            transition: border-color 0.2s ease, background 0.2s ease;
        }

        .btn-ghost:hover {
            border-color: var(--on-surface-hint);
            background: var(--surface-low);
        }

        /* ============================================================
           FORM INPUTS (shared)
           ============================================================ */
        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-weight: 500;
            font-size: 0.875rem;
            color: var(--on-surface);
            margin-bottom: 6px;
        }

        .form-input {
            width: 100%;
            padding: 12px 16px;
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

        .input-with-icon .form-input {
            padding-left: 44px;
        }

        textarea.form-input {
            resize: vertical;
            min-height: 120px;
        }

        select.form-input {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23727d7e' d='M6 8.825L.35 3.175l.825-.825L6 7.175l4.825-4.825.825.825z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 14px center;
            padding-right: 36px;
        }

        /* ============================================================
           CARDS (shared)
           ============================================================ */
        .card {
            background: var(--surface-lowest);
            border-radius: 16px;
            padding: 28px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.06);
        }

        /* ============================================================
           BADGES (shared)
           ============================================================ */
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 4px 14px;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .badge-pending {
            background: #fff3e0;
            color: #e65100;
        }

        .badge-resolved {
            background: var(--primary-container);
            color: var(--on-primary-container);
        }

        .badge-in-review {
            background: #e3f2fd;
            color: #1565c0;
        }

        .badge-critical {
            background: #fce4ec;
            color: #c62828;
        }

        /* ============================================================
           ALERTS (shared)
           ============================================================ */
        .alert {
            padding: 14px 20px;
            border-radius: 12px;
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 20px;
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

        .alert-warning {
            background: #fff8e1;
            color: #e65100;
        }

        /* ============================================================
           EMERGENCY EXIT BUTTON
           ============================================================ */
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
            text-decoration: none;
        }

        .emergency-exit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 28px rgba(254,137,131,0.55);
        }

        .emergency-exit .material-symbols-outlined {
            font-size: 20px;
        }

        /* ============================================================
           FOOTER
           ============================================================ */
        .footer {
            background: var(--surface-low);
            padding: 60px 40px 32px;
            margin-top: 80px;
        }

        .footer-grid {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            gap: 60px;
            flex-wrap: wrap;
        }

        .footer-brand {
            max-width: 360px;
        }

        .footer-brand-name {
            display: flex;
            align-items: center;
            gap: 8px;
            font-family: 'Manrope', sans-serif;
            font-weight: 800;
            font-size: 1.15rem;
            color: var(--primary);
            margin-bottom: 12px;
        }

        .footer-brand-name .material-symbols-outlined {
            font-size: 24px;
        }

        .footer-brand p {
            font-size: 0.85rem;
            color: var(--on-surface-muted);
            line-height: 1.7;
            margin-bottom: 20px;
        }

        .footer-copyright {
            font-size: 0.78rem;
            color: var(--on-surface-hint);
        }

        .footer-links-area {
            display: flex;
            gap: 60px;
            flex-wrap: wrap;
        }

        .footer-col h4 {
            font-family: 'Manrope', sans-serif;
            font-weight: 700;
            font-size: 0.85rem;
            color: var(--on-surface);
            margin-bottom: 16px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .footer-col ul {
            list-style: none;
        }

        .footer-col li {
            margin-bottom: 10px;
        }

        .footer-col a {
            font-size: 0.85rem;
            color: var(--on-surface-muted);
            transition: color 0.2s ease;
        }

        .footer-col a:hover {
            color: var(--primary);
        }

        /* ============================================================
           UTILITIES
           ============================================================ */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 24px;
        }

        .section {
            padding: 80px 0;
        }

        .text-center {
            text-align: center;
        }

        .text-primary {
            color: var(--primary);
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        /* ============================================================
           CLICK-OUTSIDE OVERLAY — closes all dropdowns when clicked
           ============================================================ */
        .dropdown-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            z-index: 999;
        }

        .dropdown-overlay.active {
            display: block;
        }

        /* ============================================================
           RESPONSIVE
           ============================================================ */
        @media (max-width: 768px) {
            .navbar {
                padding: 0 20px;
            }

            .navbar-links {
                display: none;
            }

            .footer-grid {
                flex-direction: column;
                gap: 40px;
            }

            .footer-links-area {
                gap: 40px;
            }

            .container {
                padding: 0 16px;
            }

            .section {
                padding: 48px 0;
            }

            .notif-dropdown {
                width: 300px;
                right: -40px;
            }

            .account-dropdown,
            .settings-dropdown {
                right: -8px;
            }
        }
    </style>
</head>
<body>

<!-- Invisible overlay to close dropdowns when clicking outside -->
<div class="dropdown-overlay" id="dropdownOverlay" onclick="closeAllDropdowns()"></div>

<!-- ============================================================
     NAVBAR
     ============================================================ -->
<nav class="navbar" id="main-navbar">
    <a href="${pageContext.request.contextPath}/home" class="navbar-brand">
        <span class="material-symbols-outlined">shield_with_heart</span>
        SafeSpace
    </a>

    <ul class="navbar-links">
        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Support</a></li>
        <li><a href="${pageContext.request.contextPath}/home#how-it-works">Resources</a></li>
    </ul>

    <div class="navbar-actions">

        <%-- ============ NOTIFICATION BELL ============ --%>
        <div class="navbar-dropdown-wrapper">
            <button class="navbar-icon-btn" title="Notifications" id="notifBtn" onclick="toggleDropdown('notifDropdown')">
                <span class="material-symbols-outlined">notifications</span>
                <% if (session.getAttribute("username") != null) { %>
                    <span class="notif-badge" id="notifBadge"></span>
                <% } %>
            </button>

            <!-- Notification Dropdown Panel -->
            <div class="dropdown-panel notif-dropdown" id="notifDropdown">
                <div class="dropdown-header">
                    <h3>Notifications</h3>
                    <a href="#" onclick="markAllRead()">Mark all read</a>
                </div>
                <ul class="notif-list">
                    <% if (session.getAttribute("username") != null) { %>
                        <li class="notif-item unread" onclick="this.classList.remove('unread')">
                            <div class="notif-icon">
                                <span class="material-symbols-outlined">check_circle</span>
                            </div>
                            <div class="notif-content">
                                <p>Your report <strong>#SF-1</strong> status has been updated.</p>
                                <span class="notif-time">2 hours ago</span>
                            </div>
                        </li>
                        <li class="notif-item unread" onclick="this.classList.remove('unread')">
                            <div class="notif-icon">
                                <span class="material-symbols-outlined">security</span>
                            </div>
                            <div class="notif-content">
                                <p>New security advisory posted for campus residents.</p>
                                <span class="notif-time">5 hours ago</span>
                            </div>
                        </li>
                        <li class="notif-item" onclick="this.classList.remove('unread')">
                            <div class="notif-icon">
                                <span class="material-symbols-outlined">info</span>
                            </div>
                            <div class="notif-content">
                                <p>Welcome to SafeSpace! Your account is now active.</p>
                                <span class="notif-time">1 day ago</span>
                            </div>
                        </li>
                    <% } else { %>
                        <li class="notif-empty">
                            <span class="material-symbols-outlined" style="font-size:32px; display:block; margin-bottom:8px;">notifications_off</span>
                            Sign in to view your notifications
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>

        <%-- ============ SETTINGS COG ============ --%>
        <div class="navbar-dropdown-wrapper">
            <button class="navbar-icon-btn" title="Settings" id="settingsBtn" onclick="toggleDropdown('settingsDropdown')">
                <span class="material-symbols-outlined">settings</span>
            </button>

            <!-- Settings Dropdown Panel -->
            <div class="dropdown-panel settings-dropdown" id="settingsDropdown">
                <div class="dropdown-header">
                    <h3>Settings</h3>
                </div>
                <ul class="settings-list">
                    <li class="settings-item" onclick="alert('Appearance settings coming soon.')">
                        <span class="material-symbols-outlined">dark_mode</span>
                        Appearance
                    </li>
                    <li class="settings-item" onclick="alert('Language preferences coming soon.')">
                        <span class="material-symbols-outlined">language</span>
                        Language
                    </li>
                    <li class="settings-item" onclick="alert('Notification preferences coming soon.')">
                        <span class="material-symbols-outlined">tune</span>
                        Notification Preferences
                    </li>
                    <li class="settings-divider"></li>
                    <li class="settings-item" onclick="alert('Privacy settings coming soon.')">
                        <span class="material-symbols-outlined">shield</span>
                        Privacy & Security
                    </li>
                    <li class="settings-item" onclick="alert('Accessibility options coming soon.')">
                        <span class="material-symbols-outlined">accessibility_new</span>
                        Accessibility
                    </li>
                    <li class="settings-divider"></li>
                    <li class="settings-item" onclick="alert('SafeSpace v1.0.0 — Built with care at Islington College.')">
                        <span class="material-symbols-outlined">info</span>
                        About SafeSpace
                    </li>
                </ul>
            </div>
        </div>

        <%-- ============ ACCOUNT / SIGN IN ============ --%>
        <% if (session.getAttribute("username") != null) { %>
            <!-- Logged in — show account button with dropdown -->
            <div class="account-dropdown-wrapper navbar-dropdown-wrapper">
                <button class="account-btn" id="accountBtn" onclick="toggleDropdown('accountDropdown')">
                    <span class="material-symbols-outlined">account_circle</span>
                    <%= session.getAttribute("fullName") %>
                    <span class="material-symbols-outlined chevron">expand_more</span>
                </button>

                <!-- Account Dropdown Panel -->
                <div class="dropdown-panel account-dropdown" id="accountDropdown">
                    <div class="account-dropdown-header">
                        <div class="account-avatar">
                            <span class="material-symbols-outlined">person</span>
                        </div>
                        <div class="account-info">
                            <h4><%= session.getAttribute("fullName") %></h4>
                            <p><%= session.getAttribute("role") %> &bull; @<%= session.getAttribute("username") %></p>
                        </div>
                    </div>
                    <div class="account-divider"></div>
                    <ul class="account-menu">
                        <li>
                            <a href="<%= "COUNSELOR".equals(session.getAttribute("role")) ?
                                request.getContextPath() + "/admin/dashboard" :
                                request.getContextPath() + "/student/dashboard" %>" class="account-menu-item">
                                <span class="material-symbols-outlined">dashboard</span>
                                Dashboard
                            </a>
                        </li>
                        <li>
                            <a href="#" class="account-menu-item" onclick="alert('Profile settings coming soon.')">
                                <span class="material-symbols-outlined">manage_accounts</span>
                                My Profile
                            </a>
                        </li>
                        <li>
                            <a href="#" class="account-menu-item" onclick="alert('Activity log coming soon.')">
                                <span class="material-symbols-outlined">history</span>
                                Activity Log
                            </a>
                        </li>
                        <li class="account-divider"></li>
                        <li>
                            <a href="${pageContext.request.contextPath}/logout" class="account-menu-item logout">
                                <span class="material-symbols-outlined">logout</span>
                                Sign Out
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        <% } else { %>
            <!-- Not logged in — show Sign In button -->
            <a href="${pageContext.request.contextPath}/login" class="btn-signin" style="margin-left:4px;">Sign In</a>
        <% } %>
    </div>
</nav>

<!-- Navbar + Dropdown JavaScript -->
<script>
    // Add shadow to navbar when user scrolls down
    window.addEventListener('scroll', function() {
        var navbar = document.getElementById('main-navbar');
        if (window.scrollY > 10) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    /**
     * toggleDropdown — opens or closes a specific dropdown panel.
     * Closes all other open dropdowns first, then toggles the target.
     *
     * @param dropdownId the ID of the dropdown panel to toggle
     */
    function toggleDropdown(dropdownId) {
        var dropdown = document.getElementById(dropdownId);
        var overlay = document.getElementById('dropdownOverlay');
        var isOpen = dropdown.classList.contains('open');

        // Close all dropdowns first
        closeAllDropdowns();

        // If it was closed, open it now
        if (!isOpen) {
            dropdown.classList.add('open');
            overlay.classList.add('active');

            // Toggle chevron rotation on account button
            if (dropdownId === 'accountDropdown') {
                document.getElementById('accountBtn').classList.add('open');
            }
        }
    }

    /**
     * closeAllDropdowns — closes every open dropdown panel
     * and removes the click-outside overlay.
     */
    function closeAllDropdowns() {
        // Close all dropdown panels
        var panels = document.querySelectorAll('.dropdown-panel');
        for (var i = 0; i < panels.length; i++) {
            panels[i].classList.remove('open');
        }

        // Remove overlay
        var overlay = document.getElementById('dropdownOverlay');
        overlay.classList.remove('active');

        // Reset account button chevron
        var accBtn = document.getElementById('accountBtn');
        if (accBtn) accBtn.classList.remove('open');
    }

    /**
     * markAllRead — removes the 'unread' class from all notifications
     * and hides the notification badge dot.
     */
    function markAllRead() {
        var items = document.querySelectorAll('.notif-item.unread');
        for (var i = 0; i < items.length; i++) {
            items[i].classList.remove('unread');
        }
        // Hide the badge dot
        var badge = document.getElementById('notifBadge');
        if (badge) badge.style.display = 'none';
    }

    // Close dropdowns when Escape key is pressed
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeAllDropdowns();
        }
    });
</script>
