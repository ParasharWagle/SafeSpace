<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
    home.jsp — public landing page.
      1. Hero section (Nepali campus SVG backdrop)
      2. Features section  — matches reference image 1
      3. Dashboard section — matches reference image 2
      4. Charts section    — matches reference image 3
    Logged-out users see this as a scrollable demo of the platform.
--%>

<% request.setAttribute("navMode",   "hero"); %>
<% request.setAttribute("activeNav", "home"); %>
<%@ include file="header.jsp" %>

<style>
    /* ============================================================
       HERO
       ============================================================ */
    .hero {
        position: relative;
        min-height: calc(100vh - 72px);
        margin-top: -72px;
        padding: 72px 0 0;
        overflow: hidden;
        background: linear-gradient(135deg, #0a2e2a 0%, #0f3d36 45%, #134e47 100%);
        color: #fff;
    }
    .hero::before {
        content: '';
        position: absolute; inset: 0;
        background:
            radial-gradient(ellipse at 30% 40%, rgba(16,185,129,0.12) 0%, transparent 55%),
            radial-gradient(ellipse at 90% 10%, rgba(0,0,0,0.35) 0%, transparent 60%),
            linear-gradient(180deg, rgba(10,46,42,0.35) 0%, transparent 30%, rgba(10,46,42,0.55) 100%);
        pointer-events: none;
        z-index: 1;
    }
    .hero-backdrop {
        position: absolute; inset: 0;
        width: 100%; height: 100%;
        z-index: 0; opacity: 0.85;
    }
    .hero-inner {
        position: relative; z-index: 2;
        max-width: 1280px; margin: 0 auto;
        padding: 120px 48px 80px;
        display: grid;
        grid-template-columns: 1.15fr 1fr;
        gap: 60px;
        align-items: center;
    }
    .hero-left { max-width: 620px; }
    .hero-badge {
        display: inline-flex; align-items: center; gap: 10px;
        padding: 7px 18px;
        border-radius: 9999px;
        background: rgba(0,0,0,0.35);
        border: 1px solid rgba(255,255,255,0.12);
        backdrop-filter: blur(10px);
        font-size: 0.8rem; font-weight: 500;
        color: #fff;
        margin-bottom: 36px;
    }
    .hero-badge .badge-dot {
        width: 8px; height: 8px;
        border-radius: 50%;
        background: var(--primary);
        animation: pulse-dot 2s infinite;
    }
    @keyframes pulse-dot {
        0%   { box-shadow: 0 0 0 0 rgba(16,185,129,0.7); }
        70%  { box-shadow: 0 0 0 8px rgba(16,185,129,0); }
        100% { box-shadow: 0 0 0 0 rgba(16,185,129,0); }
    }
    .hero h1 {
        font-size: clamp(2.4rem, 5.2vw, 4.4rem);
        font-weight: 800;
        line-height: 1.05;
        letter-spacing: -0.02em;
        margin-bottom: 28px;
    }
    .hero h1 .highlight { color: var(--primary); }
    .hero-subtitle {
        font-size: 1.1rem;
        color: rgba(255,255,255,0.82);
        max-width: 520px;
        line-height: 1.65;
        margin-bottom: 40px;
    }
    .hero-buttons { display: flex; gap: 16px; flex-wrap: wrap; }
    .hero .btn-primary { padding: 16px 32px; font-size: 1rem; }
    .hero .btn-secondary {
        display: inline-flex; align-items: center; justify-content: center;
        gap: 8px;
        padding: 16px 32px;
        border-radius: 12px;
        background: rgba(255,255,255,0.06);
        color: #fff;
        border: 1.5px solid rgba(255,255,255,0.35);
        font-weight: 600; font-size: 1rem;
        backdrop-filter: blur(10px);
        transition: all 0.2s ease;
    }
    .hero .btn-secondary:hover {
        background: rgba(255,255,255,0.14);
        border-color: rgba(255,255,255,0.6);
        transform: translateY(-2px);
    }
    .hero-stats { display: flex; gap: 48px; margin-top: 64px; }
    .hero-stat-value {
        font-family: 'Manrope', sans-serif;
        font-weight: 800;
        font-size: 2.2rem;
        color: var(--primary-light);
        line-height: 1;
        margin-bottom: 6px;
    }
    .hero-stat-label { font-size: 0.82rem; color: rgba(255,255,255,0.7); font-weight: 500; }

    .hero-right {
        position: relative;
        display: flex; flex-direction: column; gap: 20px;
        justify-self: end;
        width: 340px;
    }
    .status-card {
        display: flex; align-items: center; gap: 14px;
        padding: 16px 20px;
        background: rgba(0,0,0,0.35);
        border: 1px solid rgba(255,255,255,0.12);
        border-radius: 14px;
        backdrop-filter: blur(18px);
        box-shadow: 0 8px 32px rgba(0,0,0,0.25);
        transition: transform 0.25s ease, background 0.25s ease;
    }
    .status-card:hover { transform: translateX(-6px); background: rgba(0,0,0,0.5); }
    .status-card:nth-child(2) { margin-right: -24px; }
    .status-card:nth-child(3) { margin-right: -8px; }
    .status-icon {
        width: 40px; height: 40px; border-radius: 10px;
        display: flex; align-items: center; justify-content: center;
        flex-shrink: 0;
    }
    .status-icon.green { background: rgba(16,185,129,0.2); color: var(--primary-light); }
    .status-icon.blue  { background: rgba(59,130,246,0.2); color: #60a5fa; }
    .status-icon.amber { background: rgba(245,158,11,0.2); color: #fbbf24; }
    .status-icon .material-symbols-outlined {
        font-size: 22px;
        font-variation-settings: 'FILL' 1;
    }
    .status-text h4 { font-size: 0.95rem; font-weight: 700; margin-bottom: 2px; }
    .status-text p  { font-size: 0.78rem; color: rgba(255,255,255,0.7); }

    .hero-scroll {
        position: absolute; bottom: 32px; left: 50%;
        transform: translateX(-50%);
        z-index: 2;
        display: flex; flex-direction: column; align-items: center; gap: 4px;
        color: rgba(255,255,255,0.6);
        font-size: 0.7rem; font-weight: 600;
        letter-spacing: 2px;
    }
    .hero-scroll .material-symbols-outlined {
        font-size: 20px;
        animation: bounce 1.8s ease-in-out infinite;
    }
    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50%      { transform: translateY(6px); }
    }

    /* ============================================================
       FEATURES SECTION (matches reference image 1)
       ============================================================ */
    .features-section {
        padding: 100px 0;
        background: var(--surface-lowest);
    }
    .features-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 24px;
        max-width: 1200px; margin: 0 auto;
        padding: 0 24px;
    }
    .feature-card {
        position: relative;
        padding: 32px 28px;
        border-radius: 20px;
        background: var(--surface-lowest);
        border: 1.5px solid var(--surface-high);
        transition: all 0.3s ease;
    }
    .feature-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 20px 50px rgba(16,185,129,0.1);
        border-color: var(--primary-container);
    }
    .feature-icon-chip {
        width: 52px; height: 52px;
        border-radius: 14px;
        display: flex; align-items: center; justify-content: center;
        margin-bottom: 22px;
    }
    .feature-icon-chip .material-symbols-outlined {
        font-size: 26px;
        font-variation-settings: 'FILL' 1;
    }
    /* Colour themes for each card (matches reference) */
    .feature-card.theme-green  .feature-icon-chip { background: var(--accent-green-bg); color: var(--accent-green-fg); }
    .feature-card.theme-teal   .feature-icon-chip { background: var(--accent-teal-bg);  color: var(--accent-teal-fg); }
    .feature-card.theme-blue   .feature-icon-chip { background: var(--accent-blue-bg);  color: var(--accent-blue-fg); }
    .feature-card.theme-amber  .feature-icon-chip { background: var(--accent-amber-bg); color: var(--accent-amber-fg); }
    .feature-card.theme-pink   .feature-icon-chip { background: var(--accent-pink-bg);  color: var(--accent-pink-fg); }
    .feature-card.theme-purple .feature-icon-chip { background: var(--accent-purple-bg); color: var(--accent-purple-fg); }

    /* Top-right coloured pill for each card (matches reference) */
    .feature-tag {
        position: absolute;
        top: 28px; right: 28px;
        padding: 4px 12px;
        border-radius: 9999px;
        font-size: 0.7rem; font-weight: 600;
    }
    .feature-card.theme-green  .feature-tag { background: var(--accent-green-bg); color: var(--on-primary-container); }
    .feature-card.theme-teal   .feature-tag { background: var(--accent-teal-bg);  color: #115e59; }
    .feature-card.theme-blue   .feature-tag { background: var(--accent-blue-bg);  color: #1e3a8a; }
    .feature-card.theme-amber  .feature-tag { background: var(--accent-amber-bg); color: #92400e; }
    .feature-card.theme-pink   .feature-tag { background: var(--accent-pink-bg);  color: #9d174d; }
    .feature-card.theme-purple .feature-tag { background: var(--accent-purple-bg); color: #5b21b6; }

    .feature-card h3 {
        font-size: 1.2rem;
        color: var(--on-surface);
        margin-bottom: 10px;
        font-weight: 700;
    }
    .feature-card p {
        font-size: 0.92rem;
        color: var(--on-surface-muted);
        line-height: 1.7;
        margin-bottom: 20px;
    }
    .feature-learn {
        display: inline-flex; align-items: center; gap: 4px;
        font-size: 0.85rem; font-weight: 600;
        color: var(--on-surface-muted);
        transition: color 0.2s ease;
    }
    .feature-learn:hover { color: var(--primary); }
    .feature-learn .material-symbols-outlined { font-size: 16px; }

    /* ============================================================
       DASHBOARD SECTION (matches reference image 2)
       Uses soft background, coloured-border stat cards, clean table
       ============================================================ */
    .dashboard-section {
        padding: 100px 0;
        background: var(--surface-low);
    }
    .dash-stat-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 18px;
        max-width: 1200px; margin: 0 auto 32px;
        padding: 0 24px;
    }
    .dash-stat-card {
        position: relative;
        background: var(--surface-lowest);
        border-radius: 14px;
        padding: 22px 22px 22px 30px;
        overflow: hidden;
        border: 1px solid var(--surface-high);
    }
    /* Coloured left edge on each stat card (matches reference) */
    .dash-stat-card::before {
        content: '';
        position: absolute;
        left: 0; top: 0; bottom: 0;
        width: 4px;
        border-radius: 4px 0 0 4px;
    }
    .dash-stat-card.green::before  { background: var(--accent-green-fg); }
    .dash-stat-card.amber::before  { background: var(--accent-amber-fg); }
    .dash-stat-card.teal::before   { background: var(--accent-teal-fg); }
    .dash-stat-card.red::before    { background: var(--accent-red-fg); }
    .dash-stat-card.blue::before   { background: var(--accent-blue-fg); }

    .dash-stat-header {
        display: flex; justify-content: space-between; align-items: center;
        margin-bottom: 14px;
    }
    .dash-stat-icon {
        width: 40px; height: 40px;
        border-radius: 10px;
        display: flex; align-items: center; justify-content: center;
    }
    .dash-stat-icon .material-symbols-outlined { font-size: 22px; }
    .dash-stat-card.green  .dash-stat-icon { background: var(--accent-green-bg); color: var(--accent-green-fg); }
    .dash-stat-card.amber  .dash-stat-icon { background: var(--accent-amber-bg); color: var(--accent-amber-fg); }
    .dash-stat-card.teal   .dash-stat-icon { background: var(--accent-teal-bg);  color: var(--accent-teal-fg); }
    .dash-stat-card.red    .dash-stat-icon { background: var(--accent-red-bg);   color: var(--accent-red-fg); }
    .dash-stat-card.blue   .dash-stat-icon { background: var(--accent-blue-bg);  color: var(--accent-blue-fg); }

    .dash-stat-value {
        font-family: 'Manrope', sans-serif;
        font-weight: 800;
        font-size: 2rem;
        color: var(--on-surface);
        line-height: 1;
        margin-bottom: 4px;
    }
    .dash-stat-label {
        font-size: 0.88rem;
        color: var(--on-surface-muted);
    }

    /* Recent Reports table card */
    .dash-table-card {
        background: var(--surface-lowest);
        border-radius: 16px;
        border: 1px solid var(--surface-high);
        overflow: hidden;
        max-width: 1200px; margin: 0 auto;
    }
    .dash-table-head {
        padding: 20px 28px;
        display: flex; justify-content: space-between; align-items: center;
        background: var(--surface-lowest);
        border-bottom: 1px solid var(--surface-high);
    }
    .dash-table-head h3 {
        font-size: 1rem;
        font-weight: 700;
        color: var(--on-surface);
    }
    .dash-table-head span {
        font-size: 0.78rem;
        color: var(--on-surface-hint);
    }
    .dash-table {
        width: 100%;
        border-collapse: collapse;
    }
    .dash-table th {
        text-align: left;
        padding: 14px 28px;
        font-size: 0.7rem;
        font-weight: 700;
        color: var(--on-surface-hint);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        background: var(--surface-highest);
        border-bottom: 1px solid var(--surface-high);
    }
    .dash-table td {
        padding: 18px 28px;
        font-size: 0.88rem;
        color: var(--on-surface);
        border-bottom: 1px solid var(--surface-high);
    }
    .dash-table tr:last-child td { border-bottom: none; }
    .dash-table tr:hover td { background: var(--surface-highest); }
    .dash-table .report-id {
        font-weight: 700;
        color: var(--on-surface);
    }

    /* Severity dot indicator */
    .sev-dot {
        display: inline-flex; align-items: center; gap: 8px;
    }
    .sev-dot::before {
        content: '';
        display: inline-block;
        width: 8px; height: 8px;
        border-radius: 50%;
    }
    .sev-dot.high::before     { background: var(--accent-amber-fg); }
    .sev-dot.medium::before   { background: var(--accent-amber-fg); }
    .sev-dot.critical::before { background: var(--accent-red-fg); }
    .sev-dot.low::before      { background: var(--accent-green-fg); }

    /* ============================================================
       CHARTS SECTION (matches reference image 3)
       ============================================================ */
    .charts-section {
        padding: 100px 0;
        background: var(--surface-lowest);
    }
    .charts-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
        max-width: 1200px; margin: 0 auto 24px;
        padding: 0 24px;
    }
    .chart-card {
        background: var(--surface-low);
        border-radius: 20px;
        padding: 28px;
    }
    .chart-card-header {
        display: flex; justify-content: space-between; align-items: flex-start;
        margin-bottom: 24px;
    }
    .chart-card-header h3 {
        font-size: 1.1rem;
        color: var(--on-surface);
        margin-bottom: 4px;
    }
    .chart-card-header p {
        font-size: 0.82rem;
        color: var(--on-surface-muted);
    }
    .chart-legend {
        display: flex; gap: 14px;
        font-size: 0.78rem;
        color: var(--on-surface-muted);
    }
    .chart-legend-item { display: inline-flex; align-items: center; gap: 6px; }
    .chart-legend-dot {
        width: 10px; height: 10px;
        border-radius: 50%;
        display: inline-block;
    }

    /* Weekly bar chart */
    .bar-chart-weekly {
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        gap: 10px;
        height: 220px;
        padding: 0 10px;
        position: relative;
    }
    .bar-pair { display: flex; gap: 4px; align-items: flex-end; height: 100%; flex: 1; justify-content: center; }
    .bar-filed, .bar-resolved {
        width: 18px;
        border-radius: 4px 4px 0 0;
        transition: opacity 0.2s ease;
    }
    .bar-filed    { background: var(--chart-1); }
    .bar-resolved { background: var(--chart-2); }
    .bar-pair:hover .bar-filed    { opacity: 0.8; }
    .bar-pair:hover .bar-resolved { opacity: 0.8; }
    .bar-chart-labels {
        display: flex; justify-content: space-between;
        margin-top: 12px;
        padding: 0 10px;
    }
    .bar-chart-labels span {
        flex: 1;
        text-align: center;
        font-size: 0.78rem;
        color: var(--on-surface-muted);
        font-weight: 500;
    }

    /* Category donut */
    .donut-row { display: flex; align-items: center; gap: 32px; }
    .donut-wrap {
        flex-shrink: 0;
        width: 180px; height: 180px;
        position: relative;
    }
    .donut-svg { transform: rotate(-90deg); }
    .donut-center {
        position: absolute;
        inset: 0;
        display: flex; flex-direction: column; align-items: center; justify-content: center;
    }
    .donut-center .value {
        font-family: 'Manrope', sans-serif;
        font-weight: 800;
        font-size: 2rem;
        color: var(--on-surface);
        line-height: 1;
    }
    .donut-center .label {
        font-size: 0.78rem;
        color: var(--on-surface-muted);
        margin-top: 2px;
    }

    .donut-categories {
        flex: 1;
        display: flex; flex-direction: column; gap: 12px;
    }
    .donut-row-item {
        display: grid;
        grid-template-columns: 10px 1fr auto;
        align-items: center;
        gap: 10px;
    }
    .donut-row-item .dot {
        width: 10px; height: 10px;
        border-radius: 50%;
    }
    .donut-row-item .label {
        font-size: 0.88rem; color: var(--on-surface);
    }
    .donut-row-item .pct {
        font-size: 0.88rem;
        font-weight: 700;
        color: var(--on-surface);
    }
    .donut-row-item .bar-track {
        grid-column: 2 / 4;
        height: 3px;
        background: var(--surface-high);
        border-radius: 4px;
        overflow: hidden;
        margin-top: 2px;
    }
    .donut-row-item .bar-fill { height: 100%; border-radius: 4px; }

    /* Bottom stat strip */
    .chart-stat-strip {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 24px;
        max-width: 1200px; margin: 0 auto;
        padding: 0 24px;
    }
    .chart-stat-item {
        background: var(--surface-low);
        border-radius: 16px;
        padding: 24px 28px;
        display: flex; align-items: center; gap: 18px;
    }
    .chart-stat-item .icon-box {
        width: 48px; height: 48px;
        border-radius: 12px;
        background: var(--surface-lowest);
        display: flex; align-items: center; justify-content: center;
    }
    .chart-stat-item .icon-box .material-symbols-outlined { font-size: 24px; }
    .chart-stat-item.green  .icon-box .material-symbols-outlined { color: var(--accent-green-fg); }
    .chart-stat-item.teal   .icon-box .material-symbols-outlined { color: var(--accent-teal-fg); }
    .chart-stat-item.amber  .icon-box .material-symbols-outlined { color: var(--accent-amber-fg); }
    .chart-stat-item .big-number {
        font-family: 'Manrope', sans-serif;
        font-weight: 800;
        font-size: 1.9rem;
        line-height: 1;
        margin-bottom: 4px;
    }
    .chart-stat-item.green .big-number  { color: var(--accent-green-fg); }
    .chart-stat-item.teal  .big-number  { color: var(--accent-teal-fg); }
    .chart-stat-item.amber .big-number  { color: var(--accent-amber-fg); }
    .chart-stat-item .small-label {
        font-size: 0.82rem;
        color: var(--on-surface-muted);
    }

    /* ============================================================
       RESPONSIVE
       ============================================================ */
    @media (max-width: 1024px) {
        .dash-stat-grid { grid-template-columns: repeat(2, 1fr); }
        .charts-grid { grid-template-columns: 1fr; }
        .chart-stat-strip { grid-template-columns: 1fr; }
    }
    @media (max-width: 960px) {
        .hero-inner { grid-template-columns: 1fr; padding: 80px 24px 120px; gap: 48px; }
        .hero-right { width: 100%; max-width: 340px; justify-self: center; }
        .features-grid { grid-template-columns: 1fr; }
        .donut-row { flex-direction: column; text-align: center; }
    }
    @media (max-width: 640px) {
        .hero-inner { padding: 60px 20px 120px; }
        .hero-buttons { flex-direction: column; width: 100%; }
        .dash-stat-grid { grid-template-columns: 1fr; }
        .dash-table { font-size: 0.82rem; }
        .dash-table th, .dash-table td { padding: 12px 16px; }
    }
</style>

<!-- ============================================================
     HERO
     ============================================================ -->
<section class="hero">

    <svg class="hero-backdrop" viewBox="0 0 1920 1080"
         preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
        <defs>
            <linearGradient id="skyGrad" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0%" stop-color="#0a2e2a"/>
                <stop offset="60%" stop-color="#0f3d36"/>
                <stop offset="100%" stop-color="#134e47"/>
            </linearGradient>
            <linearGradient id="mountainGrad" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0%" stop-color="#1a5b52" stop-opacity="0.65"/>
                <stop offset="100%" stop-color="#0a2e2a" stop-opacity="0.9"/>
            </linearGradient>
            <linearGradient id="buildingGrad" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0%" stop-color="#1f6a60" stop-opacity="0.85"/>
                <stop offset="100%" stop-color="#0d3b35" stop-opacity="0.95"/>
            </linearGradient>
            <linearGradient id="treeGrad" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0%" stop-color="#2a8075" stop-opacity="0.7"/>
                <stop offset="100%" stop-color="#0f4039" stop-opacity="0.9"/>
            </linearGradient>
            <linearGradient id="groundGrad" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0%" stop-color="#1a5b52" stop-opacity="0.8"/>
                <stop offset="100%" stop-color="#083029" stop-opacity="1"/>
            </linearGradient>
            <radialGradient id="windowGlow" cx="50%" cy="50%" r="50%">
                <stop offset="0%" stop-color="#fde68a" stop-opacity="0.7"/>
                <stop offset="100%" stop-color="#fde68a" stop-opacity="0"/>
            </radialGradient>
        </defs>
        <rect width="1920" height="1080" fill="url(#skyGrad)"/>
        <!-- Distant Himalayan range -->
        <path d="M0 420 L120 340 L240 390 L360 300 L480 360 L600 280 L720 330 L840 260 L960 310 L1080 240 L1200 290 L1320 220 L1440 270 L1560 210 L1680 260 L1800 230 L1920 270 L1920 600 L0 600 Z" fill="url(#mountainGrad)" opacity="0.55"/>
        <!-- Snow caps -->
        <path d="M340 310 L360 300 L390 320 L360 325 Z M700 285 L720 275 L745 300 L720 305 Z M1190 250 L1210 240 L1240 265 L1210 270 Z M1540 220 L1560 210 L1585 235 L1560 240 Z" fill="#e8f5f3" opacity="0.3"/>
        <!-- Near mountain layer -->
        <path d="M0 540 L180 460 L360 500 L540 430 L720 490 L900 440 L1080 480 L1260 420 L1440 470 L1620 430 L1800 480 L1920 450 L1920 720 L0 720 Z" fill="url(#mountainGrad)" opacity="0.75"/>
        <!-- Main college building -->
        <g opacity="0.9">
            <rect x="600" y="480" width="720" height="260" fill="url(#buildingGrad)"/>
            <rect x="590" y="470" width="740" height="14" fill="#083029" opacity="0.95"/>
            <g fill="#083029" opacity="0.6">
                <rect x="640" y="484" width="6" height="256"/>
                <rect x="720" y="484" width="6" height="256"/>
                <rect x="800" y="484" width="6" height="256"/>
                <rect x="880" y="484" width="6" height="256"/>
                <rect x="960" y="484" width="6" height="256"/>
                <rect x="1040" y="484" width="6" height="256"/>
                <rect x="1120" y="484" width="6" height="256"/>
                <rect x="1200" y="484" width="6" height="256"/>
                <rect x="1280" y="484" width="6" height="256"/>
            </g>
            <g>
                <rect x="652" y="510" width="60" height="40" fill="#fde68a" opacity="0.35" rx="2"/>
                <rect x="732" y="510" width="60" height="40" fill="#fde68a" opacity="0.28" rx="2"/>
                <rect x="812" y="510" width="60" height="40" fill="#fde68a" opacity="0.4" rx="2"/>
                <rect x="892" y="510" width="60" height="40" fill="#fde68a" opacity="0.32" rx="2"/>
                <rect x="972" y="510" width="60" height="40" fill="#fde68a" opacity="0.38" rx="2"/>
                <rect x="1052" y="510" width="60" height="40" fill="#fde68a" opacity="0.3" rx="2"/>
                <rect x="1132" y="510" width="60" height="40" fill="#fde68a" opacity="0.36" rx="2"/>
                <rect x="1212" y="510" width="60" height="40" fill="#fde68a" opacity="0.28" rx="2"/>
                <rect x="652" y="580" width="60" height="40" fill="#fde68a" opacity="0.28" rx="2"/>
                <rect x="732" y="580" width="60" height="40" fill="#fde68a" opacity="0.4" rx="2"/>
                <rect x="812" y="580" width="60" height="40" fill="#fde68a" opacity="0.3" rx="2"/>
                <rect x="892" y="580" width="60" height="40" fill="#fde68a" opacity="0.36" rx="2"/>
                <rect x="972" y="580" width="60" height="40" fill="#fde68a" opacity="0.28" rx="2"/>
                <rect x="1052" y="580" width="60" height="40" fill="#fde68a" opacity="0.4" rx="2"/>
                <rect x="1132" y="580" width="60" height="40" fill="#fde68a" opacity="0.32" rx="2"/>
                <rect x="1212" y="580" width="60" height="40" fill="#fde68a" opacity="0.38" rx="2"/>
                <rect x="652" y="660" width="60" height="60" fill="#fde68a" opacity="0.45" rx="2"/>
                <rect x="732" y="660" width="60" height="60" fill="#fde68a" opacity="0.42" rx="2"/>
                <rect x="812" y="660" width="60" height="60" fill="#fde68a" opacity="0.48" rx="2"/>
                <rect x="892" y="660" width="60" height="60" fill="#fde68a" opacity="0.4" rx="2"/>
                <rect x="972" y="660" width="60" height="60" fill="#fde68a" opacity="0.5" rx="2"/>
                <rect x="1052" y="660" width="60" height="60" fill="#fde68a" opacity="0.44" rx="2"/>
                <rect x="1132" y="660" width="60" height="60" fill="#fde68a" opacity="0.46" rx="2"/>
                <rect x="1212" y="660" width="60" height="60" fill="#fde68a" opacity="0.42" rx="2"/>
            </g>
            <ellipse cx="1002" cy="690" rx="80" ry="50" fill="url(#windowGlow)" opacity="0.6"/>
            <rect x="910" y="700" width="180" height="40" fill="#052621" opacity="0.9"/>
            <rect x="900" y="696" width="200" height="8" fill="#041d19"/>
            <line x1="960" y1="470" x2="960" y2="410" stroke="#e8f5f3" stroke-width="2" opacity="0.5"/>
            <path d="M961 410 L982 422 L961 430 L982 442 L961 450 Z" fill="#dc2626" opacity="0.7"/>
        </g>
        <!-- Left wing -->
        <g opacity="0.85">
            <rect x="300" y="540" width="260" height="200" fill="url(#buildingGrad)"/>
            <rect x="290" y="532" width="280" height="12" fill="#083029"/>
            <g fill="#fde68a">
                <rect x="330" y="570" width="40" height="32" opacity="0.35" rx="2"/>
                <rect x="390" y="570" width="40" height="32" opacity="0.3" rx="2"/>
                <rect x="450" y="570" width="40" height="32" opacity="0.38" rx="2"/>
                <rect x="510" y="570" width="40" height="32" opacity="0.32" rx="2"/>
                <rect x="330" y="625" width="40" height="32" opacity="0.3" rx="2"/>
                <rect x="390" y="625" width="40" height="32" opacity="0.4" rx="2"/>
                <rect x="450" y="625" width="40" height="32" opacity="0.32" rx="2"/>
                <rect x="510" y="625" width="40" height="32" opacity="0.36" rx="2"/>
                <rect x="330" y="680" width="40" height="50" opacity="0.42" rx="2"/>
                <rect x="390" y="680" width="40" height="50" opacity="0.4" rx="2"/>
                <rect x="450" y="680" width="40" height="50" opacity="0.46" rx="2"/>
                <rect x="510" y="680" width="40" height="50" opacity="0.38" rx="2"/>
            </g>
        </g>
        <!-- Right wing -->
        <g opacity="0.82">
            <rect x="1360" y="560" width="240" height="180" fill="url(#buildingGrad)"/>
            <rect x="1350" y="552" width="260" height="12" fill="#083029"/>
        </g>
        <!-- Foreground trees -->
        <g>
            <ellipse cx="180" cy="680" rx="70" ry="140" fill="url(#treeGrad)" opacity="0.85"/>
            <rect x="172" y="760" width="16" height="80" fill="#041d19"/>
            <ellipse cx="260" cy="720" rx="55" ry="100" fill="url(#treeGrad)" opacity="0.8"/>
            <rect x="254" y="780" width="12" height="60" fill="#041d19"/>
            <ellipse cx="1780" cy="700" rx="68" ry="130" fill="url(#treeGrad)" opacity="0.82"/>
            <rect x="1772" y="770" width="16" height="80" fill="#041d19"/>
            <ellipse cx="1680" cy="760" rx="50" ry="70" fill="url(#treeGrad)" opacity="0.75"/>
        </g>
        <rect x="0" y="740" width="1920" height="340" fill="url(#groundGrad)"/>
        <path d="M700 1080 L860 740 L1060 740 L1220 1080 Z" fill="#1a5b52" opacity="0.55"/>
        <path d="M720 1080 L880 740 L1040 740 L1200 1080 Z" fill="#2a8075" opacity="0.3"/>
        <g opacity="0.7">
            <line x1="760" y1="760" x2="760" y2="900" stroke="#041d19" stroke-width="3"/>
            <circle cx="760" cy="758" r="6" fill="#fde68a" opacity="0.8"/>
            <line x1="1160" y1="760" x2="1160" y2="900" stroke="#041d19" stroke-width="3"/>
            <circle cx="1160" cy="758" r="6" fill="#fde68a" opacity="0.8"/>
        </g>
    </svg>

    <div class="hero-inner">
        <div class="hero-left">
            <div class="hero-badge">
                <span class="badge-dot"></span>
                Trusted by 500+ Schools Nationwide
            </div>
            <h1>Report Safely.<br><span class="highlight">Get Help</span> Instantly.</h1>
            <p class="hero-subtitle">
                An anonymous reporting platform empowering students to speak up without fear &mdash;
                connecting them to support, counseling, and real change.
            </p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/login" class="btn-primary">
                    Start Anonymous Report
                    <span class="material-symbols-outlined">arrow_forward</span>
                </a>
                <a href="#dashboard" class="btn-secondary">View Dashboard Demo</a>
            </div>
            <div class="hero-stats">
                <div><div class="hero-stat-value">2,847</div><div class="hero-stat-label">Reports Resolved</div></div>
                <div><div class="hero-stat-value">10K+</div><div class="hero-stat-label">Students Protected</div></div>
                <div><div class="hero-stat-value">94%</div><div class="hero-stat-label">Resolution Rate</div></div>
            </div>
        </div>

        <div class="hero-right">
            <div class="status-card">
                <div class="status-icon green"><span class="material-symbols-outlined">verified</span></div>
                <div class="status-text"><h4>Report Submitted</h4><p>Anonymous &bull; 2 mins ago</p></div>
            </div>
            <div class="status-card">
                <div class="status-icon blue"><span class="material-symbols-outlined">support_agent</span></div>
                <div class="status-text"><h4>Counselor Assigned</h4><p>Response in &lt; 5 mins</p></div>
            </div>
            <div class="status-card">
                <div class="status-icon amber"><span class="material-symbols-outlined">task_alt</span></div>
                <div class="status-text"><h4>Case Resolved</h4><p>#SF-12 &bull; Today at 9:30am</p></div>
            </div>
        </div>
    </div>

    <a href="#features" class="hero-scroll" aria-label="Scroll to features">
        SCROLL
        <span class="material-symbols-outlined">arrow_downward</span>
    </a>
</section>


<!-- ============================================================
     FEATURES (reference image 1)
     ============================================================ -->
<section class="features-section" id="features">
    <div class="section-header">
        <div class="section-eyebrow">Platform Features</div>
        <h2 class="section-title">Everything You Need to Feel Safe</h2>
        <p class="section-subtitle">
            Comprehensive tools designed with student privacy first &mdash;
            because speaking up should never feel risky.
        </p>
    </div>

    <div class="features-grid">
        <div class="feature-card theme-green">
            <span class="feature-tag">Privacy First</span>
            <div class="feature-icon-chip"><span class="material-symbols-outlined">description</span></div>
            <h3>100% Anonymous Reporting</h3>
            <p>Submit incident reports with complete anonymity. End-to-end encryption ensures your identity is never revealed &mdash; not even to administrators.</p>
            <a href="${pageContext.request.contextPath}/login" class="feature-learn">Learn more <span class="material-symbols-outlined">arrow_forward</span></a>
        </div>
        <div class="feature-card theme-teal">
            <span class="feature-tag">24/7 Available</span>
            <div class="feature-icon-chip"><span class="material-symbols-outlined">support_agent</span></div>
            <h3>Counseling Support</h3>
            <p>Connect instantly with a trained counselor for confidential guidance. Available 24/7 via text, voice, or video sessions.</p>
            <a href="${pageContext.request.contextPath}/contact" class="feature-learn">Learn more <span class="material-symbols-outlined">arrow_forward</span></a>
        </div>
        <div class="feature-card theme-blue">
            <span class="feature-tag">500+ Resources</span>
            <div class="feature-icon-chip"><span class="material-symbols-outlined">menu_book</span></div>
            <h3>Resource Library</h3>
            <p>Access curated guides, articles, and support materials designed specifically for students dealing with bullying, stress, and safety concerns.</p>
            <a href="#" class="feature-learn">Learn more <span class="material-symbols-outlined">arrow_forward</span></a>
        </div>
        <div class="feature-card theme-amber">
            <span class="feature-tag">Real-Time</span>
            <div class="feature-icon-chip"><span class="material-symbols-outlined">notifications_active</span></div>
            <h3>Instant Alerts</h3>
            <p>Critical incidents trigger immediate notifications to the right people. Our smart routing ensures no report goes unnoticed.</p>
            <a href="#" class="feature-learn">Learn more <span class="material-symbols-outlined">arrow_forward</span></a>
        </div>
        <div class="feature-card theme-pink">
            <span class="feature-tag">For Admins</span>
            <div class="feature-icon-chip"><span class="material-symbols-outlined">monitoring</span></div>
            <h3>Analytics Dashboard</h3>
            <p>Administrators gain actionable insights through powerful visualizations &mdash; track trends, response times, and resolution rates at a glance.</p>
            <a href="#dashboard" class="feature-learn">Learn more <span class="material-symbols-outlined">arrow_forward</span></a>
        </div>
        <div class="feature-card theme-purple">
            <span class="feature-tag">Certified</span>
            <div class="feature-icon-chip"><span class="material-symbols-outlined">verified_user</span></div>
            <h3>FERPA Compliant</h3>
            <p>Fully compliant with federal student privacy laws. SOC 2 certified infrastructure with zero data selling &mdash; ever.</p>
            <a href="#" class="feature-learn">Learn more <span class="material-symbols-outlined">arrow_forward</span></a>
        </div>
    </div>
</section>


<!-- ============================================================
     DASHBOARD PREVIEW (reference image 2)
     ============================================================ -->
<section class="dashboard-section" id="dashboard">
    <div class="section-header">
        <div class="section-eyebrow">Admin Dashboard</div>
        <h2 class="section-title">Data-Driven Safety Insights</h2>
        <p class="section-subtitle">
            Real-time visibility into every incident, case status, and response metric &mdash;
            giving administrators the tools to act fast.
        </p>
    </div>

    <!-- 4 stat cards with coloured left edges -->
    <div class="dash-stat-grid">
        <div class="dash-stat-card green">
            <div class="dash-stat-header">
                <div class="dash-stat-icon"><span class="material-symbols-outlined">description</span></div>
                <span class="change-pill up">+12%</span>
            </div>
            <div class="dash-stat-value">1,284</div>
            <div class="dash-stat-label">Total Reports</div>
        </div>
        <div class="dash-stat-card amber">
            <div class="dash-stat-header">
                <div class="dash-stat-icon"><span class="material-symbols-outlined">warning</span></div>
                <span class="change-pill up">+3%</span>
            </div>
            <div class="dash-stat-value">47</div>
            <div class="dash-stat-label">Active Cases</div>
        </div>
        <div class="dash-stat-card teal">
            <div class="dash-stat-header">
                <div class="dash-stat-icon"><span class="material-symbols-outlined">check_circle</span></div>
                <span class="change-pill up">+18%</span>
            </div>
            <div class="dash-stat-value">238</div>
            <div class="dash-stat-label">Resolved This Month</div>
        </div>
        <div class="dash-stat-card red">
            <div class="dash-stat-header">
                <div class="dash-stat-icon"><span class="material-symbols-outlined">timer</span></div>
                <span class="change-pill down">-8%</span>
            </div>
            <div class="dash-stat-value">4.2m</div>
            <div class="dash-stat-label">Avg. Response Time</div>
        </div>
    </div>

    <!-- Recent Reports table -->
    <div class="dash-table-card">
        <div class="dash-table-head">
            <h3>Recent Reports</h3>
            <span>6 latest entries</span>
        </div>
        <table class="dash-table">
            <thead>
                <tr>
                    <th>Report ID</th>
                    <th>Category</th>
                    <th>Date &amp; Time</th>
                    <th>Severity</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="report-id">#SF-21</td>
                    <td>Harassment or Bullying</td>
                    <td>2026-04-22 09:14</td>
                    <td><span class="sev-dot high">High</span></td>
                    <td><span class="badge badge-new">New</span></td>
                </tr>
                <tr>
                    <td class="report-id">#SF-20</td>
                    <td>Mental Health Concern</td>
                    <td>2026-04-22 08:55</td>
                    <td><span class="sev-dot medium">Medium</span></td>
                    <td><span class="badge badge-in-progress">In Progress</span></td>
                </tr>
                <tr>
                    <td class="report-id">#SF-19</td>
                    <td>Safety Concern</td>
                    <td>2026-04-21 15:40</td>
                    <td><span class="sev-dot critical">Critical</span></td>
                    <td><span class="badge badge-in-progress">In Progress</span></td>
                </tr>
                <tr>
                    <td class="report-id">#SF-18</td>
                    <td>Cyberbullying</td>
                    <td>2026-04-21 12:22</td>
                    <td><span class="sev-dot medium">Medium</span></td>
                    <td><span class="badge badge-resolved">Resolved</span></td>
                </tr>
                <tr>
                    <td class="report-id">#SF-17</td>
                    <td>Substance Abuse</td>
                    <td>2026-04-20 17:05</td>
                    <td><span class="sev-dot low">Low</span></td>
                    <td><span class="badge badge-resolved">Resolved</span></td>
                </tr>
            </tbody>
        </table>
    </div>
</section>


<!-- ============================================================
     CHARTS (reference image 3)
     ============================================================ -->
<section class="charts-section" id="charts">
    <div class="section-header">
        <div class="section-eyebrow">Analytics</div>
        <h2 class="section-title">Visual Impact Overview</h2>
        <p class="section-subtitle">
            Understand incident patterns and response effectiveness through interactive visual reports.
        </p>
    </div>

    <div class="charts-grid">

        <!-- Weekly bar chart -->
        <div class="chart-card">
            <div class="chart-card-header">
                <div>
                    <h3>Weekly Report Volume</h3>
                    <p>Reports filed vs resolved this week</p>
                </div>
                <div class="chart-legend">
                    <span class="chart-legend-item">
                        <span class="chart-legend-dot" style="background: var(--chart-1);"></span>Filed
                    </span>
                    <span class="chart-legend-item">
                        <span class="chart-legend-dot" style="background: var(--chart-2);"></span>Resolved
                    </span>
                </div>
            </div>
            <div class="bar-chart-weekly">
                <div class="bar-pair"><div class="bar-filed" style="height: 55%;"></div><div class="bar-resolved" style="height: 38%;"></div></div>
                <div class="bar-pair"><div class="bar-filed" style="height: 72%;"></div><div class="bar-resolved" style="height: 58%;"></div></div>
                <div class="bar-pair"><div class="bar-filed" style="height: 48%;"></div><div class="bar-resolved" style="height: 40%;"></div></div>
                <div class="bar-pair"><div class="bar-filed" style="height: 95%;"></div><div class="bar-resolved" style="height: 72%;"></div></div>
                <div class="bar-pair"><div class="bar-filed" style="height: 85%;"></div><div class="bar-resolved" style="height: 65%;"></div></div>
                <div class="bar-pair"><div class="bar-filed" style="height: 25%;"></div><div class="bar-resolved" style="height: 22%;"></div></div>
                <div class="bar-pair"><div class="bar-filed" style="height: 28%;"></div><div class="bar-resolved" style="height: 18%;"></div></div>
            </div>
            <div class="bar-chart-labels">
                <span>Mon</span><span>Tue</span><span>Wed</span><span>Thu</span><span>Fri</span><span>Sat</span><span>Sun</span>
            </div>
        </div>

        <!-- Donut chart by category -->
        <div class="chart-card">
            <div class="chart-card-header">
                <div>
                    <h3>Reports by Category</h3>
                    <p>Distribution of incident types this month</p>
                </div>
            </div>
            <div class="donut-row">
                <div class="donut-wrap">
                    <%-- Pre-calc the cumulative strokes for a conic donut.
                         Using stroke-dasharray on overlapping circles.
                         Total = 100. Segments: 35, 28, 20, 11, 6         --%>
                    <svg class="donut-svg" width="180" height="180" viewBox="0 0 42 42">
                        <circle cx="21" cy="21" r="15.915" fill="transparent"
                                stroke="var(--surface-high)" stroke-width="6"/>
                        <circle cx="21" cy="21" r="15.915" fill="transparent"
                                stroke="var(--chart-1)" stroke-width="6"
                                stroke-dasharray="35 65" stroke-dashoffset="0"/>
                        <circle cx="21" cy="21" r="15.915" fill="transparent"
                                stroke="var(--chart-2)" stroke-width="6"
                                stroke-dasharray="28 72" stroke-dashoffset="-35"/>
                        <circle cx="21" cy="21" r="15.915" fill="transparent"
                                stroke="var(--chart-3)" stroke-width="6"
                                stroke-dasharray="20 80" stroke-dashoffset="-63"/>
                        <circle cx="21" cy="21" r="15.915" fill="transparent"
                                stroke="var(--chart-4)" stroke-width="6"
                                stroke-dasharray="11 89" stroke-dashoffset="-83"/>
                        <circle cx="21" cy="21" r="15.915" fill="transparent"
                                stroke="var(--chart-5)" stroke-width="6"
                                stroke-dasharray="6 94" stroke-dashoffset="-94"/>
                    </svg>
                    <div class="donut-center">
                        <div class="value">100</div>
                        <div class="label">Total Reports</div>
                    </div>
                </div>
                <div class="donut-categories">
                    <div class="donut-row-item">
                        <span class="dot" style="background: var(--chart-1);"></span>
                        <span class="label">Harassment / Bullying</span>
                        <span class="pct">35%</span>
                        <div class="bar-track"><div class="bar-fill" style="background: var(--chart-1); width: 35%;"></div></div>
                    </div>
                    <div class="donut-row-item">
                        <span class="dot" style="background: var(--chart-2);"></span>
                        <span class="label">Mental Health</span>
                        <span class="pct">28%</span>
                        <div class="bar-track"><div class="bar-fill" style="background: var(--chart-2); width: 28%;"></div></div>
                    </div>
                    <div class="donut-row-item">
                        <span class="dot" style="background: var(--chart-3);"></span>
                        <span class="label">Safety Concerns</span>
                        <span class="pct">20%</span>
                        <div class="bar-track"><div class="bar-fill" style="background: var(--chart-3); width: 20%;"></div></div>
                    </div>
                    <div class="donut-row-item">
                        <span class="dot" style="background: var(--chart-4);"></span>
                        <span class="label">Cyberbullying</span>
                        <span class="pct">11%</span>
                        <div class="bar-track"><div class="bar-fill" style="background: var(--chart-4); width: 11%;"></div></div>
                    </div>
                    <div class="donut-row-item">
                        <span class="dot" style="background: var(--chart-5);"></span>
                        <span class="label">Other</span>
                        <span class="pct">6%</span>
                        <div class="bar-track"><div class="bar-fill" style="background: var(--chart-5); width: 6%;"></div></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bottom 3-up stat strip -->
    <div class="chart-stat-strip">
        <div class="chart-stat-item green">
            <div class="icon-box"><span class="material-symbols-outlined">schedule</span></div>
            <div>
                <div class="big-number">94%</div>
                <div class="small-label">Reports resolved within 48 hours</div>
            </div>
        </div>
        <div class="chart-stat-item teal">
            <div class="icon-box"><span class="material-symbols-outlined">groups</span></div>
            <div>
                <div class="big-number">10K+</div>
                <div class="small-label">Students actively protected</div>
            </div>
        </div>
        <div class="chart-stat-item amber">
            <div class="icon-box"><span class="material-symbols-outlined">apartment</span></div>
            <div>
                <div class="big-number">500+</div>
                <div class="small-label">Partner schools nationwide</div>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>
