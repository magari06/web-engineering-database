# 05. Funkcjonalność, Wyszukiwarka, Koszyk i Wydajność (Core Web Vitals)

> **Pytanie główne z listy kontrolnej («Osiem obszarów, czterdzieści pytań»):**
> *«Czy koszyk i wyszukiwarka działają bezbłędnie?»*

---

## 1. Rola kategorii w architekturze strony

Niezawodność funkcjonalna serwisu jest weryfikowana w najbardziej krytycznych biznesowo ścieżkach użytkownika: **wyszukiwarce wewnętrznej z autouzupełnianiem**, **koszyku i procesie zakupowym (*Checkout*)**, spełnieniu norm **Google Core Web Vitals (`LCP <= 2.5s`, `INP <= 200ms`, `CLS <= 0.1`)**, odporności na błędy (`Error Boundaries`, obsługa `404`/`500`/trybu offline) oraz automatycznych testach E2E (`Microsoft Playwright`, `Google Lighthouse`).

---

## 2. Pięć pytań kontrolnych audytu (21–25 z 40) i kryteria inżynieryjne

### Q5.1. Błyskawiczna wyszukiwarka z tolerancją literówek i obsługą braku wyników (`Instant Search & Typo Tolerance`)
* **Pytanie:** *Czy wyszukiwarka działa błyskawicznie, toleruje literówki i pomaga użytkownikowi przy braku wyników?*
* **Kryteria weryfikacji:**
  * Czas odpowiedzi autouzupełniania (*typeahead*) **$\le 100\text{ ms}$ (p95)** z zastosowaniem `debounce` (`150–250 ms`) i anulowaniem nieaktualnych zapytań przez `AbortController`.
  * Tolerancja na błędy pisowni (1 literówka w słowach od 4–5 znaków, 2 literówki od 8+ znaków — standard `Meilisearch` / `Typesense` / `Algolia`).
  * Widok „Brak wyników” (*Zero-Results UX*) proponuje poprawione zapytania, popularne kategorie i szybki reset filtrów, a stan wyszukiwania jest zsynchronizowany z parametrami URL (`?q=...`).

### Q5.2. Niezawodność koszyka, Optimistic UI i idempotentność zakupów (`Cart Persistence & Optimistic UI`)
* **Pytanie:** *Czy koszyk i proces zakupowy zachowują stan, reagują natychmiastowo i są odporne na błędy synchronizacji?*
* **Kryteria weryfikacji:**
  * Dodanie produktu oraz zmiana ilości aktualizują interfejs natychmiastowo (**$< 50\text{ ms}$** przez `useOptimistic`) z automatycznym wycofaniem (*rollback*) w razie błędu sieci.
  * Zawartość koszyka jest zachowywana po odświeżeniu strony, między kartami przeglądarki oraz łączona po zalogowaniu użytkownika, a transakcje płatnicze są zabezpieczone kluczem `Idempotency-Key`.

### Q5.3. Spełnienie rygorystycznych progów Google Core Web Vitals (`LCP, INP, CLS`)
* **Pytanie:** *Czy strona spełnia rygorystyczne progi Core Web Vitals dla szybkości ładowania, responsywności i stabilności układu?*
* **Kryteria weryfikacji (75. percentyl CrUX):**
  * **LCP (Largest Contentful Paint) $\le 2.5\text{ s}$**: obraz Hero obecny w początkowym HTML SSR z atrybutem `fetchpriority="high"` i bez `loading="lazy"`, `TTFB <= 200–800 ms`.
  * **INP (Interaction to Next Paint) $\le 200\text{ ms}$**: brak zadań blokujących główny wątek (`Long Tasks > 50 ms`), zwalnianie wątku przez `scheduler.yield()`.
  * **CLS (Cumulative Layout Shift) $\le 0.1$**: zarezerwowane wymiary wszystkich mediów i czcionek.

### Q5.4. Bezpieczna obsługa błędów 404/500 i awarii sieci (`Graceful Degradation & Error Boundaries`)
* **Pytanie:** *Czy aplikacja bezpiecznie obsługuje błędy 404/500, utratę połączenia i awarie API bez utraty danych użytkownika?*
* **Kryteria weryfikacji:**
  * Nieistniejące adresy URL zwracają rzeczywisty status HTTP `404 Not Found` (brak tzw. *Soft 404* ze statusem `200 OK`).
  * Awaria pojedynczego widżetu jest izolowana przez lokalny komponent `ErrorBoundary` z przyciskiem ponowienia próby.

### Q5.5. Spójność międzyprzeglądarkowa i testy E2E (`Cross-Browser E2E Verification`)
* **Pytanie:** *Czy kluczowe ścieżki użytkownika działają identycznie na wszystkich współczesnych przeglądarkach i urządzeniach bez błędów w konsoli?*
* **Kryteria weryfikacji:**
  * W testach E2E Playwright dla ścieżki *Strona główna $\rightarrow$ Wyszukiwarka $\rightarrow$ Produkt $\rightarrow$ Koszyk $\rightarrow$ Zamówienie* w przeglądarkach Chromium, Firefox i WebKit (Safari / iOS) liczba błędów `pageerror`, `unhandledrejection` i uszkodzonych linków (`4xx`/`5xx`) wynosi **0**.

---

## 3. Źródła i Zweryfikowane Repozytoria Korporacyjne

| Nr | Repozytorium i link źródłowy | Właściciel / Organizacja | Opis i zastosowanie | Status w `database/05-functionality-and-performance/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[GoogleChrome/web-vitals](https://github.com/GoogleChrome/web-vitals)** | **Google Chrome Team** | Oficjalna biblioteka Google do pomiaru `LCP`, `INP`, `CLS`, `FCP`, `TTFB` z diagnostyką konkretnych węzłów DOM (`web-vitals/attribution`). | Sklonowano lokalnie (`./web-vitals`) |
| 2 | **[vercel/commerce](https://github.com/vercel/commerce)** | **Vercel** | Wzorcowa architektura sklepu internetowego na Next.js App Router, RSC, Server Actions i optymistycznym koszyku (`useOptimistic`). | Sklonowano lokalnie (`./vercel-commerce`) |
| 3 | **[algolia/autocomplete](https://github.com/algolia/autocomplete)** | **Algolia** | Branżowy standard komponentu wyszukiwarki z autouzupełnianiem (WAI-ARIA 1.2 Combobox, podpowiedzi, historia zapytań). | Sklonowano lokalnie (`./algolia-autocomplete`) |
| 4 | **[GoogleChrome/lighthouse](https://github.com/GoogleChrome/lighthouse)** | **Google Chrome Team** | Zautomatyzowany silnik audytu wydajności, dostępności, SEO i przepływów użytkownika (User Flows). | Źródło referencyjne |
| 5 | **[microsoft/playwright](https://github.com/microsoft/playwright)** | **Microsoft** | Światowy standard testów E2E na silnikach Chromium, WebKit i Firefox z pełnym zapisem śladu wykonania (`Trace Viewer`). | Źródło referencyjne |
| 6 | **[Shopify/hydrogen](https://github.com/Shopify/hydrogen)** | **Shopify** | Oficjalny framework e-commerce Shopify (`useOptimisticCart`, `PredictiveSearch`, buforowanie Edge). | Źródło referencyjne |
| 7 | **[meilisearch/meilisearch](https://github.com/meilisearch/meilisearch)** | **Meilisearch** | Ultraszybki ($< 50\text{ ms}$) silnik wyszukiwania w Rust z tolerancją literówek, filtrami fasetowymi i wyszukiwaniem hybrydowym AI. | Źródło referencyjne |
| 8 | **[Pagefind/pagefind](https://github.com/Pagefind/pagefind)** | **CloudCannon** | Statyczna wyszukiwarka pełnotekstowa w Rust/WebAssembly działająca bez backendu. | Źródło referencyjne |

---

## 4. Przewodniki inżynieryjne w tej kategorii

- [`guides/01-core-web-vitals.md`](./guides/01-core-web-vitals.md) — Optymalizacja LCP, INP (`scheduler.yield()`) i CLS, optymalizacja czcionek (`WOFF2`), obrazów (`AVIF`) i Speculation Rules API.
- [`guides/02-rendering-and-frameworks.md`](./guides/02-rendering-and-frameworks.md) — Architektury renderowania (SSR, SSG, ISR, Streaming SSR, PPR, RSC, Islands, Resumability) oraz dobór frameworka (Next.js, Nuxt, Astro, SvelteKit, Qwik).
