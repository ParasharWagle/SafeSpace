<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="SafeSpace — Anonymous incident reporting platform. Report safely, get support confidentially.">
    <title>SafeSpace — Report Safely. Get Help Instantly.</title>

    <!-- Google Fonts: Manrope (headings), Public Sans (body), Material Symbols -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@500;600;700;800&family=Public+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet">

    <style>
        /* ============================================================
           SafeSpace Design System — shared across all pages
           ============================================================ */
        :root {
            /* --- Brand greens --- */
            --primary:              #10b981;
            --primary-dark:         #059669;
            --primary-darker:       #047857;
            --primary-light:        #34d399;
            --primary-container:    #d1fae5;
            --primary-container-2:  #ecfdf5;
            --on-primary:           #ffffff;
            --on-primary-container: #065f46;

            /* --- Hero accents --- */
            --accent-deep:          #0f3d36;
            --accent-mid:           #1a5b52;

            /* --- Surfaces --- */
            --background:           #f8fafa;
            --surface-low:          #f1f5f9;
            --surface-lowest:       #ffffff;
            --surface-high:         #e2e8f0;
            --surface-highest:      #f8fafc;

            /* --- Text --- */
            --on-surface:           #0f172a;
            --on-surface-muted:     #475569;
            --on-surface-hint:      #94a3b8;
            --outline-variant:      #cbd5e1;

            /* --- Semantic palette for stat-cards, badges, donut chart ---
                 Matches the reference UI images. Each group has:
                 -fg  — the vivid border / dot / text color
                 -bg  — the soft background for icon chip / soft pills      */
            --accent-green-fg:      #10b981;
            --accent-green-bg:      #d1fae5;
            --accent-amber-fg:      #f59e0b;
            --accent-amber-bg:      #fef3c7;
            --accent-teal-fg:       #14b8a6;
            --accent-teal-bg:       #ccfbf1;
            --accent-red-fg:        #ef4444;
            --accent-red-bg:        #fee2e2;
            --accent-blue-fg:       #3b82f6;
            --accent-blue-bg:       #dbeafe;
            --accent-purple-fg:     #8b5cf6;
            --accent-purple-bg:     #ede9fe;
            --accent-pink-fg:       #ec4899;
            --accent-pink-bg:       #fce7f3;

            /* --- Chart palette (reference image 3 colors) --- */
            --chart-1:              #10b981;  /* primary green */
            --chart-2:              #34d399;  /* lighter green */
            --chart-3:              #f59e0b;  /* amber */
            --chart-4:              #ef4444;  /* red */
            --chart-5:              #8b5cf6;  /* purple */
            --chart-6:              #3b82f6;  /* blue */
        }

        /* ============================================================
           RESET & BASE
           ============================================================ */
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
        html { scroll-behavior: smooth; }
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
            line-height: 1.2;
            letter-spacing: -0.01em;
        }
        a { text-decoration: none; color: inherit; }
        img { max-width: 100%; display: block; }
        button { font-family: inherit; }

        /* ============================================================
           NAVBAR
           ============================================================ */
        .navbar {
            position: sticky;
            top: 0;
            z-index: 1000;
            padding: 0 48px;
            height: 72px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: background 0.3s ease, box-shadow 0.3s ease, color 0.3s ease;
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
        }
        .navbar.scrolled { box-shadow: 0 1px 12px rgba(0,0,0,0.06); }
        .navbar.on-hero {
            background: transparent;
            backdrop-filter: none;
            -webkit-backdrop-filter: none;
            box-shadow: none;
        }
        .navbar.on-hero.scrolled {
            background: rgba(15, 61, 54, 0.88);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            box-shadow: 0 1px 16px rgba(0,0,0,0.25);
        }

        .navbar-brand {
            display: flex; align-items: center; gap: 10px;
            font-family: 'Manrope', sans-serif;
            font-weight: 800;
            font-size: 1.35rem;
            color: var(--on-surface);
        }
        .navbar.on-hero .navbar-brand { color: #fff; }

        .navbar-brand-logo {
            width: 36px; height: 36px;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-darker) 100%);
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 4px 12px rgba(16,185,129,0.35);
        }
        .navbar-brand-logo .material-symbols-outlined {
            font-size: 20px; color: #fff;
            font-variation-settings: 'FILL' 1;
        }

        .navbar-links {
            display: flex; align-items: center; gap: 4px;
            list-style: none;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }
        .navbar-links a {
            font-weight: 500; font-size: 0.92rem;
            color: var(--on-surface-muted);
            padding: 8px 18px;
            border-radius: 8px;
            transition: all 0.2s ease;
            border: 1.5px solid transparent;
        }
        .navbar.on-hero .navbar-links a { color: rgba(255,255,255,0.85); }
        .navbar-links a:hover { color: var(--on-surface); }
        .navbar.on-hero .navbar-links a:hover { color: #fff; }
        .navbar-links a.active {
            color: var(--on-surface);
            border-color: var(--on-surface);
        }
        .navbar.on-hero .navbar-links a.active {
            color: #fff;
            border-color: rgba(255,255,255,0.85);
        }

        .navbar-actions { display: flex; align-items: center; gap: 12px; }

        /* Icon buttons (logged-in) */
        .navbar-dropdown-wrapper { position: relative; }
        .navbar-icon-btn {
            width: 40px; height: 40px; border-radius: 50%;
            border: none; background: transparent;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer;
            color: var(--on-surface-muted);
            transition: background 0.2s ease, color 0.2s ease;
            position: relative;
        }
        .navbar.on-hero .navbar-icon-btn { color: rgba(255,255,255,0.9); }
        .navbar-icon-btn:hover { background: var(--surface-low); color: var(--primary); }
        .navbar.on-hero .navbar-icon-btn:hover { background: rgba(255,255,255,0.12); color: #fff; }
        .notif-badge {
            position: absolute; top: 8px; right: 8px;
            width: 9px; height: 9px;
            border-radius: 50%;
            background: var(--accent-red-fg);
            border: 2px solid #fff;
        }

        /* ============================================================
           DROPDOWNS (notif / settings / account)
           ============================================================ */
        .dropdown-panel {
            position: absolute;
            top: calc(100% + 8px);
            right: 0;
            background: var(--surface-lowest);
            border-radius: 16px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.12), 0 1px 4px rgba(0,0,0,0.06);
            opacity: 0; visibility: hidden;
            transform: translateY(-8px);
            transition: opacity 0.2s ease, transform 0.2s ease, visibility 0.2s ease;
            z-index: 2000;
            overflow: hidden;
        }
        .dropdown-panel.open { opacity: 1; visibility: visible; transform: translateY(0); }
        .dropdown-header {
            padding: 16px 20px;
            border-bottom: 1px solid var(--surface-high);
            display: flex; align-items: center; justify-content: space-between;
        }
        .dropdown-header h3 { font-size: 0.95rem; font-weight: 700; color: var(--on-surface); }
        .dropdown-header a { font-size: 0.78rem; color: var(--primary); font-weight: 600; }

        .notif-dropdown { width: 360px; }
        .notif-list { list-style: none; max-height: 360px; overflow-y: auto; }
        .notif-item {
            padding: 14px 20px;
            display: flex; gap: 12px; align-items: flex-start;
            cursor: pointer;
            transition: background 0.15s ease;
            border-bottom: 1px solid var(--surface-high);
        }
        .notif-item:last-child { border-bottom: none; }
        .notif-item:hover { background: var(--surface-low); }
        .notif-item.unread { background: rgba(16,185,129,0.05); }
        .notif-icon {
            width: 36px; height: 36px; border-radius: 50%;
            background: var(--primary-container);
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .notif-icon .material-symbols-outlined { font-size: 18px; color: var(--primary); }
        .notif-content p { font-size: 0.85rem; color: var(--on-surface); margin-bottom: 4px; line-height: 1.45; }
        .notif-time { font-size: 0.72rem; color: var(--on-surface-hint); }

        .settings-dropdown { width: 240px; }
        .settings-list { list-style: none; padding: 8px 0; }
        .settings-item {
            padding: 10px 20px;
            display: flex; align-items: center; gap: 12px;
            font-size: 0.88rem; color: var(--on-surface);
            cursor: pointer;
            transition: background 0.15s ease;
        }
        .settings-item:hover { background: var(--surface-low); }
        .settings-item .material-symbols-outlined { font-size: 20px; color: var(--on-surface-hint); }
        .settings-divider { height: 1px; background: var(--surface-high); margin: 6px 0; }

        .account-btn {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 6px 14px 6px 6px;
            border-radius: 9999px;
            border: 1.5px solid var(--outline-variant);
            background: var(--surface-lowest);
            cursor: pointer;
            font-size: 0.85rem; font-weight: 500;
            color: var(--on-surface);
            transition: border-color 0.2s ease, background 0.2s ease;
        }
        .navbar.on-hero .account-btn {
            background: rgba(255,255,255,0.1);
            border-color: rgba(255,255,255,0.25);
            color: #fff;
            backdrop-filter: blur(10px);
        }
        .account-btn:hover { border-color: var(--primary); }
        .account-btn .material-symbols-outlined { font-size: 24px; color: var(--primary); }
        .account-btn .chevron {
            font-size: 18px; color: var(--on-surface-hint);
            transition: transform 0.2s ease;
        }
        .account-btn.open .chevron { transform: rotate(180deg); }

        .account-dropdown { width: 280px; }
        .account-dropdown-header {
            padding: 20px;
            display: flex; align-items: center; gap: 12px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-darker) 100%);
            color: #fff;
        }
        .account-avatar {
            width: 48px; height: 48px; border-radius: 50%;
            background: rgba(255,255,255,0.2);
            display: flex; align-items: center; justify-content: center;
        }
        .account-avatar .material-symbols-outlined { font-size: 28px; color: #fff; }
        .account-info h4 { font-size: 0.95rem; font-weight: 700; margin-bottom: 2px; }
        .account-info p { font-size: 0.75rem; opacity: 0.9; }

        .account-menu { list-style: none; padding: 8px 0; }
        .account-menu-item {
            display: flex; align-items: center; gap: 12px;
            padding: 11px 20px;
            font-size: 0.88rem; color: var(--on-surface);
            cursor: pointer;
            transition: background 0.15s ease;
        }
        .account-menu-item:hover { background: var(--surface-low); }
        .account-menu-item .material-symbols-outlined { font-size: 20px; color: var(--on-surface-hint); }
        .account-menu-item.logout { color: #c62828; }
        .account-menu-item.logout .material-symbols-outlined { color: #c62828; }
        .account-divider { height: 1px; background: var(--surface-high); margin: 4px 0; }

        /* ============================================================
           HERO nav buttons (logged-out)
           ============================================================ */
        .btn-nav-outline {
            padding: 10px 22px;
            border-radius: 10px;
            background: transparent;
            color: var(--on-surface);
            border: 1.5px solid var(--on-surface);
            font-weight: 600; font-size: 0.88rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .navbar.on-hero .btn-nav-outline {
            color: #fff;
            border-color: rgba(255,255,255,0.85);
        }
        .btn-nav-outline:hover { background: var(--on-surface); color: #fff; }
        .navbar.on-hero .btn-nav-outline:hover { background: #fff; color: var(--accent-deep); }

        .btn-nav-primary {
            padding: 10px 24px;
            border-radius: 10px;
            background: var(--primary);
            color: #fff;
            border: none;
            font-weight: 600; font-size: 0.88rem;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 2px 8px rgba(16,185,129,0.25);
        }
        .btn-nav-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 4px 14px rgba(16,185,129,0.4);
        }

        /* ============================================================
           SHARED BUTTONS
           ============================================================ */
        .btn-primary {
            display: inline-flex; align-items: center; justify-content: center;
            gap: 8px;
            padding: 14px 30px;
            border-radius: 12px;
            background: var(--primary);
            color: #fff;
            font-weight: 600; font-size: 0.95rem;
            border: none; cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 4px 14px rgba(16,185,129,0.3);
        }
        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 8px 22px rgba(16,185,129,0.4);
        }
        .btn-outline {
            display: inline-flex; align-items: center; justify-content: center;
            gap: 8px;
            padding: 14px 30px;
            border-radius: 12px;
            background: transparent;
            color: var(--on-surface);
            font-weight: 600; font-size: 0.95rem;
            border: 1.5px solid var(--outline-variant);
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .btn-outline:hover {
            border-color: var(--primary);
            background: var(--primary-container-2);
            color: var(--on-primary-container);
        }
        .btn-ghost {
            display: inline-flex; align-items: center; justify-content: center;
            gap: 8px;
            padding: 12px 28px;
            border-radius: 10px;
            background: transparent;
            color: var(--on-surface-muted);
            font-weight: 600; font-size: 0.95rem;
            border: 1.5px solid var(--outline-variant);
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .btn-ghost:hover { border-color: var(--on-surface-hint); background: var(--surface-low); }

        /* ============================================================
           FORMS
           ============================================================ */
        .form-group { margin-bottom: 20px; }
        .form-label {
            display: block;
            font-weight: 500; font-size: 0.875rem;
            color: var(--on-surface);
            margin-bottom: 8px;
        }
        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: 12px 16px;
            border-radius: 10px;
            border: 1.5px solid var(--outline-variant);
            background: var(--surface-lowest);
            font-family: 'Public Sans', sans-serif;
            font-size: 0.9rem;
            color: var(--on-surface);
            outline: none;
            transition: all 0.2s ease;
        }
        .form-input:focus, .form-select:focus, .form-textarea:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(16,185,129,0.15);
        }
        .form-input::placeholder, .form-textarea::placeholder { color: var(--on-surface-hint); }

        .input-with-icon { position: relative; }
        .input-with-icon .material-symbols-outlined {
            position: absolute;
            left: 14px; top: 50%; transform: translateY(-50%);
            font-size: 20px; color: var(--on-surface-hint);
            pointer-events: none;
        }
        .input-with-icon .form-input { padding-left: 44px; }

        .form-textarea { resize: vertical; min-height: 120px; }
        .form-select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23727d7e' d='M6 8.825L.35 3.175l.825-.825L6 7.175l4.825-4.825.825.825z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 14px center;
            padding-right: 36px;
        }

        /* ============================================================
           CARDS / BADGES / ALERTS
           ============================================================ */
        .card {
            background: var(--surface-lowest);
            border-radius: 16px;
            padding: 28px;
            border: 1px solid var(--surface-high);
            transition: all 0.25s ease;
        }
        .card:hover { box-shadow: 0 8px 30px rgba(0,0,0,0.06); }

        /* Status badges (used in tables & lists) */
        .badge {
            display: inline-flex; align-items: center; gap: 4px;
            padding: 5px 14px;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            white-space: nowrap;
        }
        .badge-new { background: var(--accent-green-bg); color: var(--on-primary-container); }
        .badge-pending { background: var(--accent-amber-bg); color: #92400e; }
        .badge-resolved { background: var(--primary-container); color: var(--on-primary-container); }
        .badge-in-review, .badge-in-progress { background: var(--accent-amber-bg); color: #92400e; }
        .badge-critical { background: var(--accent-red-bg); color: #991b1b; }

        /* Percentage change pill (used on stat cards) */
        .change-pill {
            display: inline-flex; align-items: center;
            padding: 3px 10px;
            border-radius: 9999px;
            font-size: 0.72rem; font-weight: 600;
        }
        .change-pill.up   { background: var(--accent-green-bg); color: var(--on-primary-container); }
        .change-pill.down { background: var(--accent-red-bg);   color: #991b1b; }

        .alert {
            padding: 14px 20px;
            border-radius: 12px;
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 20px;
            display: flex; align-items: center; gap: 10px;
        }
        .alert-success { background: var(--primary-container); color: var(--on-primary-container); }
        .alert-error { background: var(--accent-red-bg); color: #991b1b; }
        .alert-warning { background: var(--accent-amber-bg); color: #92400e; }

        /* ============================================================
           SECTION HEADERS (shared pattern across pages)
           ============================================================ */
        .section-header {
            max-width: 700px; margin: 0 auto 56px; text-align: center;
        }
        .section-eyebrow {
            display: inline-block;
            font-size: 0.78rem; font-weight: 700;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 12px;
        }
        .section-title {
            font-family: 'Manrope', sans-serif;
            font-size: clamp(2rem, 4vw, 3rem);
            font-weight: 800;
            color: var(--on-surface);
            margin-bottom: 14px;
        }
        .section-subtitle {
            font-size: 1.02rem;
            color: var(--on-surface-muted);
            line-height: 1.65;
        }

        /* ============================================================
           EMERGENCY EXIT BUTTON
           ============================================================ */
        .emergency-exit {
            position: fixed;
            bottom: 28px; right: 28px;
            z-index: 9999;
            display: inline-flex; align-items: center; gap: 8px;
            padding: 12px 24px;
            border-radius: 9999px;
            background: var(--accent-red-fg);
            color: #fff;
            font-weight: 600; font-size: 0.875rem;
            box-shadow: 0 4px 20px rgba(239,68,68,0.4);
            transition: all 0.2s ease;
        }
        .emergency-exit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 28px rgba(239,68,68,0.55);
        }
        .emergency-exit .material-symbols-outlined { font-size: 20px; }

        /* ============================================================
           FOOTER
           ============================================================ */
        .footer {
            background: var(--surface-low);
            padding: 60px 40px 32px;
            margin-top: 80px;
        }
        .footer-grid {
            max-width: 1200px; margin: 0 auto;
            display: flex; justify-content: space-between; gap: 60px;
            flex-wrap: wrap;
        }
        .footer-brand { max-width: 360px; }
        .footer-brand-name {
            display: flex; align-items: center; gap: 10px;
            font-family: 'Manrope', sans-serif;
            font-weight: 800; font-size: 1.15rem;
            color: var(--primary);
            margin-bottom: 12px;
        }
        .footer-brand-name .logo-chip {
            width: 28px; height: 28px;
            border-radius: 8px;
            background: linear-gradient(135deg, var(--primary), var(--primary-darker));
            display: flex; align-items: center; justify-content: center;
        }
        .footer-brand-name .logo-chip .material-symbols-outlined {
            font-size: 16px; color: #fff;
            font-variation-settings: 'FILL' 1;
        }
        .footer-brand p {
            font-size: 0.85rem;
            color: var(--on-surface-muted);
            line-height: 1.7;
            margin-bottom: 20px;
        }
        .footer-copyright { font-size: 0.78rem; color: var(--on-surface-hint); }
        .footer-links-area { display: flex; gap: 60px; flex-wrap: wrap; }
        .footer-col h4 {
            font-family: 'Manrope', sans-serif;
            font-weight: 700; font-size: 0.85rem;
            color: var(--on-surface);
            margin-bottom: 16px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .footer-col ul { list-style: none; }
        .footer-col li { margin-bottom: 10px; }
        .footer-col a {
            font-size: 0.85rem; color: var(--on-surface-muted);
            transition: color 0.2s ease;
        }
        .footer-col a:hover { color: var(--primary); }

        /* ============================================================
           UTILITIES
           ============================================================ */
        .container { max-width: 1200px; margin: 0 auto; padding: 0 24px; }
        .section { padding: 80px 0; }
        .text-center { text-align: center; }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        /* Click-outside overlay for dropdowns */
        .dropdown-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            z-index: 999;
        }
        .dropdown-overlay.active { display: block; }

        /* ============================================================
           RESPONSIVE
           ============================================================ */
        @media (max-width: 960px) {
            .navbar { padding: 0 24px; }
            .navbar-links { display: none; }
        }
        @media (max-width: 768px) {
            .footer-grid { flex-direction: column; gap: 40px; }
            .footer-links-area { gap: 40px; }
            .container { padding: 0 16px; }
            .section { padding: 48px 0; }
            .notif-dropdown { width: 300px; right: -40px; }
            .account-dropdown, .settings-dropdown { right: -8px; }
            .btn-nav-outline { display: none; }
        }
    </style>
</head>
<body>

<!-- Invisible overlay that closes any open dropdown when clicked -->
<div class="dropdown-overlay" id="dropdownOverlay" onclick="closeAllDropdowns()"></div>

<%
    // Nav mode ("hero" or "solid") + active link are set by each JSP
    // BEFORE including this header file.
    String navMode = (String) request.getAttribute("navMode");
    if (navMode == null) navMode = "solid";
    String navClass = "hero".equals(navMode) ? "navbar on-hero" : "navbar";

    String activeNav = (String) request.getAttribute("activeNav");
    if (activeNav == null) activeNav = "home";
%>

<nav class="<%= navClass %>" id="main-navbar">

    <a href="${pageContext.request.contextPath}/home" class="navbar-brand">
        <div class="navbar-brand-logo">
            <span class="material-symbols-outlined">shield_person</span>
        </div>
        SafeSpace
    </a>

    <ul class="navbar-links">
        <li><a href="${pageContext.request.contextPath}/home"
               class="<%= "home".equals(activeNav) ? "active" : "" %>">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/home#features"
               class="<%= "features".equals(activeNav) ? "active" : "" %>">Features</a></li>
        <li><a href="${pageContext.request.contextPath}/home#dashboard"
               class="<%= "dashboard".equals(activeNav) ? "active" : "" %>">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/home#charts"
               class="<%= "charts".equals(activeNav) ? "active" : "" %>">Charts</a></li>
    </ul>

    <div class="navbar-actions">
        <% if (session.getAttribute("username") == null) { %>
            <!-- Logged-out -->
            <a href="${pageContext.request.contextPath}/home#dashboard" class="btn-nav-outline">View Demo</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-nav-primary">Get Started</a>
        <% } else { %>
            <!-- Logged-in: notification + settings + account -->
            <div class="navbar-dropdown-wrapper">
                <button class="navbar-icon-btn" title="Notifications" onclick="toggleDropdown('notifDropdown')">
                    <span class="material-symbols-outlined">notifications</span>
                    <span class="notif-badge" id="notifBadge"></span>
                </button>
                <div class="dropdown-panel notif-dropdown" id="notifDropdown">
                    <div class="dropdown-header">
                        <h3>Notifications</h3>
                        <a href="#" onclick="markAllRead(); return false;">Mark all read</a>
                    </div>
                    <ul class="notif-list">
                        <li class="notif-item unread" onclick="this.classList.remove('unread')">
                            <div class="notif-icon"><span class="material-symbols-outlined">check_circle</span></div>
                            <div class="notif-content">
                                <p>Your report <strong>#SF-1</strong> status has been updated.</p>
                                <span class="notif-time">2 hours ago</span>
                            </div>
                        </li>
                        <li class="notif-item unread" onclick="this.classList.remove('unread')">
                            <div class="notif-icon"><span class="material-symbols-outlined">security</span></div>
                            <div class="notif-content">
                                <p>New security advisory posted for campus residents.</p>
                                <span class="notif-time">5 hours ago</span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="navbar-dropdown-wrapper">
                <button class="navbar-icon-btn" title="Settings" onclick="toggleDropdown('settingsDropdown')">
                    <span class="material-symbols-outlined">settings</span>
                </button>
                <div class="dropdown-panel settings-dropdown" id="settingsDropdown">
                    <div class="dropdown-header"><h3>Settings</h3></div>
                    <ul class="settings-list">
                        <li class="settings-item" onclick="alert('Appearance settings coming soon.')">
                            <span class="material-symbols-outlined">dark_mode</span>Appearance
                        </li>
                        <li class="settings-item" onclick="alert('Language preferences coming soon.')">
                            <span class="material-symbols-outlined">language</span>Language
                        </li>
                        <li class="settings-divider"></li>
                        <li class="settings-item" onclick="alert('SafeSpace v1.0 — Built at Islington College, Kathmandu.')">
                            <span class="material-symbols-outlined">info</span>About SafeSpace
                        </li>
                    </ul>
                </div>
            </div>

            <div class="account-dropdown-wrapper navbar-dropdown-wrapper">
                <button class="account-btn" id="accountBtn" onclick="toggleDropdown('accountDropdown')">
                    <span class="material-symbols-outlined">account_circle</span>
                    <%= session.getAttribute("fullName") %>
                    <span class="material-symbols-outlined chevron">expand_more</span>
                </button>
                <div class="dropdown-panel account-dropdown" id="accountDropdown">
                    <div class="account-dropdown-header">
                        <div class="account-avatar"><span class="material-symbols-outlined">person</span></div>
                        <div class="account-info">
                            <h4><%= session.getAttribute("fullName") %></h4>
                            <p><%= session.getAttribute("role") %> &bull; @<%= session.getAttribute("username") %></p>
                        </div>
                    </div>
                    <ul class="account-menu">
                        <li>
                            <a href="<%= "COUNSELOR".equals(session.getAttribute("role")) ?
                                request.getContextPath() + "/admin/dashboard" :
                                request.getContextPath() + "/student/dashboard" %>" class="account-menu-item">
                                <span class="material-symbols-outlined">dashboard</span>Dashboard
                            </a>
                        </li>
                        <li class="account-divider"></li>
                        <li>
                            <a href="${pageContext.request.contextPath}/logout" class="account-menu-item logout">
                                <span class="material-symbols-outlined">logout</span>Sign Out
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        <% } %>
    </div>
</nav>

<script>
    window.addEventListener('scroll', function () {
        var navbar = document.getElementById('main-navbar');
        if (!navbar) return;
        if (window.scrollY > 10) navbar.classList.add('scrolled');
        else navbar.classList.remove('scrolled');
    });
    function toggleDropdown(dropdownId) {
        var dropdown = document.getElementById(dropdownId);
        if (!dropdown) return;
        var overlay = document.getElementById('dropdownOverlay');
        var isOpen = dropdown.classList.contains('open');
        closeAllDropdowns();
        if (!isOpen) {
            dropdown.classList.add('open');
            overlay.classList.add('active');
            if (dropdownId === 'accountDropdown') {
                var accBtn = document.getElementById('accountBtn');
                if (accBtn) accBtn.classList.add('open');
            }
        }
    }
    function closeAllDropdowns() {
        var panels = document.querySelectorAll('.dropdown-panel');
        for (var i = 0; i < panels.length; i++) panels[i].classList.remove('open');
        var overlay = document.getElementById('dropdownOverlay');
        if (overlay) overlay.classList.remove('active');
        var accBtn = document.getElementById('accountBtn');
        if (accBtn) accBtn.classList.remove('open');
    }
    function markAllRead() {
        var items = document.querySelectorAll('.notif-item.unread');
        for (var i = 0; i < items.length; i++) items[i].classList.remove('unread');
        var badge = document.getElementById('notifBadge');
        if (badge) badge.style.display = 'none';
    }
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') closeAllDropdowns();
    });
</script>
