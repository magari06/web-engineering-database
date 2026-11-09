# 09. Dodatkowe Bazy Danych: Techniczne SEO, GEO (AI-Search), Systemy CMS, Platformy i Infrastruktura

> **Przeznaczenie kategorii:**
> W tym module zgromadzono zaawansowane materiały inżynieryjno-marketingowe, specyfikacje oraz repozytoria, które wykraczają poza 8 podstawowych obszarów użyteczności z listy kontrolnej («*Osiem obszarów, czterdzieści pytań*»), lecz są niezbędne do pozycjonowania strony w wyszukiwarkach tradycyjnych i asystentach AI (`Google AI Overviews`, `ChatGPT Search`, `Perplexity`), wyboru systemu CMS oraz wdrożenia produkcyjnego.

---

## 1. Struktura Modułu

### 🔍 1. Techniczne SEO, Schema.org i Optymalizacja pod Wyszukiwarki AI (`01-seo-and-geo/`)
- [`01-technical-seo.md`](./01-seo-and-geo/01-technical-seo.md) — Zarządzanie budżetem indeksowania (*Crawl Budget*), nawigacja fasetowa, `rel="canonical"`, `hreflang`, mapy XML Sitemaps, protokół **IndexNow** oraz powiązany graf encji **Schema.org (`@graph` + `@id`)**.
- [`03-geo-ai-search-optimization.md`](./01-seo-and-geo/03-geo-ai-search-optimization.md) — Optymalizacja pod **Google AI Overviews**, **ChatGPT Search** i **Perplexity**: mechanizm `Query Fan-Out`, formuła badań Uniwersytetu Princeton nad GEO (+30–40% widoczności w odpowiedziach AI), modułowa budowa **Answer Capsules (130–170 słów)**, plik **`/llms.txt`** oraz konfiguracja `robots.txt` dla botów AI (`OAI-SearchBot`, `PerplexityBot`).
- **Lokalnie sklonowane repozytorium:** [`llmstxt`](./llmstxt/) — oficjalne repozytorium specyfikacji **`/llms.txt`** (`AnswerDotAI/llms-txt`) ułatwiającej dużym modelom językowym (LLM) odczyt kluczowych treści witryny.

### 📚 2. Rejestr Źródeł Pierwotnych, Specyfikacji W3C/IETF/NIST i Prac Naukowych (`02-sources-and-specs/`)
- [`01-authoritative-sources.md`](./02-sources-and-specs/01-authoritative-sources.md) — Katalog główny ponad 45 oficjalnych specyfikacji, dokumentów RFC i badań.
- [`02-w3c-whatwg-ietf-specs.md`](./02-sources-and-specs/02-w3c-whatwg-ietf-specs.md) — Opracowanie standardów W3C, WHATWG, IETF RFC (HTTP/3 RFC 9114, QUIC RFC 9000, TLS 1.3 RFC 8446, Privacy Pass RFC 9577) oraz NIST FIPS 203.
- [`03-google-search-and-webdev-docs.md`](./02-sources-and-specs/03-google-search-and-webdev-docs.md) — Wytyczne Google Search Essentials, Googlebot WRS, instrukcja dla oceniających jakość SQRG (E-E-A-T, YMYL) oraz patent `US11354342B2` (*Information Gain*).
- [`04-ux-cro-and-accessibility-studies.md`](./02-sources-and-specs/04-ux-cro-and-accessibility-studies.md) — Badania Baymard Institute, NN/g, raporty WebAIM Million oraz akty prawne EU EAA 2025, DSA Art. 25 i FTC Click-to-Cancel.
- [`05-geo-ai-search-papers-and-specs.md`](./02-sources-and-specs/05-geo-ai-search-papers-and-specs.md) — Analiza pracy naukowej Uniwersytetu Princeton (`arXiv:2311.09735` — GEO-bench), badań Ahrefs/Semrush oraz specyfikacji `llmstxt.org`.

### 🏗️ 3. Platformy No-Code, Systemy CMS, Silniki E-Commerce i Generatory AI (`03-platforms-cms-and-builders/`)
- [`01-nocode-and-visual-builders.md`](./03-platforms-cms-and-builders/01-nocode-and-visual-builders.md) — Porównanie **Framer, Webflow, Tilda, Wix Studio, Readymag** (architektura renderowania, wyniki CWV, eksport kodu).
- [`02-cms-and-ecommerce-engines.md`](./03-platforms-cms-and-builders/02-cms-and-ecommerce-engines.md) — Nowoczesny stos **WordPress** (Bedrock + Bricks), **Shopify** (Liquid vs Hydrogen), **Medusa.js 2.0**, **WooCommerce** oraz systemy **Headless CMS** (**Payload CMS 3.0, Strapi 5, Sanity, Directus, Keystatic**).
- [`03-ai-builders-and-vibe-coding.md`](./03-platforms-cms-and-builders/03-ai-builders-and-vibe-coding.md) — Generatory interfejsów AI (**v0 by Vercel, Bolt.new, Lovable.dev, Relume AI**) oraz środowiska agentowe (**Google Antigravity, Cursor, Windsurf, Claude Code**) z potokiem produkcyjnym MCP.

### 🧰 4. Domeny, Hosting, BaaS, Płatności, Analityka, Zgodność Prawna i Plan Wdrożenia (`04-infrastructure-and-roadmap/`)
- [`02-domains-hosting-baas-and-payments.md`](./04-infrastructure-and-roadmap/02-domains-hosting-baas-and-payments.md) — Rejestratorzy domen i DNS (Cloudflare), hosting Edge (**Vercel, Cloudflare Workers, Railway, Fly.io**) vs **VPS + Coolify / Dokploy**, bazy danych (**Supabase, Neon, Turso**), **Better Auth vs Clerk**, poczta (**Resend**) oraz bramki płatnicze (**Stripe, Paddle, Lemon Squeezy**).
- [`03-analytics-qa-legal-and-roadmap.md`](./04-infrastructure-and-roadmap/03-analytics-qa-legal-and-roadmap.md) — Testy automatyczne (**Vitest, Playwright, Lighthouse CI**), analityka i monitoring (**PostHog, Plausible/Umami, GA4, Sentry**), lista kontrolna zgodności z **RODO / GDPR**, kosztorysy oraz **18-dniowy plan uruchomienia strony od zera**.
- [`00-production-reference-guide-2025-2026.md`](./00-production-reference-guide-2025-2026.md) — Pełny przewodnik referencyjny 2025–2026 z tabelą docelowych metryk SLA i listą kontrolną przed wdrożeniem produkcyjnym (*Pre-Launch Master Checklist*).

---

## 2. Źródła i Zweryfikowane Repozytoria dla SEO, Schema.org i AI-Search (GEO)

| Nr | Repozytorium i link źródłowy | Właściciel / Organizacja | Opis i zastosowanie | Status |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[AnswerDotAI/llms-txt](https://github.com/AnswerDotAI/llms-txt)** | **Answer.AI (Jeremy Howard)** | Oficjalna specyfikacja i narzędzia standardu **`/llms.txt`** dla wyszukiwarek AI i agentów LLM. | Sklonowano lokalnie (`./llmstxt`) |
| 2 | **[schemaorg/schemaorg](https://github.com/schemaorg/schemaorg)** | **Schema.org Consortium (Google, Microsoft, Yahoo, Yandex)** | Oficjalna baza schematów i słowników danych strukturalnych **Schema.org** (JSON-LD, Microdata, RDFa). | Źródło referencyjne |
| 3 | **[GoogleChrome/CrUX](https://github.com/GoogleChrome/CrUX)** | **Google Chrome Team** | Repozytorium zapytań, dashboardów i narzędzi analizy bazy danych **Chrome User Experience Report (CrUX)**. | Źródło referencyjne |
| 4 | **[payloadcms/payload](https://github.com/payloadcms/payload)** | **Payload CMS (Figma)** | Wiodący system Headless CMS i framework aplikacji natywny dla Next.js. | Źródło referencyjne |
| 5 | **[withastro/astro](https://github.com/withastro/astro)** | **Astro Technology Company** | Framework webowy oparty na architekturze wyspowej (**Islands Architecture**) z zerowym JS domyślnie i najwyższymi wynikami SEO/CWV. | Źródło referencyjne |
| 6 | **[medusajs/medusa](https://github.com/medusajs/medusa)** | **Medusa.js** | Modułowy silnik open-source dla nowoczesnego handlu elektronicznego (Headless E-Commerce). | Źródło referencyjne |
