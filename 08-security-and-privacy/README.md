# 08. Bezpieczeństwo, HTTPS, Nagłówki HTTP i Ochrona Danych

> **Pytanie główne z listy kontrolnej («Osiem obszarów, czterdzieści pytań»):**
> *«Czy strona działa na HTTPS i chroni dane?»*

---

## 1. Rola kategorii w architekturze strony

Bezpieczeństwo nowoczesnej strony internetowej opiera się na zasadzie **Defense in Depth (obrona w głąb)**: od warstwy transportowej (**HTTP/3 QUIC + TLS 1.3 + HSTS Preload**) i restrykcyjnych nagłówków odpowiedzi serwera (**CSP Level 3 z kryptograficznym `nonce`**, `COOP`, `X-Content-Type-Options`), przez weryfikację aplikacji wg standardów **OWASP ASVS / Top 10** i bezhasłowe uwierzytelnianie (**Passkeys / WebAuthn**), aż po ochronę prywatności (**RODO / GDPR**) i niewidoczną ochronę przed botami (**Cloudflare Turnstile**).

---

## 2. Pięć pytań kontrolnych audytu (36–40 z 40) i kryteria inżynieryjne

### Q8.1. Szyfrowanie połączenia: HTTPS, TLS 1.3 i HSTS Preload (`Transport Layer Security`)
* **Pytanie:** *Czy połączenie jest w pełni szyfrowane (HTTPS / TLS 1.3 / HSTS Preload) bez Mixed Content?*
* **Kryteria weryfikacji:**
  * Aktywne protokoły **TLS 1.3** oraz **HTTP/3 (QUIC)** zgodnie z profilem Mozilla Modern/Intermediate (ocena **A+** w SSL Labs); protokoły TLS 1.0/1.1 całkowicie wyłączone.
  * Bezwarunkowe przekierowanie `301/308` z HTTP na HTTPS, nagłówek `Strict-Transport-Security: max-age=63072000; includeSubDomains; preload` oraz **0 błędów Mixed Content**.

### Q8.2. Restrykcyjne nagłówki bezpieczeństwa HTTP (`CSP Level 3 & Security Headers`)
* **Pytanie:** *Czy skonfigurowano restrykcyjne nagłówki bezpieczeństwa HTTP (CSP, COOP, Frame-Ancestors)?*
* **Kryteria weryfikacji:**
  * Ocena **A / A+** w audycie **MDN / Mozilla HTTP Observatory**.
  * Wdrożony nagłówek `Content-Security-Policy` oparty na `nonce-...` oraz `'strict-dynamic'`, `object-src 'none'`, `base-uri 'none'`, `frame-ancestors 'none'` (lub `'self'`), a także `X-Content-Type-Options: nosniff`, `Referrer-Policy: strict-origin-when-cross-origin`, `Cross-Origin-Opener-Policy: same-origin` oraz `Permissions-Policy`.

### Q8.3. Bezpieczeństwo uwierzytelniania, sesji i ciasteczek (`Session Hardening, Passkeys & CSRF`)
* **Pytanie:** *Czy uwierzytelnianie, sesje i ciasteczka są odporne na przejęcie i CSRF?*
* **Kryteria weryfikacji:**
  * Ciasteczka sesyjne korzystają z prefiksu `__Host-` oraz flag `Secure; HttpOnly; SameSite=Lax` (lub `Strict`); **0 tokenów sesji w `localStorage`**.
  * Żądania zmieniające stan są chronione przed CSRF (`Sec-Fetch-Site` + token CSRF), hasła są haszowane algorytmem **Argon2id**, a logowanie wspiera **Passkeys (WebAuthn / FIDO2)**.

### Q8.4. Ochrona przed XSS, wstrzyknięciami i atakami Supply Chain (`DOM Sanitization, SQLi & SRI`)
* **Pytanie:** *Czy dane wejściowe i DOM są chronione przed XSS, wstrzyknięciami i atakami Supply Chain (SRI)?*
* **Kryteria weryfikacji:**
  * Każdy kod HTML/Markdown/SVG pochodzący od użytkownika przechodzi sanityzację przez **DOMPurify** + tryb **W3C Trusted Types** (`require-trusted-types-for 'script'`).
  * Dane wejściowe API są walidowane schematem (Zod / Valibot) po stronie serwera; zapytania do bazy danych używają wyłącznie zapytań parametryzowanych (*Prepared Statements*); zewnętrzne skrypty CDN posiadają atrybuty `integrity="sha384-..."` (**Subresource Integrity**).

### Q8.5. Ochrona prywatności (RODO / GDPR) i niewidoczna ochrona przed botami (`Privacy & Anti-Bot`)
* **Pytanie:** *Czy strona chroni prywatność użytkowników (GDPR/RODO) i blokuje boty bez utrudniania dostępu ludziom?*
* **Kryteria weryfikacji:**
  * Zewnętrzne skrypty śledzące nie ładują się przed wyrażeniem wyraźnej zgody (*Opt-in*), a przycisk „Odrzuć wszystkie” w banerze cookie ma taką samą wagę wizualną jak „Zaakceptuj wszystkie”.
  * Zamiast nieczytelnych obrazkowych zagadek CAPTCHA stosowane są niewidoczne weryfikacje kryptograficzne (**Cloudflare Turnstile**, Private Access Tokens RFC 9577, WAF Rate Limiting).

---

## 3. Źródła i Zweryfikowane Repozytoria Korporacyjne

| Nr | Repozytorium i link źródłowy | Właściciel / Organizacja | Opis i zastosowanie | Status w `database/08-security-and-privacy/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[OWASP/CheatSheetSeries](https://github.com/OWASP/CheatSheetSeries)** | **OWASP Foundation** | Kompletna baza praktycznych przewodników (`cheatsheets/*.md`) dotyczących ochrony przed XSS, CSRF, SQLi, konfiguracji CSP, HSTS, sesji i WebAuthn. | Sklonowano lokalnie (`./owasp-cheatsheets`) |
| 2 | **[OWASP/ASVS](https://github.com/OWASP/ASVS)** | **OWASP Foundation** | **Application Security Verification Standard**: światowy standard weryfikacji bezpieczeństwa aplikacji webowych (w formatach JSON, CSV, XML, Markdown). | Sklonowano lokalnie (`./owasp-asvs`) |
| 3 | **[cure53/DOMPurify](https://github.com/cure53/DOMPurify)** | **Cure53 Security** | Branżowy standard szybkiej sanityzacji drzewa DOM (HTML, MathML, SVG) chroniący przed atakami XSS i mXSS. | Sklonowano lokalnie (`./dompurify`) |
| 4 | **[helmetjs/helmet](https://github.com/helmetjs/helmet)** | **Helmet.js** | Wzorcowa biblioteka konfiguracji nagłówków bezpieczeństwa HTTP (`CSP`, `HSTS`, `COOP`, `CORP`, `Permissions-Policy`). | Źródło referencyjne |
| 5 | **[mozilla/ssl-config-generator](https://github.com/mozilla/ssl-config-generator)** | **Mozilla Corporation** | Oficjalny generator konfiguracji TLS 1.3 / HTTP/3 Mozilla (Modern, Intermediate) dla serwerów Nginx, Caddy, Apache i Cloudflare. | Źródło referencyjne |
| 6 | **[mdn/mdn-http-observatory](https://github.com/mdn/mdn-http-observatory)** | **Mozilla / MDN** | Silnik oceny i punktacji bezpieczeństwa nagłówków HTTP, TLS, flag Cookies oraz polityki CORS (skala od `F` do `A+`). | Źródło referencyjne |
| 7 | **[MasterKale/SimpleWebAuthn](https://github.com/MasterKale/SimpleWebAuthn)** | **Matthew Miller (FIDO / W3C WG)** | Standardowa biblioteka TypeScript do wdrażania bezhasłowego logowania za pomocą **Passkeys (WebAuthn / FIDO2)**. | Źródło referencyjne |
| 8 | **[OWASP/wstg](https://github.com/OWASP/wstg)** | **OWASP Foundation** | **Web Security Testing Guide**: pełna metodologia testowania bezpieczeństwa aplikacji webowych i API. | Źródło referencyjne |

---

## 4. Przewodniki inżynieryjne w tej kategorii

- [`guides/01-network-and-headers.md`](./guides/01-network-and-headers.md) — Konfiguracja HTTP/3 (QUIC), TLS 1.3, kryptografii postkwantowej (`X25519MLKEM768`), kompresji Brotli/Zstd oraz wzorcowe nagłówki HSTS, Strict CSP (`nonce`), COOP/COEP.
- [`guides/02-owasp-auth-and-antibot.md`](./guides/02-owasp-auth-and-antibot.md) — Praktyczna ochrona wg OWASP Top 10, wdrożenie Passkeys (WebAuthn), zabezpieczenie sesji (`__Host-`), JA4+ Fingerprinting oraz Cloudflare Turnstile.
