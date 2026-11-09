# Полный реестр авторитетных источников, стандартов и исследований (2025–2026)

В этом документе собраны и систематизированы **все первоисточники, официальные спецификации W3C / IETF / WHATWG, руководства Google Search Central, отчеты исследовательских институтов и научные работы**, на которые опирается база знаний по созданию эталонных сайтов.

---

## Оглавление

1. [Архитектура, Core Web Vitals и веб-производительность](#1-архитектура-core-web-vitals-и-веб-производительность)
2. [Современные фреймворки и паттерны рендеринга](#2-современные-фреймворки-и-паттерны-рендеринга)
3. [Сетевая, браузерная и прикладная безопасность](#3-сетевая-браузерная-и-прикладная-безопасность)
4. [UX/UI-дизайн, типографика и психология интерфейсов](#4-uxui-дизайн-типографика-и-психология-интерфейсов)
5. [Веб-доступность (Accessibility — WCAG 2.2, APCA, EAA)](#5-веб-доступность-accessibility--wcag-22-apca-eaa)
6. [Оптимизация конверсии (CRO), веб-формы и регулирование Dark Patterns](#6-оптимизация-конверсии-cro-веб-формы-и-регулирование-dark-patterns)
7. [Техническое SEO, микроразметка Schema.org и E-E-A-T](#7-техническое-seo-микроразметка-schemaorg-и-e-e-a-t)
8. [Генеративный поиск (GEO / AEO), ИИ-краулеры и стандарт llms.txt](#8-генеративный-поиск-geo--aeo-ии-краулеры-и-стандарт-llmstxt)

---

## 1. Архитектура, Core Web Vitals и веб-производительность

| Источник / Организация | Название документа / Стандарта | Что подтверждает в базе знаний | Ссылка на первоисточник |
| :--- | :--- | :--- | :--- |
| **Google web.dev** | *Web Vitals — Essential metrics for a healthy site* | Пороги метрик на 75-м перцентиле CrUX: **LCP $\le 2.5\text{ с}$**, **INP $\le 200\text{ мс}$** (официальная замена FID), **CLS $\le 0.1$**. | [web.dev/articles/vitals](https://web.dev/articles/vitals) |
| **Google web.dev** | *Optimize Largest Contentful Paint (LCP)* | Разбивка LCP на 4 подфазы (*TTFB*, *Load Delay*, *Load Duration*, *Render Delay*), запрет `loading="lazy"` на первом экране. | [web.dev/articles/optimize-lcp](https://web.dev/articles/optimize-lcp) |
| **Google web.dev** | *Optimize Interaction to Next Paint (INP)* | Фазы взаимодействия (*Input Delay*, *Processing Duration*, *Presentation Delay*), борьба с Long Tasks ($>50\text{ мс}$) и LoAF. | [web.dev/articles/optimize-inp](https://web.dev/articles/optimize-inp) |
| **Google web.dev** | *Optimize Cumulative Layout Shift (CLS)* | Окна сессий CLS (до 5 сек), резервирование `width`/`height` и `aspect-ratio`, калибровка веб-шрифтов. | [web.dev/articles/optimize-cls](https://web.dev/articles/optimize-cls) |
| **Google web.dev** | *Optimize Time to First Byte (TTFB)* | Порог диагностической метрики **TTFB $\le 800\text{ мс}$**, влияние CDN и серверного кэширования. | [web.dev/articles/optimize-ttfb](https://web.dev/articles/optimize-ttfb) |
| **Chrome for Developers / WICG** | *Prerender pages in Chrome for instant page navigations (Speculation Rules API)* | Декларативный пререндеринг `<script type="speculationrules">`, уровни `eagerness` (`immediate`, `eager`, `moderate`, `conservative`), `document.prerendering`. | [developer.chrome.com/docs/web-platform/prerender-pages](https://developer.chrome.com/docs/web-platform/prerender-pages) |
| **MDN Web Docs** | *Fetch Priority API (`fetchpriority`)* | Повышение приоритета загрузки главного изображения через `fetchpriority="high"` и понижение второстепенных ресурсов. | [developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch) |
| **MDN Web Docs** | *Scheduler: `yield()` method* | Кооперативная уступка главного потока браузеру для отрисовки кадра с сохранением приоритета в очереди задач. | [developer.mozilla.org/en-US/docs/Web/API/Scheduler/yield](https://developer.mozilla.org/en-US/docs/Web/API/Scheduler/yield) |
| **Google web.dev** | *Best practices for fonts & CSS `@font-face` metric overrides* | Использование WOFF2, отказ от внешних шрифтовых CDN из-за Cache Partitioning, дескрипторы `size-adjust`, `ascent-override`, `descent-override`. | [web.dev/articles/font-best-practices](https://web.dev/articles/font-best-practices) |
| **Google web.dev** | *`content-visibility`: the new CSS property that boosts your rendering performance* | Пропуск Layout & Paint для секций за пределами экрана через `content-visibility: auto` и `contain-intrinsic-size`. | [web.dev/articles/content-visibility](https://web.dev/articles/content-visibility) |
| **Google web.dev** | *Back/forward cache (`bfcache`)* | Мгновенная навигация «Назад/Вперед», отказ от событий `unload` и заголовка `Cache-Control: no-store` на HTML. | [web.dev/articles/bfcache](https://web.dev/articles/bfcache) |
| **Partytown (Builder.io)** | *Partytown Documentation — Relocate resource intensive scripts into a web worker* | Вынос сторонних скриптов аналитики (GTM, GA4, пиксели) с главного потока в Web Worker через Proxy и Sync XHR. | [partytown.builder.io](https://partytown.builder.io/) |
| **HTTP Archive** | *Web Almanac (Annual State of the Web Report)* | Мировая статистика внедрения AVIF/WebP, веса JS-бандлов, распространения HTTP/3 и Core Web Vitals. | [almanac.httparchive.org](https://almanac.httparchive.org/) |

---

## 2. Современные фреймворки и паттерны рендеринга

| Источник / Фреймворк | Название документа | Что подтверждает в базе знаний | Ссылка на первоисточник |
| :--- | :--- | :--- | :--- |
| **Next.js (Vercel)** | *Partial Prerendering (PPR) & Dynamic IO (`'use cache'`)* | Объединение мгновенной статической оболочки на Edge и потокового SSR (`<Suspense>`) в одном HTTP-ответе; директивы `'use cache'` и `cacheTag`. | [nextjs.org/docs/app/building-your-application/rendering/partial-prerendering](https://nextjs.org/docs/app/building-your-application/rendering/partial-prerendering) |
| **React Team (Meta)** | *React Server Components (RSC) Specification* | Выполнение компонентов на сервере с нулевым весом клиентского бандла (0 KB JS). | [react.dev/reference/rsc/server-components](https://react.dev/reference/rsc/server-components) |
| **Astro** | *Astro Islands Architecture & Server Islands (`server:defer`)* | Архитектура островов (Zero JS по умолчанию), селективная гидратация (`client:visible`, `client:idle`) и отложенные серверные острова. | [docs.astro.build/en/concepts/islands](https://docs.astro.build/en/concepts/islands/) |
| **Nuxt** | *Nuxt Rendering Modes & Nitro Hybrid Route Rules* | Помаршрутная настройка рендеринга (`prerender`, `swr`, `isr`, `ssr: false`) на уровне движка Nitro. | [nuxt.com/docs/guide/concepts/rendering](https://nuxt.com/docs/guide/concepts/rendering) |
| **Svelte / SvelteKit** | *Svelte 5 Runes (`$state`, `$derived`, `$effect`) & SvelteKit Docs* | Тонкогранулярная компиляторная реактивность без Virtual DOM и минимальный рантайм для низкого INP. | [svelte.dev/docs/svelte/what-are-runes](https://svelte.dev/docs/svelte/what-are-runes) |
| **Qwik** | *Resumability vs Hydration* | Отказ от гидратации в пользу сериализации состояния и слушателей в HTML; загрузка JS по действию со сложностью $O(1)$. | [qwik.dev/docs/concepts/resumable](https://qwik.dev/docs/concepts/resumable/) |

---

## 3. Сетевая, браузерная и прикладная безопасность

| Источник / Организация | Название стандарта / RFC | Что подтверждает в базе знаний | Ссылка на первоисточник |
| :--- | :--- | :--- | :--- |
| **IETF** | **RFC 8446** — *The Transport Layer Security (TLS) Protocol Version 1.3* | Рукопожатие 1-RTT / 0-RTT, обязательная прямая секретность (PFS), удаление устаревших шифров, шифры AEAD. | [datatracker.ietf.org/doc/html/rfc8446](https://datatracker.ietf.org/doc/html/rfc8446) |
| **NIST / Cloudflare** | **FIPS 203 (ML-KEM)** & *Post-Quantum Cryptography (`X25519MLKEM768`)* | Гибридный постквантовый обмен ключами в TLS 1.3 для защиты от атак *«Harvest Now, Decrypt Later»*. | [blog.cloudflare.com/post-quantum-cryptography-ga](https://blog.cloudflare.com/post-quantum-cryptography-ga/) |
| **IETF** | **RFC 9114** (*HTTP/3*) & **RFC 9000** (*QUIC: A UDP-Based Multiplexed and Secure Transport*) | Работа поверх UDP, полное устранение транспортного Head-of-Line Blocking, бесшовная миграция соединения (`Connection ID`). | [datatracker.ietf.org/doc/html/rfc9114](https://datatracker.ietf.org/doc/html/rfc9114) |
| **IETF / Chromium** | **RFC 6797** (*HTTP Strict Transport Security*) & *HSTS Preload List* | Принудительный HTTPS и требования к включению домена в жестко зашитый список браузеров (`max-age=63072000; includeSubDomains; preload`). | [hstspreload.org](https://hstspreload.org/) |
| **W3C / Google Web.dev** | *Content Security Policy Level 3 (CSP3) & Strict CSP* | Защита от XSS с помощью криптографических одноразовых токенов `'nonce-...'` и директивы `'strict-dynamic'`. | [w3.org/TR/CSP3](https://www.w3.org/TR/CSP3/) / [web.dev/articles/strict-csp](https://web.dev/articles/strict-csp) |
| **W3C / Google Web.dev** | *Trusted Types API (`require-trusted-types-for 'script'`)* | Блокировка небезопасных записей в DOM XSS sinks (`innerHTML`, `document.write`) на уровне движка браузера. | [web.dev/articles/trusted-types](https://web.dev/articles/trusted-types) |
| **OWASP Foundation** | *OWASP Top 10 & OWASP Cheat Sheet Series* | Контроль доступа на сервере, защита от SSRF, атрибуты куки с префиксом `__Host-`, безопасность цепочки поставок (SBOM, SRI). | [owasp.org/www-project-top-ten](https://owasp.org/www-project-top-ten/) / [cheatsheetseries.owasp.org](https://cheatsheetseries.owasp.org/) |
| **W3C & FIDO Alliance** | *Web Authentication (WebAuthn) Level 3 & Passkeys.dev* | Беспарольная криптографическая аутентификация, устойчивая к фишингу (AiTM), и автозаполнение через Conditional UI (`mediation: 'conditional'`). | [w3.org/TR/webauthn-3](https://www.w3.org/TR/webauthn-3/) / [passkeys.dev](https://passkeys.dev/) |
| **IETF** | **RFC 9577** — *The Privacy Pass Architecture (Private Access Tokens)* | Невидимая криптографическая аттестация реальных устройств Apple/Google без показа визуальных CAPTCHA и без отслеживания пользователя. | [datatracker.ietf.org/doc/rfc9577](https://datatracker.ietf.org/doc/rfc9577/) |
| **Cloudflare / FoxIO** | *Cloudflare Turnstile & JA4+ Network Fingerprinting* | Невидимая замена CAPTCHA и детектирование headless-ботов по отпечаткам TLS-рукопожатий и кадров HTTP/2. | [developers.cloudflare.com/turnstile](https://developers.cloudflare.com/turnstile/) |

---

## 4. UX/UI-дизайн, типографика и психология интерфейсов

| Источник / Автор | Название исследования / Руководства | Что подтверждает в базе знаний | Ссылка на первоисточник |
| :--- | :--- | :--- | :--- |
| **Nielsen Norman Group (NN/g)** | *Psychology for UX & Laws of UX (Hick's, Fitts's, Jakob's, Miller's Laws, Doherty Threshold)* | Ограничение верхнего меню 4–6 пунктами, размеры тач-таргетов в зоне большого пальца, сохранение привычных ментальных моделей, отклик интерфейса $< 400\text{ мс}$. | [nngroup.com/articles/psychology-study-guide](https://www.nngroup.com/articles/psychology-study-guide/) / [lawsofux.com](https://lawsofux.com/) |
| **MDN Web Docs / W3C** | *CSS Containment Module Level 3 — Container Queries (`@container`)* | Компонентно-ориентированная адаптивность (`container-type: inline-size`, единицы `cqi`) вместо глобальных медиа-запросов к экрану. | [developer.mozilla.org/en-US/docs/Web/CSS/CSS_containment/Container_queries](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_containment/Container_queries) |
| **Smashing Magazine** | *Modern Fluid Typography Using CSS Clamp (With Accessibility / WCAG 1.4.4 Compliance)* | Безопасная формула `clamp(min, Xrem + Yvw, max)`, сохраняющая масштабирование шрифта при браузерном зуме до 200%, и оптимальная длина строки `50–75ch` (`65ch`). | [smashingmagazine.com/2022/01/modern-fluid-typography-css-clamp](https://www.smashingmagazine.com/2022/01/modern-fluid-typography-css-clamp/) |
| **W3C / Chrome for Developers** | *CSS View Transitions Module Level 1 & Level 2 (`@view-transition`)* | Нативные бесшовные анимации переходов между состояниями DOM и полными перезагрузками страниц (MPA/SPA) без сторонних JS-библиотек. | [developer.chrome.com/docs/web-platform/view-transitions](https://developer.chrome.com/docs/web-platform/view-transitions) |
| **W3C / Smashing Magazine** | *Designing Safer Web Animation For Motion Sensitivity (`prefers-reduced-motion`)* | Принцип *«Reduce, Don't Delete»*: отключение вестибулярных триггеров (параллакса, вращения) с сохранением мягких переходов прозрачности. | [smashingmagazine.com/2020/09/design-reduced-motion-sensitivities](https://www.smashingmagazine.com/2020/09/design-reduced-motion-sensitivities/) |

---

## 5. Веб-доступность (Accessibility — WCAG 2.2, APCA, EAA)

| Источник / Организация | Название стандарта / Отчета | Что подтверждает в базе знаний | Ссылка на первоисточник |
| :--- | :--- | :--- | :--- |
| **W3C Recommendation** | *Web Content Accessibility Guidelines (WCAG) 2.2* | Официальный стандарт доступности: удаление критерия `4.1.1 Parsing` и введение 9 новых критериев (`2.4.11 Focus Not Obscured`, `2.5.7 Dragging Movements`, `2.5.8 Target Size Minimum 24×24px`, `3.2.6 Consistent Help`, `3.3.7 Redundant Entry`, `3.3.8 Accessible Authentication`). | [w3.org/TR/WCAG22](https://www.w3.org/TR/WCAG22/) |
| **W3C** | *What's New in WCAG 2.2* | Подробный разбор всех новых критериев WCAG 2.2 с визуальными примерами прохождения и провала аудита. | [w3.org/WAI/standards-guidelines/wcag/new-in-22](https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/) |
| **WebAIM** | *The WebAIM Million (Annual Accessibility Analysis of Top 1,000,000 Home Pages, 2025–2026)* | Статистика ошибок на 94.8%–95.9% сайтов мира, топ-6 критических нарушений (низкий контраст 83.6%+, отсутствие `alt` и `<label>`) и рост ошибок на 41%–68% при неправильном использовании ARIA. | [webaim.org/projects/million](https://webaim.org/projects/million/) |
| **W3C** | *Using ARIA (First Rule of ARIA Use)* | Первое правило ARIA: использование нативных семантических элементов HTML5 (`<dialog>`, `<details>`, `<button>`, `popover`) вместо кастомных `<div>` с ролями. | [w3.org/TR/using-aria/#rule1](https://www.w3.org/TR/using-aria/#rule1) |
| **W3C / Myndex Research** | *Accessible Perceptual Contrast Algorithm (APCA) & WCAG 3.0 Working Draft* | Перцептивный расчет контраста ($L_c \ge 75\text{–}90$ для основного текста, $L_c \ge 60$ для подзаголовков, $L_c \ge 45$ для крупных заголовков) с учетом веса шрифта и темной темы. | [w3.org/TR/wcag-3.0](https://www.w3.org/TR/wcag-3.0/) / [apcacontrast.com](https://apcacontrast.com/) |
| **European Union Law** | **Directive (EU) 2019/882** — *European Accessibility Act (EAA) & Standard EN 301 549* | Обязательность соблюдения стандарта доступности для e-commerce, банков, билетных сервисов и SaaS на рынке ЕС с 28 июня 2025 года. | [eur-lex.europa.eu/eli/dir/2019/882/oj](https://eur-lex.europa.eu/eli/dir/2019/882/oj) |

---

## 6. Оптимизация конверсии (CRO), веб-формы и регулирование Dark Patterns

| Источник / Институт | Название исследования / Закона | Что подтверждает в базе знаний | Ссылка на первоисточник |
| :--- | :--- | :--- | :--- |
| **Nielsen Norman Group (NN/g)** | *How Users Read on the Web: Text Scanning Patterns (Eyetracking Study)* | Доказательство того, что 79% пользователей сканируют текст; превосходство паттерна «Слоеный пирог» (*Layer-Cake Pattern*) над *F-Pattern*. | [nngroup.com/articles/text-scanning-patterns-eyetracking](https://www.nngroup.com/articles/text-scanning-patterns-eyetracking/) |
| **Baymard Institute** | *49 Cart Abandonment Rate Statistics (2025–2026)* | Средний процент брошенных корзин (**70.22%**), главные причины отказов: неожиданные доплаты (**48%**), принудительная регистрация (**26%**), сложный чекаут (**18%–22%**). | [baymard.com/lists/cart-abandonment-rate](https://baymard.com/lists/cart-abandonment-rate) |
| **Baymard Institute** | *Checkout Usability: Autocomplete, Form Fields & Guest Checkout* | Потенциал роста конверсии **+35.26%**; эталон в **7–8 полей ввода** (12–14 элементов формы), одноколоночная верстка, скрытие поля *Address Line 2* и промокода, валидация по `onBlur`. | [baymard.com/blog/checkout-flow-average-form-fields](https://baymard.com/blog/checkout-flow-average-form-fields) |
| **Spiegel Research Center (Northwestern University)** | *How Online Reviews Influence Sales* | Максимальная вероятность покупки при рейтинге товара в диапазоне **4.2 – 4.7 из 5.0**; падение доверия при стерильном рейтинге 5.0; важность верифицированных отзывов. | [spiegel.medill.northwestern.edu/how-online-reviews-influence-sales](https://spiegel.medill.northwestern.edu/how-online-reviews-influence-sales/) |
| **European Union Law** | **Digital Services Act (DSA) — Article 25** (*Protection against Dark Patterns*) | Прямой запрет манипулятивных интерфейсов (*Confirmshaming*, *Roach Motel*, *Pre-ticked Boxes*) со штрафами до 6% мирового оборота. | [eur-lex.europa.eu/eli/reg/2022/2065/oj](https://eur-lex.europa.eu/eli/reg/2022/2065/oj) |
| **Federal Trade Commission (FTC, USA)** | *FTC Final "Click-to-Cancel" Rule (Negative Option Rule)* | Юридическое требование: отмена подписки должна быть такой же простой и доступной в том же канале, что и ее подключение. | [ftc.gov/news-events/news/press-releases/2024/10/federal-trade-commission-announces-final-click-cancel-rule](https://www.ftc.gov/news-events/news/press-releases/2024/10/federal-trade-commission-announces-final-click-cancel-rule-making-it-easier-consumers-end-recurring) |

---

## 7. Техническое SEO, микроразметка Schema.org и E-E-A-T

| Источник / Организация | Название документации | Что подтверждает в базе знаний | Ссылка на первоисточник |
| :--- | :--- | :--- | :--- |
| **Google Search Central** | *Large Site Owner's Guide to Managing Your Crawl Budget* | Влияние скорости ответа сервера и отсутствия ошибок `5xx`/`429` на лимит сканирования; борьба с фасетными ловушками (Crawl Traps). | [developers.google.com/search/docs/crawling-indexing/large-site-managing-crawl-budget](https://developers.google.com/search/docs/crawling-indexing/large-site-managing-crawl-budget) |
| **Google Search Central** | *How to Specify a Canonical with `rel="canonical"` and Other Methods* | Обязательность самоссылающихся каноникалов, запрет конфликтов между `canonical`, `noindex`, `301` и `sitemap.xml`, правила пагинации. | [developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls](https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls) |
| **Google Search Central** | *Localized Versions of Your Pages (`hreflang` Guidelines)* | Правило взаимных обратных ссылок (Reciprocity), коды ISO 639-1 и ISO 3166-1 Alpha 2 (`GB` вместо `UK`), использование `x-default`. | [developers.google.com/search/docs/specialty/international/localized-versions](https://developers.google.com/search/docs/specialty/international/localized-versions) |
| **Google Search Central** | *Build and Submit a Sitemap (`<lastmod>` Best Practices)* | Использование `<lastmod>` как ключевого сигнала переобхода только при реальном значимом изменении контента; игнорирование `<priority>` и `<changefreq>`. | [developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap](https://developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap) |
| **Google Search Central** | *Simplifying the Search Results Page (Structured Data Deprecations 2023–2025)* | Официальное прекращение показа сниппетов `HowTo`, ограничение `FAQPage`, а также отключение `ClaimReview`, `CourseInfo`, `EstimatedSalary`, `LearningVideo`, `SpecialAnnouncement`, `VehicleListing`. | [developers.google.com/search/blog/2025/06/simplifying-search-results](https://developers.google.com/search/blog/2025/06/simplifying-search-results) |
| **Schema.org & Google Search Central** | *Introduction to Structured Data Markup in Google Search (JSON-LD & Entity Graph)* | Построение связанного графа сущностей через `@graph`, сквозные идентификаторы `@id` и свойство `sameAs`; разметка `Organization`, `Product`, `Article`, `ProfilePage`. | [developers.google.com/search/docs/appearance/structured-data/intro-structured-data](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data) / [schema.org](https://schema.org/) |
| **Google Search Central** | *Creating Helpful, Reliable, People-First Content & Search Quality Rater Guidelines (E-E-A-T)* | Критерии **Experience, Expertise, Authoritativeness, Trustworthiness**; интеграция Helpful Content System в ядро ранжирования; санкции за Scaled Content Abuse. | [developers.google.com/search/docs/fundamentals/creating-helpful-content](https://developers.google.com/search/docs/fundamentals/creating-helpful-content) |
| **Google Patent (US11354342B2)** | *Contextual estimation of link information gain (Information Gain Score)* | Оценка прироста новой уникальной информации в документе по сравнению с уже просмотренными пользователем страницами выдачи. | [patents.google.com/patent/US11354342B2/en](https://patents.google.com/patent/US11354342B2/en) |
| **Ahrefs & Semrush** | *Topic Clusters & Pillar Pages for SEO (Hub & Spoke Architecture)* | Построение Topical Authority за счет центральной хабовой страницы (Pillar Page) и поддерживающих кластерных статей с двусторонней контекстной перелинковкой. | [ahrefs.com/blog/topic-clusters](https://ahrefs.com/blog/topic-clusters/) / [semrush.com/blog/topic-clusters](https://www.semrush.com/blog/topic-clusters/) |

---

## 8. Генеративный поиск (GEO / AEO), ИИ-краулеры и стандарт `llms.txt`

| Источник / Авторы | Название исследования / Спецификации | Что подтверждает в базе знаний | Ссылка на первоисточник |
| :--- | :--- | :--- | :--- |
| **Princeton University, Georgia Tech, Allen Institute for AI, IIT Delhi** | *GEO: Generative Engine Optimization* (Pranjal Aggarwal et al., ACM SIGKDD / arXiv:2311.09735) | Фундаментальное научное исследование на бенчмарке **GEO-bench** (10 000 запросов): рост видимости в ответах ИИ на **+30–40%** при добавлении статистики (`Statistics Addition`), ссылок на источники (`Cite Sources`) и цитат экспертов (`Quotation Addition`); падение видимости при `Keyword Stuffing`. | [arxiv.org/abs/2311.09735](https://arxiv.org/abs/2311.09735) |
| **Ahrefs Research (2025–2026)** | *AI Overviews Reduce Clicks by 58% & Brand Radar AI Citations Study* | Снижение CTR первой позиции органики при наличии AI Overview; пересечение лишь ~38% цитат AIO с классическим ТОП-10 за счет механизма *Query Fan-Out*; роль внешних упоминаний бренда. | [ahrefs.com/blog/ai-overviews-reduce-clicks](https://ahrefs.com/blog/ai-overviews-reduce-clicks/) |
| **Semrush Research (2025–2026)** | *AI Overviews Study: What 2025 SEO Data Tells Us About Google's Search Shift* | Динамика роста доли AI Overviews в выдаче и экспансия из чисто информационных в коммерческие и навигационные запросы. | [semrush.com/blog/semrush-ai-overviews-study](https://www.semrush.com/blog/semrush-ai-overviews-study/) |
| **Answer.AI (Jeremy Howard)** | *The `/llms.txt` File Standard Proposal* | Спецификация файлов `/llms.txt` и `/llms-full.txt` в формате Markdown для быстрой и точной навигации LLM-агентов и RAG-систем по структуре сайта. | [llmstxt.org](https://llmstxt.org/) |
| **OpenAI Platform** | *Overview of OpenAI Crawlers (`OAI-SearchBot`, `ChatGPT-User`, `GPTBot`)* | Официальное разделение бота поискового индекса ChatGPT Search (`OAI-SearchBot`), пользовательского агента (`ChatGPT-User`) и краулера обучения моделей (`GPTBot`). | [platform.openai.com/docs/bots](https://platform.openai.com/docs/bots) |
| **Google Search Central** | *Google Crawler and Fetcher Overview (`Googlebot` vs `Google-Extended`)* | Разграничение основного поискового робота `Googlebot` (отвечающего за Google Search и AI Overviews) и управляющего токена `Google-Extended`. | [developers.google.com/search/docs/crawling-indexing/overview-google-crawlers](https://developers.google.com/search/docs/crawling-indexing/overview-google-crawlers) |
| **Perplexity AI & Anthropic** | *PerplexityBot & ClaudeBot / Claude-SearchBot Documentation* | Правила настройки `robots.txt` и WAF для разрешения индексации в генеративных поисковых системах Perplexity и Claude. | [docs.perplexity.ai/guides/bots](https://docs.perplexity.ai/guides/bots) |
