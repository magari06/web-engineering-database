# 08. Bezpieczeństwo / Безопасность, HTTPS и защита данных

> **Базовый вопрос чек-листа («Osiem obszarów, czterdzieści pytań»):**
> *«Czy strona działa na HTTPS i chroni dane?»* — **Работает ли сайт по HTTPS и защищает ли он данные?**

---

## 1. Обзор категории и инженерная роль

Безопасность современного сайта строится по принципу **Defense in Depth (эшелонированная защита)**: от транспортного уровня (**HTTP/3 QUIC + TLS 1.3 + HSTS Preload**) и строгих заголовков ответа сервера (**CSP Level 3 с криптографическим `nonce`**, `COOP`, `X-Content-Type-Options`) до защиты приложения по стандартам **OWASP ASVS / Top 10**, беспарольной аутентификации (**Passkeys / WebAuthn**) и невидимой антибот-защиты без раздражающих визуальных капч (**Cloudflare Turnstile**, Private Access Tokens).

---

## 2. Пять контрольных вопросов аудита (40/40) и технические метрики

### Q8.1. Шифрование транспорта: HTTPS, TLS 1.3 и HSTS Preload (`Transport Layer Security`)
* **Вопрос (PL / RU):** *Czy połączenie jest w pełni szyfrowane (HTTPS / TLS 1.3 / HSTS Preload) bez Mixed Content?* / Защищено ли соединение по протоколу HTTPS (TLS 1.3 + HSTS Preload) без смешанного контента?
* **Инженерные критерии проверки:**
  * Активированы **TLS 1.3** и **HTTP/3 (QUIC)** по профилю Mozilla Modern/Intermediate (SSL Labs Grade **A+**); протоколы TLS 1.0/1.1 полностью отключены.
  * Настроен безусловный `301/308` редирект с HTTP на HTTPS, заголовок `Strict-Transport-Security: max-age=63072000; includeSubDomains; preload` и **0 ошибок Mixed Content**.

### Q8.2. Строгие HTTP-заголовки безопасности (`CSP Level 3 & HTTP Security Headers`)
* **Вопрос (PL / RU):** *Czy skonfigurowano restrykcyjne nagłówki bezpieczeństwa HTTP (CSP, COOP, Frame-Ancestors)?* / Настроены ли защитные HTTP-заголовки (CSP, защита от Clickjacking и MIME-sniffing)?
* **Инженерные критерии проверки:**
  * Рейтинг **A / A+** в **MDN / Mozilla HTTP Observatory**.
  * Внедрен `Content-Security-Policy` с `nonce-...` и `'strict-dynamic'`, `object-src 'none'`, `base-uri 'none'`, `frame-ancestors 'none'` (или `'self'`), а также `X-Content-Type-Options: nosniff`, `Referrer-Policy: strict-origin-when-cross-origin`, `Cross-Origin-Opener-Policy: same-origin` и `Permissions-Policy`.

### Q8.3. Защита аутентификации, сессий и куки (`Session Hardening, Passkeys & CSRF`)
* **Вопрос (PL / RU):** *Czy uwierzytelnianie, sesje i ciasteczka są odporne na przejęcie i CSRF?* / Защищены ли аутентификация, сессии и cookies от перехвата, брутфорса и CSRF-атак?
* **Инженерные критерии проверки:**
  * Сессионные cookies используют префикс `__Host-` и флаги `Secure; HttpOnly; SameSite=Lax` (или `Strict`); **0 токенов сессии в `localStorage`**.
  * Мутирующие запросы защищены от CSRF (проверка `Sec-Fetch-Site` + CSRF-токен), пароли хешируются **Argon2id**, поддерживается вход по **Passkeys (WebAuthn / FIDO2)**.

### Q8.4. Защита от XSS, инъекций и подмены зависимостей (`DOM Sanitization, SQLi & SRI`)
* **Вопрос (PL / RU):** *Czy dane wejściowe i DOM są chronione przed XSS, wstrzyknięciami i atakami Supply Chain (SRI)?* / Защищены ли пользовательский ввод, DOM и внешние скрипты от XSS, инъекций и подмены?
* **Инженерные критерии проверки:**
  * Любой пользовательский HTML/Markdown/SVG проходит санитизацию через **DOMPurify** + режим **W3C Trusted Types** (`require-trusted-types-for 'script'`).
  * Входные данные API валидируются по строгой схеме (Zod / Valibot) на сервере; запросы к БД используют только параметризованные запросы (Prepared Statements); внешние CDN-ресурсы снабжены хешами `integrity="sha384-..."` (**Subresource Integrity**).

### Q8.5. Приватность данных (GDPR / 152-ФЗ) и бесшовная защита от ботов (`Privacy & Invisible Anti-Bot`)
* **Вопрос (PL / RU):** *Czy strona chroni prywatność użytkowników (GDPR/RODO) i blokuje boty bez utrudniania dostępu ludziom?* / Соблюдает ли сайт приватность данных и защищает ли формы от ботов без враждебных человеку визуальных капч?
* **Инженерные критерии проверки:**
  * Сторонние трекеры не загружаются до явного согласия пользователя (Opt-in), а кнопка «Отклонить все» в Cookie-баннере равнозначна кнопке «Принять все».
  * Вместо нечитаемых картинок-капч используются невидимые криптографические проверки (**Cloudflare Turnstile**, Private Access Tokens RFC 9577, WAF Rate Limiting).

---

## 3. Верифицированные репозитории и базы данных корпораций

| № | Репозиторий | Владелец / Организация | Описание и ценность | Статус в `database/08-security-and-privacy/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[OWASP/CheatSheetSeries](https://github.com/OWASP/CheatSheetSeries)** | **OWASP Foundation** | Полная база практических руководств (`cheatsheets/*.md`) по защите от XSS, CSRF, SQLi, настройке CSP, HSTS, REST/GraphQL, сессий и WebAuthn. | Локальный клон (`./owasp-cheatsheets`) |
| 2 | **[OWASP/ASVS](https://github.com/OWASP/ASVS)** | **OWASP Foundation** | **Application Security Verification Standard**: мировой стандарт верификации безопасности веб-приложений (в форматах JSON, CSV, XML, Markdown). | Локальный клон (`./owasp-asvs`) |
| 3 | **[cure53/DOMPurify](https://github.com/cure53/DOMPurify)** | **Cure53 Security** | Индустриальный стандарт быстрой DOM-санитизации HTML, MathML и SVG против XSS и мутационных атак (mXSS). | Локальный клон (`./dompurify`) |
| 4 | **[helmetjs/helmet](https://github.com/helmetjs/helmet)** | **Helmet.js** | Эталонная библиотека установки защитных HTTP-заголовков (`CSP`, `HSTS`, `COOP`, `CORP`, `Permissions-Policy`). | Внешний эталон |
| 5 | **[mozilla/ssl-config-generator](https://github.com/mozilla/ssl-config-generator)** | **Mozilla Corporation** | Официальный генератор эталонных TLS 1.3 / HTTP/3 конфигураций Mozilla (Modern, Intermediate) для Nginx, Caddy, Apache и Cloudflare. | Внешний эталон |
| 6 | **[mdn/mdn-http-observatory](https://github.com/mdn/mdn-http-observatory)** | **Mozilla / MDN** | Движок оценки и скоринга безопасности HTTP-заголовков, TLS, флагов Cookies и политики CORS (шкала от `F` до `A+`). | Внешний эталон |
| 7 | **[MasterKale/SimpleWebAuthn](https://github.com/MasterKale/SimpleWebAuthn)** | **Matthew Miller (FIDO / W3C WG)** | Стандартная TypeScript-библиотека для внедрения беспарольного входа через **Passkeys (WebAuthn / FIDO2)**. | Внешний эталон |
| 8 | **[OWASP/wstg](https://github.com/OWASP/wstg)** | **OWASP Foundation** | **Web Security Testing Guide**: полная методология тестирования безопасности веб-приложений и API. | Внешний эталон |

---

## 4. Локальные руководства в этой категории

- [`guides/01-network-and-headers.md`](./guides/01-network-and-headers.md) — Настройка HTTP/3 (QUIC), TLS 1.3, постквантовой криптографии (`X25519MLKEM768`), Brotli/Zstd и эталонные конфиги HSTS, Strict CSP (`nonce`), COOP/COEP.
- [`guides/02-owasp-auth-and-antibot.md`](./guides/02-owasp-auth-and-antibot.md) — Практическая защита по OWASP Top 10, внедрение Passkeys (WebAuthn), защита сессий (`__Host-`), JA4+ Fingerprinting и Cloudflare Turnstile.
