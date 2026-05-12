<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="64kb" autoFlush="true" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Search Results — Resonance</title>
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

    /* ── Background canvas ── */
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

    /* ── SEARCH BAR ── */
    .search-bar-zone {
      position: sticky; top: var(--nav-h); z-index: 200;
      display: flex; justify-content: center;
      padding: 0.9rem 2rem;
      background: rgba(8,3,5,0.32);
      border-bottom: 1px solid rgba(255,255,255,0.055);
      backdrop-filter: blur(22px) saturate(150%);
      transition: padding 0.4s ease;
    }
    .search-bar-zone.scrolled { padding: 0.65rem 2rem; }
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

    /* ── PAGE HEADER ── */
    .page-header {
      padding: 2.8rem 0 2.2rem;
      border-bottom: 1px solid rgba(255,255,255,0.06);
      margin-bottom: 2.8rem;
    }
    .page-header-inner { display: flex; align-items: flex-end; justify-content: space-between; gap: 2rem; flex-wrap: wrap; }
    .breadcrumb { font-family: 'Syne', sans-serif; font-size: 0.68rem; font-weight: 600; letter-spacing: 0.22em; text-transform: uppercase; color: var(--text-muted); display: flex; align-items: center; gap: 0.55rem; margin-bottom: 0.85rem; }
    .breadcrumb a { color: var(--red); text-decoration: none; opacity: 0.82; transition: opacity 0.2s; }
    .breadcrumb a:hover { opacity: 1; }
    .breadcrumb svg { width: 10px; height: 10px; opacity: 0.4; }
    .page-title { font-family: 'Cormorant Garamond', serif; font-size: clamp(2rem, 4vw, 3rem); font-weight: 300; line-height: 1.1; }
    .page-title em { font-style: italic; background: linear-gradient(100deg, var(--red-light) 0%, var(--red) 55%, #ff8a80 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
    .result-meta { text-align: right; }
    .result-count-badge {
      display: inline-flex; align-items: center; gap: 8px;
      background: rgba(232,48,42,0.10); border: 1px solid rgba(232,48,42,0.24);
      border-radius: 100px; padding: 0.4rem 1rem;
      font-family: 'Syne', sans-serif; font-size: 0.75rem; font-weight: 600;
      letter-spacing: 0.08em; color: var(--red-light);
    }
    .result-count-badge span { font-size: 1.05rem; font-family: 'Cormorant Garamond', serif; font-weight: 400; }
    .genre-badge {
      display: inline-flex; align-items: center; gap: 6px; margin-top: 0.5rem;
      background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.09);
      border-radius: 100px; padding: 0.28rem 0.8rem;
      font-family: 'Syne', sans-serif; font-size: 0.68rem; font-weight: 500;
      letter-spacing: 0.1em; text-transform: uppercase; color: var(--text-secondary);
    }

    /* ── ARTIST GRID (Apple Music-style) ── */
    .tiles-grid {
      display: grid;
      grid-template-columns: repeat(5, 1fr);
      gap: 1rem 1.4rem;
      padding-bottom: 6rem;
    }
    @media (max-width: 1100px) { .tiles-grid { grid-template-columns: repeat(4, 1fr); } }
    @media (max-width: 800px)  { .tiles-grid { grid-template-columns: repeat(3, 1fr); } }
    @media (max-width: 520px)  { .tiles-grid { grid-template-columns: repeat(2, 1fr); } }

    /* ── ARTIST CARD (Apple Music circle-photo style) ── */
    .hero-tile {
      position: relative;
      background: transparent;
      border: none;
      border-radius: 16px;
      overflow: visible;
      cursor: pointer;
      text-decoration: none;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 1rem 0.5rem 1.2rem;
      animation: tileIn 0.45s cubic-bezier(.22,1,.36,1) both;
      transition: transform 0.35s cubic-bezier(.22,1,.36,1);
    }
    .hero-tile:focus-visible { outline: 2px solid var(--red-light); outline-offset: 3px; border-radius: 50%; }
    .hero-tile:hover { transform: translateY(-5px); }

    @keyframes tileIn {
      from { opacity: 0; transform: translateY(22px) scale(0.95); }
      to   { opacity: 1; transform: translateY(0)    scale(1);    }
    }

    /* Photo wrapper — the circle */
    .tile-photo-wrap {
      position: relative;
      width: 100%;
      aspect-ratio: 1 / 1;
      border-radius: 50%;
      overflow: hidden;
      margin-bottom: 0.85rem;
      flex-shrink: 0;
      box-shadow: 0 8px 32px rgba(0,0,0,0.45);
      transition: box-shadow 0.35s, transform 0.35s cubic-bezier(.22,1,.36,1);
    }
    .hero-tile:hover .tile-photo-wrap {
      box-shadow: 0 16px 48px rgba(0,0,0,0.60), 0 0 0 3px rgba(232,48,42,0.30);
      transform: scale(1.06);
    }
    .hero-tile:nth-child(5n+2):hover .tile-photo-wrap { box-shadow: 0 16px 48px rgba(0,0,0,0.60), 0 0 0 3px rgba(139,43,226,0.38); }
    .hero-tile:nth-child(5n+3):hover .tile-photo-wrap { box-shadow: 0 16px 48px rgba(0,0,0,0.60), 0 0 0 3px rgba(37,99,235,0.38); }
    .hero-tile:nth-child(5n+4):hover .tile-photo-wrap { box-shadow: 0 16px 48px rgba(0,0,0,0.60), 0 0 0 3px rgba(232,48,42,0.30); }
    .hero-tile:nth-child(5n+5):hover .tile-photo-wrap { box-shadow: 0 16px 48px rgba(0,0,0,0.60), 0 0 0 3px rgba(59,130,246,0.38); }

    /* Artist photo — fills the circle */
    .tile-avatar {
      width: 100%; height: 100%;
      object-fit: cover;
      object-position: center top;
      display: block;
      border-radius: 50%;
    }

    /* Monogram fallback — shown when no imageUrl */
    .tile-avatar-monogram {
      width: 100%; height: 100%;
      display: flex; align-items: center; justify-content: center;
      font-family: 'Cormorant Garamond', serif;
      font-size: clamp(1.8rem, 6vw, 3rem); font-weight: 300;
      background: linear-gradient(135deg, rgba(232,48,42,0.32), rgba(155,26,21,0.20));
      color: var(--text-primary);
    }
    .hero-tile:nth-child(5n+2) .tile-avatar-monogram { background: linear-gradient(135deg, rgba(107,31,168,0.35), rgba(91,33,182,0.20)); }
    .hero-tile:nth-child(5n+3) .tile-avatar-monogram { background: linear-gradient(135deg, rgba(37,99,235,0.35), rgba(30,58,138,0.20)); }

    /* Play icon overlay on hover */
    .tile-photo-wrap::after {
      content: '';
      position: absolute; inset: 0;
      background: radial-gradient(circle at 50% 50%, rgba(0,0,0,0.28) 0%, rgba(0,0,0,0.05) 70%);
      border-radius: 50%;
      opacity: 0;
      transition: opacity 0.28s;
    }
    .hero-tile:hover .tile-photo-wrap::after { opacity: 1; }

    /* Tile body — text below circle */
    .tile-body {
      width: 100%;
      display: flex; flex-direction: column; align-items: center;
      text-align: center;
      padding: 0;
      position: relative; z-index: 1;
    }

    /* Artist name */
    .tile-name {
      font-family: 'DM Sans', sans-serif;
      font-size: 0.88rem; font-weight: 500; line-height: 1.3;
      color: var(--text-primary);
      margin-bottom: 0.22rem;
      transition: color 0.2s;
      white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
      max-width: 100%;
    }
    .hero-tile:hover .tile-name { color: #fff; }

    /* Genre / type label */
    .tile-genre {
      font-family: 'DM Sans', sans-serif; font-size: 0.75rem; font-weight: 400;
      color: var(--text-secondary);
      white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
      max-width: 100%;
    }

    /* Country / extra meta */
    .tile-meta { font-size: 0.72rem; color: var(--text-muted); margin-top: 0.1rem; }

    /* Label badge (was in footer) — now a tiny pill below genre */
    .tile-label {
      display: inline-block; margin-top: 0.3rem;
      font-size: 0.64rem; font-family: 'Syne', sans-serif;
      padding: 0.1rem 0.55rem;
      background: rgba(255,255,255,0.055); border-radius: 100px;
      color: var(--text-muted); letter-spacing: 0.05em;
    }

    /* Selection ring */
    .hero-tile.selected .tile-photo-wrap {
      box-shadow: 0 0 0 3px var(--red), 0 16px 48px rgba(232,48,42,0.30);
    }

    /* Selection indicator — sits at top-right of photo circle */
    .tile-select-indicator {
      position: absolute; top: 6px; right: 6px; z-index: 10;
      width: 22px; height: 22px; border-radius: 50%;
      background: rgba(232,48,42,0.14); border: 1.5px solid rgba(232,48,42,0.30);
      display: flex; align-items: center; justify-content: center;
      transition: all 0.25s;
      opacity: 0;
    }
    .hero-tile:hover .tile-select-indicator,
    .hero-tile.selected .tile-select-indicator { opacity: 1; }
    .hero-tile.selected .tile-select-indicator {
      background: var(--red); border-color: var(--red);
      box-shadow: 0 0 0 3px rgba(232,48,42,0.20);
    }
    .tile-check { display: none; }
    .hero-tile.selected .tile-check { display: block; }
    .tile-uncheck { display: block; }
    .hero-tile.selected .tile-uncheck { display: none; }

    /* Section label above the grid */
    .section-label {
      font-family: 'Syne', sans-serif;
      font-size: 1.2rem; font-weight: 700;
      letter-spacing: 0.01em;
      color: var(--text-primary);
      margin-bottom: 1.4rem;
      display: flex; align-items: center; gap: 0.75rem;
    }
    .section-label-count {
      font-family: 'DM Sans', sans-serif;
      font-size: 0.8rem; font-weight: 400;
      color: var(--text-muted);
    }

    /* ── EMPTY STATE ── */
    .empty-state {
      grid-column: 1 / -1;
      display: flex; flex-direction: column; align-items: center;
      padding: 5rem 2rem; text-align: center;
    }
    .empty-icon {
      width: 72px; height: 72px; border-radius: 18px;
      background: rgba(255,255,255,0.04); border: 1px solid rgba(255,255,255,0.08);
      display: flex; align-items: center; justify-content: center;
      margin-bottom: 1.5rem;
    }
    .empty-state h3 { font-family: 'Cormorant Garamond', serif; font-size: 1.65rem; font-weight: 300; margin-bottom: 0.75rem; }
    .empty-state p { color: var(--text-secondary); font-size: 0.92rem; max-width: 360px; line-height: 1.72; margin-bottom: 2rem; }
    .btn-back { display: inline-flex; align-items: center; gap: 8px; background: linear-gradient(135deg, rgba(232,48,42,0.14), rgba(155,26,21,0.10)); border: 1px solid rgba(232,48,42,0.32); color: var(--red-light); font-family: 'Syne', sans-serif; font-size: 0.8rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; text-decoration: none; padding: 0.75rem 1.6rem; border-radius: 100px; transition: all 0.28s; }
    .btn-back:hover { background: linear-gradient(135deg, rgba(232,48,42,0.26), rgba(155,26,21,0.22)); border-color: rgba(232,48,42,0.6); color: #fff; transform: translateY(-2px); }

    /* ── SELECTION BAR ── */
    .selection-bar {
      position: fixed; bottom: 2rem; left: 50%; transform: translateX(-50%) translateY(100px);
      z-index: 400;
      background: rgba(12,5,8,0.88); backdrop-filter: blur(28px) saturate(180%);
      border: 1px solid rgba(232,48,42,0.28);
      border-radius: 100px;
      padding: 0.7rem 0.7rem 0.7rem 1.4rem;
      display: flex; align-items: center; gap: 1rem;
      box-shadow: 0 20px 60px rgba(0,0,0,0.55), 0 0 0 1px rgba(232,48,42,0.08);
      transition: transform 0.4s cubic-bezier(.22,1,.36,1), opacity 0.3s;
      opacity: 0; pointer-events: none;
    }
    .selection-bar.visible { transform: translateX(-50%) translateY(0); opacity: 1; pointer-events: all; }
    .sel-count { font-family: 'Syne', sans-serif; font-size: 0.8rem; font-weight: 600; color: var(--text-secondary); letter-spacing: 0.06em; white-space: nowrap; }
    .sel-count strong { color: var(--red-light); font-size: 1rem; font-family: 'Cormorant Garamond', serif; font-weight: 400; margin-right: 3px; }
    .sel-clear { font-size: 0.72rem; color: var(--text-muted); background: none; border: none; cursor: pointer; font-family: 'DM Sans', sans-serif; padding: 0.2rem 0.4rem; border-radius: 4px; transition: color 0.2s; }
    .sel-clear:hover { color: var(--text-secondary); }
    .sel-actions { display: flex; gap: 0.4rem; }
    .btn-sel-action { font-family: 'Syne', sans-serif; font-size: 0.74rem; font-weight: 600; letter-spacing: 0.08em; text-transform: uppercase; border: none; border-radius: 100px; padding: 0.6rem 1.2rem; cursor: pointer; transition: all 0.22s; }
    .btn-sel-action.secondary { background: rgba(255,255,255,0.07); color: var(--text-secondary); }
    .btn-sel-action.secondary:hover { background: rgba(255,255,255,0.12); color: var(--text-primary); }
    .btn-sel-action.primary { background: linear-gradient(135deg, #e8302a, #9b1a15); color: #fff; box-shadow: 0 4px 16px rgba(232,48,42,0.30); }
    .btn-sel-action.primary:hover { filter: brightness(1.12); transform: translateY(-1px); box-shadow: 0 8px 24px rgba(232,48,42,0.42); }

    footer { border-top: 1px solid rgba(255,255,255,0.07); padding: 2rem 0; text-align: center; }
    footer p { font-size: .8rem; color: var(--text-muted); }
    footer a { color: var(--red); text-decoration: none; opacity: .72; }
    footer a:hover { opacity: 1; }
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

<%-- NAV --%>
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

<%-- Sticky search bar so users can refine without going back --%>
<div class="search-bar-zone" id="search-zone" role="search">
  <div class="search-panel">
    <span class="search-label">Refine your search</span>
    <form method="get" action="${pageContext.request.contextPath}/search" id="search-form">
      <div class="search-row">
        <div class="search-input-wrap">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
            <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
          </svg>
          <input id="search-input"
                 name="name"
                 class="search-input"
                 type="search"
                 placeholder="Artist name, stage name…"
                 autocomplete="off"
                 aria-label="Search for an artist by name"
                 value="${fn:escapeXml(param.name)}" />
          <input type="hidden" id="genre-input" name="genre" value="${fn:escapeXml(param.genre)}" />
        </div>
        <button type="submit" class="btn-search" id="search-btn" aria-label="Run search">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" aria-hidden="true"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
          Search
        </button>
      </div>
    </form>
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

    <%-- Page header — Apple Music style: just the query, clean --%>
    <header class="page-header">
      <div class="page-header-inner">
        <div>
          <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><polyline points="9 18 15 12 9 6"/></svg>
            Search Results
          </div>
          <h1 class="page-title">
            &ldquo;<em>${fn:escapeXml(param.name)}</em>&rdquo;
            <c:if test="${not empty param.genre}">
              &nbsp;<span class="genre-badge">
                <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" aria-hidden="true"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                ${fn:escapeXml(param.genre)}
              </span>
            </c:if>
          </h1>
        </div>
        <div class="result-meta">
          <div class="result-count-badge">
            <span>${fn:length(artists)}</span>
            artist${fn:length(artists) ne 1 ? 's' : ''} found
          </div>
        </div>
      </div>
    </header>

    <%-- Section label — "Artists" like Apple Music --%>
    <c:if test="${not empty artists}">
      <div class="section-label">
        Artists
        <span class="section-label-count">${fn:length(artists)} result${fn:length(artists) ne 1 ? 's' : ''}</span>
      </div>
    </c:if>

    <%-- 5-column Apple Music-style artist grid --%>
    <div class="tiles-grid" id="tiles-grid" role="list" aria-label="Search results">

      <c:choose>

        <%-- Empty results state --%>
        <c:when test="${empty artists}">
          <div class="empty-state" role="listitem">
            <div class="empty-icon" aria-hidden="true">
              <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="rgba(240,238,250,0.28)" stroke-width="1.5" stroke-linecap="round">
                <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
              </svg>
            </div>
            <h3>No artists found</h3>
            <p>
              No results matched
              <strong style="color:var(--text-primary)">&ldquo;${fn:escapeXml(param.name)}&rdquo;</strong>
              <c:if test="${not empty param.genre}">
                in <strong style="color:var(--text-primary)">${fn:escapeXml(param.genre)}</strong>
              </c:if>.
              Try a different name or clear the genre filter.
            </p>
            <a href="${pageContext.request.contextPath}/" class="btn-back">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" aria-hidden="true"><line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/></svg>
              Back to Search
            </a>
          </div>
        </c:when>

        <%-- Artist cards --%>
        <c:otherwise>
          <c:forEach var="artist" items="${artists}" varStatus="status">
            <c:set var="delay" value="${status.index * 45 > 360 ? 360 : status.index * 45}" />

            <a href="#"
               class="hero-tile"
               style="animation-delay:${delay}ms"
               role="listitem"
               aria-label="${fn:escapeXml(artist.name)}"
               data-id="${artist.id}">

              <%-- Circular photo + selection indicator --%>
              <div class="tile-photo-wrap">

                <c:choose>
                  <c:when test="${not empty artist.imageURL}">
                    <img class="tile-avatar"
                         src="${artist.imageURL}"
                         alt="${fn:escapeXml(artist.name)}"
                         loading="lazy" />
                  </c:when>
                  <c:otherwise>
                    <div class="tile-avatar-monogram" aria-hidden="true">
                      ${fn:substring(fn:toUpperCase(artist.name), 0, 1)}
                    </div>
                  </c:otherwise>
                </c:choose>

                <%-- Selection indicator (top-right of circle) --%>
                <div class="tile-select-indicator" aria-hidden="true">
                  <svg class="tile-check" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="3" stroke-linecap="round"><polyline points="20 6 9 17 4 12"/></svg>
                  <svg class="tile-uncheck" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="rgba(240,238,250,0.45)" stroke-width="2" stroke-linecap="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
                </div>

              </div>

              <%-- Text info below circle --%>
              <div class="tile-body">

                <div class="tile-name">${fn:escapeXml(artist.name)}</div>

                <%-- Genre --%>
                <c:choose>
                  <c:when test="${not empty artist.genre}">
                    <div class="tile-genre">
                      <c:forEach var="g" items="${artist.genre}" varStatus="gs">
                        ${fn:escapeXml(g)}<c:if test="${!gs.last}">&nbsp;&middot;&nbsp;</c:if>
                      </c:forEach>
                    </div>
                  </c:when>
                  <c:when test="${not empty artist.genre}">
                    <div class="tile-genre">${fn:escapeXml(artist.genre)}</div>
                  </c:when>
                  <c:otherwise>
                    <div class="tile-genre">Artist</div>
                  </c:otherwise>
                </c:choose>

                <%-- Country --%>
                <c:if test="${not empty artist.country}">
                  <div class="tile-meta">${fn:escapeXml(artist.country)}</div>
                </c:if>

              </div>

            </a>
          </c:forEach>
        </c:otherwise>

      </c:choose>
    </div>

  </div>
</main>

<%-- Floating selection action bar (appears when ≥ 1 tile is selected) --%>
<div class="selection-bar" id="selection-bar" aria-live="polite" aria-label="Selection actions">
  <div class="sel-count"><strong id="sel-count-num">0</strong> selected</div>
  <button class="sel-clear" id="sel-clear-btn" aria-label="Clear selection">Clear</button>
  <div class="sel-actions">
    <button class="btn-sel-action secondary" id="sel-compare-btn">Compare</button>
    <button class="btn-sel-action primary" id="sel-view-btn">View Selected</button>
  </div>
</div>

<footer>
  <div class="wrapper">
    <p>Resonance Music Artist Registry &nbsp;&middot;&nbsp; <a href="#">API Docs</a> &nbsp;&middot;&nbsp; <a href="#">Privacy</a></p>
  </div>
</footer>

<script>
  /* ── Scroll effects ── */
  const nav        = document.getElementById('main-nav');
  const searchZone = document.getElementById('search-zone');

  window.addEventListener('scroll', () => {
    const sy = window.scrollY;
    nav.classList.toggle('scrolled', sy > 20);
    searchZone.classList.toggle('scrolled', sy > 60);
  }, { passive: true });

  /* ── Genre chips: update hidden input and re-submit form ── */
  document.querySelectorAll('.chip').forEach(chip => {
    chip.addEventListener('click', () => {
      document.querySelectorAll('.chip').forEach(c => c.classList.remove('active'));
      chip.classList.add('active');
      document.getElementById('genre-input').value = chip.dataset.genre;
      const nameVal = document.getElementById('search-input').value.trim();
      if (nameVal) document.getElementById('search-form').submit();
    });
  });

  /* ── Mouse glare on hero tiles (disabled — no glare element in new layout) ── */
  /* document.querySelectorAll('.hero-tile').forEach(tile => { ... }); */

  /* ── Tile selection ── */
  const selectionBar  = document.getElementById('selection-bar');
  const selCountNum   = document.getElementById('sel-count-num');
  const selClearBtn   = document.getElementById('sel-clear-btn');
  const selectedIds   = new Set();

  function updateSelectionBar() {
    const n = selectedIds.size;
    selCountNum.textContent = n;
    selectionBar.classList.toggle('visible', n > 0);
  }

  document.querySelectorAll('.hero-tile').forEach(tile => {
    tile.addEventListener('click', e => {
      e.preventDefault(); // href="#" — no navigation yet
      const id = tile.dataset.id;
      if (selectedIds.has(id)) {
        selectedIds.delete(id);
        tile.classList.remove('selected');
      } else {
        selectedIds.add(id);
        tile.classList.add('selected');
      }
      updateSelectionBar();
    });

    /* Keyboard support */
    tile.addEventListener('keydown', e => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        tile.click();
      }
    });
    tile.setAttribute('tabindex', '0');
  });

  selClearBtn.addEventListener('click', () => {
    selectedIds.clear();
    document.querySelectorAll('.hero-tile.selected').forEach(t => t.classList.remove('selected'));
    updateSelectionBar();
  });
</script>

</body>
</html>
