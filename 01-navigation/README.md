# 01. Nawigacja i Architektura Informacji

> **Pytanie główne z listy kontrolnej («Osiem obszarów, czterdzieści pytań»):**
> *«Czy z każdej podstrony wrócisz na stronę główną?»*

---

## 1. Rola kategorii w architekturze strony

Nawigacja i architektura informacji (Information Architecture — IA) decydują o tym, czy użytkownik oraz roboty indeksujące potrafią bez wysiłku zorientować się w strukturze witryny (`Wayfinding`), przejść do kluczowych sekcji w maksymalnie 3 kliknięciach oraz bezpiecznie wyjść ze stron błędów (`404`) lub pustych wyników wyszukiwania.

---

## 2. Pięć pytań kontrolnych audytu (1–5 z 40) i kryteria inżynieryjne

### Q1.1. Powrót na stronę główną i pomijanie bloków (`Home & Global Anchor`)
* **Pytanie:** *Czy z każdej podstrony wrócisz na stronę główną?*
* **Kryteria weryfikacji:**
  * W nagłówku `<header>` znajduje się klikalne logo `<a href="/">` z czytelną nazwą dostępną (`aria-label="[Marka] — Strona główna"` lub atrybutem `alt`).
  * Pierwszym elementem fokusowalnym w drzewie DOM (`body > a.skip-link:first-child`) jest link **Przejdź do głównej treści** (`href="#main-content"`), widoczny po naciśnięciu klawisza `Tab` (`:focus-visible`).

### Q1.2. Wskazanie bieżącej lokalizacji i ścieżka powrotu (`Wayfinding & Breadcrumbs`)
* **Pytanie:** *Czy użytkownik zawsze wie, gdzie aktualnie się znajduje w strukturze serwisu?*
* **Kryteria weryfikacji:**
  * Aktywna pozycja menu posiada atrybut `aria-current="page"` oraz wyróżnienie wizualne niezależne od samego koloru (linia, pogrubienie, tło).
  * Na wszystkich podstronach od 2. poziomu zagnieżdżenia widoczna jest ścieżka powrotu `<nav aria-label="Breadcrumb"><ol>...</ol></nav>` z mikrodanymi `Schema.org/BreadcrumbList` (JSON-LD).

### Q1.3. Przewidywalność menu i płytka głębokość kliknięć (`Shallow Depth <= 3 Clicks`)
* **Pytanie:** *Czy główne menu jest spójne, zrozumiałe i pozwala dotrzeć do kluczowych treści w maksymalnie 3 kliknięciach?*
* **Kryteria weryfikacji:**
  * Główny poziom nawigacji `<nav aria-label="Główna nawigacja">` zawiera **od 4 do 7 elementów** (zgodnie z prawem Hicka i Millera).
  * Rozwijane menu obsługują klawisze `Escape`, `ArrowDown`/`ArrowUp` oraz bezpieczny trójkąt trajektorii kursora (*safe polygon*).

### Q1.4. Ergonomia nawigacji mobilnej (`Mobile Drawer & Touch Targets`)
* **Pytanie:** *Czy nawigacja mobilna jest łatwo dostępna pod kciukiem i poprawnie zarządza fokusem?*
* **Kryteria weryfikacji:**
  * Wszystkie linki i przyciski nawigacyjne posiadają obszar dotyku **$\ge 44 \times 44\text{ CSS px}$** (minimum WCAG 2.2 AA: $24 \times 24\text{ CSS px}$).
  * Przycisk menu mobilnego posiada `aria-expanded="false|true"`, blokuje przewijanie tła i zamyka fokus wewnątrz otwartego panelu (`FocusTrap` / atrybut `inert`).

### Q1.5. Wyszukiwarka wewnętrzna, Command Palette i obsługa błędów 404 (`Search & Dead-End Recovery`)
* **Pytanie:** *Czy serwis oferuje szybką wyszukiwarkę oraz pomocne wyjście ze stron błędów (404 / brak wyników)?*
* **Kryteria weryfikacji:**
  * Pole wyszukiwania jest umieszczone w znaczniku `<search>` lub `<form role="search">` i obsługuje skrót klawiszowy `/` lub `⌘K` (`Ctrl+K`).
  * Strona `404 Not Found` zawiera wyszukiwarkę, linki do najpopularniejszych sekcji oraz przycisk powrotu na stronę główną.

---

## 3. Źródła i Zweryfikowane Repozytoria Korporacyjne

| Nr | Repozytorium i link źródłowy | Właściciel / Organizacja | Opis i zastosowanie | Status w `database/01-navigation/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[w3c/aria-practices](https://github.com/w3c/aria-practices)** | **W3C (WAI-ARIA WG)** | Oficjalne repozytorium **ARIA Authoring Practices Guide (APG)**: wzorce `Breadcrumb`, `Navigation Menubar`, `Disclosure Navigation`, `Tabs`, `Treeview`. | Sklonowano lokalnie (`./w3c-aria-practices`) |
| 2 | **[pacocoursey/cmdk](https://github.com/pacocoursey/cmdk)** | **Paco Coursey / Vercel** | Standard branżowy palety poleceń i szybkiej nawigacji klawiaturą (`⌘K`), używany przez Vercel i Linear. | Sklonowano lokalnie (`./cmdk`) |
| 3 | **[uswds/uswds](https://github.com/uswds/uswds)** | **U.S. General Services Administration** | **U.S. Web Design System**: federalny standard nawigacji rządowej USA (`usa-header`, `usa-nav`, `usa-breadcrumb`, `usa-skipnav`). | Źródło referencyjne |
| 4 | **[alphagov/govuk-frontend](https://github.com/alphagov/govuk-frontend)** | **UK Government Digital Service** | **GOV.UK Frontend**: brytyjski standard dostępnej nawigacji (`govuk-breadcrumbs`, `govuk-service-navigation`). | Źródło referencyjne |
| 5 | **[TanStack/router](https://github.com/TanStack/router)** | **TanStack** | Typowany router ze stanem w parametrach URL, preloadingiem `intent` i przywracaniem pozycji przewijania. | Źródło referencyjne |
| 6 | **[radix-ui/primitives](https://github.com/radix-ui/primitives)** | **WorkOS / Radix UI** | Dostępne prymitywy `NavigationMenu` i `DropdownMenu` z obsługą roving `tabindex`. | Źródło referencyjne |
| 7 | **[adobe/react-spectrum](https://github.com/adobe/react-spectrum)** | **Adobe Inc.** | Biblioteka `React Aria` (`useMenu`, `useBreadcrumbs`, `useTabList`, `useLandmark`). | Źródło referencyjne |
| 8 | **[carbon-design-system/carbon](https://github.com/carbon-design-system/carbon)** | **IBM** | Korporacyjny standard nawigacji `UI Shell` (Global Header, Side Nav, Switcher). | Źródło referencyjne |
