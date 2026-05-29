<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Resonance — Music Artist Registry</title>
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
      --grad-text:  linear-gradient(100deg, var(--red-light) 0%, #c084fc 50%, var(--blue-light) 100%);
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
      background-image: radial-gradient(ellipse 80% 60% at 15% 10%, rgba(120,10,8,0.55) 0%, transparent 60%),
                        radial-gradient(ellipse 70% 55% at 88% 85%, rgba(20,40,160,0.45) 0%, transparent 60%),
                        radial-gradient(ellipse 50% 40% at 50% 50%, rgba(80,15,120,0.18) 0%, transparent 70%);
      color: var(--text-primary);
      font-family: 'DM Sans', sans-serif;
      font-size: 15px; line-height: 1.6;
      overflow-x: hidden;
    }

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
  content: ''; 
  position: absolute; 
  inset: 0;
  /* Fixed: Swapped internal single quotes and ensured data URI parsing integrity */
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.03'/%3E%3C/svg%3E");
  opacity: .45;
}
    .grid-lines {
      position: fixed; inset: 0; z-index: 0; pointer-events: none;
      background-image: linear-gradient(rgba(255,255,255,0.018) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.018) 1px, transparent 1px);
      background-size: 80px 80px;
      mask-image: radial-gradient(ellipse 88% 88% at 50% 45%, black 10%, transparent 100%);
    }

    .wrapper { position: relative; z-index: 1; max-width: 1100px; margin: 0 auto; padding: 0 2rem; }

    /* NAV */
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

    /* SEARCH BAR */
    .search-bar-zone {
      position: sticky; top: var(--nav-h); z-index: 200;
      display: flex; justify-content: center;
      padding: 0.9rem 2rem;
      background: transparent;
      border-bottom: 1px solid transparent;
      transition: background 0.5s ease, border-color 0.5s ease, padding 0.4s ease;
    }
    .search-bar-zone.scrolled {
      background: rgba(8,3,5,0.32);
      border-bottom-color: rgba(255,255,255,0.055);
      backdrop-filter: blur(22px) saturate(150%);
      padding: 0.65rem 2rem;
    }
    .search-panel {
      width: 100%; max-width: 680px;
      background: rgba(255,255,255,0.048);
      backdrop-filter: blur(28px) saturate(160%);
      border: 1px solid rgba(255,255,255,0.10);
      border-radius: 18px;
      padding: 1.1rem 1.4rem 1.25rem;
      box-shadow: 0 4px 40px rgba(0,0,0,0.35), inset 0 1px 0 rgba(255,255,255,0.08);
      transition: border-color 0.3s, box-shadow 0.3s, padding 0.4s;
    }
    .search-bar-zone.scrolled .search-panel { padding: 0.82rem 1.4rem 0.92rem; }
    .search-panel:focus-within { border-color: rgba(232,48,42,0.38); box-shadow: 0 4px 40px rgba(0,0,0,0.35), 0 0 0 3px rgba(232,48,42,0.07), inset 0 1px 0 rgba(255,255,255,0.08); }
    .search-label {
      font-family: 'Syne', sans-serif; font-size: 0.66rem; font-weight: 600;
      letter-spacing: 0.24em; text-transform: uppercase; color: var(--text-muted);
      display: block; margin-bottom: 0.7rem;
      max-height: 2em; overflow: hidden;
      transition: max-height 0.38s ease, opacity 0.3s ease, margin-bottom 0.38s ease;
    }
    .search-bar-zone.scrolled .search-label { max-height: 0; opacity: 0; margin-bottom: 0; }
    .search-row { display: flex; gap: 0.65rem; }
    .search-input-wrap { flex: 1; position: relative; }
    .search-input-wrap svg { position: absolute; left: 14px; top: 50%; transform: translateY(-50%); color: var(--text-muted); pointer-events: none; width: 17px; height: 17px; transition: color 0.2s; }
    .search-input-wrap:focus-within svg { color: var(--red-light); }
    .search-input { width: 100%; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.08); border-radius: 11px; color: var(--text-primary); font-family: 'DM Sans', sans-serif; font-size: 0.93rem; padding: 0.76rem 1rem 0.76rem 2.6rem; outline: none; transition: background 0.22s, border-color 0.22s, box-shadow 0.22s; }
    .search-input::placeholder { color: var(--text-muted); }
    .search-input:focus { background: rgba(255,255,255,0.08); border-color: rgba(232,48,42,0.38); box-shadow: 0 0 0 3px rgba(232,48,42,0.07); }
    .btn-search { background: linear-gradient(135deg, #e8302a 0%, #9b1a15 100%); color: #fff; font-family: 'Syne', sans-serif; font-size: 0.79rem; font-weight: 700; letter-spacing: 0.1em; text-transform: uppercase; border: none; border-radius: 11px; padding: 0 1.3rem; cursor: pointer; white-space: nowrap; display: flex; align-items: center; gap: 7px; position: relative; overflow: hidden; transition: transform 0.22s, box-shadow 0.22s, filter 0.22s; }
    .btn-search::after { content: ''; position: absolute; top: 0; left: -100%; width: 60%; height: 100%; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.22), transparent); transition: left 0.45s ease; }
    .btn-search:hover::after { left: 140%; }
    .btn-search:hover { transform: translateY(-2px); box-shadow: 0 8px 28px rgba(232,48,42,0.42); filter: brightness(1.1); }
    .search-filters { display: flex; gap: 0.4rem; flex-wrap: wrap; margin-top: 0.72rem; }
    .chip { font-size: 0.7rem; font-family: 'Syne', sans-serif; font-weight: 500; padding: 0.24rem 0.72rem; border-radius: 100px; border: 1px solid rgba(255,255,255,0.09); background: rgba(255,255,255,0.04); color: var(--text-secondary); cursor: pointer; transition: all 0.2s; user-select: none; }
    .chip:hover { border-color: rgba(232,48,42,0.4); background: rgba(232,48,42,0.09); color: var(--red-light); }
    .chip.active { border-color: rgba(232,48,42,0.52); background: rgba(232,48,42,0.12); color: var(--red-light); }

    /* HERO */
    .hero { padding: 5.5rem 0 4.5rem; text-align: center; display: flex; flex-direction: column; align-items: center; }
    .hero-eyebrow { font-family: 'Syne', sans-serif; font-size: 0.69rem; font-weight: 600; letter-spacing: 0.32em; text-transform: uppercase; color: var(--red); margin-bottom: 1.4rem; display: flex; align-items: center; gap: 10px; }
    .hero-eyebrow::before, .hero-eyebrow::after { content: ''; display: block; width: 28px; height: 1px; background: linear-gradient(90deg, transparent, var(--red)); }
    .hero-eyebrow::after { background: linear-gradient(90deg, var(--red), transparent); }
    .hero h1 { font-family: 'Cormorant Garamond', serif; font-size: clamp(3.4rem, 7vw, 6.5rem); font-weight: 300; line-height: 1.06; color: var(--text-primary); margin-bottom: 1.35rem; max-width: 760px; }
    .hero h1 em { font-style: italic; background: linear-gradient(100deg, var(--red-light) 0%, var(--red) 55%, #ff8a80 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
    .hero-sub { font-size: 1rem; color: var(--text-secondary); max-width: 460px; line-height: 1.8; }
    .parallax-hero { will-change: transform; }

    /* RESULTS */
    #results-section { padding: 3rem 0; }
    .results-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.5rem; }
    .results-title { font-family: 'Cormorant Garamond', serif; font-size: 1.5rem; font-weight: 400; }
    .results-count { font-size: 0.79rem; color: var(--text-muted); font-family: 'Syne', sans-serif; }
    .results-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(288px, 1fr)); gap: 1.15rem; }

    /* ARTIST CARD */
    .artist-card { background: rgba(255,255,255,0.038); backdrop-filter: blur(18px); border: 1px solid rgba(255,255,255,0.08); border-radius: 16px; padding: 1.45rem; cursor: pointer; position: relative; overflow: hidden; display: flex; flex-direction: column; gap: 1rem; animation: fadeUp .45s ease both; transition: transform 0.38s cubic-bezier(.22,1,.36,1), border-color 0.35s, box-shadow 0.35s; }
    .artist-card::before { content: ''; position: absolute; inset: 0; border-radius: 16px; background: linear-gradient(135deg, rgba(232,48,42,0.07) 0%, rgba(155,26,21,0.05) 60%, rgba(255,107,96,0.04) 100%); opacity: 0; transition: opacity 0.35s; }
    .glare { position: absolute; border-radius: 50%; pointer-events: none; background: radial-gradient(circle, rgba(255,255,255,0.055) 0%, transparent 68%); width: 180px; height: 180px; transform: translate(-50%,-50%); opacity: 0; transition: opacity 0.28s; }
    .artist-card:hover { transform: translateY(-6px) scale(1.013); border-color: rgba(232,48,42,0.28); box-shadow: 0 24px 60px rgba(0,0,0,0.48), 0 0 0 1px rgba(232,48,42,0.1), inset 0 1px 0 rgba(255,255,255,0.09); }
    .artist-card:hover::before { opacity: 1; }
    .artist-card:hover .glare { opacity: 1; }
    @keyframes fadeUp { from { opacity:0; transform:translateY(22px) scale(0.98); } to { opacity:1; transform:translateY(0) scale(1); } }
    .artist-avatar { width: 52px; height: 52px; border-radius: 11px; display: flex; align-items: center; justify-content: center; font-family: 'Cormorant Garamond', serif; font-size: 1.3rem; font-weight: 400; background: linear-gradient(135deg, rgba(232,48,42,0.18), rgba(155,26,21,0.18)); border: 1px solid rgba(232,48,42,0.18); flex-shrink: 0; transition: transform 0.3s, border-color 0.3s; }
    .artist-card:hover .artist-avatar { transform: scale(1.08); border-color: rgba(232,48,42,0.38); }
    .artist-info { flex: 1; }
    .artist-name { font-family: 'Cormorant Garamond', serif; font-size: 1.18rem; font-weight: 400; color: var(--text-primary); margin-bottom: 0.2rem; }
    .artist-genre { font-size: 0.72rem; color: var(--red-light); font-family: 'Syne', sans-serif; font-weight: 500; letter-spacing: 0.09em; text-transform: uppercase; margin-bottom: 0.32rem; }
    .artist-meta { font-size: 0.8rem; color: var(--text-secondary); }
    .artist-card-footer { display: flex; align-items: center; justify-content: space-between; border-top: 1px solid rgba(255,255,255,0.055); padding-top: 0.72rem; }
    .artist-tag { font-size: 0.68rem; padding: 0.16rem 0.56rem; background: rgba(255,255,255,0.055); border-radius: 100px; color: var(--text-secondary); }
    .arrow-btn { width: 27px; height: 27px; border-radius: 50%; background: rgba(232,48,42,0.1); border: 1px solid rgba(232,48,42,0.22); display: flex; align-items: center; justify-content: center; transition: all 0.24s; }
    .artist-card:hover .arrow-btn { background: rgba(232,48,42,0.22); border-color: rgba(232,48,42,0.52); transform: translateX(3px); }
    .state-box { grid-column:1/-1; text-align:center; padding:3rem 1rem; }
    .state-box p { color: var(--text-secondary); font-size: .95rem; }
    .state-icon { width:52px; height:52px; border-radius:13px; background:rgba(255,255,255,0.04); border:1px solid rgba(255,255,255,0.08); display:flex; align-items:center; justify-content:center; margin:0 auto 1rem; }

    /* REVEAL */
    .reveal { opacity: 0; transform: translateY(30px); transition: opacity 0.75s ease, transform 0.75s ease; }
    .reveal.in-view { opacity: 1; transform: translateY(0); }
    .reveal-d1 { transition-delay: 0.10s; }
    .reveal-d2 { transition-delay: 0.22s; }
    .reveal-d3 { transition-delay: 0.34s; }

    /* CTA */
    .cta-section { padding: 5rem 0 8rem; text-align: center; }
    .cta-card { background: rgba(10,4,4,0.72); backdrop-filter: blur(40px) saturate(180%); border: 1px solid rgba(255,255,255,0.08); border-radius: 26px; padding: 4.5rem 3rem; position: relative; overflow: hidden; max-width: 720px; margin: 0 auto; transition: border-color 0.4s, box-shadow 0.4s; }
    .cta-card::before { content: ''; position: absolute; top: 0; left: 8%; right: 8%; height: 1px; background: linear-gradient(90deg, transparent, rgba(232,48,42,0.6), rgba(255,107,96,0.4), transparent); }
    .cta-card::after { content: ''; position: absolute; inset: 0; border-radius: 26px; background: radial-gradient(ellipse 70% 50% at 50% 0%, rgba(155,26,21,0.10) 0%, transparent 70%); pointer-events: none; }
    .cta-card:hover { border-color: rgba(232,48,42,0.20); box-shadow: 0 30px 80px rgba(155,26,21,0.14), 0 0 0 1px rgba(232,48,42,0.07); }
    .cta-card h2 { font-family: 'Cormorant Garamond', serif; font-size: clamp(2rem, 4vw, 3.2rem); font-weight: 300; line-height: 1.18; margin-bottom: 1rem; position: relative; z-index: 1; }
    .cta-card h2 em { font-style: italic; background: linear-gradient(100deg, var(--red-light), var(--red)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
    .cta-card p { color: var(--text-secondary); font-size: .95rem; max-width: 400px; margin: 0 auto 2.5rem; line-height: 1.78; position: relative; z-index: 1; }
    .btn-cta { display: inline-flex; align-items: center; gap: 10px; background: linear-gradient(135deg, rgba(232,48,42,0.18), rgba(155,26,21,0.14)); border: 1px solid rgba(232,48,42,0.38); color: var(--red-light); font-family: 'Syne', sans-serif; font-size: .88rem; font-weight: 600; letter-spacing: 0.09em; text-transform: uppercase; text-decoration: none; padding: 1rem 2.25rem; border-radius: 100px; transition: all 0.3s; position: relative; z-index: 1; }
    .btn-cta:hover { background: linear-gradient(135deg, rgba(232,48,42,0.32), rgba(155,26,21,0.28)); border-color: rgba(232,48,42,0.68); color: #fff; transform: translateY(-2px); box-shadow: 0 12px 36px rgba(232,48,42,0.25); }
    .btn-cta svg { transition: transform 0.22s; }
    .btn-cta:hover svg { transform: translateX(5px); }
    .cta-stats { display: flex; justify-content: center; gap: 3.5rem; margin-top: 3rem; padding-top: 2rem; border-top: 1px solid rgba(255,255,255,0.07); position: relative; z-index: 1; }
    .stat-item { text-align: center; }
    .stat-value { font-family: 'Cormorant Garamond', serif; font-size: 2.35rem; font-weight: 300; color: var(--text-primary); display: block; }
    .stat-label { font-size: .7rem; color: var(--text-muted); font-family: 'Syne', sans-serif; letter-spacing: .12em; text-transform: uppercase; }

    footer { border-top: 1px solid rgba(255,255,255,0.07); padding: 2rem 0; text-align: center; }
    footer p { font-size: .8rem; color: var(--text-muted); }
    footer a { color: var(--red); text-decoration: none; opacity: .72; }
    footer a:hover { opacity: 1; }

    .no-results-hidden { display: none; }
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

<nav id="main-nav">
  <div class="wrapper">
    <div class="nav-inner">
      <a href="${pageContext.request.contextPath}/" class="logo">
        <div class="logo-icon" aria-hidden="true">
          <svg viewBox="0 0 24 24"><path d="M12 3a9 9 0 100 18A9 9 0 0012 3zm0 2a7 7 0 110 14A7 7 0 0112 5zm-1 3v5.586l-2.707 2.707 1.414 1.414L13 15.414V8h-2z"/></svg>
        </div>
        Reso<span>nance</span>
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

<%-- Search form submits GET to /api/artists/search — results returned in ${artists} model attribute --%>
<div class="search-bar-zone" id="search-zone" role="search">
  <div class="search-panel">
    <span class="search-label">Find an Artist</span>
    <form method="get" action="${pageContext.request.contextPath}/search" id="search-form">
      <div class="search-row">
        <div class="search-input-wrap">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
            <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
          </svg>
          <%-- Pre-fill input with the last searched value via EL --%>
          <input id="search-input"
                 name="name"
                 class="search-input"
                 type="search"
                 placeholder="Artist name, stage name…"
                 autocomplete="off"
                 aria-label="Search for an artist by name"
                 value="${fn:escapeXml(param.name)}" />
          <%-- Hidden genre field updated by chip JS below --%>
          <input type="hidden" id="genre-input" name="genre" value="${fn:escapeXml(param.genre)}" />
        </div>
        <button type="submit" class="btn-search" id="search-btn" aria-label="Run search">
          Search
        </button>
      </div>
    </form>

    <%-- Genre filter chips — active chip is highlighted via EL comparison --%>
    <div class="search-filters" role="group" aria-label="Filter by genre">
      <button class="chip ${empty param.genre ? 'active' : ''}" data-genre="">All</button>
      <c:forEach var="g" items="${genres}">
        <button class="chip ${param.genre eq g ? 'active' : ''}" data-genre="${g}">${g}</button>
      </c:forEach>
    </div>
  </div>
</div>

<main>
  <div class="wrapper">

    <%-- Hero --%>
    <section class="hero parallax-hero" id="hero" aria-labelledby="hero-heading">
        <div class="hero-eyebrow" aria-hidden="true">Music Artist Registry</div>
        <h1 id="hero-heading">Discover the voices<br />that shape <em>music</em></h1>
        <p class="hero-sub">Search across thousands of registered artists — from rising independents to established names — and explore their stories, genres, and discographies.</p>
      </section>

    <%-- CTA / Stats section — stats populated from ${stats} model attribute --%>
    <section class="cta-section" aria-labelledby="cta-heading">
      <div class="cta-card reveal">
        <h2 id="cta-heading" class="reveal reveal-d1">Explore every<br /><em>registered</em> artist</h2>
        <p class="reveal reveal-d2">Browse the complete registry — filter by genre, label, country, or debut year. The full catalogue awaits.</p>
        <div class="reveal reveal-d3">
          <a href="${pageContext.request.contextPath}/artists" class="btn-cta">
            Open Artist Library
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
              <line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/>
            </svg>
          </a>
        </div>

        <div class="cta-stats">
          <%-- EL: read directly from ${stats} map set in the model by the controller --%>
          <div class="stat-item">
            <span class="stat-value">${stats.totalArtists != null ? stats.totalArtists : '—'}</span>
            <span class="stat-label">Artists</span>
          </div>
          <div class="stat-item">
            <span class="stat-value">${stats.totalGenres != null ? stats.totalGenres : '—'}</span>
            <span class="stat-label">Genres</span>
          </div>
          <div class="stat-item">
            <span class="stat-value">${stats.totalCountries != null ? stats.totalCountries : '—'}</span>
            <span class="stat-label">Countries</span>
          </div>
        </div>
      </div>
    </section>

  </div>
</main>

<footer>
  <div class="wrapper">
    <p>Resonance Music Artist Registry &nbsp;&middot;&nbsp; <a href="#">API Docs</a> &nbsp;&middot;&nbsp; <a href="#">Privacy</a></p>
  </div>
</footer>

<script>
  /* ── Scroll effects ── */
  const nav        = document.getElementById('main-nav');
  const searchZone = document.getElementById('search-zone');
  const parallax   = document.querySelector('.parallax-hero');
  let ticking = false;

  window.addEventListener('scroll', () => {
    if (!ticking) { requestAnimationFrame(onScroll); ticking = true; }
  }, { passive: true });

  function onScroll() {
    const sy = window.scrollY;
    nav.classList.toggle('scrolled', sy > 20);
    searchZone.classList.toggle('scrolled', sy > 60);
    if (parallax) parallax.style.transform = 'translateY(' + (sy * 0.36) + 'px)';
    ticking = false;
  }

  /* ── Scroll reveal ── */
  const revealObs = new IntersectionObserver(entries => {
    entries.forEach(e => { if (e.isIntersecting) { e.target.classList.add('in-view'); revealObs.unobserve(e.target); } });
  }, { threshold: 0.14 });
  document.querySelectorAll('.reveal').forEach(el => revealObs.observe(el));

  /* ── Hero entrance ── */
  const heroEl = document.getElementById('hero');
  if (heroEl) {
    heroEl.querySelectorAll('.hero-eyebrow, h1, .hero-sub').forEach((el, i) => {
      el.style.cssText = 'opacity:0;transform:translateY(18px);transition:opacity .75s ' + (i * 0.15) + 's ease,transform .75s ' + (i * 0.15) + 's ease';
      requestAnimationFrame(() => requestAnimationFrame(() => { el.style.opacity = '1'; el.style.transform = 'translateY(0)'; }));
    });
  }

  /* ── Genre chips: update hidden input and re-submit form ── */
  document.querySelectorAll('.chip').forEach(chip => {
    chip.addEventListener('click', () => {
      document.querySelectorAll('.chip').forEach(c => c.classList.remove('active'));
      chip.classList.add('active');
      document.getElementById('genre-input').value = chip.dataset.genre;
      /* Auto-submit only if a name is already entered */
      const nameVal = document.getElementById('search-input').value.trim();
      if (nameVal) document.getElementById('search-form').submit();
    });
  });
</script>

</body>
</html>
