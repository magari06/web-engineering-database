# 02. Struktura i układ (Semantyka HTML5, Hierarchia H1–H3 i Siatka)

> **Pytanie główne z listy kontrolnej («Osiem obszarów, czterdzieści pytań»):**
> *«Czy nagłówki tworzą hierarchię H1, H2, H3?»*

---

## 1. Rola kategorii w architekturze strony

Struktura dokumentu oraz siatka układu (Layout Grid) odpowiadają za czytelność maszynową (dla robotów wyszukiwarek, czytników ekranu oraz modeli AI poprzez semantyczny DOM i strukturę `H1–H6`), a także za stabilność wizualną i responsywność interfejsu (`CSS Grid`, `@container` Container Queries, brak przesunięć układu `CLS <= 0.1`).

---

## 2. Pięć pytań kontrolnych audytu (6–10 z 40) i kryteria inżynieryjne

### Q2.1. Ścisła hierarchia nagłówków (`Document Outline & Heading Hierarchy H1–H6`)
* **Pytanie:** *Czy nagłówki tworzą hierarchię H1, H2, H3?*
* **Kryteria weryfikacji:**
  * Dokładnie **jeden znacznik `<h1>` na stronę**, spójny z tytułem `<title>`.
  * Brak pomijania poziomów w dół (np. niedozwolone przejście z `<h2>` bezpośrednio do `<h4>` bez `<h3>`). Rozmiar wizualny jest kontrolowany przez klasy CSS, a poziom znacznika wynika wyłącznie ze struktury logicznej.

### Q2.2. Semantyczne regiony strony (`HTML5 Landmark Regions`)
* **Pytanie:** *Czy struktura strony wykorzystuje semantyczne znaczniki HTML5 (`<header>`, `<nav>`, `<main>`, `<aside>`, `<footer>`)?*
* **Kryteria weryfikacji:**
  * Cała widoczna treść znajduje się wewnątrz semantycznych punktów orientacyjnych: `<header>`, `<nav>`, pojedynczego widocznego `<main id="main-content">`, `<aside>` oraz `<footer>`.
  * Powtarzające się regiony (np. kilka bloków `<nav>` lub `<section>`) posiadają unikalne atrybuty `aria-label` lub `aria-labelledby`.

### Q2.3. Hierarchia wizualna, siatka modułowa i światło (`Grid & Whitespace`)
* **Pytanie:** *Czy układ strony ma czytelną hierarchię wizualną, konsekwentną siatkę (Grid) i odpowiednie odstępy (whitespace)?*
* **Kryteria weryfikacji:**
  * Układ oparty na `CSS Grid` / `Flexbox` ze spójną skalą tokenów odstępów (krok `4px`/`8px` lub płynna skala `clamp()`).
  * Zachowana **zasada bliskości Gestalt**: odstępy wewnętrzne (`padding` i `gap` wewnątrz karty) są zawsze mniejsze niż odstępy zewnętrzne między sekcjami ($d_{\text{wewnętrzny}} < d_{\text{zewnętrzny}}$).

### Q2.4. Responsywność, Container Queries i brak poziomego przewijania (`Reflow 400%`)
* **Pytanie:** *Czy układ płynnie dopasowuje się do każdej rozdzielczości ekranu (od 320px do 4K) oraz powiększenia 200–400% bez poziomego przewijania?*
* **Kryteria weryfikacji:**
  * Brak poziomego paska przewijania na szerokościach od `320 CSS px` do `2560+ CSS px` oraz przy powiększeniu 400% (**WCAG 2.2 SC 1.4.10 Reflow**).
  * Komponenty wykorzystują zapytania kontenerowe `@container` (`container-type: inline-size`) oraz elastyczne siatki `repeat(auto-fit, minmax(min(100%, 280px), 1fr))`.

### Q2.5. Stabilność wizualna układu podczas ładowania (`Zero CLS`)
* **Pytanie:** *Czy elementy strony nie przesuwają się samoistnie podczas ładowania (brak skoków układu / CLS)?*
* **Kryteria weryfikacji:**
  * Wskaźnik **CLS (Cumulative Layout Shift) $\le 0.1$** (cel inżynieryjny $\le 0.02$).
  * Wszystkie elementy `<img>`, `<video>`, `<iframe>` oraz kontenery reklamowe mają jawnie zdefiniowane wymiary `width`/`height` lub `aspect-ratio`, a czcionki internetowe korzystają z `size-adjust`.

---

## 3. Źródła i Zweryfikowane Repozytoria Korporacyjne

| Nr | Repozytorium i link źródłowy | Właściciel / Organizacja | Opis i zastosowanie | Status w `database/02-structure-and-layout/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[thedaviddias/Front-End-Checklist](https://github.com/thedaviddias/Front-End-Checklist)** | **David Dias (70k+ ★)** | Najpopularniejsza na GitHubie lista kontrolna semantyki HTML5, sekcji `<head>`/`<body>`, hierarchii nagłówków i architektury CSS. | Sklonowano lokalnie (`./front-end-checklist`) |
| 2 | **[argyleink/open-props](https://github.com/argyleink/open-props)** | **Adam Argyle (Google Chrome CSS Lead)** | Zestaw atomowych zmiennych CSS Custom Properties: skale siatki, odstępów, proporcji (`aspect-ratio`) i kontenerów. | Sklonowano lokalnie (`./open-props`) |
| 3 | **[trys/utopia-core](https://github.com/trys/utopia-core)** | **Utopia (Trys Mudford & James Gilyead)** | Silnik matematyczny do wyliczania płynnych (fluid) skal odstępów, siatek i typografii za pomocą `clamp()`. | Sklonowano lokalnie (`./utopia-core`) |
| 4 | **[h5bp/html5-boilerplate](https://github.com/h5bp/html5-boilerplate)** | **H5BP Organization (56k+ ★)** | Klasyczny wzorzec struktury dokumentu HTML5 i konfiguracji bazowej. | Źródło referencyjne |
| 5 | **[validator/validator](https://github.com/validator/validator)** | **W3C / Nu Html Checker** | Oficjalny walidator W3C (`validator.w3.org`) sprawdzający zgodność ze standardem WHATWG HTML i strukturę nagłówków. | Źródło referencyjne |
| 6 | **[html-validate/html-validate](https://github.com/html-validate/html-validate)** | **HTML-Validate** | Statyczny analizator HTML z regułą `heading-level` (wykrywanie pominiętych poziomów `h1 -> h3`) i kontrolą regionów ARIA. | Źródło referencyjne |
| 7 | **[5t3ph/smolcss](https://github.com/5t3ph/smolcss)** | **Stephanie Eckles (W3C CSS WG)** | Kompendium nowoczesnych wzorców układu na bazie CSS Grid, Flexbox i `@container` queries. | Źródło referencyjne |
| 8 | **[GoogleChrome/web-vitals](https://github.com/GoogleChrome/web-vitals)** | **Google Chrome Team** | Oficjalna biblioteka Google do pomiaru wskaźnika `CLS` i diagnostyki przesunięć DOM. | Sklonowano w `05-functionality-and-performance` |

---

## 4. Przewodniki inżynieryjne w tej kategorii

- [`guides/01-ux-laws-and-modern-ui.md`](./guides/01-ux-laws-and-modern-ui.md) — Prawa psychologii UX (Fittsa, Hicka, Jakoba, Millera), Intrinsic Web Design (`@container`), Bento Grid i płynne skale układu.
