# 05. Funkcjonalność / Функциональность, поиск, корзина и производительность

> **Базовый вопрос чек-листа («Osiem obszarów, czterdzieści pytań»):**
> *«Czy koszyk i wyszukiwarka działają bezbłędnie?»* — **Безошибочно ли работают корзина и поиск?**

---

## 1. Обзор категории и инженерная роль

Функциональная надежность сайта проверяется в самых нагруженных и критичных для выручки сценариях: **поиск по сайту с автодополнением**, **корзина и оформление заказа (Checkout)**, соблюдение метрик **Google Core Web Vitals (`LCP <= 2.5s`, `INP <= 200ms`, `CLS <= 0.1`)**, отказоустойчивость (`Error Boundaries`, обработка `404`/`500`/офлайн) и сквозное E2E-тестирование (`Microsoft Playwright`, `Google Lighthouse`).

---

## 2. Пять контрольных вопросов аудита (25/40) и технические метрики

### Q5.1. Мгновенный поиск с устойчивостью к опечаткам и обработкой пустой выдачи (`Instant Search & Typo Tolerance`)
* **Вопрос (PL / RU):** *Czy wyszukiwarka działa błyskawicznie, toleruje literówki i pomaga użytkownikowi przy braku wyników?* / Работает ли поиск мгновенно, прощает ли опечатки и предлагает ли выход при отсутствии результатов?
* **Инженерные критерии проверки:**
  * Задержка ответа автодополнения (typeahead) **$\le 100\text{ мс}$ (p95)** с `debounce` `150–250 мс` и отменой устаревших запросов через `AbortController`.
  * Поддержка устойчивости к опечаткам (1 опечатка на 4–5 символов, 2 опечатки на 8+ символов — стандарт `Meilisearch` / `Typesense` / `Algolia`).
  * Экран «0 результатов» (`Zero-Results UX`) предлагает исправленные запросы, популярные категории и быстрый сброс фильтров; поисковый запрос синхронизирован с URL (`?q=...`).

### Q5.2. Надежность корзины, оптимистичный UI и идемпотентность чекаута (`Cart Persistence & Optimistic UI`)
* **Вопрос (PL / RU):** *Czy koszyk i proces zakupowy zachowują stan, reagują natychmiastowo i są odporne na błędy synchronizacji?* / Сохраняет ли корзина состояние при любых сценариях, реагирует ли мгновенно и защищена ли она от ошибок синхронизации?
* **Инженерные критерии проверки:**
  * Добавление товара и изменение количества обновляют UI мгновенно (**$< 50\text{ мс}$** через `useOptimistic`) с автоматическим откатом при сетевом сбое.
  * Содержимое корзины сохраняется при перезагрузке, смене вкладок и объединяется при входе в аккаунт; транзакции оплаты защищены ключом идемпотентности (`Idempotency-Key`).

### Q5.3. Выполнение нормативов Google Core Web Vitals (`LCP, INP, CLS`)
* **Вопрос (PL / RU):** *Czy strona spełnia rygorystyczne progi Core Web Vitals dla szybkości ładowania, responsywności i stabilności układu?* / Укладывается ли сайт в зеленую зону метрик Core Web Vitals на 75-м перцентиле реальных пользователей (CrUX)?
* **Инженерные критерии проверки:**
  * **LCP (Largest Contentful Paint) $\le 2.5\text{ с}$**: Hero-изображение в исходном SSR HTML с `fetchpriority="high"` без `loading="lazy"`, `TTFB <= 200–800 мс`.
  * **INP (Interaction to Next Paint) $\le 200\text{ мс}$**: отсутствие Long Tasks $> 50\text{ мс}$ в главном потоке, уступание потока через `scheduler.yield()`.
  * **CLS (Cumulative Layout Shift) $\le 0.1$**: жестко зарезервированные размеры медиа и шрифтов.

### Q5.4. Изящная деградация и обработка ошибок 404/500 и обрыва сети (`Graceful Degradation & Error Boundaries`)
* **Вопрос (PL / RU):** *Czy aplikacja bezpiecznie obsługuje błędy 404/500, utratę połączenia i awarie API bez utraty danych użytkownika?* / Корректно ли приложение обрабатывает ошибки 404/500, обрыв соединения и сбои API без потери данных пользователя?
* **Инженерные критерии проверки:**
  * Несуществующие страницы отдают реальный HTTP-статус `404 Not Found` (никаких Soft-404 со статусом `200 OK`).
  * Падение отдельного виджета изолируется локальным `ErrorBoundary` с кнопкой повтора без падения всей страницы.

### Q5.5. Кроссбраузерная и мобильная E2E-целостность (`Cross-Browser E2E Verification`)
* **Вопрос (PL / RU):** *Czy kluczowe ścieżki użytkownika działają identycznie na wszystkich współczesnych przeglądarkach i urządzeniach bez błędów w konsoli?* / Работают ли критические пользовательские сценарии без сбоев и ошибок в консоли в Chromium, Firefox и WebKit (Safari / iOS)?
* **Инженерные критерии проверки:**
  * В E2E-тестах Playwright по маршруту *Главная $\rightarrow$ Поиск $\rightarrow$ Карточка товара $\rightarrow$ Корзина $\rightarrow$ Чекаут* количество ошибок `pageerror`, `unhandledrejection` и битых ссылок (`4xx`/`5xx`) строго равно **0**.

---

## 3. Верифицированные репозитории и базы данных корпораций

| № | Репозиторий | Владелец / Организация | Описание и ценность | Статус в `database/05-functionality-and-performance/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[GoogleChrome/web-vitals](https://github.com/GoogleChrome/web-vitals)** | **Google Chrome Team** | Официальная библиотека измерения `LCP`, `INP`, `CLS`, `FCP`, `TTFB` с диагностической атрибуцией DOM-узлов (`web-vitals/attribution`). | Локальный клон (`./web-vitals`) |
| 2 | **[vercel/commerce](https://github.com/vercel/commerce)** | **Vercel** | Эталонная архитектура высокоскоростного интернет-магазина на Next.js App Router, RSC, Server Actions и оптимистичной корзине (`useOptimistic`). | Локальный клон (`./vercel-commerce`) |
| 3 | **[algolia/autocomplete](https://github.com/algolia/autocomplete)** | **Algolia** | Индустриальный эталон UI-компонента мгновенного поиска с автодополнением (WAI-ARIA 1.2 Combobox, подсказки, история запросов). | Локальный клон (`./algolia-autocomplete`) |
| 4 | **[GoogleChrome/lighthouse](https://github.com/GoogleChrome/lighthouse)** | **Google Chrome Team** | Автоматизированный движок комплексного аудита производительности, доступности, SEO и пользовательских потоков (User Flows). | Внешний эталон |
| 5 | **[microsoft/playwright](https://github.com/microsoft/playwright)** | **Microsoft** | Главный мировой стандарт кроссбраузерного E2E-тестирования (Chromium, WebKit, Firefox) с полной трассировкой (`Trace Viewer`). | Внешний эталон |
| 6 | **[Shopify/hydrogen](https://github.com/Shopify/hydrogen)** | **Shopify** | Официальный e-commerce фреймворк Shopify (`useOptimisticCart`, `PredictiveSearch`, Edge-кэширование). | Внешний эталон |
| 7 | **[meilisearch/meilisearch](https://github.com/meilisearch/meilisearch)** | **Meilisearch** | Сверхбыстрый ($< 50\text{ мс}$) поисковый движок на Rust с защитой от опечаток, фасетными фильтрами и гибридным ИИ-поиском. | Внешний эталон |
| 8 | **[Pagefind/pagefind](https://github.com/Pagefind/pagefind)** | **CloudCannon** | Статический полнотекстовый поиск на Rust/WebAssembly, работающий без бэкенда с минимальным сетевым весом. | Внешний эталон |

---

## 4. Локальные руководства в этой категории

- [`guides/01-core-web-vitals.md`](./guides/01-core-web-vitals.md) — Глубокая оптимизация LCP, INP (`scheduler.yield()`) и CLS, оптимизация шрифтов (`WOFF2`), изображений (`AVIF`) и Speculation Rules API.
- [`guides/02-rendering-and-frameworks.md`](./guides/02-rendering-and-frameworks.md) — Матрица паттернов рендеринга (SSR, SSG, ISR, Streaming SSR, PPR, RSC, Islands, Resumability) и выбор стека (Next.js, Nuxt, Astro, SvelteKit, Qwik).
