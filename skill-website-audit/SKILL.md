---
name: website-audit
description: >-
  Comprehensive 9-pillar / 40-question website usability, engineering, accessibility, design system, security, and SEO/GEO auditor powered by the local corporate database (C:/Users/лахушка/Desktop/websites/database). Trigger this skill whenever the user says "сделай аудит", "проверь сайт", "прогони по базе", "аудит сайта", "zrób audyt", "audit website", or asks to analyze, review, or improve a website or frontend codebase.
---

# Website 360° Audit Skill (8 Usability Areas / 40 Questions + 9th SEO/GEO Pillar)

This skill audits any local website codebase (`HTML/CSS/JS/TS/React/Next.js/Astro/Vue`) or live URL against the **9-category / 40-question corporate engineering database** located at:
- **Local Database Path:** `C:/Users/лахушка/Desktop/websites/database`
- **GitHub Mirror:** `https://github.com/magari06/web-engineering-database`

---

## When to Activate

Activate immediately when the user uses any of these commands or intents:
- *"сделай аудит"* / *"сделай аудит сайта [папка/URL]"*
- *"проверь сайт по базе"* / *"прогони через базу"*
- *"zrób audyt strony"*
- *"audit website"* / *"analyze and improve this site"*

---

## Step-by-Step Audit Execution Protocol

### Step 1: Identify Target & Run Automated Scanner
1. Determine the target website directory (e.g., `./page1`, `./page2`, `./archetype-portfolio`, or current working directory) or live URL.
2. Run the automated static & structural scanner script against the target folder:
   ```powershell
   powershell -ExecutionPolicy Bypass -File "C:/Users/лахушка/.gemini/config/skills/website-audit/scripts/run-audit.ps1" -TargetPath "<TARGET_PATH>"
   ```
3. If the target is a running local dev server or live URL, also inspect it using browser/Lighthouse/Playwright tools if requested.

---

### Step 2: Cross-Reference Against the 9 Database Categories (40 Questions + Extra)

Consult the corresponding category references in `C:/Users/лахушка/Desktop/websites/database/` as needed:

| # | Category Folder in `database/` | Core Focus & Reference Repositories | Questions |
| :--- | :--- | :--- | :--- |
| **01** | [`01-navigation`](file:///C:/Users/лахушка/Desktop/websites/database/01-navigation/README.md) | **Nawigacja (Navigation & IA)**: Logo `<a href="/">`, Skip Link, `aria-current="page"`, `BreadcrumbList`, $\le 3$ clicks depth, mobile `FocusTrap`, `<search>` / `⌘K`, `404` recovery. Refs: `w3c-aria-practices`, `cmdk`. | **Q1.1 – Q1.5** |
| **02** | [`02-structure-and-layout`](file:///C:/Users/лахушка/Desktop/websites/database/02-structure-and-layout/README.md) | **Struktura i układ (Structure & Layout)**: Single `<h1>`, strict `H1->H2->H3` hierarchy, HTML5 landmarks (`<header>`, `<nav>`, `<main>`, `<footer>`), CSS Grid/Gestalt spacing, `@container` queries, 400% zoom reflow, zero CLS (`width`/`height`/`aspect-ratio`). Refs: `front-end-checklist`, `open-props`, `utopia-core`. | **Q2.1 – Q2.5** |
| **03** | [`03-content-and-readability`](file:///C:/Users/лахушка/Desktop/websites/database/03-content-and-readability/README.md) | **Treść i czytelność (Content & Readability)**: Base font $\ge 16\text{px}$ (`rem`/`clamp()`), WCAG 2.2 AA contrast ($\ge 4.5:1$) & W3C APCA ($|L_c| \ge 75$), line length `50–75ch`, line-height `1.5–1.65`, BLUF scannability, Plain Language microcopy. Refs: `apca-w3`, `mozilla-readability`, `mailchimp-style-guide`. | **Q3.1 – Q3.5** |
| **04** | [`04-forms-and-validation`](file:///C:/Users/лахушка/Desktop/websites/database/04-forms-and-validation/README.md) | **Formularze (Forms & Validation)**: Real-time inline validation (*Reward Early, Punish Late*), persistent `<label>` + `aria-invalid`/`aria-describedby`, `inputmode` + `autocomplete`, no `onPaste` blocking, state preservation on error, $\le 7–8$ fields & `aria-busy` submit protection. Refs: `standard-schema`, `conform`. | **Q4.1 – Q4.5** |
| **05** | [`05-functionality-and-performance`](file:///C:/Users/лахушка/Desktop/websites/database/05-functionality-and-performance/README.md) | **Funkcjonalność (Functionality & CWV)**: Search $\le 100\text{ms}$ with typo tolerance & Zero-Results UX, cart persistence & `useOptimistic`, Core Web Vitals (`LCP <= 2.5s`, `INP <= 200ms`, `CLS <= 0.1`), `fetchpriority="high"` on Hero image, `AVIF`/`WebP`, `WOFF2`, Error Boundaries. Refs: `web-vitals`, `vercel-commerce`, `algolia-autocomplete`. | **Q5.1 – Q5.5** |
| **06** | [`06-accessibility`](file:///C:/Users/лахушка/Desktop/websites/database/06-accessibility/README.md) | **Dostępność (Accessibility & Keyboard)**: 100% keyboard operability, `:focus-visible` ($\ge 2\text{px}$) & `Focus Not Obscured` (WCAG 2.4.11), `<html lang>`, `alt` attributes, `aria-live`, target size $\ge 24\times24\text{px}$ (WCAG 2.5.8, ideal $44\times44\text{px}$), `prefers-reduced-motion: reduce`. Refs: `axe-core`, `a11yproject`. | **Q6.1 – Q6.5** |
| **07** | [`07-aesthetics-and-design-systems`](file:///C:/Users/лахушка/Desktop/websites/database/07-aesthetics-and-design-systems/README.md) | **Estetyka (Aesthetics & Design Systems)**: W3C DTCG Design Tokens (0 hardcoded magic hex/px), Light/Dark/High-Contrast parity in `OKLCH`, 60–30–10 hierarchy & whitespace, unified SVG iconography (`viewBox`, `stroke-width`), GPU-only motion (`transform`/`opacity`, 120–350ms). Refs: `spectrum-design-data` (Adobe), `material-web` (Google), `primer-primitives` (GitHub). | **Q7.1 – Q7.5** |
| **08** | [`08-security-and-privacy`](file:///C:/Users/лахушка/Desktop/websites/database/08-security-and-privacy/README.md) | **Bezpieczeństwo (Security & Privacy)**: HTTPS/TLS 1.3 + HSTS Preload, Strict CSP (`nonce`), `X-Content-Type-Options: nosniff`, `COOP`, `Referrer-Policy`, `Permissions-Policy`, `__Host-` cookies + Passkeys, DOMPurify sanitization + SRI, GDPR/152-FZ & Cloudflare Turnstile. Refs: `owasp-cheatsheets`, `owasp-asvs`, `dompurify`. | **Q8.1 – Q8.5** |
| **09** | [`09-additional-seo-geo-and-infrastructure`](file:///C:/Users/лахушка/Desktop/websites/database/09-additional-seo-geo-and-infrastructure/README.md) | **Dodatkowe (SEO, GEO/AI-Search, CMS & Infra)**: `<title>`, `<meta name="description">`, `rel="canonical"`, `hreflang`, `sitemap.xml`, `robots.txt` allowing AI search bots (`OAI-SearchBot`, `PerplexityBot`), `Schema.org` `@graph` JSON-LD, Answer Capsules (130–170 words), `/llms.txt`. Ref: `llmstxt`. | **SEO & GEO** |

---

### Step 3: Generate the Structured Audit Report & Action Plan

Always output the audit report in **Russian** (unless the user explicitly requests Polish or English) using this structure:

1. **Общая оценка сайта (Overall Score: `XX / 100`)** — summary table across all 9 categories with status badges (`✅ Pass`, `⚠️ Warning`, `❌ Fail`) and score per category.
2. **Детальный разбор по 8 областям (40 вопросов) + Блок 09 (SEO/GEO)** — concrete findings linked to exact files and line numbers (`[index.html](file:///.../index.html#L10-L25)`), referencing the corresponding standard from `database/` (e.g., *Adobe Spectrum / GitHub Primer tokens*, *W3C APCA*, *OWASP CheatSheet*, *WCAG 2.2 SC 2.4.11*).
3. **Приоритетный план исправлений (Quick Wins & Critical Fixes)** — sorted into:
   - 🔴 **Critical (Блокеры безопасности, доступности, SEO и конверсии)**
   - 🟡 **Major (Улучшения UX, структуры, форм и Core Web Vitals)**
   - 🟢 **Polish (Дизайн-токены, микро-интеракции, `/llms.txt` и GEO)**
4. **Автоматическое применение исправлений** — ask the user if they want you to immediately fix all detected issues in the code, or apply the fixes right away if the user asked to *"сделай аудит и улучши/исправь"*.
