<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Artist — Resonance</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Syne:wght@400;500;600;700&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;1,9..40,300&display=swap" rel="stylesheet" />
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --red:        #e8302a;
      --red-light:  #ff6b5b;
      --red-deep:   #9b1a15;
      --blue:       #2563eb;
      --blue-light: #60a5fa;
      --blue-deep:  #1e3a8a;
      --grad:       linear-gradient(135deg, var(--red) 0%, #8b2be2 50%, var(--blue) 100%);
      --glass-bg:   rgba(255,255,255,0.038);
      --glass-border: rgba(255,255,255,0.09);
      --text-primary:   #f0eefa;
      --text-secondary: rgba(240,238,250,0.52);
      --text-muted:     rgba(240,238,250,0.28);
      --nav-h: 66px;
    }

    html { scroll-behavior: smooth; }

    body {
      min-height: 100vh;
      background: #07050f;
      background-image:
        radial-gradient(ellipse 80% 60% at 15% 10%, rgba(120,10,8,0.55) 0%, transparent 60%),
        radial-gradient(ellipse 70% 55% at 88% 85%, rgba(20,40,160,0.45) 0%, transparent 60%),
        radial-gradient(ellipse 50% 40% at 50% 50%, rgba(80,15,120,0.18) 0%, transparent 70%);
      color: var(--text-primary);
      font-family: 'DM Sans', sans-serif;
      font-size: 15px; line-height: 1.6;
      overflow-x: hidden;
    }

    /* ── Background ── */
    .bg-canvas { position: fixed; inset: 0; z-index: 0; overflow: hidden; pointer-events: none; }
    .orb { position: absolute; border-radius: 50%; filter: blur(140px); animation: drift 22s ease-in-out infinite alternate; }
    .orb-1 { width: 820px; height: 820px; background: #8b0a06; opacity:.24; top:-300px; left:-240px; animation-duration:24s; }
    .orb-2 { width: 600px; height: 600px; background: #0d2fa8; opacity:.22; bottom:-160px; right:-140px; animation-duration:30s; animation-delay:-10s; }
    .orb-3 { width: 420px; height: 420px; background: #6b1fa8; opacity:.18; top:38%; left:50%; animation-duration:26s; animation-delay:-6s; }
    .orb-4 { width: 300px; height: 300px; background: #c41612; opacity:.16; bottom:28%; left:7%; animation-duration:34s; animation-delay:-16s; }
    @keyframes drift {
      0%   { transform: translate(0,0) scale(1); }
      33%  { transform: translate(45px,-38px) scale(1.06); }
      66%  { transform: translate(-32px,52px) scale(0.96); }
      100% { transform: translate(22px,-22px) scale(1.03); }
    }
    .bg-canvas::after {
      content: ''; position: absolute; inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.03'/%3E%3C/svg%3E");
      opacity:.45;
    }
    .grid-lines {
      position: fixed; inset: 0; z-index: 0; pointer-events: none;
      background-image: linear-gradient(rgba(255,255,255,0.018) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.018) 1px, transparent 1px);
      background-size: 80px 80px;
      mask-image: radial-gradient(ellipse 88% 88% at 50% 45%, black 10%, transparent 100%);
    }

    .wrapper { position: relative; z-index: 1; max-width: 1200px; margin: 0 auto; padding: 0 2rem; }

    /* ── NAV ── */
    nav {
      position: sticky; top: 0; z-index: 300;
      height: var(--nav-h); display: flex; align-items: center;
      background: rgba(8,3,5,0.45);
      backdrop-filter: blur(28px) saturate(160%);
      border-bottom: 1px solid rgba(255,255,255,0.07);
      transition: background 0.45s;
    }
    nav.scrolled { background: rgba(8,3,5,0.82); }
    .nav-inner { display: flex; align-items: center; justify-content: space-between; width: 100%; }
    .logo { font-family: 'Cormorant Garamond', serif; font-size: 1.5rem; font-weight: 300; letter-spacing: 0.08em; color: var(--text-primary); text-decoration: none; display: flex; align-items: center; gap: 0.6rem; }
    .logo-icon { width: 28px; height: 28px; background: linear-gradient(135deg, var(--red), var(--red-deep)); border-radius: 6px; display: flex; align-items: center; justify-content: center; }
    .logo-icon svg { width: 16px; height: 16px; fill: #fff; }
    .logo span { color: var(--red-light); font-style: italic; }
    .nav-links { display: flex; align-items: center; gap: 0.2rem; list-style: none; }
    .nav-links a { color: var(--text-secondary); text-decoration: none; font-size: 0.84rem; font-weight: 500; letter-spacing: 0.06em; text-transform: uppercase; padding: 0.48rem 0.88rem; border-radius: 8px; transition: color 0.2s, background 0.2s; }
    .nav-links a:hover { color: var(--text-primary); background: rgba(255,255,255,0.05); }
    .nav-links .btn-library { background: linear-gradient(135deg, rgba(232,48,42,0.14), rgba(155,26,21,0.14)); border: 1px solid rgba(232,48,42,0.32); color: var(--red-light); display: flex; align-items: center; gap: 6px; }
    .nav-links .btn-library:hover { background: linear-gradient(135deg, rgba(232,48,42,0.26), rgba(155,26,21,0.26)); border-color: rgba(232,48,42,0.6); color: #fff; transform: translateY(-1px); box-shadow: 0 4px 20px rgba(232,48,42,0.18); }

    /* ── SKELETON LOADER ── */
    @keyframes shimmer {
      0%   { background-position: -600px 0; }
      100% { background-position:  600px 0; }
    }
    .skel {
      background: linear-gradient(90deg, rgba(255,255,255,0.04) 25%, rgba(255,255,255,0.09) 50%, rgba(255,255,255,0.04) 75%);
      background-size: 600px 100%;
      animation: shimmer 1.5s infinite;
      border-radius: 8px;
    }

    /* ── ERROR STATE ── */
    .error-state {
      display: flex; flex-direction: column; align-items: center;
      padding: 6rem 2rem; text-align: center; gap: 1rem;
    }
    .error-icon {
      width: 72px; height: 72px; border-radius: 18px;
      background: rgba(232,48,42,0.08); border: 1px solid rgba(232,48,42,0.18);
      display: flex; align-items: center; justify-content: center;
      margin-bottom: 0.5rem;
    }
    .error-state h3 { font-family: 'Cormorant Garamond', serif; font-size: 1.8rem; font-weight: 300; }
    .error-state p { color: var(--text-secondary); max-width: 360px; line-height: 1.7; }

    /* ── HERO SECTION ── */
    .artist-hero {
      padding: 3rem 0 0;
      display: flex;
      gap: 3.5rem;
      align-items: flex-start;
      animation: heroIn 0.55s cubic-bezier(.22,1,.36,1) both;
    }
    @keyframes heroIn {
      from { opacity: 0; transform: translateY(28px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    /* ── AVATAR ── */
    .artist-avatar-wrap {
      flex-shrink: 0;
      width: clamp(160px, 20vw, 240px);
      aspect-ratio: 1/1;
      border-radius: 50%;
      overflow: hidden;
      box-shadow: 0 24px 72px rgba(0,0,0,0.6), 0 0 0 3px rgba(232,48,42,0.22);
      position: relative;
    }
    .artist-avatar-wrap::after {
      content: '';
      position: absolute; inset: 0; border-radius: 50%;
      background: radial-gradient(circle at 30% 25%, rgba(255,255,255,0.08) 0%, transparent 60%);
      pointer-events: none;
    }
    .artist-avatar {
      width: 100%; height: 100%;
      object-fit: cover; object-position: center top;
      display: block;
    }
    .artist-avatar-monogram {
      width: 100%; height: 100%;
      display: flex; align-items: center; justify-content: center;
      font-family: 'Cormorant Garamond', serif;
      font-size: clamp(3rem, 8vw, 5rem);
      font-weight: 300;
      background: linear-gradient(135deg, rgba(232,48,42,0.32), rgba(155,26,21,0.20));
      color: var(--text-primary);
    }
    .artist-avatar-skel {
      width: clamp(160px, 20vw, 240px);
      aspect-ratio: 1/1;
      border-radius: 50%;
      flex-shrink: 0;
    }

    /* ── HERO TEXT ── */
    .artist-hero-info {
      flex: 1;
      padding-top: 0.5rem;
      min-width: 0;
    }
    .breadcrumb {
      font-family: 'Syne', sans-serif; font-size: 0.68rem; font-weight: 600;
      letter-spacing: 0.22em; text-transform: uppercase; color: var(--text-muted);
      display: flex; align-items: center; gap: 0.55rem; margin-bottom: 1rem;
    }
    .breadcrumb a { color: var(--red); text-decoration: none; opacity: 0.82; transition: opacity 0.2s; }
    .breadcrumb a:hover { opacity: 1; }
    .breadcrumb svg { width: 10px; height: 10px; opacity: 0.4; }

    .artist-name {
      font-family: 'Cormorant Garamond', serif;
      font-size: clamp(2.4rem, 5vw, 4rem);
      font-weight: 300;
      line-height: 1.05;
      margin-bottom: 0.6rem;
      background: linear-gradient(110deg, #f0eefa 30%, var(--red-light) 80%, #f0eefa 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }
    .artist-name-skel { height: 3.5rem; width: 60%; margin-bottom: 0.6rem; }
    .artist-id-badge {
      display: inline-flex; align-items: center; gap: 6px;
      font-family: 'Syne', sans-serif; font-size: 0.68rem; font-weight: 600;
      letter-spacing: 0.18em; text-transform: uppercase;
      color: var(--text-muted); margin-bottom: 1.4rem;
    }
    .artist-id-badge code {
      font-family: 'DM Sans', monospace; font-size: 0.7rem;
      background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.09);
      border-radius: 6px; padding: 0.15rem 0.5rem;
      color: var(--text-secondary); letter-spacing: 0;
    }

    /* Genre pills */
    .genre-list { display: flex; flex-wrap: wrap; gap: 0.4rem; margin-bottom: 1.6rem; }
    .genre-pill {
      font-family: 'Syne', sans-serif; font-size: 0.72rem; font-weight: 600;
      letter-spacing: 0.08em; text-transform: uppercase;
      padding: 0.3rem 0.85rem; border-radius: 100px;
      background: rgba(232,48,42,0.10); border: 1px solid rgba(232,48,42,0.26);
      color: var(--red-light);
      transition: background 0.2s, border-color 0.2s;
    }
    .genre-pill:hover { background: rgba(232,48,42,0.18); border-color: rgba(232,48,42,0.46); }

    /* Meta row */
    .meta-row { display: flex; flex-wrap: wrap; gap: 1.6rem; margin-bottom: 2rem; }
    .meta-item { display: flex; flex-direction: column; gap: 0.18rem; }
    .meta-label {
      font-family: 'Syne', sans-serif; font-size: 0.62rem; font-weight: 600;
      letter-spacing: 0.22em; text-transform: uppercase; color: var(--text-muted);
    }
    .meta-value {
      font-family: 'DM Sans', sans-serif; font-size: 0.9rem; font-weight: 400;
      color: var(--text-primary);
    }
    .meta-skel { height: 2.8rem; width: 90px; }

    /* Action buttons */
    .hero-actions { display: flex; gap: 0.75rem; flex-wrap: wrap; }
    .btn-primary {
      display: inline-flex; align-items: center; gap: 8px;
      background: linear-gradient(135deg, #e8302a 0%, #9b1a15 100%);
      color: #fff; font-family: 'Syne', sans-serif; font-size: 0.8rem;
      font-weight: 700; letter-spacing: 0.1em; text-transform: uppercase;
      border: none; border-radius: 100px; padding: 0.75rem 1.6rem;
      cursor: pointer; position: relative; overflow: hidden;
      transition: transform 0.22s, box-shadow 0.22s, filter 0.22s;
      text-decoration: none;
    }
    .btn-primary::after { content: ''; position: absolute; top: 0; left: -100%; width: 60%; height: 100%; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.22), transparent); transition: left 0.45s ease; }
    .btn-primary:hover::after { left: 140%; }
    .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 28px rgba(232,48,42,0.42); filter: brightness(1.1); }
    .btn-secondary {
      display: inline-flex; align-items: center; gap: 8px;
      background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.10);
      color: var(--text-secondary); font-family: 'Syne', sans-serif; font-size: 0.8rem;
      font-weight: 600; letter-spacing: 0.08em; text-transform: uppercase;
      border-radius: 100px; padding: 0.75rem 1.4rem;
      cursor: pointer; transition: all 0.22s; text-decoration: none;
    }
    .btn-secondary:hover { background: rgba(255,255,255,0.10); border-color: rgba(255,255,255,0.18); color: var(--text-primary); transform: translateY(-2px); }

    /* ── DIVIDER ── */
    .section-divider {
      height: 1px; background: rgba(255,255,255,0.07);
      margin: 3rem 0;
    }

    /* ── DETAILS SECTION ── */
    .details-section {
      padding-bottom: 5rem;
      animation: heroIn 0.6s 0.12s cubic-bezier(.22,1,.36,1) both;
    }
    .section-title {
      font-family: 'Syne', sans-serif; font-size: 0.7rem; font-weight: 700;
      letter-spacing: 0.28em; text-transform: uppercase;
      color: var(--text-muted); margin-bottom: 1.6rem;
      display: flex; align-items: center; gap: 0.75rem;
    }
    .section-title::after {
      content: ''; flex: 1; height: 1px;
      background: rgba(255,255,255,0.07);
    }

    /* Info grid */
    .info-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
      gap: 1px;
      background: rgba(255,255,255,0.07);
      border: 1px solid rgba(255,255,255,0.07);
      border-radius: 16px;
      overflow: hidden;
      margin-bottom: 2.5rem;
    }
    .info-cell {
      background: rgba(255,255,255,0.025);
      padding: 1.4rem 1.6rem;
      transition: background 0.2s;
    }
    .info-cell:hover { background: rgba(255,255,255,0.045); }
    .info-cell-label {
      font-family: 'Syne', sans-serif; font-size: 0.62rem; font-weight: 600;
      letter-spacing: 0.2em; text-transform: uppercase;
      color: var(--text-muted); margin-bottom: 0.45rem;
    }
    .info-cell-value {
      font-family: 'DM Sans', sans-serif; font-size: 0.92rem; font-weight: 400;
      color: var(--text-primary); line-height: 1.5;
    }
    .info-cell-value.empty { color: var(--text-muted); font-style: italic; font-size: 0.82rem; }
    .info-cell-value a { color: var(--red-light); text-decoration: none; transition: opacity 0.2s; }
    .info-cell-value a:hover { opacity: 0.75; }

    /* Skeleton cells */
    .info-cell-skel .info-cell-value { height: 1.1rem; border-radius: 6px; }

    /* ── BACK BUTTON ── */
    .btn-back {
      display: inline-flex; align-items: center; gap: 8px;
      background: linear-gradient(135deg, rgba(232,48,42,0.10), rgba(155,26,21,0.07));
      border: 1px solid rgba(232,48,42,0.24); color: var(--red-light);
      font-family: 'Syne', sans-serif; font-size: 0.8rem; font-weight: 600;
      letter-spacing: 0.1em; text-transform: uppercase; text-decoration: none;
      padding: 0.7rem 1.4rem; border-radius: 100px; transition: all 0.28s;
    }
    .btn-back:hover { background: linear-gradient(135deg, rgba(232,48,42,0.22), rgba(155,26,21,0.18)); border-color: rgba(232,48,42,0.5); color: #fff; transform: translateY(-2px); }

    footer { border-top: 1px solid rgba(255,255,255,0.07); padding: 2rem 0; text-align: center; }
    footer p { font-size: .8rem; color: var(--text-muted); }
    footer a { color: var(--red); text-decoration: none; opacity: .72; }
    footer a:hover { opacity: 1; }

    @media (max-width: 720px) {
      .artist-hero { flex-direction: column; align-items: center; text-align: center; gap: 2rem; }
      .breadcrumb { justify-content: center; }
      .genre-list  { justify-content: center; }
      .meta-row    { justify-content: center; }
      .hero-actions { justify-content: center; }
    }
  </style>
</head>
<body>

<div class="bg-canvas" aria-hidden="true">
  <div class="orb orb-1"></div>
  <div class="orb orb-2"></div>
  <div class="orb orb-3"></div>
  <div class="orb orb-4"></div>
</div>
<div class="grid-lines" aria-hidden="true"></div>

<!-- NAV -->
<nav id="main-nav">
  <div class="wrapper">
    <div class="nav-inner">
      <a href="${pageContext.request.contextPath}/" class="logo">
        <div class="logo-icon" aria-hidden="true">
          <svg viewBox="0 0 24 24"><path d="M12 3a9 9 0 100 18A9 9 0 0012 3zm0 2a7 7 0 110 14A7 7 0 0112 5zm-1 3v5.586l-2.707 2.707 1.414 1.414L13 15.414V8h-2z"/></svg>
        </div>
        Reso<span>Nance</span>
      </a>
      <ul class="nav-links">
        <li><a href="#">About</a></li>
        <li><a href="#">Genres</a></li>
        <li>
          <a href="${pageContext.request.contextPath}/artists" class="btn-library">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg>
            Artist Library
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<main>
  <div class="wrapper">

    <!-- SKELETON shown while fetching -->
    <div id="skeleton-view">
      <div class="artist-hero">
        <div class="artist-avatar-skel skel"></div>
        <div class="artist-hero-info" style="flex:1">
          <div class="skel" style="height:0.75rem;width:160px;margin-bottom:1.2rem;border-radius:4px;"></div>
          <div class="artist-name-skel skel"></div>
          <div class="skel" style="height:0.75rem;width:100px;margin-bottom:1.6rem;border-radius:4px;"></div>
          <div style="display:flex;gap:0.6rem;margin-bottom:1.6rem;">
            <div class="skel" style="height:1.8rem;width:80px;border-radius:100px;"></div>
            <div class="skel" style="height:1.8rem;width:60px;border-radius:100px;"></div>
          </div>
          <div style="display:flex;gap:1.6rem;margin-bottom:2rem;">
            <div class="meta-skel skel"></div>
            <div class="meta-skel skel"></div>
            <div class="meta-skel skel"></div>
          </div>
          <div style="display:flex;gap:0.75rem;">
            <div class="skel" style="height:2.6rem;width:130px;border-radius:100px;"></div>
            <div class="skel" style="height:2.6rem;width:110px;border-radius:100px;"></div>
          </div>
        </div>
      </div>
      <div class="section-divider"></div>
      <div class="info-grid">
        <div class="info-cell info-cell-skel" style="padding:1.4rem 1.6rem" aria-hidden="true">
          <div class="skel" style="height:0.65rem;width:70px;margin-bottom:0.55rem;border-radius:4px;"></div>
          <div class="skel info-cell-value"></div>
        </div>
        <div class="info-cell info-cell-skel" aria-hidden="true">
          <div class="skel" style="height:0.65rem;width:55px;margin-bottom:0.55rem;border-radius:4px;"></div>
          <div class="skel info-cell-value"></div>
        </div>
        <div class="info-cell info-cell-skel" aria-hidden="true">
          <div class="skel" style="height:0.65rem;width:80px;margin-bottom:0.55rem;border-radius:4px;"></div>
          <div class="skel info-cell-value"></div>
        </div>
        <div class="info-cell info-cell-skel" aria-hidden="true">
          <div class="skel" style="height:0.65rem;width:60px;margin-bottom:0.55rem;border-radius:4px;"></div>
          <div class="skel info-cell-value"></div>
        </div>
      </div>
    </div>

    <!-- ERROR STATE (hidden until needed) -->
    <div id="error-view" style="display:none">
      <div class="error-state">
        <div class="error-icon" aria-hidden="true">
          <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--red-light)" stroke-width="1.5" stroke-linecap="round">
            <circle cx="12" cy="12" r="9"/><line x1="12" y1="8" x2="12" y2="12"/><circle cx="12" cy="16" r="0.5" fill="var(--red-light)"/>
          </svg>
        </div>
        <h3>Artist not found</h3>
        <p id="error-msg">We couldn't load this artist's profile. The record may have been removed or the ID is invalid.</p>
        <div style="display:flex;gap:0.75rem;margin-top:1rem;flex-wrap:wrap;justify-content:center;">
          <a href="javascript:history.back()" class="btn-back">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" aria-hidden="true"><line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/></svg>
            Go Back
          </a>
        </div>
      </div>
    </div>

    <!-- ARTIST CONTENT (hidden until loaded) -->
    <div id="artist-view" style="display:none">

      <!-- Hero -->
      <div class="artist-hero" id="artist-hero-section">

        <div class="artist-avatar-wrap" id="avatar-wrap">
          <!-- injected by JS -->
        </div>

        <div class="artist-hero-info">
          <nav class="breadcrumb" aria-label="Breadcrumb">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><polyline points="9 18 15 12 9 6"/></svg>
            <a id="back-to-search-link" href="javascript:history.back()">Search Results</a>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><polyline points="9 18 15 12 9 6"/></svg>
            <span id="breadcrumb-name" aria-current="page">Artist</span>
          </nav>

          <h1 class="artist-name" id="artist-name">—</h1>

          <div class="artist-id-badge">
            ID <code id="artist-id-display">—</code>
          </div>

          <div class="genre-list" id="genre-list">
            <!-- pills injected -->
          </div>

          <div class="meta-row" id="meta-row">
            <!-- meta items injected -->
          </div>
        </div>
      </div>

      <div class="section-divider"></div>

      <!-- Details -->
      <div class="details-section">
        <div class="section-title">Profile Details</div>
        <div class="info-grid" id="info-grid">
          <!-- cells injected -->
        </div>
      </div>

    </div><!-- /artist-view -->

  </div><!-- /wrapper -->
</main>

<footer>
  <div class="wrapper">
    <p>Resonance Music Artist Registry &nbsp;&middot;&nbsp; <a href="#">API Docs</a> &nbsp;&middot;&nbsp; <a href="#">Privacy</a></p>
  </div>
</footer>

<script>
  /* Context root injected server-side */
  const CTX = '${pageContext.request.contextPath}';

  /* ── Nav scroll effect ── */
  const mainNav = document.getElementById('main-nav');
  window.addEventListener('scroll', () => {
    mainNav.classList.toggle('scrolled', window.scrollY > 20);
  }, { passive: true });

  /* ── Helpers ── */
  function el(id) { return document.getElementById(id); }

  function escHtml(str) {
    if (str == null) return '';
    return String(str)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;');
  }

  function val(v) {
    return (v !== null && v !== undefined && String(v).trim() !== '')
      ? escHtml(v) : null;
  }

  /* ── Extract ?id= from URL ── */
  function getArtistId() {
    const params = new URLSearchParams(window.location.search);
    return params.get('id');
  }

  /* ── Show / hide panels ── */
  function showSkeleton() {
    el('skeleton-view').style.display = '';
    el('artist-view').style.display   = 'none';
    el('error-view').style.display    = 'none';
  }
  function showError(msg) {
    el('skeleton-view').style.display = 'none';
    el('artist-view').style.display   = 'none';
    el('error-view').style.display    = '';
    if (msg) el('error-msg').textContent = msg;
  }
  function showArtist() {
    el('skeleton-view').style.display = 'none';
    el('error-view').style.display    = 'none';
    el('artist-view').style.display   = '';
  }

  /* ── Build avatar ── */
  function buildAvatar(artist) {
    const wrap = el('avatar-wrap');
    if (artist.imageURL) {
      const img = document.createElement('img');
      img.className = 'artist-avatar';
      img.src       = artist.imageURL;
      img.alt       = artist.name || 'Artist photo';
      img.width     = 240;
      img.height    = 240;
      img.onerror   = () => {
        img.remove();
        wrap.innerHTML = `<div class="artist-avatar-monogram" aria-hidden="true">\${escHtml((artist.name || '?')[0].toUpperCase())}</div>`;
      };
      wrap.appendChild(img);
    } else {
      wrap.innerHTML = `<div class="artist-avatar-monogram" aria-hidden="true">\${escHtml((artist.name || '?')[0].toUpperCase())}</div>`;
    }
  }

  /* ── Build genre pills ── */
  /* Java HashSet<String> serialises to a JSON array e.g. ["Rock","Pop"] */
  function buildGenres(artist) {
    const list = el('genre-list');
    const genres = Array.isArray(artist.genre) ? artist.genre : [];

    if (genres.length === 0) {
      list.innerHTML = '<span class="genre-pill">Artist</span>';
      return;
    }
    list.innerHTML = genres.map(g => `<span class="genre-pill">\${escHtml(g)}</span>`).join('');
  }

  /* ── Format ArtistType enum → readable label ── */
  /* e.g. "SOLO_ARTIST" → "Solo Artist", "BAND" → "Band" */
  function formatType(raw) {
    if (!raw) return null;
    return String(raw)
      .toLowerCase()
      .replace(/_/g, ' ')
      .replace(/\b\w/g, c => c.toUpperCase());
  }

  /* ── Build meta row (prominent top-level fields) ── */
  /* Artist DTO fields surfaced here: country, type */
  function buildMeta(artist) {
    const row   = el('meta-row');
    const items = [];

    if (val(artist.country)) {
      items.push({ label: 'Country', value: val(artist.country) });
    }
    if (artist.type) {
      items.push({ label: 'Type', value: escHtml(formatType(artist.type)) });
    }

    if (items.length === 0) return;

    row.innerHTML = items.map(item => `
      <div class="meta-item">
        <div class="meta-label">\${item.label}</div>
        <div class="meta-value">\${item.value}</div>
      </div>
    `).join('');
  }

  /* ── Build info grid ── */
  /* Maps all Artist DTO fields not already shown in the hero/meta row.
     DTO: mongoId, id, name, type, bio, country, genre (Set<String>), imageURL */
  function buildInfoGrid(artist) {
    const grid  = el('info-grid');
    const cells = [];

    /* Bio — full-width feel, spans nicely in auto-fill grid */
    if (val(artist.bio)) {
      cells.push({ label: 'Biography', display: escHtml(artist.bio), wide: true });
    }

    /* Genres — also shown as pills in hero, but listed here as plain text for completeness */
    const genres = Array.isArray(artist.genre) ? artist.genre : [];
    if (genres.length > 0) {
      cells.push({ label: 'Genres', display: genres.map(g => escHtml(g)).join(', ') });
    }

    /* Country */
    if (val(artist.country)) {
      cells.push({ label: 'Country', display: val(artist.country) });
    }

    /* Artist type */
    if (artist.type) {
      cells.push({ label: 'Artist Type', display: escHtml(formatType(artist.type)) });
    }

    /* Artist ID (the domain id field, not mongoId) */
    if (val(artist.id)) {
      cells.push({ label: 'Artist ID', display: `<code style="font-size:0.82rem;letter-spacing:0;">\${escHtml(artist.id)}</code>` });
    }

    if (cells.length === 0) {
      grid.innerHTML = `<div class="info-cell" style="grid-column:1/-1">
        <span class="info-cell-value empty">No additional details available.</span>
      </div>`;
      return;
    }

    grid.innerHTML = cells.map(({ label, display, wide }) => `
      <div class="info-cell"\${wide ? ' style="grid-column:1/-1"' : ''}>
        <div class="info-cell-label">\${escHtml(label)}</div>
        <div class="info-cell-value">\${display}</div>
      </div>
    `).join('');
  }

  /* ── Render artist ── */
  function renderArtist(artist) {
    /* Page title */
    document.title = (artist.name ? artist.name + ' — ' : '') + 'Resonance';

    /* Breadcrumb + name */
    el('breadcrumb-name').textContent = artist.name || 'Artist';
    el('artist-name').textContent     = artist.name || 'Unknown Artist';
    el('artist-id-display').textContent = artist.id ?? '—';

    buildAvatar(artist);
    buildGenres(artist);
    buildMeta(artist);
    buildInfoGrid(artist);

    showArtist();
  }

  /* ── Fetch & render ── */
  async function loadArtist() {
    const id = getArtistId();

    if (!id) {
      showError('No artist ID was provided in the URL. Please go back to the search results and select an artist.');
      return;
    }

    showSkeleton();

    try {
      /* Use the server-injected context root for the API call */
      const response = await fetch(`\${CTX}/api/artists/\${encodeURIComponent(id)}`, {
        headers: { 'Accept': 'application/json' }
      });

      if (response.status === 404) {
        showError(`No artist found with ID "\${escHtml(id)}".`);
        return;
      }
      if (!response.ok) {
        showError(`Failed to load artist (HTTP \${response.status}). Please try again.`);
        return;
      }

      const artist = await response.json();

      /* Spring ResponseEntity can return HTTP 200 with a null body if orElse(null) resolves */
      if (!artist || typeof artist !== 'object') {
        showError(`No artist found with ID "\${escHtml(id)}".`);
        return;
      }

      renderArtist(artist);

    } catch (err) {
      console.error('Artist fetch error:', err);
      showError('A network error occurred. Please check your connection and try again.');
    }
  }

  /* ── Boot ── */
  loadArtist();
</script>

</body>
</html>
