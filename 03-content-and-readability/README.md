# 03. Treść i czytelność (Typografia, Kontrast WCAG/APCA i Styl)

> **Pytanie główne z listy kontrolnej («Osiem obszarów, czterdzieści pytań»):**
> *«Czy rozmiar i kontrast tekstu ułatwiają czytanie?»*

---

## 1. Rola kategorii w architekturze strony

Czytelność (Readability) oraz rozpoznawalność znaków (Legibility) decydują o tym, jak szybko i bez zmęczenia wzroku użytkownik przyswaja informacje. Na poziomie inżynieryjnym zapewnia to płynna typografia (`clamp()`), kontrast percepcyjny (**WCAG 2.2 AA** oraz **W3C APCA / WCAG 3** w przestrzeni `OKLCH`), optymalna długość wiersza (`50–75ch`), czystość drzewa DOM (`Mozilla Readability`) oraz dyscyplina redakcyjna (`BLUF`, *Plain Language*).

---

## 2. Pięć pytań kontrolnych audytu (11–15 z 40) i kryteria inżynieryjne

### Q3.1. Rozmiar czcionki bazowej i płynna skala (`Fluid Typography & Text Resize`)
* **Pytanie:** *Czy rozmiar tekstu głównego jest wystarczająco duży i responsywny?*
* **Kryteria weryfikacji:**
  * Bazowy rozmiar tekstu głównego (`body`, `<p>`, `<li>`) wynosi **$\ge 16\text{ px}$ (`1rem`)**, a tekstów pomocniczych minimum **$\ge 12\text{ px}$ (`0.75rem`)**, optymalnie `14px`.
  * Rozmiary czcionek są zdefiniowane w jednostkach względnych (`rem` + `clamp()`), spełniając wymóg **WCAG 2.2 SC 1.4.4 (Powiększenie tekstu do 200%)** bez ucinania zawartości.

### Q3.2. Kontrast barwny i percepcyjny w trybie jasnym i ciemnym (`WCAG 2.2 & APCA Contrast`)
* **Pytanie:** *Czy kontrast tekstu względem tła ułatwia czytanie w każdych warunkach oświetleniowych?*
* **Kryteria weryfikacji:**
  * **WCAG 2.2 AA (SC 1.4.3):** zwykły tekst ($< 24\text{ px}$) posiada kontrast **$\ge 4.5:1$** (poziom AAA — $\ge 7:1$); duży tekst ($\ge 24\text{ px}$ lub $\ge 18.66\text{ px bold}$) — **$\ge 3.0:1$**.
  * **W3C APCA (WCAG 3 / `Myndex/apca-w3`):** główny tekst artykułu osiąga kontrast percepcyjny **$|L_c| \ge 75$** (minimum $|L_c| \ge 60$ dla bloków treści), duże nagłówki — **$|L_c| \ge 45$**.
  * W **Dark Mode** unika się efektu halo (czysta biel `#FFFFFF` na czystej czerni `#000000`) na rzecz złamanej bieli (`#E2E8F0` / `oklch(0.92 0.01 250)`) na ciemnołupkowym tle (`#0F172A`).

### Q3.3. Długość wiersza, interlinia i rytm pionowy (`Measure, Leading & Vertical Rhythm`)
* **Pytanie:** *Czy szerokość kolumny tekstu, interlinia i odstępy wspierają płynne czytanie?*
* **Kryteria weryfikacji:**
  * Długość wiersza mieści się w przedziale **`50ch–75ch`** (wzorzec `max-width: 65ch` wg `@tailwindcss/typography` i WCAG 1.4.8).
  * Interlinia (`line-height`): **`1.5–1.65`** dla tekstu głównego oraz **`1.1–1.25`** dla nagłówków (`text-wrap: balance` dla nagłówków, `text-wrap: pretty` dla akapitów, zakaz `text-align: justify`).
  * Zgodność z **WCAG 2.2 SC 1.4.12 (Odstępy w tekście)**.

### Q3.4. Skanowalność tekstu i zasada odwróconej piramidy (`Scannability & BLUF`)
* **Pytanie:** *Czy struktura tekstu (nagłówki, wypunktowania, wyróżnienia) pozwala na szybkie skanowanie strony?*
* **Kryteria weryfikacji:**
  * Zastosowana zasada **BLUF (Bottom Line Up Front)**: najważniejszy wniosek znajduje się w pierwszym akapicie (`TL;DR`), a tekst jest dzielony śródtytułami `H2`/`H3` co 200–350 słów, listami `<ul>`/`<ol>` oraz tabelami `<table>`.

### Q3.5. Prosty język i precyzyjne mikrocopy (`Plain Language & Actionable Microcopy`)
* **Pytanie:** *Czy język komunikatów jest prosty, zrozumiały i wolny od żargonu?*
* **Kryteria weryfikacji:**
  * Średnia długość zdania wynosi **15–20 słów**, udział strony biernej $< 10\%$ (zgodnie ze standardem Jasnopis / Google / Microsoft Style Guide).
  * Przyciski i linki precyzyjnie opisują akcję (np. *„Pobierz cennik PDF (1,8 MB)”* zamiast *„Kliknij tutaj”* lub *„Więcej”*).

---

## 3. Źródła i Zweryfikowane Repozytoria Korporacyjne

| Nr | Repozytorium i link źródłowy | Właściciel / Organizacja | Opis i zastosowanie | Status w `database/03-content-and-readability/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[Myndex/apca-w3](https://github.com/Myndex/apca-w3)** | **W3C AGWG / Myndex** | Oficjalna implementacja algorytmu **APCA (Accessible Perceptual Contrast Algorithm)** dla standardu WCAG 3. | Sklonowano lokalnie (`./apca-w3`) |
| 2 | **[mozilla/readability](https://github.com/mozilla/readability)** | **Mozilla Corporation** | Oficjalny silnik **Firefox Reader View** oceniający czystość semantyczną tekstu i gęstość treści na stronie. | Sklonowano lokalnie (`./mozilla-readability`) |
| 3 | **[mailchimp/content-style-guide](https://github.com/mailchimp/content-style-guide)** | **Mailchimp (Intuit)** | Korporacyjny przewodnik po stylu treści, *Plain Language*, tonie komunikacji i mikrocopy interfejsów. | Sklonowano lokalnie (`./mailchimp-style-guide`) |
| 4 | **[color-js/color.js](https://github.com/color-js/color.js)** | **W3C CSS WG Editors (Lea Verou & Chris Lilley)** | Biblioteka obliczeń kolorystycznych (`OKLCH`, `Display-P3`) i kontrastu (`WCAG21`, `APCA`, `Michelson`). | Źródło referencyjne |
| 5 | **[adobe/leonardo](https://github.com/adobe/leonardo)** | **Adobe Inc.** | Generator adaptacyjnych palet barwnych oparty na docelowych współczynnikach kontrastu WCAG 2.2 i APCA. | Źródło referencyjne |
| 6 | **[tailwindlabs/tailwindcss-typography](https://github.com/tailwindlabs/tailwindcss-typography)** | **Tailwind Labs** | Branżowy wzorzec proporcji typograficznych (`.prose`, `max-width: 65ch`, rytm pionowy). | Źródło referencyjne |
| 7 | **[vale-cli/packages](https://github.com/vale-cli/packages)** | **Vale CLI / Errata AI** | Reguły automatycznego sprawdzania czytelności tekstu wg **Google** i **Microsoft Developer Style Guide**. | Źródło referencyjne |
| 8 | **[fontsource/fontsource](https://github.com/fontsource/fontsource)** | **Fontsource** | Katalog czcionek internetowych (`WOFF2`, Variable Fonts) do hostowania lokalnego (self-hosted). | Źródło referencyjne |

---

## 4. Przewodniki inżynieryjne w tej kategorii

- [`guides/02-content-eeat-and-clusters.md`](./guides/02-content-eeat-and-clusters.md) — Inżynieryjne podejście do E-E-A-T, patent Google Information Gain, zasada BLUF oraz klastry tematyczne.
