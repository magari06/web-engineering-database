# 07. Estetyka / Эстетика, дизайн-системы и идентификация бренда

> **Базовый вопрос чек-листа («Osiem obszarów, czterdzieści pytań»):**
> *«Czy design jest zgodny z identyfikacją marki?»* — **Соответствует ли дизайн идентификации бренда?**

---

## 1. Обзор категории и инженерная роль

Эстетическая целостность и узнаваемость бренда на инженерном уровне строятся не на субъективном вкусе, а на **системе дизайн-токенов (W3C Design Tokens Community Group — DTCG)**, перцептивно равномерных цветовых пространствах (`OKLCH` / `Display-P3`), модульных сетках (`4px`/`8px`), консистентной иконографии и выверенной физике микро-интеракций.

В этой категории собраны полные исходные базы данных дизайн-систем крупнейших мировых корпораций: **Adobe Spectrum (`spectrum-design-data`)**, **Google Material Design 3 (`material-web`)** и **GitHub Primer (`primer-primitives`)**.

---

## 2. Пять контрольных вопросов аудита (35/40) и технические метрики

### Q7.1. Архитектура дизайн-токенов бренда (`W3C DTCG Design Tokens Foundation`)
* **Вопрос (PL / RU):** *Czy fundament wizualny opiera się na spójnych tokenach projektowych (Design Tokens)?* / Построен ли визуальный стиль сайта на строгой иерархии дизайн-токенов бренда без «магических чисел»?
* **Инженерные критерии проверки:**
  * В стилях компонентов **0% захардкоженных HEX-цветов и случайных отступов** (`margin: 13px`).
  * Внедрена 3-уровневая система токенов по спецификации **W3C DTCG**: базовые примитивы (`--color-blue-500`), семантические токены (`--color-accent-primary`, `--surface-elevated`) и компонентные токены (`--button-bg-primary`).

### Q7.2. Перцептивный паритет тем (`Light, Dark & High-Contrast Mode Parity`)
* **Вопрос (PL / RU):** *Czy motywy kolorystyczne (Light, Dark, High-Contrast) zachowują spójność percepcyjną?* / Обеспечен ли перцептивный паритет между светлой, темной и высококонтрастной темами?
* **Инженерные критерии проверки:**
  * Цветовые палитры спроектированы в пространстве **`oklch(L C H)`**, обеспечивающем одинаковую воспринимаемую светлоту (`L`) разных оттенков.
  * Поддерживаются `@media (prefers-color-scheme: dark)`, `@media (prefers-contrast: more)`, `@media (forced-colors: active)` и свойство `color-scheme: light dark` на `:root`.
  * В Dark Mode высота поверхности (`elevation`) передается ступенчатым осветлением фона (`surface-1` $\rightarrow$ `surface-3`) и тонкими `1px` границами, а не черными тенями.

### Q7.3. Визуальная иерархия и баланс свободного пространства (`Visual Hierarchy & Whitespace Balance`)
* **Вопрос (PL / RU):** *Czy hierarchia wizualna i światło (whitespace) eliminują szum informacyjny?* / Выстроена ли визуальная иерархия и баланс «воздуха» без информационного шума?
* **Инженерные критерии проверки:**
  * Соблюдается правило **60–30–10** (60% нейтральный фон, 30% вторичные поверхности/типографика, 10% брендовый акцент) и не более **1 главной кнопки Primary CTA** на первом экране.
  * Доля свободного пространства (whitespace) составляет не менее **25–40%** площади вьюпорта.

### Q7.4. Единство иконографии, иллюстраций и медиа (`Iconography & Media Consistency`)
* **Вопрос (PL / RU):** *Czy ikonografia, ilustracje i media są spójne stylistycznie?* / Соблюдено ли стилистическое единство иконок, фотографий, видео и графики?
* **Инженерные критерии проверки:**
  * Все SVG-иконки принадлежат единой системе (единый `viewBox="0 0 24 24"`, единая толщина штриха `stroke-width: 1.5px` или `2px`, `stroke="currentColor"`).
  * Медиаконтейнеры используют стандартизированные токены пропорций (`aspect-ratio: 16/9 | 4/3 | 1/1`), `object-fit: cover` и единый радиус скругления (`border-radius`).

### Q7.5. Физика микро-интеракций и характер движения (`Motion Tokens & Micro-Interactions`)
* **Вопрос (PL / RU):** *Czy mikrointerakcje i animacje odzwierciedlają charakter marki bez pogarszania UX?* / Соответствуют ли микро-интеракции и анимации характеру бренда без ущерба для отзывчивости?
* **Инженерные критерии проверки:**
  * Длительность микро-интеракций (`hover`, `focus`, `active`) составляет **120–200 мс**, переходов панелей/модалок — **200–350 мс** на естественных кривых `cubic-bezier(0.2, 0, 0, 1)`.
  * Анимируются только композитные GPU-свойства (`transform`, `opacity`) и нативный **View Transitions API** с полным отключением при `@media (prefers-reduced-motion: reduce)`.

---

## 3. Верифицированные репозитории и базы данных корпораций

| № | Репозиторий | Владелец / Организация | Описание и ценность | Статус в `database/07-aesthetics-and-design-systems/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[adobe/spectrum-design-data](https://github.com/adobe/spectrum-design-data)** | **Adobe Inc.** | Официальная база данных дизайн-токенов, JSON-схем и спецификаций дизайн-системы **Adobe Spectrum**. | Локальный клон (`./spectrum-design-data`) |
| 2 | **[material-components/material-web](https://github.com/material-components/material-web)** | **Google** | Официальная кодовая база веб-компонентов и дизайн-токенов **Google Material Design 3 (Material Web)**. | Локальный клон (`./material-web`) |
| 3 | **[primer/primitives](https://github.com/primer/primitives)** | **GitHub (Microsoft)** | Эталонная база дизайн-токенов **GitHub Primer** (цвета Light/Dark/High-Contrast/Colorblind, типографика, размеры) в формате W3C DTCG. | Локальный клон (`./primer-primitives`) |
| 4 | **[style-dictionary/style-dictionary](https://github.com/style-dictionary/style-dictionary)** | **Amazon / Style Dictionary** | Индустриальный компилятор дизайн-токенов из JSON/W3C DTCG в CSS Custom Properties, JS, iOS и Android. | Внешний эталон |
| 5 | **[design-tokens/community-group](https://github.com/design-tokens/community-group)** | **W3C DTCG** | Официальная спецификация стандарта дизайн-токенов W3C (`$value`, `$type`, `$extensions`). | Внешний эталон |
| 6 | **[carbon-design-system/carbon](https://github.com/carbon-design-system/carbon)** | **IBM** | Монорепозиторий корпоративной дизайн-системы **IBM Carbon** (`@carbon/themes`, `@carbon/layout`, `@carbon/motion`). | Внешний эталон |
| 7 | **[Shopify/polaris](https://github.com/Shopify/polaris)** | **Shopify** | Дизайн-система и токены **Shopify Polaris** для коммерческих интерфейсов и личных кабинетов. | Внешний эталон |
| 8 | **[microsoft/fluentui](https://github.com/microsoft/fluentui)** | **Microsoft** | Официальная дизайн-система **Microsoft Fluent 2** с эталонной поддержкой High Contrast Mode (`forced-colors`). | Внешний эталон |
| 9 | **[shadcn-ui/ui](https://github.com/shadcn-ui/ui)** | **shadcn / Vercel** | Современный стандарт копируемых компонентов на базе Radix UI, Tailwind CSS и семантических OKLCH-переменных. | Внешний эталон |

---

## 4. Локальные руководства в этой категории

- [`guides/01-design-and-frontend-toolkit.md`](./guides/01-design-and-frontend-toolkit.md) — Figma Variables, Auto Layout 5.0+, Code Connect, Figma MCP, Tailwind CSS v4 (`@theme`, `oklch()`), shadcn/ui, Radix UI, React Aria, Motion и GSAP.
