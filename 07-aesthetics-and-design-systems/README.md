# 07. Estetyka, Systemy Projektowe (Design Systems) i Identyfikacja Marki

> **Pytanie główne z listy kontrolnej («Osiem obszarów, czterdzieści pytań»):**
> *«Czy design jest zgodny z identyfikacją marki?»*

---

## 1. Rola kategorii w architekturze strony

Spójność estetyczna i rozpoznawalność marki na poziomie inżynieryjnym opierają się na **architekturze tokenów projektowych (W3C Design Tokens Community Group — DTCG)**, percepcyjnie jednorodnych przestrzeniach barw (`OKLCH` / `Display-P3`), siatkach modułowych (`4px`/`8px`), spójnej ikonografii oraz płynnych mikrointerakcjach.

W tej kategorii znajdują się pełne bazy danych systemów projektowych największych światowych korporacji: **Adobe Spectrum (`spectrum-design-data`)**, **Google Material Design 3 (`material-web`)** oraz **GitHub Primer (`primer-primitives`)**.

---

## 2. Pięć pytań kontrolnych audytu (31–35 z 40) i kryteria inżynieryjne

### Q7.1. Fundament tokenów projektowych marki (`W3C DTCG Design Tokens Foundation`)
* **Pytanie:** *Czy fundament wizualny opiera się na spójnych tokenach projektowych (Design Tokens)?*
* **Kryteria weryfikacji:**
  * **0% „magicznych liczb”** w stylach komponentów (brak wpisanych na sztywno kodów HEX czy przypadkowych marginesów `margin: 13px`).
  * Wdrożona 3-poziomowa hierarchia tokenów wg **W3C DTCG**: tokeny bazowe (`--color-blue-500`), tokeny semantyczne (`--color-accent-primary`, `--surface-elevated`) oraz tokeny komponentowe (`--button-bg-primary`).

### Q7.2. Percepcyjna spójność motywów kolorystycznych (`Light, Dark & High-Contrast Parity`)
* **Pytanie:** *Czy motywy kolorystyczne (Light, Dark, High-Contrast) zachowują spójność percepcyjną?*
* **Kryteria weryfikacji:**
  * Palety kolorystyczne zdefiniowane w przestrzeni **`oklch(L C H)`**, gwarantującej identyczną postrzeganą jasność (`L`) dla różnych odcieni.
  * Obsługa `@media (prefers-color-scheme: dark)`, `@media (prefers-contrast: more)`, `@media (forced-colors: active)` oraz właściwości `color-scheme: light dark` na `:root`.
  * W trybie ciemnym hierarchia wysokości (*elevation*) jest budowana przez stopniowe rozjaśnianie powierzchni (`surface-1` $\rightarrow$ `surface-3`) oraz subtelne obramowania `1px`.

### Q7.3. Hierarchia wizualna i równowaga światła (`Visual Hierarchy & Whitespace Balance`)
* **Pytanie:** *Czy hierarchia wizualna i światło (whitespace) eliminują szum informacyjny?*
* **Kryteria weryfikacji:**
  * Zachowana zasada **60–30–10** (60% tło neutralne, 30% powierzchnie drugorzędne/typografia, 10% akcent marki) oraz maksymalnie **1 główny przycisk Primary CTA** na pierwszym ekranie (*Above the Fold*).
  * Udział wolnej przestrzeni (*whitespace*) stanowi minimum **25–40%** powierzchni widoku.

### Q7.4. Spójność ikonografii, ilustracji i mediów (`Iconography & Media Consistency`)
* **Pytanie:** *Czy ikonografia, ilustracje i media są spójne stylistycznie?*
* **Kryteria weryfikacji:**
  * Wszystkie ikony SVG pochodzą z jednej rodziny (wspólny `viewBox="0 0 24 24"`, jednolita grubość linii `stroke-width: 1.5px` lub `2px`, `stroke="currentColor"`).
  * Kontenery multimedialne stosują ustandaryzowane proporcje (`aspect-ratio: 16/9 | 4/3 | 1/1`), `object-fit: cover` oraz spójne promienie zaokrągleń (`border-radius`).

### Q7.5. Fizyka mikrointerakcji i charakter ruchu (`Motion Tokens & Micro-Interactions`)
* **Pytanie:** *Czy mikrointerakcje i animacje odzwierciedlają charakter marki bez pogarszania UX?*
* **Kryteria weryfikacji:**
  * Czas trwania mikrointerakcji (`hover`, `focus`, `active`) wynosi **120–200 ms**, a przejść paneli/modali — **200–350 ms** przy użyciu naturalnych krzywych `cubic-bezier(0.2, 0, 0, 1)`.
  * Animowane są wyłącznie właściwości kompozytowe GPU (`transform`, `opacity`) oraz natywne **View Transitions API** z pełnym poszanowaniem `@media (prefers-reduced-motion: reduce)`.

---

## 3. Źródła i Zweryfikowane Repozytoria Korporacyjne

| Nr | Repozytorium i link źródłowy | Właściciel / Organizacja | Opis i zastosowanie | Status w `database/07-aesthetics-and-design-systems/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[adobe/spectrum-design-data](https://github.com/adobe/spectrum-design-data)** | **Adobe Inc.** | Oficjalna baza danych tokenów projektowych, schematów JSON i specyfikacji systemu **Adobe Spectrum**. | Sklonowano lokalnie (`./spectrum-design-data`) |
| 2 | **[material-components/material-web](https://github.com/material-components/material-web)** | **Google** | Oficjalne repozytorium komponentów webowych i tokenów projektowych **Google Material Design 3 (Material Web)**. | Sklonowano lokalnie (`./material-web`) |
| 3 | **[primer/primitives](https://github.com/primer/primitives)** | **GitHub (Microsoft)** | Baza tokenów projektowych **GitHub Primer** (motywy Light, Dark, High-Contrast, Colorblind, typografia, wymiary) w formacie W3C DTCG. | Sklonowano lokalnie (`./primer-primitives`) |
| 4 | **[style-dictionary/style-dictionary](https://github.com/style-dictionary/style-dictionary)** | **Amazon / Style Dictionary** | Branżowy kompilator tokenów projektowych z formatu JSON/W3C DTCG do zmiennych CSS, JS, iOS i Android. | Źródło referencyjne |
| 5 | **[design-tokens/community-group](https://github.com/design-tokens/community-group)** | **W3C DTCG** | Oficjalna specyfikacja standardu W3C Design Tokens (`$value`, `$type`, `$extensions`). | Źródło referencyjne |
| 6 | **[carbon-design-system/carbon](https://github.com/carbon-design-system/carbon)** | **IBM** | Monorepo korporacyjnego systemu projektowego **IBM Carbon** (`@carbon/themes`, `@carbon/layout`, `@carbon/motion`). | Źródło referencyjne |
| 7 | **[Shopify/polaris](https://github.com/Shopify/polaris)** | **Shopify** | System projektowy i tokeny **Shopify Polaris** dla interfejsów e-commerce i paneli administracyjnych. | Źródło referencyjne |
| 8 | **[microsoft/fluentui](https://github.com/microsoft/fluentui)** | **Microsoft** | Oficjalny system projektowy **Microsoft Fluent 2** z wzorcową obsługą trybu wysokiego kontrastu (`forced-colors`). | Źródło referencyjne |
| 9 | **[shadcn-ui/ui](https://github.com/shadcn-ui/ui)** | **shadcn / Vercel** | Nowoczesny standard komponentów UI oparty na Radix UI, Tailwind CSS i semantycznych zmiennych OKLCH. | Źródło referencyjne |

---

## 4. Przewodniki inżynieryjne w tej kategorii

- [`guides/01-design-and-frontend-toolkit.md`](./guides/01-design-and-frontend-toolkit.md) — Figma Variables, Auto Layout 5.0+, Code Connect, Figma MCP, Tailwind CSS v4 (`@theme`, `oklch()`), shadcn/ui, Radix UI, React Aria, Motion oraz GSAP.
