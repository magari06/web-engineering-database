# 09. Dodatkowe / Дополнительные базы данных: Техническое SEO, GEO (AI-Search), CMS, Платформы и Инфраструктура

> **Назначение категории:**
> В этот раздел вынесены все профильные инженерно-маркетинговые материалы, спецификации и репозитории, которые выходят за рамки 8 базовых UX/Usability-категорий слайда («*Osiem obszarów, czterdzieści pytań*»), но критически необходимы для создания, продвижения в поисковых системах и ИИ-агентах (`Google AI Overviews`, `ChatGPT Search`, `Perplexity`), выбора CMS/платформы и деплоя сайта.

---

## 1. Структура раздела

### 🔍 1. Техническое SEO, Schema.org и Генеративный ИИ-поиск (`01-seo-and-geo/`)
- [`01-technical-seo.md`](./01-seo-and-geo/01-technical-seo.md) — Управление краулинговым бюджетом, фасетная навигация, `rel="canonical"`, `hreflang`, XML Sitemaps, протокол **IndexNow** и связанный граф микроразметки **Schema.org (`@graph` + `@id`)**.
- [`03-geo-ai-search-optimization.md`](./01-seo-and-geo/03-geo-ai-search-optimization.md) — Оптимизация под **Google AI Overviews**, **ChatGPT Search** и **Perplexity**: веерное ветвление запросов (`Query Fan-Out`), формула Принстонского исследования GEO (+30–40% к цитируемости), модульная верстка **Answer Capsules (130–170 слов)**, манифест **`/llms.txt`** и настройка `robots.txt` для ИИ-краулеров (`OAI-SearchBot`, `PerplexityBot`).
- **Локальный репозиторий:** [`llmstxt`](./llmstxt) — официальный репозиторий спецификации **`/llms.txt`** (`AnswerDotAI/llms-txt`) для стандартизированного предоставления контента сайта большим языковым моделям (LLM).

### 📚 2. Реестр первоисточников, спецификаций W3C/IETF/NIST и научных работ (`02-sources-and-specs/`)
- [`01-authoritative-sources.md`](./02-sources-and-specs/01-authoritative-sources.md) — Единый мастер-каталог 45+ официальных спецификаций, RFC и исследований.
- [`02-w3c-whatwg-ietf-specs.md`](./02-sources-and-specs/02-w3c-whatwg-ietf-specs.md) — Конспект спецификаций W3C, WHATWG, IETF RFC (HTTP/3 RFC 9114, QUIC RFC 9000, TLS 1.3 RFC 8446, Privacy Pass RFC 9577) и NIST FIPS 203.
- [`03-google-search-and-webdev-docs.md`](./02-sources-and-specs/03-google-search-and-webdev-docs.md) — Стандарты Google Search Essentials, Googlebot WRS, руководство асессоров SQRG (E-E-A-T, YMYL) и патент `US11354342B2` (Information Gain).
- [`04-ux-cro-and-accessibility-studies.md`](./02-sources-and-specs/04-ux-cro-and-accessibility-studies.md) — Исследования Baymard Institute, NN/g, WebAIM Million, EU EAA 2025, DSA Art. 25 и FTC Click-to-Cancel.
- [`05-geo-ai-search-papers-and-specs.md`](./02-sources-and-specs/05-geo-ai-search-papers-and-specs.md) — Разбор научной статьи Принстонского университета (`arXiv:2311.09735` — GEO-bench), исследований Ahrefs/Semrush и спецификации `llmstxt.org`.

### 🏗️ 3. Платформы, CMS, E-Commerce движки и ИИ-генераторы сайтов (`03-platforms-cms-and-builders/`)
- [`01-nocode-and-visual-builders.md`](./03-platforms-cms-and-builders/01-nocode-and-visual-builders.md) — Сравнение **Framer, Webflow, Tilda, Wix Studio, Readymag** (рендеринг, CWV, экспорт кода, 152-ФЗ).
- [`02-cms-and-ecommerce-engines.md`](./03-platforms-cms-and-builders/02-cms-and-ecommerce-engines.md) — Современный стек **WordPress** (Bedrock + Bricks), **Shopify** (Liquid vs Hydrogen), **Medusa.js 2.0**, **1С-Битрикс** и **Headless CMS** (**Payload CMS 3.0, Strapi 5, Sanity, Directus, Keystatic, Astro Content Collections**).
- [`03-ai-builders-and-vibe-coding.md`](./03-platforms-cms-and-builders/03-ai-builders-and-vibe-coding.md) — ИИ-платформы генерации интерфейсов (**v0 by Vercel, Bolt.new, Lovable.dev, Relume AI**) и агентные IDE (**Google Antigravity, Cursor, Windsurf, Claude Code**) с пайплайном сборки по MCP.

### 🧰 4. Домены, Хостинг, BaaS, Платежи, Аналитика, Юридический комплаенс и План запуска (`04-infrastructure-and-roadmap/`)
- [`02-domains-hosting-baas-and-payments.md`](./04-infrastructure-and-roadmap/02-domains-hosting-baas-and-payments.md) — Домены и DNS (Cloudflare), Edge-хостинг (**Vercel, Cloudflare Workers, Railway, Fly.io**) vs **VPS + Coolify / Dokploy**, базы данных (**Supabase, Neon, Turso**), **Better Auth vs Clerk**, почта (**Resend**) и платежные шлюзы (**Stripe, Paddle vs ЮKassa, Т-Касса, CloudPayments, СБП**).
- [`03-analytics-qa-legal-and-roadmap.md`](./04-infrastructure-and-roadmap/03-analytics-qa-legal-and-roadmap.md) — Автотесты (**Vitest, Playwright, Lighthouse CI**), аналитика и мониторинг (**PostHog, Plausible/Umami, GA4, Яндекс.Метрика, Sentry**), юридический чек-лист **152-ФЗ РФ и GDPR**, сметы бюджетов и **пошаговый план запуска сайта с нуля (Дни 1–18)**.

---

## 2. Верифицированные репозитории по SEO, Schema.org и AI-Search (GEO)

| № | Репозиторий | Владелец / Организация | Описание и ценность |
| :--- | :--- | :--- | :--- |
| 1 | **[AnswerDotAI/llms-txt](https://github.com/AnswerDotAI/llms-txt)** | **Answer.AI (Jeremy Howard)** | Официальная спецификация и инструментарий стандарта **`/llms.txt`** для индексации сайтов ИИ-поисковиками и LLM-агентами. |
| 2 | **[schemaorg/schemaorg](https://github.com/schemaorg/schemaorg)** | **Schema.org Consortium (Google, Microsoft, Yahoo, Yandex)** | Официальная база схем и словарей структурированных данных **Schema.org** (JSON-LD, Microdata, RDFa). |
| 3 | **[google/site-kit-wp](https://github.com/google/site-kit-wp)** | **Google** | Официальная интеграция Google Search Console, Analytics 4, PageSpeed Insights и Tag Manager. |
| 4 | **[GoogleChrome/CrUX](https://github.com/GoogleChrome/CrUX)** | **Google Chrome Team** | Репозиторий запросов, дашбордов и инструментов анализа полевой базы данных **Chrome User Experience Report (CrUX)**. |
| 5 | **[payloadcms/payload](https://github.com/payloadcms/payload)** | **Payload CMS (Figma / Next.js native)** | Ведущая Next.js-нативная Headless CMS и фреймворк приложений с открытым исходным кодом. |
| 6 | **[withastro/astro](https://github.com/withastro/astro)** | **Astro Technology Company** | Ведущий веб-фреймворк островной архитектуры (**Islands Architecture**) с нулевым JS по умолчанию и максимальными показателями SEO/CWV. |
