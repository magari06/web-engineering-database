# 06. Dostępność Cyfrowa, Nawigacja Klawiaturą i Standard WCAG 2.2

> **Pytanie główne z listy kontrolnej («Osiem obszarów, czterdzieści pytań»):**
> *«Czy po stronie da się poruszać samą klawiaturą?»*

---

## 1. Rola kategorii w architekturze strony

Wraz z wejściem w życie **Europejskiego Aktu o Dostępności (European Accessibility Act — EAA 2025, norma EN 301 549)** spełnienie wytycznych **W3C WCAG 2.2 na poziomie AA** stało się prawnym i inżynieryjnym obowiązkiem. Dostępna strona umożliwia obsługę 100% funkcji za pomocą samej klawiatury (`Tab`, `Shift+Tab`, `Enter`, `Space`, `Escape`, strzałki), nigdy nie ukrywa ani nie zasłania wskaźnika fokusu (`Focus Not Obscured`), zapewnia odpowiedni rozmiar obszarów kliknięcia ($\ge 24\times24\text{ px}$) oraz komunikuje zmiany stanu czytnikom ekranu (`NVDA`, `VoiceOver`, `JAWS`).

---

## 2. Pięć pytań kontrolnych audytu (26–30 z 40) i kryteria inżynieryjne

### Q6.1. Pełna obsługa klawiaturą i brak pułapek fokusowych (`100% Keyboard Operability & Zero Traps`)
* **Pytanie:** *Czy po stronie da się poruszać samą klawiaturą?*
* **Kryteria weryfikacji:**
  * Wszystkie elementy interaktywne są zbudowane na natywnych znacznikach `<button>`, `<a href>`, `<input>` i są osiągalne klawiszami `Tab` / `Shift+Tab` w logicznej kolejności czytania (zakaz używania `tabindex > 0`).
  * W oknach modalnych (`<dialog>`) fokus jest zatrzymywany wewnątrz pętli (`focus-trap`), okno zamyka się klawiszem `Escape`, a fokus wraca na przycisk wywołujący (WCAG 2.1.1, 2.1.2, 2.4.3).

### Q6.2. Widoczny i niezasłonięty wskaźnik fokusu (`Focus Visible & Focus Not Obscured`)
* **Pytanie:** *Czy aktualnie sfokusowany element jest zawsze wyraźnie widoczny i nie jest zasłaniany przez pływające nagłówki lub banery?*
* **Kryteria weryfikacji:**
  * Całkowity zakaz stosowania `outline: none` bez wyraźnego zamiennika `:focus-visible` (`outline: 2px solid`, `outline-offset: 2px`, kontrast obrysu $\ge 3:1$ wg WCAG 2.4.7 / 2.4.13).
  * Zgodność z **WCAG 2.2 SC 2.4.11 (`Focus Not Obscured`)**: sfokusowany element nie chowa się pod przyklejonymi nagłówkami (`position: fixed/sticky`) ani banerami cookie (skonfigurowane `scroll-padding-top`).

### Q6.3. Semantyka dla czytników ekranu i komunikaty na żywo (`Screen Reader Semantics & ARIA Live`)
* **Pytanie:** *Czy strona posiada poprawną strukturę semantyczną, etykiety kontrolek oraz komunikaty `aria-live` dla czytników ekranu?*
* **Kryteria weryfikacji:**
  * Zdefiniowany atrybut `<html lang="pl">` (lub odpowiedni język dokumentu); przyciski ikonowe posiadają `aria-label`; obrazy informacyjne mają dokładny opis `alt`, a dekoracyjne — `alt=""` lub `aria-hidden="true"`.
  * Dynamiczne komunikaty (dodanie do koszyka, wyniki filtrowania, błędy) są ogłaszane przez `aria-live="polite"` (`role="status"`) lub `aria-live="assertive"` (`role="alert"`) zgodnie z **WCAG 4.1.3**.

### Q6.4. Rozmiar obszarów kliknięcia i alternatywa dla przeciągania (`Target Size >= 24px & No Dragging`)
* **Pytanie:** *Czy wszystkie przyciski i elementy interaktywne mają odpowiedni rozmiar obszaru kliknięcia i nie wymagają skomplikowanych gestów?*
* **Kryteria weryfikacji:**
  * Zgodność z **WCAG 2.2 SC 2.5.8 (`Target Size Minimum`)**: rozmiar celu kliknięcia minimum **$24 \times 24\text{ CSS px}$** (zalecany standard dotykowy — **$44 \times 44\text{ CSS px}$**).
  * Zgodność z **WCAG 2.2 SC 2.5.7 (`Dragging Movements`)**: suwaki cenowe, karuzele i listy drag-and-drop posiadają alternatywne sterowanie przyciskami lub polami tekstowymi.

### Q6.5. Bezpieczeństwo animacji, powiększenie 400% i napisy wideo (`Reduced Motion & Captions`)
* **Pytanie:** *Czy interfejs zachowuje czytelny kontrast, działa przy powiększeniu 200–400% i respektuje systemowe wyłączenie animacji?*
* **Kryteria weryfikacji:**
  * Przy aktywnej preferencji `@media (prefers-reduced-motion: reduce)` wyłączane są efekty paralaksy, autoodtwarzanie i gwałtowne przejścia (WCAG 2.3.3).
  * Materiały wideo ze ścieżką dźwiękową posiadają zsynchronizowane napisy `<track kind="captions">`, a filmy w tle — widoczny przycisk pauzy (WCAG 1.2.2, 2.2.2).

---

## 3. Źródła i Zweryfikowane Repozytoria Korporacyjne

| Nr | Repozytorium i link źródłowy | Właściciel / Organizacja | Opis i zastosowanie | Status w `database/06-accessibility/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[dequelabs/axe-core](https://github.com/dequelabs/axe-core)** | **Deque Systems** | Najważniejszy na świecie silnik automatycznych testów dostępności WCAG 2.0/2.1/2.2 (wykorzystywany w Google Lighthouse i Microsoft Accessibility Insights). | Sklonowano lokalnie (`./axe-core`) |
| 2 | **[a11yproject/a11yproject.com](https://github.com/a11yproject/a11yproject.com)** | **The A11Y Project** | Praktyczna baza wiedzy i lista kontrolna audytu dostępności wg standardu WCAG. | Sklonowano lokalnie (`./a11yproject`) |
| 3 | **[w3c/aria-practices](https://github.com/w3c/aria-practices)** | **W3C WAI** | Oficjalne kompendium **WAI-ARIA Authoring Practices Guide (APG)** z tabelami obsługi klawiatury dla ponad 30 komponentów UI. | Sklonowano w `01-navigation/w3c-aria-practices` |
| 4 | **[w3c/wcag](https://github.com/w3c/wcag)** | **W3C AGWG** | Oficjalne repozytorium specyfikacji **WCAG 2.2**, dokumentacji *Understanding WCAG* oraz katalogu technik (*Techniques*). | Źródło referencyjne |
| 5 | **[adobe/react-spectrum](https://github.com/adobe/react-spectrum)** | **Adobe Inc.** | Biblioteka `React Aria` zapewniająca wzorcowe zarządzanie fokusem (`FocusScope`), obsługę czytników ekranu i nawigację klawiaturą. | Źródło referencyjne |
| 6 | **[IBMa/equal-access](https://github.com/IBMa/equal-access)** | **IBM Accessibility** | Narzędzia i reguły audytu dostępności IBM Equal Access Accessibility Checker dla WCAG 2.2. | Źródło referencyjne |
| 7 | **[focus-trap/focus-trap](https://github.com/focus-trap/focus-trap)** | **Focus Trap Org** | Standardowa biblioteka utrzymywania i przywracania fokusu klawiatury w oknach modalnych i szufladach nawigacyjnych. | Źródło referencyjne |
| 8 | **[pa11y/pa11y](https://github.com/pa11y/pa11y)** | **Pa11y Organization** | Narzędzie CLI do automatycznego skanowania dostępności stron w potokach CI/CD (`axe-core` + `HTML_CodeSniffer`). | Źródło referencyjne |

---

## 4. Przewodniki inżynieryjne w tej kategorii

- [`guides/02-accessibility-wcag-2.2.md`](./guides/02-accessibility-wcag-2.2.md) — Kompleksowy przewodnik po wymaganiach **WCAG 2.2 Level AA** oraz **European Accessibility Act (EAA 2025)**, statystyki WebAIM Million, natywne znaczniki `<dialog>` i `popover`, kontrast APCA ($L_c$) oraz testy `@axe-core/playwright`.
